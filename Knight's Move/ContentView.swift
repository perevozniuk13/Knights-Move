import SwiftUI

struct ContentView: View {
    let boardSize: Int
    @StateObject private var viewModel: GameViewModel

    init(boardSize: Int) {
        self.boardSize = boardSize
        _viewModel = StateObject(wrappedValue: GameViewModel(boardSize: boardSize))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("bg2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height + (geometry.size.width > 500 ? 100 : 0))
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer().frame(height: geometry.size.height * 0.15)

                    HStack {
                        BoardView(viewModel: viewModel)
                    }
                }
                .frame(width: geometry.size.width)
            }
        }
    }
}
