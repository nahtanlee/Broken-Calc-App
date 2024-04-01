import SwiftUI

struct ThemeType {
    let primary: Color
    let secondary: Color
    let tertiary: Color
    let quaternary: Color
    let background: Color
    let disabled: Color
    let imageName: String
}

enum Theme: Codable, CaseIterable {
    case SeaBreeze
    case Floral
    case Rose
    case OceanWave
    case Camo
    case Forrest
    case Fun
    case Clay
    case Sky
    
    
    private static let SeaBreezeTheme: ThemeType = ThemeType(
        primary: Color(red: 84/255, green: 105/255, blue: 136/255, opacity: 1.0),
        secondary: Color(red: 145/255, green: 186/255, blue: 219/255, opacity: 1.0),
        tertiary: Color(red: 202/255, green: 221/255, blue: 237/255, opacity: 1.0),
        quaternary: Color(red: 163/255, green: 187/255, blue: 207/255, opacity: 1.0),
        background: Color(red: 252/255, green: 234/255, blue: 207/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Sea Breeze"
    )
    
    private static let FloralTheme: ThemeType = ThemeType(
        primary: Color(red: 84/255, green: 136/255, blue: 92/255, opacity: 1.0),
        secondary: Color(red: 145/255, green: 219/255, blue: 152/255, opacity: 1.0),
        tertiary: Color(red: 202/255, green: 237/255, blue: 205/255, opacity: 1.0),
        quaternary: Color(red: 163/255, green: 207/255, blue: 170/255, opacity: 1.0),
        background: Color(red: 207/255, green: 214/255, blue: 252/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Floral"
    )
    
    private static let RoseTheme: ThemeType = ThemeType(
        primary: Color(red: 136/255, green: 84/255, blue: 84/255, opacity: 1.0),
        secondary: Color(red: 219/255, green: 145/255, blue: 145/255, opacity: 1.0),
        tertiary: Color(red: 237/255, green: 202/255, blue: 202/255, opacity: 1.0),
        quaternary: Color(red: 207/255, green: 163/255, blue: 163/255, opacity: 1.0),
        background: Color(red: 255/255, green: 233/255, blue: 233/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Rose"
    )
    
    private static let OceanWaveTheme: ThemeType = ThemeType(
        primary: Color(red: 84/255, green: 136/255, blue: 127/255, opacity: 1.0),
        secondary: Color(red: 145/255, green: 219/255, blue: 201/255, opacity: 1.0),
        tertiary: Color(red: 202/255, green: 237/255, blue: 233/255, opacity: 1.0),
        quaternary: Color(red: 163/255, green: 207/255, blue: 207/255, opacity: 1.0),
        background: Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Ocean Wave"
    )
    
    private static let CamoTheme: ThemeType = ThemeType(
        primary: Color(red: 106/255, green: 77/255, blue: 70/255, opacity: 1.0),
        secondary: Color(red: 100/255, green: 148/255, blue: 83/255, opacity: 1.0),
        tertiary: Color(red: 146/255, green: 189/255, blue: 126/255, opacity: 1.0),
        quaternary: Color(red: 177/255, green: 207/255, blue: 163/255, opacity: 1.0),
        background: Color(red: 234/255, green: 235/255, blue: 205/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Camo"
    )
    
    private static let ForrestTheme: ThemeType = ThemeType(
        primary: Color(red: 79/255, green: 123/255, blue: 78/255, opacity: 1.0),
        secondary: Color(red: 146/255, green: 219/255, blue: 145/255, opacity: 1.0),
        tertiary: Color(red: 200/255, green: 245/255, blue: 192/255, opacity: 1.0),
        quaternary: Color(red: 170/255, green: 212/255, blue: 169/255, opacity: 1.0),
        background: Color(red: 231/255, green: 255/255, blue: 223/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Forrest"
    )
    
    private static let FunTheme: ThemeType = ThemeType(
        primary: Color(red: 78/255, green: 96/255, blue: 123/255, opacity: 1.0),
        secondary: Color(red: 145/255, green: 219/255, blue: 183/255, opacity: 1.0),
        tertiary: Color(red: 245/255, green: 227/255, blue: 192/255, opacity: 1.0),
        quaternary: Color(red: 212/255, green: 177/255, blue: 169/255, opacity: 1.0),
        background: Color(red: 223/255, green: 249/255, blue: 255/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Fun"
    )
    
    private static let ClayTheme: ThemeType = ThemeType(
        primary: Color(red: 139/255, green: 125/255, blue: 99/255, opacity: 1.0),
        secondary: Color(red: 219/255, green: 189/255, blue: 145/255, opacity: 1.0),
        tertiary: Color(red: 245/255, green: 224/255, blue: 192/255, opacity: 1.0),
        quaternary: Color(red: 212/255, green: 195/255, blue: 169/255, opacity: 1.0),
        background: Color(red: 255/255, green: 242/255, blue: 223/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Clay"
    )
    
    private static let SkyTheme: ThemeType = ThemeType(
        primary: Color(red: 78/255, green: 102/255, blue: 123/255, opacity: 1.0),
        secondary: Color(red: 150/255, green: 198/255, blue: 225/255, opacity: 1.0),
        tertiary: Color(red: 192/255, green: 223/255, blue: 245/255, opacity: 1.0),
        quaternary: Color(red: 172/255, green: 207/255, blue: 218/255, opacity: 1.0),
        background: Color(red: 220/255, green: 240/255, blue: 255/255, opacity: 1.0),
        disabled: Color(red: 236/255, green: 236/255, blue: 236/255, opacity: 1.0),
        imageName: "Sky"
    )
    
    var colorScheme: ThemeType {
            switch self {
            case .SeaBreeze:
                return Theme.SeaBreezeTheme
            case .Floral:
              return Theme.FloralTheme
            case .Rose:
                return Theme.RoseTheme
            case .OceanWave:
                return Theme.OceanWaveTheme
            case .Camo:
                return Theme.CamoTheme
            case .Forrest:
                return Theme.ForrestTheme
            case .Fun:
                return Theme.FunTheme
            case .Clay:
                return Theme.ClayTheme
            case .Sky:
                return Theme.SkyTheme
            }
        }
}
