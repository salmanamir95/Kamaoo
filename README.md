# Kamaoo - A Cross-Platform E-commerce Flutter App

Kamaoo is a feature-rich, cross-platform e-commerce application built with Flutter and GetX. It is designed to provide a seamless shopping experience on Android, iOS, and the Web, with a strong focus on clean architecture, scalability, and a platform-adaptive user interface.

## 📸 Screenshots

Here's a gallery of the Kamaoo app in action, showcasing both light and dark themes across different features.

<table align="center">
  <tr>
    <td align="center">Welcome Page (Dark)</td>
    <td align="center">Login Page (Light)</td>
    <td align="center">Sign Up Page (Light)</td>
  </tr>
  <tr>
    <td><img src="Images/WebAppImages/Welcome%20page%20black%20bg.png" alt="Welcome Page Dark" width="270"/></td>
    <td><img src="Images/WebAppImages/Login%20Page%20White%20bg.png" alt="Login Page Light" width="270"/></td>
    <td><img src="Images/WebAppImages/SignUp%20White%20bg.png" alt="Sign Up Page Light" width="270"/></td>
  </tr>
  <tr>
    <td align="center">Product List (Dark)</td>
    <td align="center">Product List (Light)</td>
    <td align="center">Product Detail (Light)</td>
  </tr>
  <tr>
    <td><img src="Images/WebAppImages/Product%20list%20black%20bg.png" alt="Product List Dark" width="270"/></td>
    <td><img src="Images/WebAppImages/base_productlist%20page%20white%20bg.png" alt="Product List Light" width="270"/></td>
    <td><img src="Images/WebAppImages/product%20detail%20page%20white%20bg.png" alt="Product Detail Light" width="270"/></td>
  </tr>
  <tr>
    <td align="center">Favorites (Light)</td>
    <td align="center">Cart & Order (Light)</td>
    <td align="center">Settings (Dark)</td>
  </tr>
  <tr>
    <td><img src="Images/WebAppImages/Favorites%20White%20bg.png" alt="Favorites Light" width="270"/></td>
    <td><img src="Images/WebAppImages/Add%20to%20Cart%20and%20Order%20White%20bg.png" alt="Cart & Order Light" width="270"/></td>
    <td><img src="Images/WebAppImages/Settings%20black%20bg.png" alt="Settings Dark" width="270"/></td>
  </tr>
</table>

---

## ✨ Features

- **Cross-Platform:** Single codebase for Android, iOS, and Web.
- **Platform-Adaptive UI:** Delivers a native look and feel on Material (Android) and Cupertino (iOS) platforms.
- **Responsive Web Design:** Fully responsive layouts for an optimal experience on any screen size.
- **State Management with GetX:** Efficient and organized state management, dependency injection, and route management.
- **Firebase Integration:**
  - User Authentication (Email/Password).
  - Firestore for product and order management.
- **Clean Architecture:**
  - **Module-based Structure:** Code is organized by features (Home, Cart, Auth, etc.).
  - **Service Layer:** Business logic is abstracted into services (`AuthService`, `ProductService`, etc.).
  - **View/Controller Separation:** Clear separation of UI from business logic.
- **User Features:**
  - Browse and discover products.
  - Add/remove items from favorites.
  - Manage a shopping cart.
  - Mock checkout process.
- **Admin Panel:**
  - A dedicated section for admins to upload new products.
- **Theming:**
  - Supports both Light and Dark modes.
  - Theme preferences are saved locally.
- **Animations:** Smooth and engaging UI animations using `flutter_animate`.

---

## 🛠️ Tech Stack & Architecture

### Core Technologies
- **Framework:** Flutter
- **State Management:** GetX
- **Backend:** Firebase (Authentication, Firestore)
- **Responsive UI:** flutter_screenutil
- **Animations:** flutter_animate
- **Local Storage:** shared_preferences

### Architecture

The project follows a clean, scalable architecture inspired by MVC and modular design principles.

1.  **Modular Structure:** The `lib/app/modules` directory contains individual features like `home`, `cart`, `auth`, etc. Each module has its own `views` and `controllers`, making the codebase easy to navigate and maintain.

2.  **Platform-Specific Views:** Each view folder contains files for different platforms (`_material.dart`, `_cupertino.dart`, `_web.dart`). A central `view.dart` file uses a `PlatformWidget` to decide which UI to render at runtime. This ensures a native user experience.

3.  **GetX Controllers:** Controllers hold the business logic and state for their respective views. They interact with services to perform operations like fetching data or authenticating users.

4.  **Service Layer:** Located in `lib/app/domain/services`, this layer abstracts all external interactions (like Firebase calls) and core business logic. This keeps the controllers clean and makes the services reusable and testable.

5.  **Centralized Routing:** All routes are managed by GetX in `lib/app/routes`, providing a single source of truth for navigation.

---

## 📂 Project Structure

```
lib/
├── app/
│   ├── components/      # Reusable widgets (ProductItem, CustomButton, etc.)
│   ├── data/            # Models and local storage (Shared Preferences)
│   ├── domain/          # Core business logic and services
│   ├── modules/         # Feature-based modules (home, cart, auth, etc.)
│   │   └── home/
│   │       ├── controllers/
│   │       └── views/
│   │           ├── home_view.dart
│   │           ├── home_view_material.dart
│   │           ├── home_view_cupertino.dart
│   │           └── home_view_web.dart
│   └── routes/          # App routes and pages managed by GetX
├── config/            # App configuration (theme, etc.)
├── utils/             # Utility classes and constants
└── main.dart          # App entry point and service initialization
```

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK (version 3.x.x or higher)
- A code editor like VS Code or Android Studio
- Firebase CLI (optional, for managing Firebase)

### Environment & Firebase Setup

This project uses Firebase for its backend.

1.  **Create a `.env` file** in the root of the project. You can copy the `.env.example` file as a starting point:
    ```sh
    cp .env.example .env
    ```
    Add any necessary secret keys to your new `.env` file.

2.  **Set up Firebase:**
    - Go to the Firebase Console and create a new project.
    - Add an Android, iOS, and Web app to your Firebase project. Follow the on-screen instructions to download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files.
    - Place `google-services.json` in the `/android/app/` directory.
    - Place `GoogleService-Info.plist` in the `/ios/Runner/` directory.
    - In the console, enable **Authentication** (with Email/Password provider) and **Firestore Database**.

3.  **Generate Firebase Options:** Install the FlutterFire CLI:
    ```sh
    dart pub global activate flutterfire_cli
    ```
5.  From the root of the project directory, configure your apps:
    ```sh
    flutterfire configure
    ```
    This will generate the `lib/firebase_options.dart` file required to connect your app to Firebase. This file is ignored by Git, so each developer needs to run this command.

### Installation & Running

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/your-username/kamaoo-app.git
    cd kamaoo-app
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run the app:**
    ```sh
    flutter run
    ```
    You can also select a specific device or run on the web:
    ```sh
    flutter run -d chrome --web-renderer html
    ```

---

## 📄 License

This project is licensed under the MIT License - see the LICENSE.md file for details.

---

*This README was generated with the help of Gemini Code Assist.*