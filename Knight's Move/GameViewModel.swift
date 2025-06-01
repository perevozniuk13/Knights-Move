import Foundation

struct Position: Hashable {
    let row: Int
    let col: Int
}

struct Player {
    var currentPosition: Position? = nil
    var visited: Set<Position> = []
    var visitOrder: [Position: Int] = [:]
}

class GameViewModel: ObservableObject {
    @Published var boardSize: Int
    @Published var player: Player

    init(boardSize: Int = 5) {
        self.boardSize = boardSize
        self.player = Player()
    }

    func startGame(at position: Position) {
        player.currentPosition = position
        player.visited.insert(position)
        player.visitOrder[position] = 1
    }

    func movePlayer(to newPos: Position) {
        guard !player.visited.contains(newPos) else { return }
        guard let current = player.currentPosition else { return }
        guard isValidKnightMove(from: current, to: newPos) else { return }

        player.currentPosition = newPos
        player.visited.insert(newPos)
        player.visitOrder[newPos] = player.visitOrder.count + 1
    }

    func resetGame() {
        self.player = Player()
    }

    func isValidKnightMove(from: Position, to: Position) -> Bool {
        let rowDiff = abs(from.row - to.row)
        let colDiff = abs(from.col - to.col)
        return (rowDiff == 2 && colDiff == 1) || (rowDiff == 1 && colDiff == 2)
    }

    func isVisited(_ pos: Position) -> Bool {
        return player.visited.contains(pos)
    }

    func visitNumber(for pos: Position) -> Int? {
        return player.visitOrder[pos]
    }
}
