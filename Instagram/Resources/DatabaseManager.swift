//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Tsung Wei Wu on 11/20/20.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    // can I create this account
    /// Check if username and email is available
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Inserts new user data to database
    /// - Parameters
    ///     - email: String representing email
    ///     - username: String representing username
    ///     - completion: Async callback for result if database entry succeeded
    public func insertNewUser(fullname: String, with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username, "fullname": fullname]) { error, _ in
            if error == nil {
                // succeeded
                completion(true)
                return
            }
            else {
                // failed
                completion(false)
                return
            }
        }
    }
}
