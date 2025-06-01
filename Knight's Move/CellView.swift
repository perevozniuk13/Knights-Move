import SwiftUI

struct CellView: View {
    let position: Position
    let isCurrent: Bool
    let isVisited: Bool
    let isLosing: Bool
    let isWinning: Bool
    let visitNumber: Int?

    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    isWinning ? Color(red: 6 / 255, green: 145 / 255, blue: 45 / 255) : // green
                    isLosing ? Color(red: 199 / 255, green: 38 / 255, blue: 10 / 255) : // red
                    isCurrent ? Color(red: 30 / 255, green: 81 / 255, blue: 117 / 255) : // teal
                    isVisited ? Color(red: 136 / 255, green: 178 / 255, blue: 200 / 255) : // grey
                    Color(red: 195 / 255, green: 228 / 255, blue: 250 / 255) // light blue
                )
                .cornerRadius(4)

            if let number = visitNumber {
                Text("\(number)")
                    .foregroundColor(.white)
                    .bold()
            }
        }
    }
}
