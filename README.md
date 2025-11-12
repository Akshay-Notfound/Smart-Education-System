# Smart Education System

A Flutter-based cross-platform application for transparent college administration.

## Features

This application implements the following features as per the problem statement:

1. **Student Election System**
   - Online election platform for student councils with candidate profiles
   - Secure voting mechanism with college email authentication
   - Live result tracking for transparency

2. **Automated Health & Leave Notifications**
   - Automatic email notifications for health and leave tracking
   - Safety tracking for student departures from campus

3. **Campus Facility Booking System**
   - Online prior booking system for campus facilities
   - Approval mechanism from relevant authorities
   - Availability status visible to students and faculty

4. **Transparent Application & Approval System**
   - Single portal for submitting applications related to events, budget, and sponsorships
   - Applications visible to all students and faculty
   - Approval workflow with priority-based escalation
   - Real-time tracking of application status

5. **Academic Integrity & Cheating Record System**
   - Public visibility of cheating records for academic integrity
   - Details include name, reason, and proof

6. **Anonymous Complaint System**
   - Students can submit anonymous complaints
   - Moderation system to block inappropriate content
   - Identity revelation only with board member approval

7. **Transparent College Budget & Sponsorship Tracking**
   - Public visibility of college sponsorships and budgets
   - Expense proofs with verification
   - Transparency for mess budgets managed by students

8. **Restricted Access for College Members Only**
   - System accessible only via college email IDs
   - Authentication ensures authenticity

## Technical Implementation

### Supported Platforms
- Windows
- iOS
- Android
- Web (Chrome, Edge, etc.)

### Technologies Used
- Flutter Framework
- Dart Programming Language

### Project Structure
```
lib/
├── main.dart                 # Entry point of the application
├── models/                   # Data models
│   ├── app_state.dart        # Main application state
│   ├── student.dart          # Student model
│   ├── election.dart         # Election and Candidate models
│   ├── application.dart      # Application model
│   ├── complaint.dart        # Complaint model
│   ├── budget.dart           # Budget and Expense models
│   ├── facility.dart         # Facility and Booking models
│   └── cheating_record.dart  # Cheating record model
├── screens/                  # UI screens
│   ├── login_screen.dart     # Login screen
│   ├── home_screen.dart      # Home dashboard
│   ├── election_screen.dart  # Election management
│   ├── application_screen.dart # Application management
│   ├── complaint_screen.dart # Complaint management
│   ├── budget_screen.dart    # Budget tracking
│   ├── facility_screen.dart  # Facility booking
│   └── cheating_screen.dart  # Cheating records
└── services/                 # Business logic
    └── data_service.dart     # Data management service
```

## Getting Started

### Prerequisites
- Flutter SDK (version 3.0 or higher)
- Dart SDK
- Android Studio or Xcode for mobile development
- Visual Studio Code or Android Studio for development

### Installation
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

### Supported Platforms
The application can be built and run on:
- Android devices and emulators
- iOS devices and simulators
- Windows desktop
- Web browsers (Chrome, Edge, Firefox, Safari)

## Usage
1. Login using a college email (demo accounts available)
2. Navigate through different services using the dashboard
3. Submit applications, complaints, book facilities, and participate in elections
4. View transparent records of budgets, cheating incidents, and more

## Demo Accounts
- john.doe@college.edu
- jane.smith@college.edu
- robert.j@college.edu

## Expected Impact
- **Transparency**: Students and faculty can track applications, funds, and election processes openly
- **Efficiency**: Automated approvals and notifications reduce manual workload
- **Accountability**: Budget tracking and complaint handling prevent misuse of funds and power
- **Fair Elections**: A structured online voting system ensures integrity
- **Student Safety**: Automated health and leave notifications keep parents informed

## Future Enhancements
- Integration with email services for automated notifications
- Backend API integration for persistent data storage
- Push notifications for real-time updates
- Enhanced security features
- Admin panel for authority management