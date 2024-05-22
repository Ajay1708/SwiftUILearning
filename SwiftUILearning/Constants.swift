//
//  Constants.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 19/05/24.
//

import Foundation
struct K {
    struct LottieResource {
        static let lottieDomain = "https://d21tpkh2l1zb46.cloudfront.net"
        struct LottieFile {
            static let lockerOnboarding = "lockerOnboarding.lottie"
            static let confetti = "confetti.json"
        }
        
        struct LottieUrl {
            static let postPurchaseRupee = "\(K.LottieResource.lottieDomain)/LottieFiles/Generic/rupee_post_purchase_success.json"
            static let emiCalculator = "\(K.LottieResource.lottieDomain)/LottieFiles/Lending_Feature/EMI_CAL_Loader.lottie"
            static let noteStack = "\(K.LottieResource.lottieDomain)/LottieFiles/GoldSip/note_stack.json"
        }
    }
}
