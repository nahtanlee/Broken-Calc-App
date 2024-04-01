import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .mac {
                ContentView()
                    .frame(width: 1300, height: 803)
            } else {
                ContentView()
            }
            
        }
        
    }
}

//// if UIDevice.current.userInterfaceIdiom == .mac {
//ContentView()
//    .frame(width: 1300, height: 803)
//} else {
