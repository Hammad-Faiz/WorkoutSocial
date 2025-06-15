import PhotosUI
import SwiftUI

struct PostView: View {
  @AppStorage("username") private var username: String = ""

  @State private var selectedItem: PhotosPickerItem? = nil
  @State private var selectedImage: UIImage? = nil
  @State private var caption: String = ""
  @State private var isPosted = false
  @State private var shareToFeed = true

  @EnvironmentObject var postStore: PostStore

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      VStack(spacing: 24) {
        Text("Check in your\nworkout")
          .font(.system(size: 28, weight: .bold, design: .rounded))
          .multilineTextAlignment(.center)
          .foregroundColor(.green)
          .padding(.top, 20)

        if let image = selectedImage {
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .cornerRadius(16)
            .frame(maxHeight: 250)
            .padding(.horizontal)
        } else {
          PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()
          ) {
            VStack(spacing: 8) {
              Image(systemName: "photo.on.rectangle")
                .font(.system(size: 36))
              Text("Select Workout Photo")
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)
          }
        }

        TextField("Crushed my push day! 💪", text: $caption)
          .padding()
          .foregroundColor(.white)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .stroke(Color.white.opacity(0.3), lineWidth: 1)
          )
          .padding(.horizontal)

        Toggle("Also share to public feed", isOn: $shareToFeed)
          .padding(.horizontal)
          .tint(.green)
          .foregroundColor(.white)

        Button(action: {
          if let image = selectedImage {
            let newPost = WorkoutPost(
              image: image,
              caption: caption,
              username: username,
              timestamp: Date()
            )

            if shareToFeed {
              postStore.posts.insert(newPost, at: 0)
            }

            // ✅ Track check-in regardless of whether it's shared
            postStore.addCheckIn()

            // Clear form + show confirmation
            selectedImage = nil
            caption = ""
            isPosted = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              isPosted = false
            }
          }
        }) {
          Text("Confirm")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(selectedImage != nil ? Color.green : Color.gray)
            .foregroundColor(.black)
            .cornerRadius(16)
        }
        .disabled(selectedImage == nil)
        .padding(.horizontal)

        if isPosted {
          Text("✅ Workout posted!")
            .foregroundColor(.green)
            .transition(.opacity)
        }

        Spacer()
      }
      .padding(.bottom)
    }
    .onChange(of: selectedItem) {
      Task {
        if let data = try? await selectedItem?.loadTransferable(type: Data.self),
          let uiImage = UIImage(data: data)
        {
          selectedImage = uiImage
        }
      }
    }
  }
}
