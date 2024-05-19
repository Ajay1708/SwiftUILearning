//
//  SliderDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 18/05/24.
//

import SwiftUI

struct CustomSliderDemo: View {
    @State var sliderMinimumValue: Float = 1
    @State var sliderMaximumValue: Float = 12
    @State var stepCount: Float = 2
    @State var sliderCurrentValue: String = "1"
    
    private let minimumTrackTintColor = UIColor(red: 119/255, green: 69/255, blue: 255/255, alpha: 1)
    private let maximumTrackTintColor = UIColor(red: 60/255, green: 51/255, blue: 87/255, alpha: 1)
    private let thumbImage = UIImage(named: "thumbImage")
    var body: some View {
        VStack {
            Spacer()
            
            Text("Slider Value \(sliderCurrentValue)")
                        
            CustomSlider(
                minimumValue: sliderMinimumValue,
                maximumValue: sliderMaximumValue,
                stepCount: stepCount,
                minimumTrackTintColor: minimumTrackTintColor,
                maximumTrackTintColor: maximumTrackTintColor,
                thumbImageNormal: thumbImage,
                thumbImageHighlighted: thumbImage,
                trackLineHeight: 8,
                sliderCurrentValue: $sliderCurrentValue
            )
            .onChange(of: sliderCurrentValue) {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
            
            HStack {
                Text("\(sliderMinimumValue.toString())")
                
                Spacer()
                
                Text("\(sliderMaximumValue.toString())")
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                sliderCurrentValue = "1"
                sliderMinimumValue = 1
                sliderMaximumValue = 6
                stepCount = 1
            })
        }
    }
}

#Preview {
    CustomSliderDemo()
}
