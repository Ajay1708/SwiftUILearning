//
//  TransitionDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 27/01/24.
//

import SwiftUI
enum Transitions: String, CaseIterable {
    case Slide
    case Scale
    case Opacity
    case Move
    case Asymmetric
}
struct TransitionDemo: View {
    @State var slideAnimation = false
    @State var scaleAnimation = false
    @State var opacityAnimation = false
    @State var moveAnimation = false
    @State var asymmetricAnimation = false
    var transitions = Transitions.allCases
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 10) {
                ForEach(transitions, id: \.self) { transition in
                    Button(transition.rawValue) {
                        switch transition {
                        case .Slide:
                            withAnimation(.easeInOut) {
                                scaleAnimation = false
                                opacityAnimation = false
                                moveAnimation = false
                                asymmetricAnimation = false
                                slideAnimation.toggle()
                            }
                        case .Scale:
                            withAnimation(.easeInOut) {
                                opacityAnimation = false
                                moveAnimation = false
                                asymmetricAnimation = false
                                slideAnimation = false
                                scaleAnimation.toggle()
                            }
                        case .Opacity:
                            withAnimation(.easeInOut) {
                                moveAnimation = false
                                asymmetricAnimation = false
                                slideAnimation = false
                                scaleAnimation = false
                                opacityAnimation.toggle()
                            }
                        case .Move:
                            withAnimation(.spring()) {
                                asymmetricAnimation = false
                                slideAnimation = false
                                scaleAnimation = false
                                opacityAnimation = false
                                moveAnimation.toggle()
                            }
                        case .Asymmetric:
                            withAnimation(.easeInOut) {
                                slideAnimation = false
                                scaleAnimation = false
                                opacityAnimation = false
                                moveAnimation = false
                                asymmetricAnimation.toggle()
                            }
                        }
                    }
                    .font(.headline)
                    .withColorStyle(transition: transition)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            if slideAnimation {
                // If the sliding view width is less than the screen width then use .frame(maxWidth: .infinity) to make the transition start from leading edge of the screen if not the transition animation will start from leading edge of RoundedRectangle frame
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.red)
                    .frame(height: UIScreen.main.bounds.size.height * 0.5)
                    .frame(width: 250) // Comment this line if you don't need it
                    .frame(maxWidth: .infinity)
                    .transition(.slide)
            }
            if scaleAnimation {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.blue)
                    .frame(height: UIScreen.main.bounds.size.height * 0.5)
                    .transition(.scale)
            }
            if opacityAnimation {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.green)
                    .frame(height: UIScreen.main.bounds.size.height * 0.5)
                    .transition(.opacity)
            }
            if moveAnimation {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.orange)
                    .frame(height: UIScreen.main.bounds.size.height * 0.5)
                    .transition(.move(edge: .bottom))
            }
            if asymmetricAnimation {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(.black)
                    .frame(height: UIScreen.main.bounds.size.height * 0.5)
                    .transition(.asymmetric(insertion: AnyTransition.move(edge: .leading), removal: AnyTransition.opacity))
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    TransitionDemo()
}

