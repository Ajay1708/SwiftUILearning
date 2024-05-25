//
//  CustomPageControl.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 24/05/24.
//

import SwiftUI

struct CustomPageControl: View {
    let noofPages: Int
    @Binding var selectedPage: Int
    private let backgroundColor:UIColor = #colorLiteral(red: 0.3026003242, green: 0.2681753039, blue: 0.4163053632, alpha: 1)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<noofPages, id: \.self) { currentPage in
                if selectedPage == currentPage {
                    ProgressCorousel()
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(backgroundColor))
        }
    }
}

struct ProgressCorousel: View {
    @State private var progressValue: CGFloat = 0
    var body: some View {
        GeometryReader { reader in
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
                .frame(width: 32, height: 8)
            
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .frame(width: reader.size.width * progressValue, height: 8)
        }
        .frame(width: 32, height: 8)
        .animation(.linear(duration: 4), value: progressValue)
        .onAppear {
            progressValue = 1
        }
        .onDisappear {
            progressValue = 0
        }
    }
}

#Preview {
    let backgroundColor: UIColor = #colorLiteral(red: 0.1529411765, green: 0.1333333333, blue: 0.2235294118, alpha: 1)
    return ZStack {
        Color(backgroundColor).ignoresSafeArea(.all)
        
        CustomPageControl(noofPages: 4, selectedPage: .constant(0))
    }
}
