//
//  LoadingView.swift
//  Broken Calc
//
//  Created by Nathan Lee on 30/1/2024.
//

import SwiftUI

enum loadingAnimation: CaseIterable {
    case bottom1, top1, bottom2, top2, bottom3, top3, bottom4, top4, scale
    
    var offsetY: Double {
        switch self {
        case .bottom1, .bottom2, .bottom3, .bottom4: 0
        case .top1, .top2, .top3, .top4: 75
        case .scale: -800
        }
    }
    
    var stage: Int {
        switch self {
        case .bottom1: 1
        case .top1: 1
        case .bottom2: 2
        case .top2: 2
        case .bottom3: 3
        case .top3: 3
        case .bottom4: 4
        case .top4: 4
        case .scale: 5
        }
    }
    
    var scale: Double {
        switch self {
        case .bottom1, .bottom2, .bottom3, .bottom4, .top1, .top2, .top3, .top4: 0.05
        case .scale: 0.36
        }
    }
    
    var opacity: Double {
        switch self {
        case .bottom1, .bottom2, .bottom3, .bottom4, .top1, .top2, .top3, .top4: 1
        case .scale: 1
        }
    }
}

struct LoadingView: View {
    @EnvironmentObject var globalVar: GlobalVar
    @State var trigger: Int = 0
    @State var rotation: Double = -30
    @State var transition: Bool = false
    @State var imageOffset: Double = -200

    var body: some View {
        Group {
            GeometryReader { screen in
                Group {
                    if !transition {
                        ZStack {
                            globalVar.theme.colorScheme.background
                                .ignoresSafeArea(.all)
                            
                            Image("Calculator@3x")
                                .phaseAnimator(loadingAnimation.allCases, trigger: trigger) { content, phase in
                                    content
                                        .opacity(phase.opacity)
                                        .rotationEffect(.degrees(rotation), anchor: UnitPoint(x: 0.5, y: 0.5))
                                        .scaleEffect(phase.scale)
                                        .offset(y: phase.offsetY)
                                        .onChange(of: phase.stage) { oldValue, newValue in
                                            if newValue.isMultiple(of: 2) {
                                                withAnimation {
                                                    rotation += 240
                                                }
                                            } else {
                                                if newValue == 5 {
                                                    withAnimation {
                                                        rotation += 152
                                                    }
                                                } else {
                                                    withAnimation {
                                                        rotation += 480
                                                    }
                                                }
                                            }
                                        }
                                    
                                } animation: { phase in
                                    switch phase {
                                    case .bottom1, .bottom2, .bottom3, .bottom4: .easeOut(duration: 0.3)
                                    case .top1, .top2, .top3, .top4: .easeIn(duration: 0.5)
                                    case .scale: .easeIn(duration: 0.3)
                                    }
                                }
                                .onAppear {
                                    trigger += 1
                                }
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                                        transition = true
                                    }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                    }
                                }
                                .offset(y: -75)
                        }
                    } else {
                        VStack(spacing: 0) {
                            globalVar.theme.colorScheme.background
                                .frame(width: 393, height: 1200)
                                .overlay {
                                    VStack {
                                        Image("Calculator@3x")
                                            .scaleEffect(0.315)
                                            .frame(width: 100, height: 100)
                                            .opacity(1)
                                        Spacer()
                                    }
                                }
                        }
                        .offset(y: imageOffset)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                imageOffset = 1400
                            }
                        }

                    }
                }
                .position(x: screen.frame(in: .local).midX, y: screen.frame(in: .local).midY)
                .scaleEffect(screen.size.height / 759)
            }
        }
        .aspectRatio(393/759, contentMode: .fit)

    }
}

#Preview {
    LoadingView()
}
