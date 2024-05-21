//
//  LottieViewAnimationDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 19/05/24.
//

import SwiftUI

struct LottieViewAnimationDemo: View {
    let urlString: String?
    let fileNameWithExtension: String?
    var contentMode: UIView.ContentMode = .scaleAspectFit
    
    var body: some View {
        LottieView(
            urlString: urlString,
            fileNameWithExtension: fileNameWithExtension,
            contentMode: contentMode
        )
        .allowsHitTesting(false)
    }
}

// MARK: PREVIEWS
struct LottieViewAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LottieViewAnimationDemo(
            urlString: K.LottieResource.LottieUrl.postPurchaseRupee,
            fileNameWithExtension: nil
        )
        
        LottieViewAnimationDemo(
            urlString: K.LottieResource.LottieUrl.emiCalculator,
            fileNameWithExtension: nil
        )
        
        LottieViewAnimationDemo(
            urlString: nil,
            fileNameWithExtension: K.LottieResource.LottieFile.lockerOnboarding,
            contentMode: .scaleToFill
        )
        .frame(width: 300, height: 400)
        
        
        ZStack {
            Button(action: {
                print("Trash icon tapped")
            }) {
                Label("Trash", systemImage: "trash")
            }
            
            LottieViewAnimationDemo(
                urlString: nil,
                fileNameWithExtension: K.LottieResource.LottieFile.confetti
            )
        }
    }
}

