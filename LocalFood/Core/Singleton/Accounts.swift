//
//  Accounts.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 12/03/2022.
//

import Foundation

class Accounts {
    private var accounts: [Account] = []
    private var loginAccount: Account?
    
    static let shared = Accounts()
    
    private init() {}
    
    func addAccount(_ account: Account) {
        accounts.append(account)
    }
    
    func login(email: String, password: String) -> Bool {
        if let account = accounts.first(where: { $0.email == email && $0.password == password }) {
            loginAccount = account
            return true
        } else {
            return false
        }
    }
    
    func accountExist(email: String) -> Bool {
        if let _ = accounts.first(where: { $0.email == email }) {
            return true
        } else {
            return false
        }
    }
    
    func logout() {
        loginAccount = nil
    }
    
    func getLoginAccount() -> Account? {
        return loginAccount
    }
    
    func editData(_ newData: Account) -> Bool {
        if let _ = accounts.first(where: { $0.email == loginAccount?.email && $0.password == loginAccount?.password }) {
            accounts.removeAll { $0.email == loginAccount?.email && $0.password == loginAccount?.password
            }
            addAccount(newData)
            loginAccount = newData
            return true
        } else {
            return false
        }
    }
}
