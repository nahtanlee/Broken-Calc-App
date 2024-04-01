import SwiftUI



class GlobalVar: ObservableObject {
    // Game
    @Published var enteredExpression: String = ""
    @Published var enteredResult: String = ""
    @Published var game: (target: Int, numbers: [Int]) = (target: 000, numbers: [0, 0, 0, 0, 0])
    @Published var countdown = 90
    @Published var score = 0
    @Published var scoreStars: Int = 0
    @Published var resultLog: [String] = [" "]
    @Published var gameProgress: String = "inactive" // inactive, starting, ongoing, paused, ended
    @Published var level: Int = 0 // 0 -> no level

    // Menu
    @Published var showMenu = true
    @Published var settingsExpanded = false
    @Published var howToPlayExpanded = false
    @Published var levelsExpanded = false
    @Published var isLoading = true
    
    
    // High score
    @Published var isHighScore = false
    @AppStorage("highScore") var highScore: Int = 0
    
    // Settings
    @AppStorage("pattern") var pattern: String = "Line - Small"
    @AppStorage("lightenPatten") var isLightened: Bool = false
    @AppStorage("haptics") var haptics: Bool = true
    @Published var theme = Theme.Rose
    @AppStorage("themeInt") var themeInt = 1

    
    // Levels
    @Published var levelContent: [Int : (target: Int, numbers: [Int])] = [
        1 : (target: 100, numbers: [25, 75, 1, 6, 2]), // 25 + 75
        2 : (target: 135, numbers: [95, 20, 4, 9, 7]), // 95 + 20 + 4 + 9 + 7
        3 : (target: 258, numbers: [10, 25, 2, 1, 5]), // 10 * 25 + 2 + 1 + 5
        4 : (target: 107, numbers: [25, 55, 2, 5, 4]), // 25 * 4 + 2 + 5
        5 : (target: 405, numbers: [35, 65, 4, 3, 8]), // 4 * (65 + 35) + 8 - 3
        6 : (target: 168, numbers: [60, 20, 1, 3, 2]), // (60 + 3 + 20 + 1) * 2
        7 : (target: 172, numbers: [85, 10, 1, 5, 2]), // 85 / 5 * 10 + 2
        8 : (target: 636, numbers: [35, 90, 9, 3, 5]), // 35 / 5 * 90 + 9 - 3
        9 : (target: 215, numbers: [70, 15, 3, 6, 2]), // 70 * 3 + 15 * (6 / 2)
        10 : (target: 240, numbers: [20, 10, 3, 4, 5]), // 3 * 4 / 5 * 10
        11 : (target: 471, numbers: [65, 80, 7, 6, 5]), // (80 / 5)  + (65 * 7)
        12 : (target: 940, numbers: [15, 55, 8, 3, 4]), // 15 / 3 * 4 * (55 - 8)
        13 : (target: 235, numbers: [35, 45, 4, 2, 9]), // (35 - 9) * 2 * 4 + 45
        14 : (target: 215, numbers: [50, 15, 1, 4, 6]), // 15 * (4 + 6 + 1) + 50
        15 : (target: 492, numbers: [65, 60, 8, 2, 9]) // 65 * 60 / 8 + 9 / 2

        //        <#Int#> : (target: <#Int#>, numbers: [<#Int#>, <#Int#>, <#Int#>, <#Int#>, <#Int#>]),
    ]
    @AppStorage("levelStars") var levelStars: [Int: Int] = [  // level no. : no. of stars
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
        13: 0,
        14: 0,
        15 : 0
    ]
    
    // Drawing
    @Published var clearDrawings: Bool = false
    @Published var isBlankCanvas: Bool = true
    
    // Info hints
    @AppStorage("levelInfoPopup") var levelInfoPopup: Bool = true
    @AppStorage("gameInfoPopup") var gameInfoPopup: Bool = true
    @AppStorage("drawingInfoPopup") var drawingInfoPopup: Bool = true

    
    @Published var reloadViews: Bool = false
    
    init() {
        if themeInt == 1 {
            
            withAnimation() {
                theme = Theme.SeaBreeze
            }
        }
        if themeInt == 2 {
            withAnimation() {
                theme = Theme.Floral
            }
        }
        if themeInt == 3 {
            withAnimation() {
                theme = Theme.Rose
            }
        }
        if themeInt == 4 {
            withAnimation() {
                theme = Theme.OceanWave
            }
        }
        if themeInt == 5 {
            withAnimation() {
                theme = Theme.Camo
            }
        }
        if themeInt == 6 {
            withAnimation() {
                theme = Theme.Forrest
            }
        }
        if themeInt == 7 {
            withAnimation() {
                theme = Theme.Fun
            }
        }
        if themeInt == 8 {
            withAnimation() {
                theme = Theme.Clay
            }
        }
        if themeInt == 9 {
            withAnimation() {
                theme = Theme.Sky
            }
        }
    }

}

struct ContentView: View {
    @StateObject var globalVar = GlobalVar()
    @State var patternOpacity: Double = 0
    @State var selection: Int? = nil
    @State var imageOffset: Double = -750
    @Namespace var namespace
    
