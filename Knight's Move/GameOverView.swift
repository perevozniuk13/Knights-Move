import SwiftUI

struct GameOverView: View {
    var hasWon: Bool
    var hasLost: Bool

    var body: some View {
        ZStack {
            if hasWon {
                Text("Challenge completed 🎉")
                    .font(.title)
                    .foregroundColor(Color(red: 6 / 255, green: 145 / 255, blue: 45 / 255))
            } else if hasLost {
                Text("Challenge failed 💀")
                    .font(.title)
                    .foregroundColor(Color(red: 199 / 255, green: 38 / 255, blue: 10 / 255))
                
            }
        }
    }
}
