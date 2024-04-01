import SwiftUI
import Foundation

struct CalcButton: Identifiable {
    let id = UUID()
    let label: String
}

enum countdownAni: CaseIterable {
    case start, middle, end
    
    var scale: Double {
        switch self {
        case .start:  1
        case .middle: 0.5
        case .end: 0.5
        }
    }
    
    var opacity: Double {
        switch self {
        case .start:  0
        case .middle: 1
        case .end: 0
        }
    }
}


struct GameView: View {
    @EnvironmentObject var globalVar: GlobalVar
    @State private var counter: CGFloat = 0
    @State private var gameOver: CGFloat = 0
    @State private var expressionScroll: Int?
    @State private var timer: Timer?
    @State private var swipeHintOpacity: Double = 0
    var body: some View {
        
        let buttons: [[String]] = [
            ["(", ")", "÷"],
            ["\(globalVar.game.numbers[0])", "\(globalVar.game.numbers[1])", "×"],
            ["\(globalVar.game.numbers[2])", "\(globalVar.game.numbers[3])", "−"],
            ["\(globalVar.game.numbers[4])", "⌫", "+"]
        ]
        Group {
            GeometryReader { screen in
                VStack {
                    Text("Swipe down to exit")
                        .opacity(swipeHintOpacity)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(.gray.opacity(0.5))
                        .ignoresSafeArea(.all)
                        .padding(.bottom, 10)
                    Image(systemName: globalVar.showMenu ? "chevron.compact.up" : "chevron.compact.down")
                        .bold()
                        .scaleEffect(2.5)
                        .foregroundStyle(.gray.opacity(0.5))
                        .padding(.bottom, 10)
                        .contentTransition(.symbolEffect)
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                globalVar.showMenu = true
                            }
                        }
                    
                    if globalVar.gameInfoPopup {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(globalVar.theme.colorScheme.tertiary)
                            .strokeBorder(globalVar.theme.colorScheme.primary, lineWidth: 2)
                            .frame(width: 300, height: 75)
                            .padding(.bottom, 5)
                            .padding(.top, 5)
                            .overlay {
                                ZStack {
                                    ZStack {
                                        Text("If you are unsure how to play, swipe down anywhere to go back to the main menu and select                                 to learn more.")
                                            .font(.system(size: 14, weight: .medium, design: .rounded))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 8)
                                        (
                                            Text(Image(systemName: "questionmark.circle.fill"))
                                            +
                                            Text(" How to play                             ")
                                        )
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 8)
                                        .padding(.top, 34)
                                    }
                                    Button("") {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            if globalVar.haptics {
                                                UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                            }
                                        }
                                        withAnimation {
                                            globalVar.gameInfoPopup = false
                                        }
                                    }
                                    .buttonStyle(symbolButton(globalVar: globalVar, symbol: "xmark", enabled: true))
                                    .position(CGPoint(x: 298, y: 3))
                                }
                                .frame(width: 300, height: 75)
                            }
                    }
                    
                    HStack {
                        Spacer()
                        
                        // Timer
                        VStack {
                            Text("Time:")
                                .font(.system(size: 25, weight: .semibold, design: .rounded))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                            
                            Text(String(globalVar.countdown))
                                .font(.system(size: 25, weight: .semibold, design: .monospaced))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                .contentTransition(.numericText(countsDown: true))
                                
                                .onAppear() {
                                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                        if globalVar.countdown > 0 {
                                            if globalVar.gameProgress == "ongoing" {
                                                withAnimation {
                                                    globalVar.countdown -= 1
                                                }
                                            }
                                        } else {
                                            if globalVar.gameProgress == "ongoing" {
                                                withAnimation() {
                                                    globalVar.gameProgress = "ended"
                                                }
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                    withAnimation(.easeInOut(duration: 2.5)) {
                                                        swipeHintOpacity = 1
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                .onDisappear {
                                    timer?.invalidate()
                                    globalVar.enteredResult = "  "
                                }
                        }
                        
                        Spacer()
                        
                        // Target
                        RoundedRectangle(cornerRadius: 15)
                            .fill(globalVar.theme.colorScheme.tertiary)
                            .stroke(globalVar.theme.colorScheme.primary, lineWidth: 4)
                            .frame(width: 180, height: 90)
                            .overlay {
                                Text(String(format: "%03d", globalVar.game.target))
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .kerning(9)
                                    .font(.system(size: 65, weight: .heavy, design: .monospaced))
                                    .contentTransition(.numericText())
                                    .padding(.all, 1)
                                    .offset(x: 4, y: 0)
                            }
                        Spacer()
                        
                        // Score
                        VStack {
                            Text("Score:")
                                .font(.system(size: 25, weight: .semibold, design: .default))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                            if globalVar.level != 0 {
                                HStack(spacing: 1) {
                                    Image(systemName: globalVar.score > 0 ? "star.fill" : "star")
                                        .font(.system(size: 20))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .contentTransition(.symbolEffect(.replace))
                                    Image(systemName: globalVar.score > 1 ? "star.fill" : "star")
                                        .font(.system(size: 20))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .contentTransition(.symbolEffect(.replace))
                                    Image(systemName: globalVar.score > 2 ? "star.fill" : "star")
                                        .font(.system(size: 20))
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .contentTransition(.symbolEffect(.replace))
                                }
                            } else {
                                Text(String(format: "%05d", globalVar.score))
                                    .font(.system(size: 25, weight: .semibold, design: .monospaced))
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .contentTransition(.numericText(countsDown: false))
                            }
                            
                        }
                        
                        Spacer()
                    }
                    .frame(width: 393, height: 90)
                    .padding(.all)
                    
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(globalVar.theme.colorScheme.tertiary.opacity(1))
                            .stroke(globalVar.theme.colorScheme.primary, lineWidth: 4)
                        
                        
                        // Expression
                        if globalVar.gameProgress == "ongoing" {
                            VStack(spacing: 0) {
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    Text("   \(globalVar.enteredExpression)   ")
                                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                                        .font(.system(size: 33, weight: .medium, design: .rounded))
                                        .onChange(of: globalVar.enteredExpression) { _ , newExpression in
                                            globalVar.enteredResult = evaluateExpression(expression: newExpression)
                                        }
                                        .onChange(of: globalVar.enteredResult) { _ , newResult in
                                            let score = calculateScore(target: String(globalVar.game.target), result: newResult, globalVar: globalVar)
                                            withAnimation {
                                                if globalVar.level == 0 {
                                                    globalVar.score += score
                                                } else {
                                                    if score == 2500 && globalVar.score < 3 {
                                                        globalVar.score = 3
                                                        withAnimation() {
                                                            globalVar.gameProgress = "ended"
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                            withAnimation(.easeInOut(duration: 2.5)) {
                                                                swipeHintOpacity = 1
                                                            }
                                                        }
                                                    } else {
                                                        if score >= 1250 && globalVar.score < 2 {
                                                            globalVar.score = 2
                                                        } else {
                                                            if score >= 500 && globalVar.score < 1 {
                                                                globalVar.score = 1
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        .scrollTargetLayout()
                                }
                                .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
                                .defaultScrollAnchor(.trailing)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                .mask(
                                    HStack(spacing: 0) {
                                        LinearGradient(gradient:
                                                        Gradient(
                                                            colors: [Color.black.opacity(0), Color.black]),
                                                       startPoint: .leading, endPoint: .trailing
                                        )
                                        .frame(width: 25)
                                        Rectangle().fill(Color.black)
                                        LinearGradient(gradient:
                                                        Gradient(
                                                            colors: [Color.black, Color.black.opacity(0)]),
                                                       startPoint: .leading, endPoint: .trailing
                                        )
                                        .frame(width: 25)
                                    }
                                )
                                .padding(.top, 12)
                                
                                // Result
                                if globalVar.enteredResult.count < 7 {
                                    Text(" \(globalVar.enteredResult) ")
                                        .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                        .font(.system(size: 75, weight: .bold))
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                        .padding(.horizontal, 15)
                                        .padding(.bottom, 12)
                                } else {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        Text(" \(globalVar.enteredResult) ")
                                            .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                            .font(.system(size: 75, weight: .bold))
                                            .padding(.horizontal, 15)
                                            .scrollTargetLayout()
                                    }
                                    .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
                                    .defaultScrollAnchor(.trailing)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                                    .mask(
                                        HStack(spacing: 0) {
                                            LinearGradient(gradient:
                                                            Gradient(
                                                                colors: [Color.black.opacity(0), Color.black]),
                                                           startPoint: .leading, endPoint: .trailing
                                            )
                                            .frame(width: 30)
                                            Rectangle().fill(Color.black)
                                            LinearGradient(gradient:
                                                            Gradient(
                                                                colors: [Color.black, Color.black.opacity(0)]),
                                                           startPoint: .leading, endPoint: .trailing
                                            )
                                            .frame(width: 30)
                                        }
                                    )
                                    .padding(.bottom, 12)
                                    
                                }
                                
                            }
                            
                        }
                        
                        // Countdown
                        if globalVar.gameProgress == "starting" {
                            Group {
                                Text("3")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                    .font(.system(size: 200, weight: .black))
                                    .phaseAnimator(countdownAni.allCases, trigger: counter) { content, phase in
                                        content
                                            .scaleEffect(phase.scale)
                                            .opacity(phase.opacity)
                                    } animation: { phase in
                                        switch phase {
                                        case .start: .easeInOut.delay(1)
                                        case .middle: .easeInOut.delay(1)
                                        case .end: .easeInOut
                                        }
                                    }
                                    .onAppear{
                                        counter += 1
                                        globalVar.resultLog = [""]
                                        globalVar.countdown = 60
                                        globalVar.enteredExpression = ""
                                        globalVar.score = 0
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                            if globalVar.haptics && globalVar.gameProgress == "starting" {
                                                UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.55)
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
                                            if globalVar.haptics && globalVar.gameProgress == "starting" {
                                                UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.70)
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.25) {
                                            if globalVar.haptics && globalVar.gameProgress == "starting" {
                                                UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.85)
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.25) {
                                            if globalVar.haptics && globalVar.gameProgress == "starting" {
                                                UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 1)
                                            }
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                            
                                            withAnimation {
                                                if globalVar.level == 0 {
                                                    globalVar.game = newGame(globalVar: globalVar)
                                                }
                                                globalVar.gameProgress = "ongoing"
                                            }
                                        }
                                    }
                                
                                Text("2")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                    .font(.system(size: 200, weight: .black))
                                    .phaseAnimator(countdownAni.allCases, trigger: counter) { content, phase in
                                        content
                                            .scaleEffect(phase.scale)
                                            .opacity(phase.opacity)
                                    } animation: { phase in
                                        switch phase {
                                        case .start: .easeInOut.delay(2)
                                        case .middle: .easeInOut.delay(2)
                                        case .end: .easeInOut
                                        }
                                    }
                                
                                Text("1")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                    .font(.system(size: 200, weight: .black))
                                    .phaseAnimator(countdownAni.allCases, trigger: counter) { content, phase in
                                        content
                                            .scaleEffect(phase.scale)
                                            .opacity(phase.opacity)
                                    } animation: { phase in
                                        switch phase {
                                        case .start: .easeInOut.delay(3)
                                        case .middle: .easeInOut.delay(3)
                                        case .end: .easeInOut
                                        }
                                    }
                                
                                Text("GO")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                    .font(.system(size: 200, weight: .black))
                                    .phaseAnimator(countdownAni.allCases, trigger: counter) { content, phase in
                                        content
                                            .scaleEffect(phase.scale)
                                            .opacity(phase.opacity)
                                    } animation: { phase in
                                        switch phase{
                                        case .start: .easeInOut.delay(4)
                                        case .middle: .easeInOut.delay(4)
                                        case .end: .easeInOut(duration: 2)
                                        }
                                    }
                            }
                            .frame(width: 360, height: 170)
                        }
                        
                        
                        // Game over
                        if globalVar.gameProgress == "ended" {
                            if globalVar.level == 0 {
                                Text("Time is up!")
                                    .font(.system(size: 50, weight: .black))
                                    .scaleEffect((globalVar.gameProgress == "ended") ? 1 : 2)
                                    .opacity((globalVar.gameProgress == "ended") ? 1 : 0)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                    .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                    .onAppear{
                                        gameOver += 1
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                            if globalVar.haptics {
                                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                            }
                                        }
                                        if globalVar.score > globalVar.highScore {
                                            globalVar.highScore = globalVar.score
                                            globalVar.isHighScore = true
                                        } else {
                                            globalVar.isHighScore = false
                                        }
                                    }
                            } else {
                                if globalVar.score == 3 {
                                    Text("Level complete!")
                                        .font(.system(size: 40, weight: .black))
                                        .scaleEffect((globalVar.gameProgress == "ended") ? 1 : 2)
                                        .opacity((globalVar.gameProgress == "ended") ? 1 : 0)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                        .onAppear{
                                            gameOver += 1
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                                if globalVar.haptics {
                                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                                }
                                            }
                                            if globalVar.score > globalVar.levelStars[globalVar.level] ?? 0 {
                                                globalVar.levelStars[globalVar.level] = globalVar.score
                                            }
                                        }
                                } else {
                                    Text("Time is up!")
                                        .font(.system(size: 50, weight: .black))
                                        .scaleEffect((globalVar.gameProgress == "ended") ? 1 : 2)
                                        .opacity((globalVar.gameProgress == "ended") ? 1 : 0)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                        .foregroundStyle(globalVar.theme.colorScheme.quaternary)
                                        .onAppear{
                                            gameOver += 1
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                                if globalVar.haptics {
                                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                                }
                                            }
                                            if globalVar.score > globalVar.levelStars[globalVar.level] ?? 0 {
                                                globalVar.levelStars[globalVar.level] = globalVar.score
                                            }
                                            
                                        }
                                }
                            }
                        }
                    }
                    .frame(width: 360, height: 170)
                    
                    
                    
                    // Keys
                    Grid {
                        GridRow {
                            Button("") {
                                print("'\(buttons[0][0])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[0][0])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: "\(buttons[0][0]) "))
                            Button("") {
                                print("'\(buttons[0][1])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[0][1])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: " \(buttons[0][1])"))
                            Button("") {
                                print("'\(buttons[0][2])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[0][2])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[0][2]))
                        }
                        GridRow {
                            Button("") {
                                print("'\(buttons[1][0])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[1][0])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[1][0]))
                            Button("") {
                                print("'\(buttons[1][1])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[1][1])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[1][1]))
                            Button("") {
                                print("'\(buttons[1][2])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[1][2])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[1][2]))
                        }
                        GridRow {
                            Button("") {
                                print("'\(buttons[2][0])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[2][0])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[2][0]))
                            Button("") {
                                print("'\(buttons[2][1])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[2][1])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[2][1]))
                            Button("") {
                                print("'\(buttons[2][2])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[2][2])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[2][2]))
                        }
                        GridRow {
                            Button("") {
                                print("'\(buttons[3][0])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[3][0])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[3][0]))
                            Button("") {
                                print("'\(buttons[3][1])' pressed")
                                if !globalVar.enteredExpression.isEmpty {
                                    if globalVar.enteredExpression.removeLast().isNumber && (globalVar.enteredExpression.last ?? " ").isNumber {
                                        globalVar.enteredExpression.removeLast()
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[3][1]))
                            Button("") {
                                print("'\(buttons[3][2])' pressed")
                                globalVar.enteredExpression = "\(globalVar.enteredExpression)\(buttons[3][2])"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    if globalVar.haptics {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                    }
                                }
                            }
                            .buttonStyle(calcButton(label: buttons[3][2]))
                        }
                        
                    }
                    .allowsHitTesting((globalVar.gameProgress == "ongoing") ? true : false)
                    .frame(alignment: .bottom)
                    .padding(.top, 25)
                    
                }
                .position(x: screen.frame(in: .local).midX, y: screen.frame(in: .local).midY)
                .scaleEffect(screen.size.height / 759)
            }
        }
        .aspectRatio(393/759, contentMode: .fit)
        
        
    }
}


#Preview {
    GameView()
}


