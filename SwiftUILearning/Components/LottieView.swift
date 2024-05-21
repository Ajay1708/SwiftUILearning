//
//  LottieView.swift
//  jar-ios
//
//  Created by Ashu Tyagi on 08/06/23.
//

import SwiftUI
import Lottie
enum AnimationFileExtension: String {
    case lottie = "lottie"
    case json = "json"
}
struct LottieView: UIViewRepresentable {
    private let urlString: String?
    private let fileNameWithExtension: String?
    private let loopMode: LottieLoopMode
    private let contentMode: UIView.ContentMode
    private let onAnimationEnd: () -> Void
    private let animationDuration: ((_ value: Double) -> Void)?
    
    init(
        urlString: String? = nil,
        fileNameWithExtension: String? = nil,
        loopMode: LottieLoopMode = .loop,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        onAnimationEnd: @escaping () -> Void = {},
        animationDuration: ((_ value: TimeInterval) -> Void)? = nil
    ) {
        self.urlString = urlString
        self.fileNameWithExtension = fileNameWithExtension
        self.loopMode = loopMode
        self.contentMode = contentMode
        self.onAnimationEnd = onAnimationEnd
        self.animationDuration = animationDuration
    }
    
    func makeUIView(context: Context) -> some UIView {
        var view = UIView(frame: .zero)
        if let urlString, let url = URL(string: urlString) {
            let isJson = urlString.hasSuffix(AnimationFileExtension.json.rawValue)
            let isLottie = urlString.hasSuffix(AnimationFileExtension.lottie.rawValue)
            if isJson {
                LottieAnimation.loadedFrom(
                    url: url,
                    closure: { animation in
                        var animationView = LottieAnimationView()
                        configure(animationView: &animationView, animation: animation)
                        add(subView: &animationView, to: &view)
                    },
                    animationCache: nil
                )
            } else if isLottie {
                _ = LottieAnimationView(dotLottieUrl: url, completion: { animationView, err in
                    if err == nil {
                        var animationView = animationView
                        configure(animationView: &animationView, animation: nil)
                        add(subView: &animationView, to: &view)
                    }
                })
            }
        } else if let fileNameWithExtension {
            let (fileName, fileExtension) = separateFileNameAndExtension(from: fileNameWithExtension)
            switch fileExtension {
            case .json:
                var animationView = LottieAnimationView()
                let animation = LottieAnimation.named(fileName)
                configure(animationView: &animationView, animation: animation)
                add(subView: &animationView, to: &view)
            case .lottie:
                _ = LottieAnimationView(dotLottieName: fileName) { animationView, err in
                    if err == nil {
                        var animationView = animationView
                        configure(animationView: &animationView, animation: nil)
                        add(subView: &animationView, to: &view)
                    }
                }
            case .none:
                break
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    private func configure(animationView: inout LottieAnimationView, animation: LottieAnimation?) {
        if let animation {
            animationView.animation = animation
        }
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        if let duration = animationView.animation?.duration {
            self.animationDuration?(duration)
        }
        animationView.play { _ in
            onAnimationEnd()
        }
    }
    
    private func add(subView: inout LottieAnimationView, to mainView: inout UIView) {
        mainView.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.heightAnchor.constraint(equalTo: mainView.heightAnchor).isActive = true
        subView.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
    }
    
}

func separateFileNameAndExtension(from fileNameWithExtension: String) -> (baseName: String, fileExtension: AnimationFileExtension?) {
    let nsFileNameWithExtension = fileNameWithExtension as NSString
    let baseName = nsFileNameWithExtension.deletingPathExtension
    let fileExtension = AnimationFileExtension(rawValue: nsFileNameWithExtension.pathExtension)
    return (baseName, fileExtension)
}
