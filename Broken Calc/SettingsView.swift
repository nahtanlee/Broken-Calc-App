import SwiftUI


private let themes: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
private let patterns: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

private let ItoT: [Int: String] = [
    1 : "",
    2 : "Sea Breeze",
    3 : "Floral",
    4 : "Rose",
    5 : "Ocean Wave",
    6 : "Camo",
    7: "Forrest",
    8: "Fun",
    9 : "Clay",
    10 : "Sky",
    11 : ""
]

private let TtoI: [String : Int] = [
    "" : 1,
    "Sea Breeze" : 2,
    "Floral" : 3,
    "Rose" : 4,
    "Ocean Wave" : 5,
    "Camo" : 6,
    "Forrest" : 7,
    "Fun" : 8,
    "Clay" : 9,
    "Sky" : 10
]

private let ItoP: [Int: String] = [
    1 : "",
    2 : "Blank",
    3 : "Stripe - Small",
    4 : "Line - Large",
    5 : "Line - Small",
    6 : "Plus - Large",
    7 : "Plus - Small",
    8 : "Square - Large",
    9 : "Square - Small",
    10 : "Wave - Small",
    11 : "Wave - Large",
    12 : "Triangle - Small",
    13 : "Crosshair - Small",
    14 : "Target - Small",
    15 : ""
]

private let PtoI: [String: Int] = [
    "" : 1,
    "Blank" : 2,
    "Stripe - Small" : 3,
    "Line - Large" : 4,
    "Line - Small" : 5,
    "Plus - Large" : 6,
    "Plus - Small" : 7,
    "Square - Large" : 8,
    "Square - Small" : 9,
    "Wave - Small" : 10,
    "Wave - Large" : 11,
    "Triangle - Small" : 12,
    "Crosshair - Small" : 13,
    "Target - Small" : 14
]


struct SettingsView: View {
    @EnvironmentObject var globalVar: GlobalVar
    @State var selectedPatternPattern: Int? = nil
    @State var selectedTheme: Int? = nil

    var body: some View {
        VStack {
            Spacer()
            Text("Pattern:")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(globalVar.theme.colorScheme.primary)
                .padding(.bottom, 10)
            
            PatternPicker
                //.environmentObject(globalVar)
                .padding(.bottom, 10)
            
            // Lighten/Darken toggle
            DualPicker
                .padding(.bottom, 2)
            
            // Dots
            HStack (spacing: 5) {
                let selectedInt = (selectedPatternPattern ?? 0) + 1
                ForEach(patterns, id: \.self) { int in
                    let selected = selectedInt == int
                    if int > 1 && int < patterns.endIndex {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(globalVar.theme.colorScheme.primary)
                            .opacity(selected ? 1 : 0.3)
                            .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: selectedPatternPattern)
                            .frame(width: selected ? 12 : 6, height: 6)
                    }
                }
            }
            .padding(.bottom, 20)
            
            
            
            Text("Theme:")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundStyle(globalVar.theme.colorScheme.primary)
                .padding(.bottom, 10)
            
            ThemePicker
                .padding(.bottom, 5)
            
            // Dots
            HStack (spacing: 5) {
                let selectedInt = (selectedTheme ?? 0) + 1
                ForEach(patterns, id: \.self) { int in
                    let selected = selectedInt == int
                    if int > 1 && int < themes.endIndex {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(globalVar.theme.colorScheme.primary)
                            .opacity(selected ? 1 : 0.3)
                            .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: selectedTheme)
                            .frame(width: selected ? 12 : 6, height: 6)
                    }
                }
            }
            .padding(.bottom, 7.5)
            
            Text(ItoT[(selectedTheme ?? -1) + 1] ?? "")
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(globalVar.theme.colorScheme.primary)
                .padding(.bottom, 20)
            
            
            
            // Haptic toggle
            HStack(spacing: 90) {
                Text("Haptics:")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                
                Button("") {
                    globalVar.haptics.toggle()
                    print("Haptics toggled \(globalVar.haptics)")
                }
                .buttonStyle(toggleButton(globalVar: _globalVar))
            }
            .padding(.bottom, 20)
            
