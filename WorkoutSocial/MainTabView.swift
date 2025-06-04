import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }

            PostView()
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }

            Text("Profile Coming Soon")
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
