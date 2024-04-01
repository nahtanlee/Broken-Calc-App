import SwiftUI

struct LevelsView: View {
    @EnvironmentObject var globalVar: GlobalVar
    @State var closeActive = false

    var body: some View {
        VStack {
            // Level grid
            Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                GridRow {
                    // Level 1
                    Group {
                        let id = 1
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 2
                    Group {
                        let id = 2
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 3
                    Group {
                        let id = 3
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                }
                GridRow {
                    // Level 4
                    Group {
                        let id = 4
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 5
                    Group {
                        let id = 5
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 6
                    Group {
                        let id = 6
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                }
                GridRow {
                    // Level 7
                    Group {
                        let id = 7
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 8
                    Group {
                        let id = 8
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 9
                    Group {
                        let id = 9
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                }
                GridRow {
                    // Level 10
                    Group {
                        let id = 10
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 11
                    Group {
                        let id = 11
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                    // Level 12
                    Group {
                        let id = 12
                        Button("") {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if globalVar.haptics {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                }
                                withAnimation() {
                                    globalVar.showMenu = false
                                    globalVar.level = id
                                    globalVar.game = globalVar.levelContent[id]!
                                    globalVar.gameProgress = "starting"
                                    globalVar.resultLog = [""]
                                    globalVar.countdown = 60
                                    globalVar.enteredExpression = ""
                                    globalVar.score = 0
                                    globalVar.clearDrawings = true
                                }
                            }
                        }
                        .buttonStyle(levelButton(label: {
                            VStack {
                                Text("\(id)")
                                    .foregroundStyle(globalVar.theme.colorScheme.primary)
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                HStack(spacing: 0) {
                                    ForEach(0..<3, id: \.self) { stars in
                                        if globalVar.levelStars[id] ?? 0 > stars {
                                            Image(systemName: "star.fill")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        } else {
                                            Image(systemName: "star")
                                                .foregroundStyle(globalVar.theme.colorScheme.primary)
                                                .font(.system(size: 13))
                                        }
                                    }
                                }
                                .padding(.bottom, 5)
                            }
                            .frame(width: 67, height: 72)
                        }, globalVar: _globalVar))
                    }
                }
                GridRow {
                   // Level 13
                   Group {
                       let id = 13
                       Button("") {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                               if globalVar.haptics {
                                   UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                               }
                               withAnimation() {
                                   globalVar.showMenu = false
                                   globalVar.level = id
                                   globalVar.game = globalVar.levelContent[id]!
                                   globalVar.gameProgress = "starting"
                                   globalVar.resultLog = [""]
                                   globalVar.countdown = 60
                                   globalVar.enteredExpression = ""
                                   globalVar.score = 0
                                   globalVar.clearDrawings = true
                               }
                           }
                       }
                       .buttonStyle(levelButton(label: {
                           VStack {
                               Text("\(id)")
                                   .foregroundStyle(globalVar.theme.colorScheme.primary)
                                   .font(.system(size: 35, weight: .bold, design: .rounded))
                               HStack(spacing: 0) {
                                   ForEach(0..<3, id: \.self) { stars in
                                       if globalVar.levelStars[id] ?? 0 > stars {
                                           Image(systemName: "star.fill")
                                               .foregroundStyle(globalVar.theme.colorScheme.primary)
                                               .font(.system(size: 13))
                                       } else {
                                           Image(systemName: "star")
                                               .foregroundStyle(globalVar.theme.colorScheme.primary)
                                               .font(.system(size: 13))
                                       }
                                   }
                               }
                               .padding(.bottom, 5)
                           }
                           .frame(width: 67, height: 72)
                       }, globalVar: _globalVar))
                   }
                   // Level 14
                   Group {
                       let id = 14
                       Button("") {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                               if globalVar.haptics {
                                   UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                               }
                               withAnimation() {
                                   globalVar.showMenu = false
                                   globalVar.level = id
                                   globalVar.game = globalVar.levelContent[id]!
                                   globalVar.gameProgress = "starting"
                                   globalVar.resultLog = [""]
                                   globalVar.countdown = 60
                                   globalVar.enteredExpression = ""
                                   globalVar.score = 0
                                   globalVar.clearDrawings = true
                               }
                           }
                       }
                       .buttonStyle(levelButton(label: {
                           VStack {
                               Text("\(id)")
                                   .foregroundStyle(globalVar.theme.colorScheme.primary)
                                   .font(.system(size: 35, weight: .bold, design: .rounded))
                               HStack(spacing: 0) {
                                   ForEach(0..<3, id: \.self) { stars in
                                       if globalVar.levelStars[id] ?? 0 > stars {
                                           Image(systemName: "star.fill")
                                               .foregroundStyle(globalVar.theme.colorScheme.primary)
                                               .font(.system(size: 13))
                                       } else {
                                           Image(systemName: "star")
                                               .foregroundStyle(globalVar.theme.colorScheme.primary)
                                               .font(.system(size: 13))
                                       }
                                   }
                               }
                               .padding(.bottom, 5)
                           }
                           .frame(width: 67, height: 72)
                       }, globalVar: _globalVar))
                   }
                   // Level 15
                   Group {
                       let id = 15
                       Button("") {
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                               if globalVar.haptics {
                                   UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                               }
                               withAnimation() {
                                   globalVar.showMenu = false
                                   globalVar.level = id
                                   globalVar.game = globalVar.levelContent[id]!
                                   globalVar.gameProgress = "starting"
                                   globalVar.resultLog = [""]
                                   globalVar.countdown = 60
                                   globalVar.enteredExpression = ""
                                   globalVar.score = 0
                                   globalVar.clearDrawings = true
                               }
                           }
                       }
                       .buttonStyle(levelButton(label: {
                           VStack {
                               Text("\(id)")
                                   .foregroundStyle(globalVar.theme.colorScheme.primary)
                                   .font(.system(size: 35, weight: .bold, design: .rounded))
                               HStack(spacing: 0) {
                                   ForEach(0..<3, id: \.self) { stars in
                                       if globalVar.levelStars[id] ?? 0 > stars {
                                           Image(systemName: "star.fill")
                                               .foregroundStyle(globalVar.theme.colorScheme.primary)
                                               .font(.system(size: 13))
                                       } else {
                                           Image(systemName: "star")
                                               .foregroundStyle(globalVar.theme.colorScheme.primary)
                                               .font(.system(size: 13))
                                       }
                                   }
                               }
                               .padding(.bottom, 5)
                           }
                           .frame(width: 67, height: 72)
                       }, globalVar: _globalVar))
                   }
               }
                
            }
            .padding(.bottom, 10)
        }
    }
}
