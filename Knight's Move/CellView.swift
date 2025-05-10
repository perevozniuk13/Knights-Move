import SwiftUI

struct CellView: View {
    let position: Position
    let isCurrent: Bool
    let isVisited: Bool
    let visitNumber: Int?

    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    isCurrent ? Color.blue :
                    isVisited ? Color(red: 136/255, green: 178/255, blue: 200/255) :
                                Color(red: 195/255, green: 228/255, blue: 250/255)
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
