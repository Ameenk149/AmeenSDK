//
//  Constants.swift
//  GiveawayInsel
//
//  Created by Muhammad Ameen Qadri on 20.09.23.
//

import Foundation

struct Constants {
    static let EMPTY_STRING = ""
    struct bindings {
        static let nameAnswer = "nameAnswer"
        static let descriptionAnswer = "descriptionAnswer"
        static let categoryAnswer = "categoryAnswer"
        static let conditionAnswer = "conditionAnswer"
        static let methodAnswer = "methodAnswer"
        static let addressAnswer = "addressAnswer"
        static let availabilityTimeAnswer = "availabilityTimeAnswer"
        static let pointsAnswer = "pointsAnswer"
   }
    
    struct productData {
        static let addProductDataUserDefaultKey = "addProductData"
    }
    
    struct UserDefaults {
        static let isOnboardingDone = "onboardingCompleted"
        static let newSignUp = "newSignUp"
    }
}

struct FirebaseEntity {
    struct User {
        static let email = "email"
        static let fullName = "full_name"
        static let users = "users"
    }
}
