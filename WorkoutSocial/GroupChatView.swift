import SwiftUI

struct GroupChatView: View {
  @State private var messages: [ChatMessage] = [
    ChatMessage(
      sender: "System", content: "💪 Faiz checked in for Friday!", timestamp: Date(), type: .system),
    ChatMessage(
      sender: "Laura", content: "Let’s gooo 🔥", timestamp: Date().addingTimeInterval(-300),
      type: .user),
    ChatMessage(
      sender: "You", content: "Just crushed it too 🙌", timestamp: Date().addingTimeInterval(-240),
      type: .user),
    ChatMessage(
      sender: "You", content: "Hey how is it going", timestamp: Date().addingTimeInterval(-200),
      type: .user),
  ]

  @State private var newMessage: String = ""
  @AppStorage("username") private var username: String = "You"

  var body: some View {
    VStack(spacing: 0) {
      headerView
      memberAvatarsView
      messagesScrollView
      messageInputView
    }
    .padding(.bottom, 4)
    .background(Color.black.ignoresSafeArea())
  }

  // MARK: - Header
  private var headerView: some View {
    Text("Group Chat")
      .font(.system(size: 26, weight: .heavy, design: .rounded))
      .foregroundColor(.green)
      .padding(.top, 12)
  }

  // MARK: - Avatars (Placeholder horizontal strip)
  private var memberAvatarsView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(["Emily", "Daniel", "Alex", "Sarah"], id: \.self) { name in
          VStack(spacing: 4) {
            Circle()
              .fill(Color.white)
              .frame(width: 44, height: 44)
              .overlay(Text(String(name.prefix(1))).font(.headline).foregroundColor(.black))
            Text(name)
              .font(.caption2)
              .foregroundColor(.white)
          }
        }
      }
      .padding(.horizontal)
      .padding(.top, 10)
    }
  }

  // MARK: - Messages Scroll View
  private var messagesScrollView: some View {
    ScrollView {
      LazyVStack(spacing: 12) {
        ForEach(groupedMessages(), id: \.self) { group in
          messageGroupView(group)
        }
      }
      .padding(.horizontal)
      .padding(.top, 8)
    }
  }

  // MARK: - Message Input Area
  private var messageInputView: some View {
    HStack(spacing: 8) {
      TextField("Message...", text: $newMessage)
        .padding(10)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
        .foregroundColor(.white)

      Button(action: sendMessage) {
        Image(systemName: "paperplane.fill")
          .foregroundColor(.black)
          .padding(10)
          .background(Color.green)
          .clipShape(Circle())
      }
      .disabled(newMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    .padding(.horizontal)
    .padding(.vertical, 8)
  }

  // MARK: - Message Group View
  private func messageGroupView(_ group: MessageGroup) -> some View {
    VStack(alignment: group.isCurrentUser ? .trailing : .leading, spacing: 4) {
      if group.isSystem {
        Text(group.messages.first?.content ?? "")
          .foregroundColor(.white)
          .font(.subheadline)
          .padding()
          .background(Color.purple)
          .cornerRadius(12)
          .frame(maxWidth: .infinity, alignment: .center)
      } else {
        ForEach(group.messages, id: \.timestamp) { message in
          HStack(alignment: .bottom, spacing: 8) {
            if !group.isCurrentUser {
              Circle()
                .fill(Color.white)
                .frame(width: 28, height: 28)
                .overlay(
                  Text(String(message.sender.prefix(1))).font(.caption).foregroundColor(.black))
            }

            VStack(alignment: .leading, spacing: 2) {
              if message == group.messages.first {
                Text(message.sender)
                  .font(.caption)
                  .foregroundColor(.gray)
              }

              Text(message.content)
                .padding(10)
                .background(group.isCurrentUser ? Color.green : Color.gray.opacity(0.3))
                .cornerRadius(14)
                .foregroundColor(group.isCurrentUser ? .black : .white)

              if message == group.messages.last {
                Text(formatTime(message.timestamp))
                  .font(.caption2)
                  .foregroundColor(.gray)
                  .padding(.top, 2)
              }
            }

            if group.isCurrentUser {
              Circle()
                .fill(Color.white)
                .frame(width: 28, height: 28)
                .overlay(Image(systemName: "person.fill").foregroundColor(.black))
            }
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: group.isCurrentUser ? .trailing : .leading)
  }

  // MARK: - Send Logic
  private func sendMessage() {
    let trimmed = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return }

    let message = ChatMessage(sender: username, content: trimmed, timestamp: Date(), type: .user)
    messages.append(message)
    newMessage = ""
  }

  // MARK: - Grouping
  private func groupedMessages() -> [MessageGroup] {
    var groups: [MessageGroup] = []
    var currentGroup: MessageGroup?

    for message in messages {
      if let group = currentGroup,
        group.sender == message.sender && message.type == .user
      {
        currentGroup?.messages.append(message)
      } else {
        if let group = currentGroup {
          groups.append(group)
        }
        currentGroup = MessageGroup(
          sender: message.sender,
          isCurrentUser: message.sender == username,
          isSystem: message.type == .system,
          messages: [message]
        )
      }
    }

    if let group = currentGroup {
      groups.append(group)
    }

    return groups
  }

  // MARK: - Helpers
  private func formatTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter.string(from: date)
  }
}

// MARK: - Supporting Models

struct ChatMessage: Hashable {
  let sender: String
  let content: String
  let timestamp: Date
  let type: MessageType

  enum MessageType {
    case user
    case system
  }
}

struct MessageGroup: Hashable {
  let sender: String
  let isCurrentUser: Bool
  let isSystem: Bool
  var messages: [ChatMessage]
}
