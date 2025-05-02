# 💬 WhatsChat iOS App

**WhatsChat** is a real-time messaging app for iOS, designed with a clean UIKit interface and backed by Firebase for authentication and cloud-based message storage. Built using the MVVM design pattern, WhatsChat ensures maintainable, scalable, and testable architecture while delivering a modern, responsive chat experience.

---

## 📲 Features

- 🔐 **Firebase Authentication**
  - Secure email & password-based sign-up/login
  - Auto session handling and user persistence

- 💬 **Real-Time Messaging**
  - Send and receive messages instantly using Firebase Firestore
  - Supports text-based chat between registered users
  - Message timestamps and user tagging

- 🖼️ **UIKit-based UI**
  - Clean, modern, and responsive interface
  - Auto-adjusting layouts for different screen sizes
  - Dark Mode support

- 🧠 **MVVM Architecture**
  - Separates UI, business logic, and networking
  - Promotes modular and testable code

- 🧾 **Chat History**
  - Messages are persistently stored in Firestore
  - Conversations are loaded dynamically with pagination

---

## 🛠️ Tech Stack

| Technology     | Purpose                                 |
|----------------|------------------------------------------|
| **UIKit**      | UI framework for interface design        |
| **Firebase Auth** | User authentication                   |
| **Firestore**  | Cloud-based NoSQL real-time database     |
| **MVVM**       | Clean architecture pattern               |
| **Swift 5**    | Programming language                     |
| **AutoLayout** | Responsive and adaptive UI               |

---

## 📁 Project Structure

WhatsChat/
├── Models/
│ ├── User.swift
│ └── Message.swift
├── ViewModels/
│ ├── AuthViewModel.swift
│ └── ChatViewModel.swift
├── Views/
│ ├── LoginViewController.swift
│ ├── RegisterViewController.swift
│ ├── ChatListViewController.swift
│ └── ChatRoomViewController.swift
├── Services/
│ └── FirebaseManager.swift
├── Utilities/
│ └── Extensions.swift
└── Resources/
└── Assets.xcassets, LaunchScreen.storyboard, Info.plist

markdown
Copy
Edit

---

## 🚀 Getting Started

### Requirements

- macOS with Xcode 13+
- iOS 14.0+ device
- Swift 5+

### Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a project.
2. Enable **Authentication** (Email/Password) and **Firestore Database**.
3. Download the `GoogleService-Info.plist` file and add it to your Xcode project.
4. Install Firebase SDK using CocoaPods or Swift Package Manager:
   ```bash
   pod init
   pod 'Firebase/Auth'
   pod 'Firebase/Firestore'
   pod install
Running the App
Clone the repository:

bash
Copy
Edit
git clone https://github.com/yourusername/whatschat-ios.git
cd whatschat-ios
Open .xcworkspace in Xcode:

bash
Copy
Edit
open WhatsChat.xcworkspace
Build and run on a real device or simulator.

🔐 Permissions
📡 Internet access (for Firebase connectivity)

📷 (Optional future feature) Camera & photo library access

📈 Planned Features
🖼️ Media sharing (images, videos)

📍 User online status and typing indicators

🛎️ Push notifications via Firebase Cloud Messaging

🔍 User search and friend discovery

💾 Offline message caching

🤝 Contributing
Contributions are welcome! To contribute:

Fork the repository

Create a new branch (git checkout -b feature/yourFeature)

Commit your changes (git commit -am 'Add new feature')

Push the branch (git push origin feature/yourFeature)

Open a Pull Request
