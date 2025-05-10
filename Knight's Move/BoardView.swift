import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var showVisitNumbers = false

    var hasWon: Bool {
        let boardSize = viewModel.boardSize
        let visitedCells = (0..<boardSize).flatMap { row in
            (0..<boardSize).map { col in
                Position(row: row, col: col)
            }
        }
        return visitedCells.allSatisfy { pos in
            viewModel.isVisited(pos)
        }
    }

    var hasLost: Bool {
        let current = viewModel.player.currentPosition
        let validMoves = validKnightMoves(from: current)
        let totalVisited = viewModel.player.visited.count
        let totalCells = viewModel.boardSize * viewModel.boardSize
        return totalVisited < totalCells && validMoves.isEmpty
    }

    private func validKnightMoves(from position: Position) -> [Position] {
        let directions = [
            (2, 1), (1, 2), (-1, 2), (-2, 1),
            (-2, -1), (-1, -2), (1, -2), (2, -1)
        ]
        return directions.compactMap { (dr, dc) -> Position? in
            let newRow = position.row + dr
            let newCol = position.col + dc
            let pos = Position(row: newRow, col: newCol)
            return (0..<viewModel.boardSize).contains(newRow) &&
                   (0..<viewModel.boardSize).contains(newCol) &&
                   !viewModel.isVisited(pos) ? pos : nil
        }
    }

    var cellSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (CGFloat(viewModel.boardSize - 1)) - totalPadding()
        return availableWidth / CGFloat(viewModel.boardSize)
    }

    private func totalPadding() -> CGFloat {
        return 40
    }

    var body: some View {
        VStack {
            Text("Knight's Move Challenge")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Picker("Board Size", selection: $viewModel.boardSize) {
                ForEach([5, 6, 7, 8], id: \.self) { size in
                    Text("\(size)x\(size)").tag(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .frame(width: 200)
            .onChange(of: viewModel.boardSize) {
                viewModel.resetGame()
            }
            

            Toggle("View Count", isOn: $showVisitNumbers)
                .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal) 


            Spacer()

            VStack(spacing: 4) {
                let boardRange = 0..<viewModel.boardSize
                ForEach(boardRange, id: \.self) { row in
                    HStack(spacing: 4) {
                        ForEach(boardRange, id: \.self) { col in
                            let pos = Position(row: row, col: col)
                            let isVisited = viewModel.isVisited(pos)
                            let isCurrent = pos == viewModel.player.currentPosition
                            let visitNumber = showVisitNumbers ? viewModel.visitNumber(for: pos) : nil

                            CellView(
                                position: pos,
                                isCurrent: isCurrent,
                                isVisited: isVisited,
                                visitNumber: visitNumber
                            )
                            .onTapGesture {
                                if viewModel.isValidKnightMove(from: viewModel.player.currentPosition, to: pos)
                                    && !isVisited {
                                    viewModel.movePlayer(to: pos)
                                }
                            }
                            .background(Color(red: 117/255, green: 162/255, blue: 191/255))
                            .cornerRadius(4)
                            .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)

            Spacer()

            GameOverView(hasWon: hasWon, hasLost: hasLost) {
                viewModel.resetGame()
            }
        }
        .padding()
    }
}
