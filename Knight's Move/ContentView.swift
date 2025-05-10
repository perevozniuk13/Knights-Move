import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel(boardSize: 5)


    var body: some View {
        ZStack {
            Color(red: 222/255, green: 240/255, blue: 252/255).ignoresSafeArea()
            BoardView(viewModel: viewModel)
        }
    }
}
