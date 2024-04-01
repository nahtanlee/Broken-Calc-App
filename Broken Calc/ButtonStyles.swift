import SwiftUI

// Menu button style
struct menuButton<content: View, overlay: View>: ButtonStyle {
    @ViewBuilder let label: content
    @ViewBuilder let labelExpanded: overlay
    @State var amount: CGFloat = 0
    @State var haptic: Bool = false
    @State var counter: Int
    @EnvironmentObject var globalVar: GlobalVar
    let type: String // settings | new | how | levels
    
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        
        
        configuration.label
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(globalVar.theme.colorScheme.secondary)
                        .strokeBorder(globalVar.theme.colorScheme.primary, lineWidth: 2)
                        .frame(width: 300, height: (type == "levels") ? ((globalVar.levelsExpanded) ? (60 + amount) : 60) : (type == "settings") ? ((globalVar.settingsExpanded) ? (60 + amount) : 60) : (type == "how") ? ((globalVar.howToPlayExpanded) ? (60 + amount) : 60) : 60)
                        .overlay(content: {
                            
                            VStack {
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(width: 300, height: 560)
                                    .allowsHitTesting(false)
                                    .overlay {
                                        labelExpanded
                                            .allowsHitTesting((type == "levels") ? ((globalVar.levelsExpanded) ? true : false) : (type == "settings") ? ((globalVar.settingsExpanded) ? true : false) : (type == "how") ? ((globalVar.howToPlayExpanded) ? true : false) : false)
                                    }
                                    .padding(.top, 50)
                                    .padding(.all)
                                
                            }
                            
                            .mask {
                                Rectangle()
                                    .foregroundStyle(.red.opacity(1))
                                    .frame(height: (type == "levels") ? ((globalVar.levelsExpanded) ? (60 + amount) : 0) : (type == "settings") ? ((globalVar.settingsExpanded) ? (60 + amount) : 0) : (type == "how") ? ((globalVar.howToPlayExpanded) ? (60 + amount) : 0) : 0)
                                
                            }
                        })
                        .animation(.linear, value: globalVar.settingsExpanded)
                        .animation(.linear, value: globalVar.howToPlayExpanded)
                        .animation(.linear, value: globalVar.levelsExpanded)
                        .allowsHitTesting((type == "how") ? false : true)
                    
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(globalVar.theme.colorScheme.primary)
                                .frame(width: 300, height: 60)
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(globalVar.theme.colorScheme.primary, lineWidth: 4)
                                .fill(globalVar.theme.colorScheme.tertiary)
                                .frame(width: 297, height: 57)
                                .overlay(content: {
                                    label
                                })
                                .offset(x: configuration.isPressed ? 0 : -3, y: configuration.isPressed ? 0 : -4)
                        }
                        
                        if (type == "settings" && globalVar.settingsExpanded) || (type == "how" && globalVar.howToPlayExpanded) || (type == "levels" && globalVar.levelsExpanded){
                            Spacer(minLength: amount)
                                .animation(.linear, value: globalVar.settingsExpanded)
                                .animation(.linear, value: globalVar.howToPlayExpanded)
                                .animation(.linear, value: globalVar.levelsExpanded)
                            
                        }
                    }
                }
            )
            .frame(minWidth: 300, minHeight: (type == "levels") ? ((globalVar.levelsExpanded) ? (60 + amount) : 60) : (type == "settings") ? ((globalVar.settingsExpanded) ? (60 + amount) : 60) : (type == "how") ? ((globalVar.howToPlayExpanded) ? (60 + amount) : 60) : 60)
            .animation(.linear, value: globalVar.settingsExpanded)
            .animation(.linear, value: globalVar.howToPlayExpanded)
            .animation(.linear, value: globalVar.levelsExpanded)
        
            .padding(.all, 3)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic && globalVar.haptics {
                    withAnimation {
                        let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                        let _ = haptic.toggle()
                    }
                } else {
                    withAnimation {
                        let _ = (haptic = true)
                    }
                }
            }
    }
    
}

