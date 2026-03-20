🚑 ResQTrack — Smart Ambulance Tracking System

📌 Overview

ResQTrack is a real-time emergency response system designed to reduce ambulance response time by connecting callers, dispatchers, and drivers on a single platform.

The system allows users to send SOS alerts with live location, enables dispatchers to assign ambulances instantly, and helps drivers navigate to emergency locations efficiently.

---

🚨 Problem Statement

In many emergency situations:

- Ambulances are delayed due to lack of real-time coordination
- Dispatch systems are manual or inefficient
- Patients cannot track ambulance status
- Drivers do not get accurate or timely location updates

This leads to critical time loss, which can cost lives.

---

💡 Solution

ResQTrack provides a real-time digital coordination system that:

- 📍 Sends accurate GPS location from the caller
- 🧭 Displays SOS requests on a dispatcher dashboard
- 🚑 Allows instant ambulance assignment
- 📡 Tracks ambulance movement live
- 🔄 Updates status dynamically (Active → Assigned → Reached)

---

🧩 System Architecture

👤 Caller Interface

- One-tap SOS button
- Captures high-accuracy GPS location
- Sends emergency request to Firestore
- Displays emergency status

🖥 Dispatcher Interface

- Shows all active SOS requests
- Interactive map with SOS locations
- Assign ambulance with one click
- Real-time status monitoring

🚑 Driver Interface

- Receives assigned SOS requests
- Displays patient location on map
- Sends live location updates
- Marks patient as reached

---

⚙️ Tech Stack

- Frontend: Flutter
- Backend: Firebase Firestore
- Maps & Location:
  - Google Maps Flutter
  - Geolocator
- Realtime Updates: Firestore Streams

---

🔥 Key Features

- ⚡ Real-time SOS system
- 📍 High-accuracy GPS tracking
- 🗺 Live map integration
- 🚑 Ambulance assignment system
- 🔄 Dynamic status updates
- 📡 Live driver tracking

---

🚀 How It Works

1. User presses SOS button
2. App fetches accurate GPS location
3. SOS request is stored in Firestore
4. Dispatcher sees request instantly
5. Dispatcher assigns ambulance
6. Driver receives request and navigates
7. Status updates until patient reached

---

📸 Prototype

«Add screenshots of:»

- Caller SOS screen
- Dispatcher dashboard
- Driver interface

---

📈 Future Improvements

- ⏱ ETA calculation using Maps API
- 🔔 Push notifications
- 📞 Direct call integration
- 🧠 Smart ambulance allocation (AI-based)
- 🏥 Hospital integration

---

🎯 Impact

ResQTrack aims to:

- Reduce ambulance response time
- Improve emergency coordination
- Provide transparency to users
- Save lives through faster action

---

👨‍💻 Contributors

- Your Name
- Team Members

---

📌 Note

This project is a prototype developed for innovation and learning purposes, with scope for real-world deployment and scaling.

---

⭐ If you like this project, consider giving it a star!
