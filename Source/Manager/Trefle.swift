//
//  Trefle.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import Foundation

public class Trefle {
    
    internal static var shared = Trefle()
    internal static let userDefaultsSuiteName = "com.PigonaHill.TrefleSwiftSDK.userDefaults.suiteName"
    internal static let userDefaultsKeychainStateUUID = "com.PigonaHill.TrefleSwiftSDK.userDefaults.stateUUID"
    internal static let keychainServiceName = "com.PigonaHill.TrefleSwiftSDK.keychain"
    internal static let baseURL = "https://trefle.io"
    internal static let baseAPIURL = "\(baseURL)/api"
    internal static let apiVersion = "v1"
    
    // MARK: - Types
    
    public enum AuthState: Equatable, CustomStringConvertible {
        case unknown
        case authorized
        case tokenExpired
        case unauthorized
        case failed(_ error: Error)
        
        public var description: String {
            switch self {
            case .unknown:
                return "Unknown authentication state"
            case .authorized:
                return "User authorized"
            case .tokenExpired:
                return "Token expired"
            case .unauthorized:
                return "User unauthorized"
            case .failed(let error):
                return "Authentication error: \(error.localizedDescription)"
            }
        }
        
        public static func == (lhs: Trefle.AuthState, rhs: Trefle.AuthState) -> Bool {
            
            switch (lhs, rhs) {
            case (.unknown, .unknown):
                return true
            case (.authorized, .authorized):
                return true
            case (.tokenExpired, .tokenExpired):
                return true
            case (.unauthorized, .unauthorized):
                return true
            case (let .failed(lhError), let .failed(rhError)):
                return lhError.localizedDescription == rhError.localizedDescription
            default:
                return false
            }
        }
    }
    
    // MARK: - Properties
    
    public var config: Config
    internal var accessToken: String = ""
    internal var uri: String = ""
    internal var jwtState: JWTState?
    internal var jwt: String? { jwtState?.jwt }
    internal var expires: Date? { jwtState?.expires }
    internal var isValid: Bool {
        guard let expires = self.expires else { return false }
        return Date() < expires
    }
    internal var stateUUID: String?
    public var authState: AuthState = .unknown {
        didSet {
            guard oldValue != authState else { return }
            authStateListenerQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else { return }
                self.authStateDidChangeListeners.values.forEach { (listener) in
                    DispatchQueue.main.async { listener(self.authState) }
                }
            }
        }
    }
    internal lazy var authStateDidChangeListeners = [UUID: ((authState: AuthState) -> Void)]()
    internal let authStateListenerQueue = DispatchQueue(label: "com.PigonaHill.TrefleSwiftSDK.AuthStateListenerQueue", attributes: .concurrent)
    internal static let operationUnderlyingQueue = DispatchQueue(label: "com.PigonaHill.TrefleSwiftSDK.TrefleAPIQueue", attributes: .concurrent)
    public static let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.TrefleSwiftSDK.OperationQueue"
        queue.underlyingQueue = operationUnderlyingQueue
        return queue
    }()
    
    // MARK: - Lifecycle
    
    private init(config: Config = .default) {
        self.config = config
    }
    
    public static func configure(accessToken: String, uri: String, config: Config = .default) {
        
        shared.config = config
        
        // Set access token and URI
        shared.accessToken = accessToken
        shared.uri = uri
        
        // Load the previous state, otherwise logout to reset state and re-authorize
        guard let stateUUID = shared.loadStateUUID() else {
            do {
                try Trefle.logout()
                Trefle.authorize()
            } catch {
                shared.authState = .failed(error)
            }
            return
        }
        
        // Set returned state
        shared.stateUUID = stateUUID
        
        // Load previous JWT state, otherwise logout to reset state and re-authorize
        guard let keychainAuthState = try? KeychainPasswordItem(service: Trefle.keychainServiceName, account: stateUUID).readObject() as JWTState else {
            do {
                try Trefle.logout()
                Trefle.authorize()
            } catch {
                shared.authState = .failed(error)
            }
            return
        }
        
        // Set returned JWT state
        shared.jwtState = keychainAuthState
        
        // Check if JWT state is valid, otherwise refresh token
        guard keychainAuthState.isValid == false else {
            shared.authState = .authorized
            return
        }
        
        Trefle.authorize()
    }
    
    // MARK: - State UUID
    
    internal func loadStateUUID() -> String? {
        
        guard let userDefaults = UserDefaults(suiteName: Trefle.userDefaultsSuiteName) else {
            return nil
        }
        return userDefaults.object(forKey: Trefle.userDefaultsKeychainStateUUID) as? String
    }
    
    @discardableResult
    internal func saveStateUUID(_ uuid: String) -> Bool {
        
        guard let userDefaults = UserDefaults(suiteName: Trefle.userDefaultsSuiteName) else {
            return false
        }
        
        userDefaults.set(uuid, forKey: Trefle.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        return true
    }
    
    @discardableResult
    internal func removeStateUUID() -> Bool {
        
        guard let userDefaults = UserDefaults(suiteName: Trefle.userDefaultsSuiteName) else {
            return false
        }
        userDefaults.removeObject(forKey: Trefle.userDefaultsKeychainStateUUID)
        userDefaults.synchronize()
        return true
    }
    
}