// Level button style
struct levelButton<content: View>: ButtonStyle {
    @ViewBuilder let label: content
    @EnvironmentObject var globalVar: GlobalVar
    @State var enabled: Bool = true
    @State var haptic: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(globalVar.theme.colorScheme.primary)
                        .frame(width: 70, height: 75)
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(enabled ? globalVar.theme.colorScheme.primary : globalVar.theme.colorScheme.quaternary, lineWidth: 3)
                        .fill(enabled ? globalVar.theme.colorScheme.tertiary : globalVar.theme.colorScheme.disabled)
                        .frame(width: 67, height: 72)
                        .overlay {
                            label
                        }
                        .offset(x: configuration.isPressed ? 0 : enabled ? -3 : 0, y: configuration.isPressed ? 0 : enabled ? -4 : 0)
                }
            )
            .allowsHitTesting(enabled)
            .frame(minWidth: 70, minHeight: 75)
            .background(.clear)
            .padding(.all, 3)
        
    }
}

// Symbol button style
struct symbolButton: ButtonStyle {
    var globalVar: GlobalVar
    @State var symbol: String
    @State var haptic: Bool = false
    @State var enabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    Circle()
                        .fill(globalVar.theme.colorScheme.primary)
                        .frame(width: 30, height: 30)
                    Circle()
                        .stroke(enabled ? globalVar.theme.colorScheme.primary : globalVar.theme.colorScheme.quaternary, lineWidth: 3)
                        .fill(enabled ? globalVar.theme.colorScheme.tertiary : globalVar.theme.colorScheme.disabled)
                        .overlay {
                            Image(systemName: symbol)
                                .foregroundStyle(enabled ? globalVar.theme.colorScheme.primary : globalVar.theme.colorScheme.quaternary)
                                .font(.system(size: 14, weight: .heavy))
                        }
                        .frame(width: 27, height: 27)
                        .offset(x: configuration.isPressed ? 0 : enabled ? -1 : 0, y: configuration.isPressed ? 0 : enabled ? -1 : 0)
                    
                }
            )
            .frame(minWidth: 30, minHeight: 30)
            .background(.clear)
            .padding(.all, 3)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic && globalVar.haptics {
                    withAnimation {
                        let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                        let _ = haptic.toggle()
                    }
                } else {
                    withAnimation {
                        let _ = (haptic = true)
                    }
                }
            }
        
    }
}



// Custom button style for toggle
struct toggleButton: ButtonStyle {
    @EnvironmentObject var globalVar: GlobalVar
    @State private var haptic: Bool = false
    @State private var value: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    
                    ZStack {
                        Capsule()
                            .fill(globalVar.haptics ? globalVar.theme.colorScheme.background: .white)
                            .stroke(globalVar.theme.colorScheme.primary, lineWidth: 1)
                            .frame(width: 52, height: 32)
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 30)
                                .fill(globalVar.theme.colorScheme.primary)
                                .frame(width: 30, height: 30)
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(globalVar.theme.colorScheme.primary, lineWidth: 2)
                                .fill(globalVar.theme.colorScheme.tertiary)
                                .frame(width: 27, height: 27)
                                .offset(x: configuration.isPressed ? 0 : -1, y: configuration.isPressed ? 0 : -2)
                                .overlay(
                                    Image(systemName: globalVar.haptics ? "checkmark" : "xmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .font(Font.title.weight(.black))
                                        .frame(width: 8, height: 8, alignment: .center)
                                        .padding(.bottom, 2)
                                        .padding(.trailing, 1)
                                        .foregroundColor(globalVar.theme.colorScheme.primary)
                                )
                        }
                        .offset(x: globalVar.haptics ? 11 : -11)
                        .animation(.snappy, value: value)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 1)
                            .onChanged({ value in
                                if value.predictedEndTranslation.width < 10 {

                                    withAnimation {
                                        globalVar.haptics = false
                                        if globalVar.haptics {
                                            UISelectionFeedbackGenerator().selectionChanged()
                                        }
                                    }
                                }
                                if value.predictedEndTranslation.width > 10 {
                                    withAnimation {
                                        globalVar.haptics = true
                                        if globalVar.haptics {
                                            UISelectionFeedbackGenerator().selectionChanged()
                                        }
                                    }
                                }
                            })
                    )
                }
            )
            .frame(minWidth: 52, minHeight: 32)
            .animation(.snappy, value: value)
        
            .padding(.all, 3)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic && globalVar.haptics {
                    withAnimation {
                        let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                        let _ = haptic.toggle()
                    }
                } else {
                    withAnimation {
                        let _ = (haptic = true)
                    }
                }
            }

    }
    
}

