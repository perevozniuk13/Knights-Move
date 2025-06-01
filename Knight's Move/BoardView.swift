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
        guard let current = viewModel.player.currentPosition else { return false }
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
        let boardSize = CGFloat(viewModel.boardSize)

        let isTablet = screenWidth > 500
        let padding = isTablet ? 200 : 40
        let spacing = boardSize - 1

        let availableWidth = screenWidth - (spacing * 4) - CGFloat(padding)
        return availableWidth / boardSize
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: UIScreen.main.bounds.width > 500 ? 10 : 30)
            Picker("Board Size", selection: $viewModel.boardSize) {
                ForEach([5, 6, 7, 8], id: \.self) { size in
                    Text("\(size)x\(size)").tag(size)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .frame(width: UIScreen.main.bounds.width > 500 ? 300 : 200)
            .onChange(of: viewModel.boardSize) {
                viewModel.resetGame()
            }
            

            Toggle("View Count", isOn: $showVisitNumbers)
                .toggleStyle(SwitchToggleStyle(tint: Color(red: 30 / 255, green: 81 / 255, blue: 117 / 255)))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(10)
                .frame(width: 300)


            Spacer().frame(height: 10)

            VStack(spacing: 4) {
                let boardRange = 0..<viewModel.boardSize
                ForEach(boardRange, id: \.self) { row in
                    HStack(spacing: 4) {
                        ForEach(boardRange, id: \.self) { col in
                            let pos = Position(row: row, col: col)
                            let isVisited = viewModel.isVisited(pos)
                            let isCurrent = pos == viewModel.player.currentPosition
                            let isLosing = hasLost && pos == viewModel.player.currentPosition
                            let isWinning = hasWon && pos == viewModel.player.currentPosition
                            let visitNumber = showVisitNumbers ? viewModel.visitNumber(for: pos) : nil

                            CellView(
                                position: pos,
                                isCurrent: isCurrent,
                                isVisited: isVisited,
                                isLosing: isLosing,
                                isWinning: isWinning,
                                visitNumber: visitNumber
                            )
                            .onTapGesture {
                                if viewModel.player.currentPosition == nil {
                                    viewModel.startGame(at: pos)
                                } else if viewModel.isValidKnightMove(from: viewModel.player.currentPosition!, to: pos)
                                            && !isVisited {
                                    viewModel.movePlayer(to: pos)
                                }
                            }
                            .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            }
            .padding(5)
            .background(Color.white)
            .cornerRadius(12)

            Spacer().frame(height: 10)
            GameOverView(hasWon: hasWon, hasLost: hasLost)
            Spacer().frame(height: 10)
            Button("Reset Board", action: viewModel.resetGame)
                .padding()
                .background(Color(red: 30 / 255, green: 81 / 255, blue: 117 / 255))
                .foregroundColor(.white)
                .cornerRadius(10)
            Spacer()
        }
        .padding()
    }
}
