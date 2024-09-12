import SwiftUI

struct SwipeUpSearchBarView: View {
    @State private var searchText = ""
    @State private var offset: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack {
                Spacer()
                Text("Swipe up to search")
                    .padding()
            }
            

            searchBar
                .offset(y: offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.height < 0 {

                                offset = max(offset + gesture.translation.height, UIScreen.main.bounds.height - 150)
                            }
                        }
                        .onEnded { _ in
                            if offset < UIScreen.main.bounds.height - 100 {

                                withAnimation {
                                    offset = UIScreen.main.bounds.height - 150
                                }
                            } else {

                                withAnimation {
                                    offset = UIScreen.main.bounds.height
                                }
                            }
                        }
                )
        }
        .edgesIgnoringSafeArea(.all)
    }

    private var searchBar: some View {
        VStack {
            TextField("Search...", text: $searchText)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeUpSearchBarView()
    }
}