            // Reset slider
            Button("") {
            }
            .buttonStyle(sliderButton())
            
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text(Image(systemName: "exclamationmark.triangle"))
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                        .baselineOffset(1)
                        .padding(.trailing, 3)
                    Text("This action will reset all settings")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(globalVar.theme.colorScheme.primary)
                }
                Text("and data, including game progress.")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                Text("The app will be reset to its initial state.")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(globalVar.theme.colorScheme.primary)
            }
            .frame(width: 220)
            
            
            Spacer(minLength: 8)
        }
    }
    
    // Pattern picker
    var PatternPicker: some View {
        
        Rectangle()
            .frame(width: 300, height: 60)
            .foregroundStyle(.clear)
            .overlay(
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 15) {
                        ForEach(patterns, id: \.self) { int in
                            let pattern = ItoP[int]
                            Group {
                                if pattern != "" {
                                    Image(pattern ?? "Blank")
                                        .resizable(resizingMode: .tile)
                                        .opacity(0.1)
                                        .frame(width: 180, height: 120)
                                        .scaleEffect(0.5)
                                        .background(globalVar.theme.colorScheme.background)
                                        .mask {
                                            RoundedRectangle(cornerRadius: 15)
                                                .frame(width: 90, height: 60)
                                        }
                                        .onTapGesture {
                                            withAnimation {
                                                selectedPatternPattern = PtoI[pattern ?? ""]! - 1
                                            }
                                        }
                                } else {
                                    Rectangle()
                                        .foregroundStyle(Color.clear)
                                        .frame(width: 45, height: 60)
                                }
                            }
                            .frame(width: 90, height: 60)
                        }
                    }
                    
                    .onAppear() {
                        selectedPatternPattern = PtoI[globalVar.pattern]! - 1
                    }
                    .scrollTargetLayout()
                    
                }
                    .scrollPosition(id: $selectedPatternPattern)
                    .onChange(of: selectedPatternPattern) {
                        withAnimation(.linear(duration: 0.2)) {
                            globalVar.pattern = ItoP[(selectedPatternPattern ?? 1) + 1] == "" ? "Square - Small" : ItoP[(selectedPatternPattern ?? 1) + 1] ?? ""
                            if globalVar.haptics {
                                UISelectionFeedbackGenerator().selectionChanged()
                            }
                        }
                    }
                    .scrollTargetBehavior(.viewAligned)
                
            )
        // Fade edges from black
            .mask(
                HStack(spacing: 0) {
                    
                    LinearGradient(gradient:
                                    Gradient(
                                        colors: [Color.black.opacity(0), Color.black]),
                                   startPoint: .leading, endPoint: .trailing
                    )
                    .frame(width: 50)
                    
                    Rectangle().fill(Color.black)
                    
                    LinearGradient(gradient:
                                    Gradient(
                                        colors: [Color.black, Color.black.opacity(0)]),
                                   startPoint: .leading, endPoint: .trailing
                    )
                    .frame(width: 50)
                }
            )
        
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(globalVar.theme.colorScheme.primary, lineWidth: 4)
                    .frame(width: 100, height: 70, alignment: .center)
            )
        
    }


    var ThemePicker: some View {
        Rectangle()
            .frame(width: 300, height: 60)
            .foregroundStyle(.clear)
            .overlay(
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 15) {
                        ForEach(themes, id: \.self) { int in
                            let theme = ItoT[int]
                            Group {
                                if theme != "" {
                                    Image("\(theme ?? " ")")
                                        .scaledToFit()
                                        .frame(width: 90, height: 60)
                                        .mask {
                                            RoundedRectangle(cornerRadius: 15)
                                                .frame(width: 90, height: 60)
                                        }
                                        .onTapGesture {
                                            withAnimation {
                                                selectedTheme = TtoI[theme ?? ""]! - 1
                                            }
                                        }
                                } else {
                                    Rectangle()
                                        .foregroundStyle(Color.clear)
                                        .frame(width: 45, height: 60)
                                }
                            }
                            .frame(width: 90, height: 60)
                        }
                    }
                    
                    .onAppear() {
                        selectedTheme = (TtoI[globalVar.theme.colorScheme.imageName] ?? 1) - 1
                    }
                    .scrollTargetLayout()
                    
                }
                    .scrollPosition(id: $selectedTheme)
                    .onChange(of: selectedTheme) {

                        withAnimation(.linear(duration: 0.2)) {
                            if globalVar.haptics {
                                UISelectionFeedbackGenerator().selectionChanged()
                            }
                            globalVar.themeInt = selectedTheme ?? 1
                        }
                    }
                    .scrollTargetBehavior(.viewAligned)
                
            )
         // Fade edges from black
            .mask(
                HStack(spacing: 0) {
                    
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0), Color.black]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 50)
                    
                    Rectangle().fill(Color.black)
                    
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 50)
                }
            )
        
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(globalVar.theme.colorScheme.primary, lineWidth: 4)
                    .frame(width: 100, height: 70, alignment: .center)
            )
        
    }

    var DualPicker: some View {

        RoundedRectangle(cornerRadius: 7)
            .fill(globalVar.theme.colorScheme.primary)
            .frame(width: 127, height: 27)
            .overlay {
                HStack(spacing: 0) {
                    Button("") {
                        withAnimation {
                            globalVar.isLightened.toggle()
                        }
                    }
                    .buttonStyle(leftPicker(label: "Lighten"))
                    Button("") {
                        withAnimation {
                            globalVar.isLightened.toggle()
                        }
                    }
                    .buttonStyle(rightPicker(label: "Darken"))
                    
                }
            }
            .gesture(
                DragGesture()
                    .onEnded({ gesture in
                        if gesture.predictedEndTranslation.width < 50 {
                            withAnimation() {
                                globalVar.isLightened = true
                            }
                        }
                        if gesture.predictedEndTranslation.width > -50 {
                            withAnimation() {
                                globalVar.isLightened = false
                            }
                        }
                    })
            )
        
    }
}

#Preview {
    SettingsView()
}
