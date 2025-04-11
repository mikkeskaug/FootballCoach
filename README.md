# ⚽️ CoachPlanner – SwiftUI + Firebase App for Football Coaches

CoachPlanner is a SwiftUI-based mobile app designed for football coaches to organize and manage their teams, plan workouts, schedule games, and share exercises with other coaches.

Built with **Firebase** for authentication and data storage, the app follows an **agile development approach** and is designed to be clean, modular, and scalable.

---

## 🚀 Features

- ✅ Email/password login with Firebase Auth
- ✅ Create and manage multiple teams
- ✅ Persistent team selection per coach
- ✅ Tab-based navigation:
  - Workouts
  - Games
  - Shared Exercises
- ✅ Add and edit teams
- ✅ Syncs team data in real-time using Firebase Firestore

---

## 🛠 Tech Stack

- **SwiftUI** (iOS 15+)
- **Firebase**
  - Authentication
  - Firestore (NoSQL database)
- **MVVM Architecture**
- **Agile Scrum-style development**

---

## 📁 Firebase Structure (Simplified)

```plaintext
users/
  [uid]/
    name: "Coach Name"
    email: "coach@example.com"
    teams: ["teamId1", "teamId2"]
    selectedTeam: "teamId1"

teams/
  [teamId]/
    name: "U14 Tigers"
    coachIds: ["uid1"]



⸻

🧩 Planned Features (Future Sprints)
    •    🔜 Workout creation + scheduling
    •    🔜 Game scheduling + opponents
    •    🔜 Shared exercise library
    •    🔜 Player management per team
    •    🔜 Push notifications
    •    🔜 Media uploads (images, videos, PDFs)

⸻

📦 Setup Instructions
    1.    Clone the repo:

git clone https://github.com/yourusername/CoachPlanner.git


    2.    Open the project in Xcode.
    3.    Set up Firebase:
    •    Create a Firebase project
    •    Add an iOS app in the Firebase console
    •    Download GoogleService-Info.plist and add it to the Xcode project
    •    Enable Firebase Authentication (Email/Password)
    •    Enable Firestore
    4.    Build and run on simulator or physical device.

⸻

🤝 Contributing

This is an ongoing agile project — feel free to fork, contribute ideas, or report bugs.

⸻

📄 License

MIT License. See LICENSE file for details.

⸻

👨‍💻 Made by


@mikkeskaug

With 💙 for coaches and the game.

---

Let me know if you'd like to customize the author or repo links, or if you want me to generate a `LICENSE` or GitHub badges section next!
