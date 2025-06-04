import SwiftUI
import PhotosUI

struct PostView: View {
    @State private var selectedImage: UIImage?
    @State private var isPosted = false
    @State private var caption: String = ""

    var body: some View {
        VStack(spacing: 20) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            PhotosPicker("Select Workout Photo", selection: .constant(nil))
                .padding()

            TextField("Write a caption...", text: $caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Post") {
                isPosted = true
            }
            .buttonStyle(.borderedProminent)

            if isPosted {
                Text("✅ Post uploaded!")
                    .foregroundColor(.green)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Post")
    }
}
