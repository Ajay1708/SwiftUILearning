//
//  CustomSlider.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 18/05/24.
//

import SwiftUI

/// Create UIViewRepresentable instance to create and manage a UIView object in your SwiftUI interface. Adopt this protocol and use its methods `makeUIView(context:)` and `updateUIView(_:, context:)`  to create and update your view.
///
/// The system doesn’t automatically communicate changes occurring within your view to other parts of your SwiftUI interface. When you want your view to coordinate with other SwiftUI views, you must provide a Coordinator instance to facilitate those interactions. For example, you use a coordinator to forward target-action and delegate messages from your view to any SwiftUI views.
struct CustomSlider: UIViewRepresentable {
    private let minimumValue: Float
    private let maximumValue: Float
    private let stepCount: Float
    private let minimumTrackTintColor: UIColor
    private let maximumTrackTintColor: UIColor
    private let thumbTintColor: UIColor
    private let minimumValueImage: UIImage?
    private let maximumValueImage: UIImage?
    private let thumbImageNormal: UIImage?
    private let thumbImageHighlighted: UIImage?
    private let trackLineHeight: CGFloat
    
    @Binding var sliderCurrentValue: String
    
    init(minimumValue: Float, maximumValue: Float,
         stepCount: Float = 1,
         minimumTrackTintColor: UIColor = UIColor.systemBlue,
         maximumTrackTintColor: UIColor = UIColor.systemGray4,
         thumbTintColor: UIColor = UIColor.white,
         minimumValueImage: UIImage? = nil,
         maximumValueImage: UIImage? = nil,
         thumbImageNormal: UIImage? = nil,
         thumbImageHighlighted: UIImage? = nil,
         trackLineHeight: CGFloat = 4,
         sliderCurrentValue: Binding<String>
    ) {
        self.minimumValue = minimumValue
        self.maximumValue = maximumValue
        self.stepCount = stepCount
        self.minimumTrackTintColor = minimumTrackTintColor
        self.maximumTrackTintColor = maximumTrackTintColor
        self.thumbTintColor = thumbTintColor
        self.minimumValueImage = minimumValueImage
        self.maximumValueImage = maximumValueImage
        self.thumbImageNormal = thumbImageNormal
        self.thumbImageHighlighted = thumbImageHighlighted
        self.trackLineHeight = trackLineHeight
        self._sliderCurrentValue = sliderCurrentValue
    }
    
    func makeUIView(context: Context) -> UISlider {
        // Here we are configuring the UISlider view
        // Note: We are configuring only once because makeUIView will be called once during initialisation
        let slider = MySlider(frame: .zero)
        slider.trackLineHeight = trackLineHeight
        slider.minimumTrackTintColor = minimumTrackTintColor
        slider.maximumTrackTintColor = maximumTrackTintColor
        slider.thumbTintColor = thumbTintColor
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        slider.minimumValueImage = minimumValueImage
        slider.maximumValueImage = maximumValueImage
        slider.minimumValue = minimumValue
        slider.maximumValue = maximumValue
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.sliderValueChanged(_:)),
            for: .valueChanged
        )
        return slider
    }
    
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        // when ever there are changes outside this struct we are updating those changes here
        // For Example if we have a toggle in a view on tap of that toggle we are changing the minimum value and maximum value and slider current value. Those values can be updated here
        uiView.minimumValue = minimumValue
        uiView.maximumValue = maximumValue
        uiView.value = sliderCurrentValue.toFloat()
        
        // Don't forgot to update the coordinator properties here
        context.coordinator.stepCount = stepCount
    }
        
    final class Coordinator: NSObject {
        var stepCount: Float
        var sliderCurrentValue: Binding<String>
        
        init(
            stepCount: Float,
            sliderCurrentValue: Binding<String>
        ) {
            self.stepCount = stepCount
            self.sliderCurrentValue = sliderCurrentValue
        }
        
        @objc func sliderValueChanged(_ slider: UISlider) {
            let sliderCurrentValueRounded = round(slider.value / stepCount) * stepCount
            let sliderCurrentValueFormatted = sliderCurrentValueRounded.toString()
            self.sliderCurrentValue.wrappedValue = sliderCurrentValueFormatted
            
            slider.value = sliderCurrentValueRounded
        }
    }
    
    // makeCoordinator will only be called once during initialisation of CustomSlider
    func makeCoordinator() -> Coordinator {
        Coordinator(
            stepCount: stepCount,
            sliderCurrentValue: $sliderCurrentValue
        )
    }
}

private class MySlider: UISlider {
    @IBInspectable var trackLineHeight: CGFloat = 4
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackLineHeight
        return newRect
    }
}

// MARK: - PREVIEWS
struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(
            minimumValue: 1,
            maximumValue: 10,
            sliderCurrentValue: .constant("1")
        )
        .padding(.horizontal, 16)
        
        CustomSlider(
            minimumValue: 1,
            maximumValue: 10,
            minimumTrackTintColor: UIColor(red: 119/255, green: 69/255, blue: 255/255, alpha: 1),
            maximumTrackTintColor: UIColor(red: 60/255, green: 51/255, blue: 87/255, alpha: 1),
            minimumValueImage: UIImage(systemName: "sun.min"),
            maximumValueImage: UIImage(systemName: "sun.min.fill"),
            thumbImageNormal: UIImage(named: "thumbImage"),
            thumbImageHighlighted: UIImage(systemName: "thumbImage"),
            sliderCurrentValue: .constant("1")
        )
        .padding(.horizontal, 16)
    }
}

extension String {
    func toFloat() -> Float {
        Float(self) ?? 0
    }
}
