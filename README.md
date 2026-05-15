<h1 align="center">📝 Online Exam System - Predictable & Scalable Architecture</h1>

<p align="center">
  <em>A high-performance examination platform designed for seamless assessment delivery and real-time evaluation.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.10+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.10+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-8BC34A?style=for-the-badge" alt="Clean Architecture" />
  <img src="https://img.shields.io/badge/Pattern-MVI-FF5722?style=for-the-badge" alt="MVI Pattern" />
  <img src="https://img.shields.io/badge/State_Management-Cubit-2196F3?style=for-the-badge&logo=flutter&logoColor=white" alt="Cubit" />
</p>

<hr>

## 📸 App Showcase

*Experience a structured and reliable examination journey.*

<p align="center">
  <table>
    <tr>
      <td align="center"><strong>Login</strong></td>
      <td align="center"><strong>Subjects</strong></td>
      <td align="center"><strong>Active Exam</strong></td>
    </tr>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/1ddd92eb-96cf-4490-946c-7784b2323c35" width="250" alt="Login"/></td>
      <td><img src="https://github.com/user-attachments/assets/5f259b85-c02c-4b92-b556-6e899bbc2177" width="250" alt="Subjects"/></td>
      <td><img src="https://github.com/user-attachments/assets/2cc4a3fa-dfbe-49be-9a21-8d3bb21f2a59" width="250" alt="Questions"/></td>
    </tr>
    <tr>
      <td align="center"><strong>Result Analysis</strong></td>
      <td align="center"><strong>Exam Answers</strong></td>
      <td align="center"><strong>Profile</strong></td>
    </tr>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/1a010e86-1ff4-4dee-8cb7-dde82d790cfc" width="250" alt="Results"/></td>
      <td><img src="https://github.com/user-attachments/assets/d4ed20b6-7543-4311-9c3f-49e312807923" width="250" alt="Exam Answers"/></td>
      <td><img src="https://github.com/user-attachments/assets/32fbfb34-9b6c-4578-aad7-bb3eb313fd52"  width="250" alt="Profile"/></td>
    </tr>
  </table>
</p>

## 🌟 Overview & Core Features

**Exam App** is engineered to handle high-stakes assessments with zero margin for error. The system prioritizes data integrity and UI stability.

* ⚡ **Real-Time Exam Engine:** Features precise automated timing and instant server-side scoring mechanisms.
* 🧠 **Intelligent State Control:** Powered by **Cubit** to maintain a predictable unidirectional flow between questions and exam states.
* 🛠️ **Feature-Based Layered Structure:** Organized for maximum maintainability and independent feature scaling.
* 📱 **Seamless Auth & Discovery:** Smooth user flows for authentication, secure searching, and dynamic exam browsing.

## 🧠 Key Engineering Highlights

### 1. Predictable State Management (MVI Pattern)
We implemented the **MVI (Model-View-Intent)** pattern using **Cubit** to eliminate side effects and unpredictable UI behaviors:
* **Unidirectional Data Flow:** Every action (Next Question, Answer Selected) triggers a specific, testable state change.
* **Resilience:** Guaranteed UI stability even during complex operations like background timing and auto-submission on timeout.

### 2. High-Performance API Integration
The app communicates with a RESTful backend using **Dio** and **Retrofit** for type-safe networking:
* **Result Pattern:** All API responses are wrapped to ensure graceful error handling and data integrity without crashing the UI.
* **Server-Driven Logic:** Exam configurations and question types are fetched dynamically to allow for diverse assessment formats.

### 3. Enterprise-Grade Clean Architecture
Strict adherence to **Clean Architecture** to ensure the codebase remains decoupled and testable:
* **Domain Isolation:** Core business logic (scoring algorithms, timer logic) is independent of external frameworks.
* **Dependency Injection:** Managed via `get_it` and `injectable` for a clean, decoupled DI graph.

## ⚙️ Tech Stack & Dependencies

* **Core Framework:** Flutter & Dart.
* **State Management:** BLoC / Cubit (MVI Pattern).
* **Architecture:** Clean Architecture + Dependency Injection (`get_it`, `injectable`).
* **Networking:** `dio` with custom interceptors, `retrofit` for type-safe API calls.
* **UI Utilities:** Google Fonts, Lottie animations, and custom Shimmer effects.

<hr>

## 🚀 Getting Started

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/CodeMatesOrganization/online_exam_app.git](https://github.com/CodeMatesOrganization/online_exam_app.git)
   cd online_exam_app

## 🤝 The Team
**This project was built collaboratively by a dedicated team of engineers.**


**Malak Hussien** [![Linkedin](https://img.shields.io/badge/-LinkedIn-blue?style=flat&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/malak-hussein-b69418249/) | [![GitHub](https://img.shields.io/badge/-Github-000?style=flat&logo=Github&logoColor=white)](https://github.com/MALAK0244)

**Nagham Arafa** [![Linkedin](https://img.shields.io/badge/-LinkedIn-blue?style=flat&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/nagham-arafa-5558942bb/) | [![GitHub](https://img.shields.io/badge/-Github-000?style=flat&logo=Github&logoColor=white)](https://github.com/NaghamArafa)
