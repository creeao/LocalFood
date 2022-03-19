//
//  EditProfileModels.swift
//  LocalFood
//
//  Created by Eryk Chrustek on 19/03/2022.
//

import Foundation

enum EditProfile {
    enum Content {
        struct Request {
            
        }
        
        struct Response {
            let data: Account
        }
        
        struct ViewModel {
            let data: Account
        }
    }
    
    enum Edit {
        struct Request {
            let data: Account
        }
        
        struct Response {
            let isEditSuccessfull: Bool
        }
        
        struct ViewModel {
            let isEditSuccessfull: Bool
        }
    }
}
