# Attendance Management System

A comprehensive and modern Attendance Management System built with Flutter.

## 📱 Overview

This application provides a streamlined and efficient way to manage attendance records. It is designed to cater to administrators, faculty/staff, and students, offering dedicated dashboards and features for each role.

## ✨ Features

- **Role-Based Access:** Dedicated interfaces for Admin, Faculty, and Students.
- **Admin Dashboard:** Manage departments, faculty members, students, and system-wide reports.
- **Faculty Portal:** Easily mark and track student attendance, view schedules, and manage class records.
- **Student Portal:** View personal attendance history, check timetables, and receive announcements.
- **Real-Time Synchronization:** Fast and reliable data updates.
- **Modern UI/UX:** Built with Flutter for a smooth, cross-platform experience.

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** Dart
- **State Management / Architecture:** (Specify if applicable, e.g., Provider, Riverpod, BLoC)
- **Backend:** (Specify if applicable, e.g., Firebase, REST API)

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your local machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- Dart SDK (comes with Flutter)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA) with Flutter and Dart plugins installed.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/BhagavatheeshR/Attendance-Management-System.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd Attendance-Management-System
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── app/               # Core app configurations and routing
├── core/              # Global utilities, platform info, and flavor configs
├── features/          # Feature-based modules
│   ├── admin/         # Admin dashboard and management screens
│   ├── auth/          # Authentication flows (login, etc.)
│   ├── faculty/       # Faculty portal (attendance marking, schedules)
│   └── student/       # Student portal (attendance view, announcements)
├── mock/              # Mock data for UI testing and development
├── models/            # Data models (Student, Faculty, AttendanceRecord, etc.)
├── shared/            # Reusable widgets (buttons, cards, dialogs, etc.)
└── theme/             # Global app themes, colors, and typography
```

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

## 📄 License

This project is licensed under the [MIT License](LICENSE).