    var body: some View {
        if globalVar.reloadViews {
            globalVar.theme.colorScheme.background
                .ignoresSafeArea(.all)
            
        } else {
            
            ZStack {
                globalVar.theme.colorScheme.background
                    .ignoresSafeArea(.all)
                    .onChange(of: globalVar.themeInt) { oldValue, newValue in
                        if newValue == 1 {
                            print("Theme changed to: Sea Breeze")
                            withAnimation() {
                                globalVar.theme = Theme.SeaBreeze
                            }
                        }
                        if newValue == 2 {
                            print("Theme changed to: Floral")
                            withAnimation() {
                                globalVar.theme = Theme.Floral
                            }
                        }
                        if newValue == 3 {
                            print("Theme changed to: Rose")
                            withAnimation() {
                                globalVar.theme = Theme.Rose
                            }
                        }
                        if newValue == 4 {
                            print("Theme changed to: Ocean Wave")
                            withAnimation() {
                                globalVar.theme = Theme.OceanWave
                            }
                        }
                        if newValue == 5 {
                            print("Theme changed to: Camo")
                            withAnimation() {
                                globalVar.theme = Theme.Camo
                            }
                        }
                        if newValue == 6 {
                            print("Theme changed to: Forrest")
                            withAnimation() {
                                globalVar.theme = Theme.Forrest
                            }
                        }
                        if newValue == 7 {
                            print("Theme changed to: Fun")
                            withAnimation() {
                                globalVar.theme = Theme.Fun
                            }
                        }
                        if newValue == 8 {
                            print("Theme changed to: Clay")
                            withAnimation() {
                                globalVar.theme = Theme.Clay
                            }
                        }
                        if newValue == 9 {
                            print("Theme changed to: Sky")
                            withAnimation() {
                                globalVar.theme = Theme.Sky
                            }
                        }
                    }

                
                // Pattern
                if globalVar.isLightened {
                    Image(globalVar.pattern)
                        .resizable(resizingMode: .tile)
                        .opacity(0.5 * patternOpacity)
                        .colorInvert()
                        .ignoresSafeArea(.all)
                } else {
                    Image(globalVar.pattern)
                        .resizable(resizingMode: .tile)
                        .opacity(0.05 * patternOpacity)
                            .ignoresSafeArea(.all)
                    }
                    
                    
                    
                    if globalVar.showMenu {
                        HStack(spacing: 0) {
                            Spacer(minLength: 10)
                            MenuView()
                                .frame(alignment: .center)
                                .environmentObject(globalVar)
                                .onAppear {
                                    if globalVar.gameProgress == "ongoing" {
                                        withAnimation {
                                            globalVar.gameProgress = "paused"
                                        }
                                    }
                                }
                            Spacer(minLength: 10)
                        }
                        .transition(.move(edge: .top))
                        .scaledToFill()
                        
                    } else {
                        
                        HStack(spacing: 0) {
                            DrawingView(side: "left", showButtons: false)
                                .environmentObject(globalVar)
                                .mask(
                                    HStack(spacing: 0) {
                                        Rectangle().fill(Color.black)
                                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .leading, endPoint: .trailing)
                                            .frame(width: 75)
                                    }
                                )
                            GameView()
                                .frame(alignment: .center)
                                .environmentObject(globalVar)
                                .onChange(of: globalVar.gameProgress) { oldValue, newValue in
                                    print("globalVar.gameProgress = \(newValue)")
                                }
                                .onAppear {
                                    if globalVar.gameProgress == "paused" {
                                        withAnimation {
                                            globalVar.gameProgress = "ongoing"
                                        }
                                    } else {
                                        withAnimation {
                                            globalVar.gameProgress = "starting"
                                        }
                                    }
                                    withAnimation() {
                                        globalVar.levelsExpanded = false
                                        globalVar.settingsExpanded = false
                                        globalVar.howToPlayExpanded = false
                                    }
                                }
                            DrawingView(side: "right", showButtons: true)
                                .environmentObject(globalVar)
                                .mask(
                                    HStack(spacing: 0) {
                                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .trailing, endPoint: .leading)
                                            .frame(width: 75)
                                        Rectangle().fill(Color.black)
                                    }
                                )
                        }
                        .transition(.move(edge: .bottom))
                        .scaledToFill()
                        
                    }
                    
                    if globalVar.isLoading {
                        LoadingView()
                            .environmentObject(globalVar)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                                    withAnimation {
                                        globalVar.isLoading = false
                                    }
                                }
                            }
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded({ gesture in
                            if gesture.predictedEndTranslation.height < 50 && !globalVar.isLoading {
                                withAnimation(.bouncy) {
                                    globalVar.showMenu = false
                                }
                            }
                            if gesture.predictedEndTranslation.height > -50 && !globalVar.isLoading {
                                withAnimation(.bouncy) {
                                    globalVar.showMenu = true
                                }
                            }
                        })
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.6) {
                        withAnimation(.easeInOut(duration: 1)) {
                            patternOpacity = 1
                        }
                    }
                }
            }
        
        
        
    }
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("BrokenCalc.ContentView")
    }
}

// Allows the levelStars dictionary to be stored using @AppStorage

extension Dictionary: RawRepresentable where Key == Int, Value == Int {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode([Int:Int].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "{}"
        }
        return result
    }

}