// Custom slider button style
struct sliderButton: ButtonStyle {
    @EnvironmentObject var globalVar: GlobalVar
    @State private var haptic: Bool = false
    @State private var value: Bool = true
    @State private var sliderOffset: CGFloat = 0
    @State private var isTapped = false
    @State private var reachedLimit = false
    @State private var rotation: Double = 0
    @State private var touch = true
    
    func makeBody(configuration: Configuration) -> some View {

        
        configuration.label
            .background(
                ZStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(globalVar.theme.colorScheme.background)
                            .stroke(globalVar.theme.colorScheme.primary, lineWidth: 2)
                            .frame(width: 225, height: 42)
                        HStack {
                            Text("Slide to reset")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                .padding(.leading, 37)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                        }
                        HStack(spacing: 0) {
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(globalVar.theme.colorScheme.primary)
                                    .frame(width: 40 + sliderOffset, height: 40)
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(globalVar.theme.colorScheme.primary, lineWidth: 3)
                                    .fill(globalVar.theme.colorScheme.tertiary)
                                    .overlay {
                                        Image(systemName: "arrow.triangle.2.circlepath")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(globalVar.theme.colorScheme.primary)
                                            .rotationEffect(Angle(degrees: sliderOffset))
                                            .rotationEffect(Angle(degrees: rotation))
                                    }
                                    .offset(x: isTapped ? 0 : -2, y: isTapped ? 0 : -2)
                                    .frame(width: 37 + sliderOffset, height: 37)

                            }
                            .frame(width: 40 + sliderOffset, height: 40, alignment: .leading)
                            .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if 0 < gesture.translation.width && gesture.translation.width < 270 && !reachedLimit {
                                            withAnimation(.snappy(duration: 0.02)) {
                                                isTapped = true
                                            }
                                            withAnimation(.bouncy) {
                                                
                                                sliderOffset = gesture.translation.width * 0.6
                                                
                                            }
                                        } else {
                                            if !reachedLimit {
                                                if globalVar.haptics {
                                                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1)
                                                }
                                            }
                                            withAnimation {
                                                reachedLimit = true
                                            }
                                            
                                            withAnimation {
                                                touch = false
                                            }
                                            withAnimation(.bouncy) {
                                                sliderOffset = 184
                                            }
                                            withAnimation(.snappy(duration: 5)) {
                                                rotation = 2520
                                            }
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                                withAnimation {
                                                    globalVar.reloadViews = true
                                                }
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                                                withAnimation {
                                                    if !(globalVar.theme == Theme.SeaBreeze) {
                                                        globalVar.reloadViews = false
                                                    }
                                                }
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                withAnimation {
                                                    touch = true
                                                    sliderOffset = 0
                                                    reachedLimit = false
                                                    globalVar.enteredExpression = ""
                                                    globalVar.enteredResult = ""
                                                    globalVar.game = (target: 000, numbers: [0, 0, 0, 0, 0])
                                                    globalVar.countdown = 90
                                                    globalVar.score = 0
                                                    globalVar.scoreStars = 0
                                                    globalVar.resultLog = [" "]
                                                    globalVar.gameProgress = "inactive" // inactive, starting, ongoing, paused, ended
                                                    globalVar.level = 0 // 0 -> no level
                                                    globalVar.showMenu = true
                                                    globalVar.settingsExpanded = false
                                                    globalVar.howToPlayExpanded = false
                                                    globalVar.levelsExpanded = false
                                                    globalVar.isLoading = true
                                                    globalVar.isHighScore = false
                                                    globalVar.highScore = 0
                                                    globalVar.pattern = "Line - Small"
                                                    globalVar.isLightened = false
                                                    globalVar.haptics = true
                                                    globalVar.theme = Theme.SeaBreeze
                                                    globalVar.themeInt = 1
                                                    globalVar.gameInfoPopup = true
                                                    globalVar.levelInfoPopup = true
                                                    globalVar.levelStars = [  // level no. : no. of stars
                                                        1 : 0,
                                                        2 : 0,
                                                        3 : 0,
                                                        4 : 0,
                                                        5 : 0,
                                                        6 : 0,
                                                        7 : 0,
                                                        8 : 0,
                                                        9 : 0,
                                                        10 : 0,
                                                        11 : 0,
                                                        12 : 0,
                                                        13 : 0,
                                                        14: 0,
                                                        15: 0
                                                    ]
                                                    globalVar.reloadViews = false
                                                }
                                            }

                                        }
                                    })
                                    .onEnded({ gesture in
                                        if gesture.translation.width < 270 {
                                            withAnimation(.bouncy) {
                                                sliderOffset = 0
                                            }
                                            
                                        }
                                        withAnimation(.bouncy) {
                                            isTapped = false
                                        }
                                    })
                            )
                            Rectangle()
                                .fill(.clear)
                                .allowsHitTesting(false)
                                .frame(width: 184 - sliderOffset, height: 40, alignment: .trailing)
                        }
                    }
                }
            )
            .allowsHitTesting(touch)
            .frame(width: 225, height: 45)
            .padding(.all, 3)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    withAnimation(.snappy(duration: 0.02)) {
                        isTapped = true
                    }
                } else {
                    if sliderOffset == 0 {
                        withAnimation(.snappy(duration: 0.02)) {
                            isTapped = false
                        }
                    } else {
                        withAnimation(.snappy(duration: 0.02)) {
                            isTapped = false
                        }
                    }
                }
                if isPressed && haptic && globalVar.haptics {
                    withAnimation {
                        let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                        let _ = haptic.toggle()
                    }
                } else {
                    withAnimation {
                        let _ = (haptic = true)
                    }
                }
            }
        
    }
    
}


