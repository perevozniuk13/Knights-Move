import SwiftUI

struct StartView: View {
    @State private var selectedSize: Int? = nil

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("background1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height + 100)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Spacer().frame(height: geometry.size.height * 0.4)


                        Text("Move the knight in an L-shape to fill every square on the board")
                            .font(.custom("Boldonse-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                        
                        Text("Choose your board size to begin the challenge!")
                            .font(.system(size: 16, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .multilineTextAlignment(.center)

                        VStack(spacing: 10) {
                            ForEach(0..<2) { row in
                                HStack(spacing: 10) {
                                    ForEach(0..<2) { col in
                                        let size = [5, 6, 7, 8][row * 2 + col]
                                        NavigationLink(destination: ContentView(boardSize: size)) {
                                            Text("\(size) × \(size)")
                                                .font(.title2)
                                                .frame(width: 150, height: 150)
                                                .background(Color(red: 30 / 255, green: 81 / 255, blue: 117 / 255))
                                                .foregroundColor(.white)
                                                .cornerRadius(16)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)

                        Spacer()
                    }
                    .frame(width: geometry.size.width)
                }
            }
        }
    }
}
