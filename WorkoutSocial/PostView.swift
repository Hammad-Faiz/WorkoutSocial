import PhotosUI
import SwiftUI

struct PostView: View {

  @EnvironmentObject var postStore: PostStore

  @State private var selectedItem: PhotosPickerItem? = nil
  @State private var selectedImage: UIImage? = nil
  @State private var caption: String = ""
  @State private var isPosted = false
  @AppStorage("username") private var username: String = ""

  var body: some View {
    VStack(spacing: 20) {
      if let image = selectedImage {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(height: 200)
          .cornerRadius(10)
      }

      PhotosPicker(
        selection: $selectedItem,
        matching: .images,
        photoLibrary: .shared()
      ) {
        Text("Select Workout Photo")
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.blue.opacity(0.1))
          .cornerRadius(8)
      }

      TextField("Write a caption...", text: $caption)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)

      Button("Post") {
        if let image = selectedImage {
          let newPost = WorkoutPost(
            image: image, caption: caption, username: username, timestamp: Date())
          postStore.posts.insert(newPost, at: 0)
          caption = ""
          selectedImage = nil
          isPosted = true
        }
      }
      .buttonStyle(.borderedProminent)

      if isPosted {
        Text("✅ Post uploaded!")
          .foregroundColor(.green)
      }

      Spacer()
    }
    .padding()
    .onChange(of: selectedItem) {
      Task {
        if let data = try? await selectedItem?.loadTransferable(type: Data.self),
          let uiImage = UIImage(data: data)
        {
          selectedImage = uiImage
        }
      }
    }
    .navigationTitle("Post")
  }
}
