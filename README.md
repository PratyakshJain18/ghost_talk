# 👻 Ghost Talk

**Ghost Talk** is an anonymous real-time chat application built with **Flutter** and **Firebase**, designed for privacy-first communication. Users can start chatting instantly—no accounts, no usernames, no personal identity.

> **No profiles. No tracking. Just conversation.**

---

## 📌 Overview

Ghost Talk allows users to communicate freely in a shared chat environment while maintaining anonymity. The app enforces moderation, spam control, and message ownership rules to keep conversations clean and usable.

Built using **GetX architecture**, the project focuses on performance, simplicity, and scalability.

---

## ✨ Features

### 🕶️ Anonymous Chat
- No login or authentication
- No usernames or personal identifiers
- Fully anonymous sessions

### 🔥 Real-Time Messaging
- Powered by **Firebase Cloud Firestore**
- Messages sync instantly across all users
- Automatic real-time updates

### 🧠 Spam Prevention (Rate Limiting)
- Users can send **only one message every 3 seconds**
- Prevents flooding and spam
- Instant UI feedback when rate limit is hit

### 🗑️ Message Actions
- Long-press any message to open actions
- 📋 **Copy Message ID** (for all messages)
- 🗑️ **Delete Message** (only messages sent by you)

### 🚩 Message Reporting & Auto-Moderation
- 🚩 **Report Message** option available on other users’ messages
- Each user can **report a message only once**
- Reports are counted anonymously
- 🚨 **Automatic deletion rule**:
  - If a message receives **more than 5 reports**, it is **automatically deleted**
- No admin intervention required
- Ensures clean chat through community-driven moderation

### 🕒 Message Metadata
- Human-readable timestamps
- Messages sorted chronologically

### 🌐 Report a Problem (App-Level)
- Available from the **app drawer**
- Opens a **hosted support/report page inside an in-app WebView**
- Keeps users inside the app
- No personal data required

### ⚡ GetX Architecture
- State management
- Navigation
- Dependency injection
- Clean separation of UI and business logic

### 📱 Modern UI
- Minimal and distraction-free design
- Smooth animations and interactions
- Fully responsive layout

---

## 🧭 Message Actions Guide

1. **Long press** on any message bubble  
2. Choose an action:
   - 📋 Copy Message ID (all messages)
   - 🗑️ Delete Message (only your own messages)
   - 🚩 Report Message (other users’ messages only)

---

## 🛠️ Tech Stack

| Technology | Usage |
|-----------|------|
| **Flutter** | UI & application logic |
| **Firebase Cloud Firestore** | Real-time database |
| **GetX** | State management & navigation |
| **Intl** | Date & time formatting |
| **WebView** | In-app reporting |

---

## 🔒 Privacy Philosophy

Ghost Talk is built with privacy as a core principle:

- No authentication
- No user accounts
- No emails or phone numbers
- No personal data collection
- Messages tied only to anonymous session identifiers

---

## 📂 Project Status

- ✅ Core features implemented
- 🔧 Actively maintained
- 🚀 Open to future improvements:
  - Topic-based chat rooms
  - Advanced moderation tools
  - Client-side content filtering

---

## 📝 License

This project is created for **educational and learning purposes**.  
You are free to explore, learn from, and extend the codebase.

---

⭐ If you find this project useful, consider giving it a star!
