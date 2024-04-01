//
//  SwiftUIView.swift
//  Swift Student Challenge 2024
//
//  Created by Nathan Lee on 26/1/2024.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var globalVar: GlobalVar
    @State private var counter: Int = 0 // to force update button view
    @State var star1 = false
    @State var star2 = false
    @State var star3 = false
    
    var body: some View {
        Group {
            GeometryReader { screen in
                VStack {
                    // Text
                    ZStack {
                        RoundedRectangle(cornerRadius: 300)
                            .fill(globalVar.theme.colorScheme.background.opacity(1))
                            .frame(width: 485, height: 275)
                            .blur(radius: 75)
                        if globalVar.gameProgress == "ended" {
                            if globalVar.level == 0 {
                                VStack {
                                    if globalVar.isHighScore {
                                        Text("New High Score:")
                                            .font(.system(size: 30, weight: .heavy, design: .default))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .kerning(2)
                                            .frame(alignment: .center)
                                        Text(String(format: "%05d", globalVar.score))
                                            .font(.system(size: 75, weight: .heavy, design: .monospaced))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .kerning(2)
                                            .frame(alignment: .center)
                                    } else {
                                        Text("Score:")
                                            .font(.system(size: 30, weight: .heavy, design: .default))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .kerning(2)
                                            .frame(alignment: .center)
                                        Text(String(globalVar.score))
                                            .font(.system(size: 75, weight: .heavy, design: .monospaced))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .kerning(2)
                                            .frame(alignment: .center)
                                            .padding(.bottom, 1)
                                        Text("High Score: " + String(format: "%05d", globalVar.highScore))
                                            .font(.system(size: 25, weight: .heavy, design: .default))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .kerning(2)
                                            .frame(alignment: .center)
                                    }
                                }
                            } else {
                                VStack {
                                    Text("Level \(globalVar.level)")
                                        .font(.system(size: 30, weight: .heavy, design: .default))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .kerning(2)
                                        .frame(alignment: .center)
                                    HStack(spacing: 15) {
                                        Image(systemName: star1 ? "star.fill" : "star")
                                            .font(.system(size: 67))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .contentTransition(.symbolEffect)
                                            .frame(alignment: .center)
                                        Image(systemName: star2 ? "star.fill" : "star")
                                            .font(.system(size: 67))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .contentTransition(.symbolEffect)
                                            .frame(alignment: .center)
                                        Image(systemName: star3 ? "star.fill" : "star")
                                            .font(.system(size: 67))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .contentTransition(.symbolEffect)
                                            .frame(alignment: .center)
                                    }
                                    .padding(.top, 2)
                                }
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                        if globalVar.score >= 1 {
                                            star1 = true
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        if globalVar.score >= 2 {
                                            star2 = true
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                                        if globalVar.score >= 3 {
                                            star3 = true
                                        }
                                    }
                                }
                            }
                        } else {
                            if globalVar.gameProgress == "paused" {
                                VStack {
                                    Text("Game")
                                        .font(.system(size: 30, weight: .heavy, design: .default))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .kerning(2)
                                        .frame(alignment: .center)
                                    Text("Paused")
                                        .font(.system(size: 75, weight: .heavy, design: .default))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .kerning(2)
                                        .frame(alignment: .center)
                                }
                            } else {
                                VStack {
                                    Text("Broken")
                                        .font(.system(size: 30, weight: .heavy, design: .default))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .kerning(2)
                                        .frame(alignment: .center)
                                    Text("Calculator")
                                        .font(.system(size: 62.5, weight: .heavy, design: .default))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .kerning(2)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                    }
                    .frame(height: 250)
                    .padding(.top, 90)
                    .padding(.bottom, 80)
                    
                    // Buttons
                    VStack (spacing: 15) {
                        
                        // New game button
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                globalVar.level = 0
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.game = (target: 000, numbers: [0, 0, 0, 0, 0])
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(menuButton(label: {
                            HStack (spacing: 0) {
                                Image(systemName: "plus.circle.fill")
                                    .bold()
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .symbolRenderingMode(.monochrome)
                                    .scaleEffect(1.7)
                                    .frame(width: 25)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                
                                Text("New Game")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                
                                Spacer()
                            }
                        }, labelExpanded: {}, counter: counter, globalVar: _globalVar, type: "new"))
                        
                        
                        if globalVar.levelsExpanded {
                            Spacer(minLength: 150)
                            if globalVar.levelInfoPopup {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(globalVar.theme.colorScheme.tertiary)
                                    .strokeBorder(globalVar.theme.colorScheme.primary, lineWidth: 2)
                                    .frame(width: 300, height: 110)
                                    .padding(.bottom, 5)
                                    .overlay {
                                        ZStack {
                                            VStack {
                                                Text("These levels were specially curated, increasing in difficulty as you progress. You receive 1 star if you are less than 100 away from the target, 2 stars if you are less than 10 away and 3 stars if you reach the target.")
                                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 8)
                                                Spacer()
                                            }
                                            Button("") {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                                    if globalVar.haptics {
                                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                                    }
                                                }
                                                withAnimation {
                                                    globalVar.levelInfoPopup = false
                                                }
                                            }
                                            .buttonStyle(symbolButton(globalVar: globalVar, symbol: "xmark", enabled: true))
                                            .position(CGPoint(x: 298, y: 3))
                                        }
                                        .frame(width: 300, height: 110)
                                    }
                            }
                        }
                        
                        
                        
                        // Levels button
                        Button("") {
                            globalVar.levelsExpanded.toggle()
                            globalVar.howToPlayExpanded = false
                            globalVar.settingsExpanded = false
                            counter += 1
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                            }
                        }
                        .buttonStyle(menuButton(label: {
                            HStack (spacing: 0) {
                                Image(systemName: "star.circle.fill")
                                    .bold()
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .symbolRenderingMode(.monochrome)
                                    .scaleEffect(1.7)
                                    .frame(width: 25)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                
                                Text("Levels")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                Spacer()
                            }
                    }, labelExpanded: {
                        LevelsView()
                            .environmentObject(globalVar)
                    }, amount: 560, counter: counter, globalVar: _globalVar, type: "levels"))
                        
                        
                        
                        if globalVar.settingsExpanded {
                            Spacer(minLength: 100)
                        }
                        
                        if globalVar.levelsExpanded {
                            Spacer(minLength: 420)
                        }
                        
                        
                        
                        // Settings button
                        Button("") {
                            globalVar.settingsExpanded.toggle()
                            globalVar.levelsExpanded = false
                            globalVar.howToPlayExpanded = false
                            counter += 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                            }
                        }
                        .buttonStyle(menuButton(label: {
                            HStack (spacing: 0) {
                                Image(systemName: "gearshape.circle.fill")
                                    .bold()
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .symbolRenderingMode(.monochrome)
                                    .scaleEffect(1.7)
                                    .frame(width: 25)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                
                                Text("Settings")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                Spacer()
                            }
                        }, labelExpanded: {
                            
                            SettingsView()
                                .environmentObject(globalVar)
                            
                            
                        }, amount: 575, counter: counter, globalVar: _globalVar, type: "settings"))
                        
                        
                        if globalVar.howToPlayExpanded {
                            Spacer(minLength: 100)
                        }
                        
                        if globalVar.settingsExpanded {
                            Spacer(minLength: 555)
                        }
                        
                        

                        // How to play button
                        Button("") {
                            globalVar.howToPlayExpanded.toggle()
                            globalVar.levelsExpanded = false
                            globalVar.settingsExpanded = false
                            counter += 1
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                            }
                        }
                        .buttonStyle(menuButton(label: {
                            HStack (spacing: 0) {
                                Image(systemName: "questionmark.circle.fill")
                                    .bold()
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .symbolRenderingMode(.monochrome)
                                    .scaleEffect(1.7)
                                    .frame(width: 25)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                
                                Text("How to play")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 30, weight: .bold, design: .rounded))
                                Spacer()
                            }
                        }, labelExpanded: {
                            
                            VStack {
                                Text("""
                In this game, you are given **3 small** numbers and **2 big** numbers. The aim is to use the given numbers and basic **math operators** to make numbers that are as close to the **3-digit target** number as possible in **60 seconds**. You may only use each number **once**. Each number you create adds to your score based on **how far away** it is from the target number.
                """)
                                .font(.system(size: 19, weight: .regular, design: .rounded))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 5)
                                
                                Text("""
                **Distance**  | **Points**
                -------------------
                0         | 2500
                0   < 10  | 1250
                10  < 50  | 750
                50  < 100 | 500
                100 < 200 | 250
                200 < 300 | 100
                300 < 400 | 50
                400 < 500 | 50
                500 < ∞   | 25
                """)
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                .multilineTextAlignment(.leading)
                            }
                            .padding(.all)
                        }, amount: 560, counter: counter, globalVar: _globalVar, type: "how"))
                        
                        
                        
                        
                        if globalVar.howToPlayExpanded {
                            Spacer(minLength: 720)
                        }
                        
                    }
                    .padding(.bottom, 30)
                    
                    Image(systemName: globalVar.showMenu ? "chevron.compact.up" : "chevron.compact.down")
                        .bold()
                        .scaleEffect(2.5)
                        .foregroundStyle(.gray.opacity(0.5))
                        .padding(.bottom, 30)
                        .contentTransition(.symbolEffect)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                globalVar.showMenu = false
                            }
                        }
                    
                }
                .animation(.linear, value: globalVar.settingsExpanded)
                .animation(.linear, value: globalVar.howToPlayExpanded)
                .animation(.linear, value: globalVar.levelsExpanded)
                .position(x: screen.frame(in: .local).midX, y: screen.frame(in: .local).midY)
                .scaleEffect(screen.size.height / 759)
            }
        }
        .aspectRatio(393/759, contentMode: .fit)
        
    }
    
    
}
