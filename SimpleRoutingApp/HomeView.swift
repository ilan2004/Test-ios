import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "house.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Welcome Home!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("This is the home screen of our simple routing app.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Quick Actions")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    NavigationLink(destination: AboutMeView()) {
                        HStack {
                            Image(systemName: "person.circle")
                            Text("Go to About Me")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
