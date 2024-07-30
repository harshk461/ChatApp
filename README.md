# ChatApp with Flutter and Firebase

Welcome to the ChatApp project! This project is built using Flutter for the frontend and Firebase for the backend. It includes features like authentication and messaging. In the future, we plan to integrate file-sharing capabilities as well.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Authentication:** Secure user authentication.
- **Messaging:** Real-time messaging between users.
- **Future Feature:** File sharing.

## Getting Started

Follow these instructions to set up and run the project locally.

### Prerequisites

Make sure you have the following installed on your system:

- Flutter (latest stable version)
- Firebase account
- Firebase CLI

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/chatapp.git
    cd chatapp
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Set up Firebase:**

    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Create a new project.
    - Add an Android and/or iOS app to your project.
    - Download the `google-services.json` file (for Android) and/or `GoogleService-Info.plist` file (for iOS) and place them in the appropriate directory:
      - `android/app` for `google-services.json`
      - `ios/Runner` for `GoogleService-Info.plist`
    - Enable Authentication and Firestore Database in the Firebase console.
    - Configure your Firebase project settings in `lib/firebase_options.dart`.

4. **Configure environment variables:**

    Create a `.env` file in the root of your project and add the following (if needed):

    ```plaintext
    FIREBASE_API_KEY=your-firebase-api-key
    FIREBASE_PROJECT_ID=your-firebase-project-id
    FIREBASE_MESSAGING_SENDER_ID=your-firebase-messaging-sender-id
    FIREBASE_APP_ID=your-firebase-app-id
    ```

### Usage

1. **Run the app:**

    ```bash
    flutter run
    ```

2. Open the app on your connected device or emulator.

## Folder Structure

Here's a brief overview of the project's folder structure:

$ tree
chatapp/
├── android/ # Android specific files
├── ios/ # iOS specific files
├── lib/ # Main Flutter application code
│ ├── models/ # Data models
│ ├── screens/ # UI screens
│ ├── services/ # Firebase and other services
│ ├── utils/ # Utility functions
│ ├── widgets/ # Reusable widgets
│ ├── main.dart # Main entry point of the app
├── test/ # Unit and widget tests
├── .env # Environment variables
├── .gitignore # Git ignore rules
├── pubspec.yaml # Project metadata and dependencies
└── README.md # Project README


## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Thank you for using and contributing to the ChatApp project!
