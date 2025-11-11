# 🚀 Flutter GetX MVVM Starter Kit

A starter kit for Flutter applications built with **GetX** and **MVVM**, featuring a well-defined folder structure, reusable components, and pre-configured utilities.  
This template is designed to help teams kickstart new Flutter projects quickly while maintaining scalability, readability, and consistency across codebases.

---

## 🧱 Features

- 🧩 **GetX** for state management, dependency injection, and navigation  
- 🏗️ **MVVM architecture** for clear separation of UI, logic, and data layers  
- 🧭 Ready-to-use folder structure for scalable projects  
- 💬 Centralized constants, themes, and utilities  
- 🧰 Reusable widgets and base classes  
- 🌐 Easy API integration setup  
- 🧑‍💻 Developer-friendly and team-ready configuration

---

## 📁 Folder Structure

```text
lib/
│
├── core/
│   ├── bindings/           # GetX dependency bindings
│   ├── routes/             # App routes and navigation
│   ├── theme/              # App theme, colors, text styles
│   ├── utils/              # Common utils, helpers, extensions
│   └── constants/          # Static values, assets, API endpoints
│
├── data/
│   ├── models/             # Shared data models
│   ├── repositories/       # Repository and data sources
│   └── services/           # API clients, local DB, network
│
├── features/
│   ├── home/
│   │   ├── binding/        # GetX bindings for Home module
│   │   ├── controller/     # ViewModel/Controller layer
│   │   ├── model/          # Feature-specific models
│   │   ├── view/           # UI screens & widgets
│   │   └── repository/     # Data layer specific to this feature
│   │
│   ├── login/
│   │   ├── binding/
│   │   ├── controller/
│   │   ├── model/
│   │   ├── view/
│   │   └── repository/
│   │
│   └── ...                 # Other features follow same structure
│
├── widgets/                # Global reusable widgets
│
└── main.dart               # App entry point (GetMaterialApp)
`````

---

🧠 Architecture Overview

This project follows the MVVM pattern using GetX for state management and navigation:

Model → Defines data structures and handles business logic

ViewModel (Controller) → Manages app state, user interaction, and logic

View → Declares the UI and observes state changes through GetX reactive observables

---

🧑‍💼 Contribution Guide

Create a new branch from main for your feature/fix.

Follow the existing folder structure and naming conventions.

Test locally before raising a Pull Request.

Submit a Pull Request with a clear description and screenshots (if UI-related).

---

🛠️ Tech Stack

Flutter (latest stable)

Dart

GetX

MVVM Architecture

---
.
## ⚙️ Getting Started

### 1️⃣ Clone the Repository

git clone https://github.com/Mobileteam-admin/flutter-app-blueprint.git

---------------------------------------------------------------------
🧾 License

This project is open source and available under the MIT License

---------------------------------------------------------------------
👨‍💻 Maintainer

Vishnu M A
Tech Lead – Mobility
