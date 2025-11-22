# ShopKart Application Documentation

## Table of Contents
- [Project Overview](#project-overview)
- [Technology Stack](#technology-stack)
- [Features](#features)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [API Endpoints](#api-endpoints)
- [Session Management](#session-management)
- [Screens & Navigation](#screens--navigation)
- [Notes & Considerations](#notes--considerations)

---

## Project Overview
ShopKart is a full-stack e-commerce application built using Flutter for the frontend and Node.js/Express with MySQL for the backend. It allows users to browse products, manage their profile, add items to a wishlist, and explore product categories. The app uses REST APIs to handle user authentication, profile updates, product fetching, and wishlist management.

---

## Technology Stack
- **Frontend:** Flutter, Dart  
- **Backend:** Node.js, Express.js  
- **Database:** MySQL  
- **File Uploads:** Multer (for profile image uploads)  
- **State Management:** Singleton-based SessionManager  
- **HTTP:** `http` package for Flutter  

---

## Features
### User Authentication & Dashboard
- Login and Signup functionality  
- Update profile information (username, email, password, profile picture)  
- Logout functionality  

### Product Management
- Fetch and display products from backend API  
- Add/remove products to wishlist  
- Mark favorites  

### Category Browsing
- Browse product categories using a grid view  
- Clickable category cards  

### Session Management
- Persistent session with `SessionManager` singleton  
- User data cleared on logout  

### Responsive UI
- Flutter widgets adapt to various screen sizes  
- Scrollable lists and grids for products and categories  

---

## Project Structure
### Frontend (`lib/`)
```shell
lib/
├── functions/
│ ├── api.dart # API call functions
│ ├── bottomnav.dart # Bottom navigation bar widget
│ ├── product_card_widget.dart # Product card widget
│ └── category_card_widget.dart# Category card widget
├── routes/
│ ├── dashboard.dart
│ └── wishlist.dart
├── main.dart # App entry point
├── home.dart # Home screen
└── account.dart # User account/profile screen
```

### Backend (`server/`)
```shell
server/
├── routes/
│ ├── index.js # Home route
│ ├── users.js # User CRUD operations
│ ├── categories.js # Category APIs
│ ├── wishlist.js # Wishlist APIs
│ ├── login_signup.js # Login & Signup APIs
│ └── dashboard.js # Update profile route
├── uploads/ # Uploaded profile images
├── app.js # Express app setup
└── db.js # MySQL database connection
```
---

## Setup & Installation

### Backend
**Install dependencies:**
```bash
cd server
npm install
Configure MySQL database in db.js.
```
**Start the server:**
```bash
npm start
Default backend URL: http://localhost:3000
```
### Frontend
**Install Flutter dependencies:**
```bash
flutter pub get
```

**Run the Flutter app:**
```bash
flutter run
```
Ensure the backend server is running before launching the app.

---

### API Endpoints

**Endpoint	Method	Description**
```shell
/loginSignup/login	POST	User login
/loginSignup/signup	POST	User registration
/dashboard	POST	Update user profile with optional image
/categories	GET	Fetch all product categories
/products	GET	Fetch all products
/wishlist	POST	Add/remove products to wishlist
```

**Example: Update Profile**
```json
URL: POST http://localhost:3000/dashboard
Body (Multipart):
{
  "id": "4",
  "username": "sadid123",
  "email": "sadid123@gmail.com",
  "password": "123456",
  "image": "file (optional)"
}
Response:
{
  "message": "Profile updated successfully",
  "user": {
    "id": "4",
    "username": "sadid123",
    "email": "sadid123@gmail.com",
    "avatar": "profile123.jpg"
  }
}
```
---

### Session Management

**Singleton Pattern:** SessionManager holds the current user data.
**Store user:** SessionManager.instance.setUser(user)
**Retrieve user:** SessionManager.instance.user
**Clear user on logout:** SessionManager.instance.clear()

---

### Screens & Navigation

**Home Screen**: Shows products, categories, and top bar with user avatar.
**Dashboard/Profile Screen**: Update user information and profile picture.
**Wishlist Screen**: Shows favorited products.
**Bottom Navigation**: Home, Browse, Wishlist, Bag, Account

**Navigation is handled using:**
```dart
Navigator.pushReplacementNamed(context, '/routeName', arguments: data);
```
User data is passed through arguments and stored in SessionManager.

---

### Notes & Considerations
**Profile Images**
- Uploaded via Multer in backend
- Accessed from /uploads folder via http://localhost:3000/uploads/{filename}

**Error Handling**
- Backend returns proper JSON errors for DB failures
- Flutter shows SnackBar messages for success/failure

**Offline / Network Errors**
- Flutter handles network exceptions when loading images or API data

**Null Safety**
- All user fields checked for null before rendering

### Known Issues & Future Enhancements

- The API does not have enough products and contains random data; therefore, the app might look empty.
- Currently, the app is built for Linux and Chrome, but other platforms can be supported easily by including the necessary packages—no need to rewrite the code.
- Due to API limitations, only product categories are listed in the Browse tab.
- In the future, the app can be built for other platforms and a better API can be used for more realistic data.