// Calculator button style
struct calcButton: ButtonStyle {
    var label: String
    @EnvironmentObject var globalVar: GlobalVar
    @State var enabled: Bool = true
    @State var haptic: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        
        
        let isNumber = (label.contains(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "⌫"]))
        
        configuration.label
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 37.5)
                        .fill(globalVar.theme.colorScheme.primary)
                        .frame(width: 90, height: 75)
                    RoundedRectangle(cornerRadius: 37.5)
                        .stroke(enabled ? globalVar.theme.colorScheme.primary : globalVar.theme.colorScheme.quaternary, lineWidth: 3)
                        .fill(enabled ? isNumber ? globalVar.theme.colorScheme.tertiary : globalVar.theme.colorScheme.secondary : globalVar.theme.colorScheme.disabled)
                        .frame(width: 87, height: 72)
                        .overlay {
                            Text(label)
                                .foregroundStyle(enabled ? isNumber ? globalVar.theme.colorScheme.primary : globalVar.theme.colorScheme.primary : globalVar.theme.colorScheme.quaternary)
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .contentTransition(.numericText())
                        }
                    //.offset(x: enabled ? configuration.isPressed ? 0 : -3 : 0, y: enabled ? configuration.isPressed ? 0 : -4 : 0)
                        .offset(x: configuration.isPressed ? 0 : enabled ? -3 : 0, y: configuration.isPressed ? 0 : enabled ? -4 : 0)
                }
            )
            .allowsHitTesting(enabled)
            .frame(minWidth: 90, minHeight: 75)
            .background(.clear)
            .padding(.all, 3)
            .onChange(of: globalVar.enteredExpression) { _, newValue in
                if !newValue.isEmpty && (label.last ?? " ").isNumber {
                    if (newValue.last ?? " ").isNumber {
                        if (newValue.last ?? " ") == label.last && (newValue.suffix(2).contains(label)){
                            withAnimation(.snappy(duration: 0.02)) {
                                enabled = false
                            }
                        } else {
                            enabled = false
                        }
                    } else {
                        let matches: [String] = newValue.matches(of: /[0-9]+/).map { String(newValue[$0.range]) }
                        if !matches.contains(label) {
                            enabled = true
                        }
                    }
                } else {
                    enabled = true
                }
            }
            .onChange(of: globalVar.gameProgress) { _, newValue in
                
                if !globalVar.enteredExpression.isEmpty && (label.last ?? " ").isNumber {
                    if (globalVar.enteredExpression.last ?? " ").isNumber {
                        if (globalVar.enteredExpression.last ?? " ") == label.last && (globalVar.enteredExpression.suffix(2).contains(label)){
                            withAnimation(.snappy(duration: 0.02)) {
                                enabled = false
                            }
                        } else {
                            
                            withAnimation(.snappy(duration: 0.02)) {
                                enabled = false
                            }
                        }
                    } else {
                        let matches: [String] = globalVar.enteredExpression.matches(of: /[0-9]+/).map { String(globalVar.enteredExpression[$0.range]) }
                        if !matches.contains(label) {
                            withAnimation(.snappy(duration: 0.02)) {
                                enabled = true
                            }
                        }
                    }
                } else {
                    withAnimation(.snappy(duration: 0.02)) {
                        enabled = true
                    }
                }
            }
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic && globalVar.haptics {
                    let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                    let _ = haptic.toggle()
                } else {
                    let _ = (haptic = true)
                }
            }
    }
}



