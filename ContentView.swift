import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                FloatingClouds()
                VStack {
                    NavigationLink(destination: Intermediate()                    .navigationBarBackButtonHidden(true)) {
                            ZStack {
                                RoundedRectangle (cornerRadius: 10)
                                    .frame(width: 150, height: 50)
                                    .foregroundColor(.white)
                                    .shadow(radius: 25)
                                    .border(Color.gray, width: 3)
                                Text("Intermediate Mode")
                        }
                    }
                    NavigationLink(destination: Zen()                    .navigationBarBackButtonHidden(true)) {
                            ZStack {
                                RoundedRectangle (cornerRadius: 10)
                                    .frame(width: 150, height: 50)
                                    .foregroundColor(.white)
                                    .shadow(radius: 25)
                                    .border(Color.gray, width: 3)
                                Text("Zen Mode")
                        }
                    }
                }
            }
        }
    }
}
