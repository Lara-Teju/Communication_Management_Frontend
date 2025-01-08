# Communication Module

## Overview
The **Communication/Event Module** is a Flutter-based application designed to streamline the event management process. The module integrates a calendar interface to create and view events, and it is connected to the **Membership Management System**. When events are created, the system automatically sends invitation emails to members based on their preferences. Once a member accepts the invitation, their details are added to the event's attendee list. The backend uses **MongoDB** to store event and member data.

---

## Features
- **Event Creation**: Users can create events with the following details:
  - Name
  - Description
  - Date and Time
  - Event Type (e.g., Webinar, Workshop, etc.)
- **Event Calendar**: View events in a calendar interface.
- **Member Integration**: The system is connected to the **Membership Management System**, which sends automatic email invitations to members based on their event preferences.
- **Automatic RSVP Handling**: Once the invitation email is accepted, the member’s details are added to the event’s attendee list.
- **Flutter Frontend**: The frontend is developed using Flutter for a smooth, responsive user experience.
- **MongoDB Database**: Stores event and member data for quick access and management.

---

## Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Node.js (Express.js)
- **Database**: MongoDB
- **Other Tools**: REST APIs for communication between frontend and backend, email integration for sending invitations.

---

## Setup Instructions

### Prerequisites
Ensure you have the following installed on your system:
- Flutter SDK ([Installation Guide](https://docs.flutter.dev/get-started/install))
- Node.js and npm ([Download](https://nodejs.org/))
- MongoDB ([Download](https://www.mongodb.com/try/download/community))

### Backend Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/Lara-Teju/Communication_Management_Frontend.git