// Right picker of DualPicker
struct rightPicker: ButtonStyle {
    var label: String
    @EnvironmentObject var globalVar: GlobalVar
    @State var haptic: Bool = false
    @State var enabled: Bool = !GlobalVar().isLightened
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 2, bottomLeadingRadius: 2, bottomTrailingRadius: 6.5, topTrailingRadius: 6.5)
                        .stroke(globalVar.theme.colorScheme.primary, lineWidth: 3)
                        .fill(enabled ? globalVar.theme.colorScheme.tertiary: globalVar.theme.colorScheme.secondary)
                        .frame(width: 62, height: 24)
                        .overlay {
                            Text(label)
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                .font(.system(size: 13, weight: .medium, design: .default))
                        }
                        .offset(x: configuration.isPressed ? 0 : enabled ? -1 : 0, y: configuration.isPressed ? 0 : enabled ? -1 : 0)
                }
            )
            .frame(minWidth: 57, minHeight: 27)
            .background(.clear)
            .padding(.all, 3)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic && globalVar.haptics {
                    let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                    let _ = haptic.toggle()
                } else {
                    let _ = (haptic = true)
                }
            }
            .onChange(of: globalVar.isLightened) { oldValue, newValue in
                withAnimation(.snappy(duration: 0.02)) {
                    enabled = !newValue
                }
            }
    }
    
}
// Left picker of DualPicker
struct leftPicker: ButtonStyle {
    var label: String
    @EnvironmentObject var globalVar: GlobalVar
    @State var haptic: Bool = false
    @State var enabled: Bool = GlobalVar().isLightened
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                ZStack {
                    UnevenRoundedRectangle(topLeadingRadius: 6.5, bottomLeadingRadius: 6.5, bottomTrailingRadius: 2, topTrailingRadius: 2)
                        .stroke(globalVar.theme.colorScheme.primary, lineWidth: 3)
                        .fill(enabled ? globalVar.theme.colorScheme.tertiary: globalVar.theme.colorScheme.secondary)
                        .frame(width: 62, height: 24)
                        .overlay {
                            Text(label)
                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                .font(.system(size: 13, weight: .medium, design: .default))
                        }
                        .offset(x: configuration.isPressed ? 0 : enabled ? -1 : 0, y: configuration.isPressed ? 0 : enabled ? -1 : 0)
                        .animation(.snappy(duration: 0.1), value: enabled)
                    
                }
            )
            .frame(minWidth: 57, minHeight: 27)
            .background(.clear)
            .padding(.all, 3)
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed && haptic && globalVar.haptics {
                    let _ = UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                    let _ = haptic.toggle()
                } else {
                    let _ = (haptic = true)
                }
            }
            .onChange(of: globalVar.isLightened) { oldValue, newValue in
                withAnimation(.snappy(duration: 0.02)) {
                    enabled = newValue
                }
            }
        
    }
}
