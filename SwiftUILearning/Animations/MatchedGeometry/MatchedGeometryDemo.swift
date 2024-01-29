//
//  MatchedGeometryDemo.swift
//  SwiftUILearning
//
//  Created by Venkata Ajay Sai Nellori on 28/01/24.
//

import SwiftUI
struct MatchedGeometryDemo: View {
    var body: some View {
        MatchedGeometryDemo3()
    }
}
struct MatchedGeometryDemo1: View {
    @State private var isClicked: Bool = false
    @Namespace private var nameSpace
    @Namespace private var circleID
    var body: some View {
        GeometryReader(content: { geometry in
            VStack {
                if !isClicked {
                    Circle()
                        .matchedGeometryEffect(id: circleID, in: nameSpace)// Always use matchedGeometryEffect before setting frame
                        .frame(width: 100, height: 100)
                        .offset(y: -(100+geometry.safeAreaInsets.top))
                }
                Spacer()
                if isClicked {
                    Circle()
                        .matchedGeometryEffect(id: circleID, in: nameSpace)// Always use matchedGeometryEffect before setting frame
                        .frame(width: 200, height: 200)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .onTapGesture {
                //Always use animation otherwise you can't see the effect.
                withAnimation(.bouncy(duration: 1)) {
                    isClicked.toggle()
                }
            }
        })
        
    }
}
#Preview {
    return MatchedGeometryDemo1()
}

struct MatchedGeometryDemo2: View {
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = "Home"
    @Namespace private var homeID
    @Namespace private var namespace
    @ViewBuilder
    func categorySample1(category: String) -> some View {
        ZStack {
            if selected == category {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red.opacity(0.5))
                    .matchedGeometryEffect(
                        id: homeID,
                        in: namespace
                    )
            }
            Text(category)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
    }
    func categorySample2(category: String) -> some View {
        ZStack {
            if selected == category {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red.opacity(0.5))
                    .frame(width: 35, height: 2)
                    .offset(y: 20)
                    .matchedGeometryEffect(
                        id: homeID,
                        in: namespace
                    )
            }
            Text(category)
                .foregroundStyle(selected == category ? Color.red : Color.black)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
    }
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                categorySample2(category: category)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selected = category
                        }
                    }
            }
        }
        .padding()
    }
}
#Preview {
    return MatchedGeometryDemo2()

}
struct MatchedGeometryDemo3: View {
    @State private var isExpanded = false
    @Namespace private var profileIcon
    @Namespace private var profileName
    @Namespace private var profileJob
    @Namespace private var nameSpace
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if !isExpanded {
                    collapsedProfileView()
                } else {
                    expandedProfileView()
                }
                listView()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func collapsedProfileView() -> some View {
        HStack(alignment: .top) {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .matchedGeometryEffect(id: profileIcon, in: nameSpace)
                .frame(width: 80, height: 80)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }
            VStack(alignment: .leading, spacing: 0) {
                Text("Ajay Sai")
                    .font(.title).bold()
                    .matchedGeometryEffect(id: profileName, in: nameSpace)
                Text("iOS Developer")
                    .foregroundStyle(.secondary)
                    .matchedGeometryEffect(id: profileJob, in: nameSpace)
            }
            Spacer()
        }
    }
    @ViewBuilder
    func expandedProfileView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Image(systemName: "photo.circle.fill")
                .resizable()
                .clipShape(Circle())
                .matchedGeometryEffect(id: profileIcon, in: nameSpace)
                .frame(width: 130, height: 130)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }
            Text("Ajay Sai")
                .font(.title).bold()
                .matchedGeometryEffect(id: profileName, in: nameSpace)
            Text("iOS Developer")
                .foregroundStyle(.pink)
                .matchedGeometryEffect(id: profileJob, in: nameSpace)
            Text("I work in Jar. I have 3+ years of experience in iOS App Development.")
                .multilineTextAlignment(.center)
                .font(.footnote)
            Spacer()
        }
    }
    
    @ViewBuilder
    func listView() -> some View {
        ForEach(1...10, id:\.self) { value in
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        }
    }
}
#Preview {
    MatchedGeometryDemo3()
}
