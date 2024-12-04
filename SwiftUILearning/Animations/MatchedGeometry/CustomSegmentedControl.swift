//
//  CustomSegmentedControl.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 01/12/24.
//

import SwiftUI
enum SegmentedControlState: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case home = "Home"
    case notifications = "Notifications"
    case settings = "Settings"
}

struct CustomSegmentedControl<Segment: Identifiable & Hashable, Content: View, SegmentViewBackground: View, SegmentControlBackground: View>: View {
    @Binding var selectedSegment: Segment
    @Namespace private var segmentedControlNamespace
    
    let segments: [Segment]
    let segmentView: (Segment, Bool) -> Content
    let segmentSpacing: CGFloat
    let animation: Animation
    let padding: CGFloat
    let segmentViewBackground: () -> SegmentViewBackground
    let segmentControlBackground: () -> SegmentControlBackground
    
    
    init (
        segments: [Segment],
        selectedSegment: Binding<Segment>,
        segmentSpacing: CGFloat = 10,
        padding: CGFloat,
        animation: Animation = .snappy,
        @ViewBuilder segmentView: @escaping(Segment, Bool) -> Content,
        @ViewBuilder segmentViewBackground: @escaping () -> SegmentViewBackground,
        @ViewBuilder segmentControlBackground: @escaping () -> SegmentControlBackground
    ) {
        self.segments = segments
        self._selectedSegment = selectedSegment
        self.segmentSpacing = segmentSpacing
        self.padding = padding
        self.animation = animation
        self.segmentView = segmentView
        self.segmentViewBackground = segmentViewBackground
        self.segmentControlBackground = segmentControlBackground
    }
    
    var body: some View {
        HStack(spacing: segmentSpacing) {
            ForEach(segments) { segment in
                Button(
                    action: {
                        withAnimation(animation) {
                            selectedSegment = segment
                        }
                    },
                    label: {
                        segmentView(segment, selectedSegment == segment)
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    selectedSegment = segment
                                }
                            }
                            .matchedGeometryEffect(
                                id: segment,
                                in: segmentedControlNamespace
                            )
                    }
                )
            }
        }
        .background(
            segmentViewBackground()
                .matchedGeometryEffect(
                    id: selectedSegment,
                    in: segmentedControlNamespace,
                    isSource: false
                )
        )
        .padding(padding)
        .background(segmentControlBackground())
    }
}

@available(iOS 17.0, *)
#Preview("Capsule Segment") {
    @Previewable @State var selectedSegment = SegmentedControlState.home
    CustomSegmentedControl(
        segments: SegmentedControlState.allCases, selectedSegment: $selectedSegment,
        padding: 6,
        segmentView: { segment, isSelected in
            Text(segment.rawValue)
                .padding(10)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(isSelected ? .white : .gray)
        },
        segmentViewBackground: {
            Capsule()
                .fill(Color.red)
        },
        segmentControlBackground: {
            Capsule()
                .fill(Color.gray.opacity(0.5))
        }
    )
}

@available(iOS 17.0, *)
#Preview("Line Segment") {
    @Previewable @State var selectedSegment = SegmentedControlState.home
    CustomSegmentedControl(
        segments: SegmentedControlState.allCases, selectedSegment: $selectedSegment,
        segmentSpacing: 0, padding: 0,
        animation: Animation.easeInOut,
        segmentView: { segment, isSelected in
            HStack {
                Spacer()
                Text(segment.rawValue)
                    .padding(10)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(isSelected ? .red : .black)
                Spacer()
            }
        },
        segmentViewBackground: {
            Rectangle()
                .fill(Color.red)
                .frame(height: 1)
                .scaleEffect(x: 0.2)
        },
        segmentControlBackground: {
            Color.clear
        }
    )
    .padding(.horizontal, 10)
}

@available(iOS 17.0, *)
#Preview("Rounded Rectangle Segment") {
    @Previewable @State var selectedSegment = SegmentedControlState.home
    CustomSegmentedControl(
        segments: SegmentedControlState.allCases, selectedSegment: $selectedSegment,
        segmentSpacing: 10, padding: 5,
        animation: Animation.easeInOut,
        segmentView: { segment, isSelected in
                Text(segment.rawValue)
                    .padding(10)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(isSelected ? .black : .gray)
        },
        segmentViewBackground: {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
        },
        segmentControlBackground: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
        }
    )
    .padding(.horizontal, 10)
}
