import SwiftUI


struct Line {
    var points: [CGPoint] = []
    var thickness: Double = 6.0
}

struct DrawingView: View {
    @EnvironmentObject var globalVar: GlobalVar		
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    var side: String // right or left
    var showButtons: Bool
    @State private var counter: Int = 0
    
    var body: some View {
        ZStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(globalVar.theme.colorScheme.quaternary), style: StrokeStyle(lineWidth: line.thickness, lineCap: .round, lineJoin: .round))
                }
                
            }
            .overlay {
                HStack {
                    VStack {
                        Spacer()
                        if showButtons {
                            // Clear button
                            if globalVar.isBlankCanvas {
                                Button("") {
                                }
                                .buttonStyle(symbolButton(globalVar: globalVar, symbol: "trash.fill", enabled: false))
                                .padding(.bottom, 18)
                            } else {
                                Button("") {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        if globalVar.haptics {
                                            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                                        }
                                    }
                                    globalVar.clearDrawings = true
                                    counter += 1
                                }
                                .buttonStyle(symbolButton(globalVar: globalVar, symbol: "trash.fill", enabled: true))
                                .padding(.bottom, 18)
                            }
                        }
                        
                    }
                    .padding(.leading, 30)
                    Spacer()

                    
                }
                
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        withAnimation {
                            globalVar.isBlankCanvas = false
                        }
                        currentLine.points.append(value.location)
                        lines.append(currentLine)
                        
                        
                    })
                    .onEnded({ value in
                        currentLine = Line(points: [])
                    })
            )
            .onChange(of: globalVar.clearDrawings, { _, clearDrawings in
                if clearDrawings {
                    print("remove")
                    lines.removeAll()
                    withAnimation {
                        globalVar.isBlankCanvas = true
                    }
                    globalVar.clearDrawings = false
                }
            })
            .onChange(of: counter, { _, _ in
                if globalVar.clearDrawings {
                    print("remove")
                    lines.removeAll()
                    withAnimation {
                        globalVar.isBlankCanvas = true
                    }
                    globalVar.clearDrawings = false
                }
            })
        }
        .ignoresSafeArea(.all)

    }
}
