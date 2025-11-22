##ShopKart Application Documentation
==================================

Table of Contents
-----------------

*   Project Overview
    
*   Technology Stack
    
*   Features
    
*   Project Structure
    
*   Setup & Installation
    
*   API Endpoints
    
*   Session Management
    
*   Screens & Navigation
    
*   Notes & Considerations
    

Project Overview
----------------

ShopKart is a **full-stack e-commerce application** built using **Flutter** for the frontend and **Node.js/Express** with MySQL for the backend. It allows users to browse products, manage their profile, add items to a wishlist, and explore product categories.

The app uses **REST APIs** to handle user authentication, profile updates, product fetching, and wishlist management.

Technology Stack
----------------

*   **Frontend:** Flutter, Dart
    
*   **Backend:** Node.js, Express.js
    
*   **Database:** MySQL
    
*   **File Uploads:** Multer (for profile image uploads)
    
*   **State Management:** Singleton-based SessionManager
    
*   **HTTP:** http package for Flutter
    

Features
--------

1.  **User Authentication & Dashboard**
    
    *   Login and Signup functionality
        
    *   Update profile information (username, email, password, profile picture)
        
    *   Logout functionality
        
2.  **Product Management**
    
    *   Fetch and display products from backend API
        
    *   Add/remove products to wishlist
        
    *   Mark favorites
        
3.  **Category Browsing**
    
    *   Browse product categories using a grid view
        
    *   Clickable category cards
        
4.  **Session Management**
    
    *   Persistent session with SessionManager singleton
        
    *   User data cleared on logout
        
5.  **Responsive UI**
    
    *   Flutter widgets adapt to various screen sizes
        
    *   Scrollable lists and grids for products and categories
        

Project Structure
-----------------

### Frontend (lib/)

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   lib/  ├── functions/  │   ├── api.dart                 # API call functions  │   ├── bottomnav.dart           # Bottom navigation bar widget  │   ├── product_card_widget.dart # Product card widget  │   └── category_card_widget.dart# Category card widget  ├── routes/  │   ├── dashboard.dart  │   └── wishlist.dart  ├── main.dart                     # App entry point  ├── home.dart                     # Home screen  └── account.dart                  # User account/profile screen   `

### Backend (server/)

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   server/  ├── routes/  │   ├── index.js                  # Home route  │   ├── users.js                  # User CRUD operations  │   ├── categories.js             # Category APIs  │   ├── wishlist.js               # Wishlist APIs  │   ├── login_signup.js           # Login & Signup APIs  │   └── dashboard.js              # Update profile route  ├── uploads/                       # Uploaded profile images  ├── app.js                         # Express app setup  └── db.js                          # MySQL database connection   `

Setup & Installation
--------------------

### Backend

1.  Install dependencies:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   cd server  npm install   `

1.  Configure MySQL database in db.js.
    
2.  Start the server:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   npm start   `

*   Default backend URL: http://localhost:3000
    

### Frontend

1.  Install Flutter dependencies:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   flutter pub get   `

1.  Run the Flutter app:
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   flutter run   `

*   Ensure the backend server is running.
    

API Endpoints
-------------

EndpointMethodDescription/loginSignup/loginPOSTUser login/loginSignup/signupPOSTUser registration/dashboardPOSTUpdate user profile with optional image/categoriesGETFetch all product categories/productsGETFetch all products/wishlistPOSTAdd/remove products to wishlist

### Example: Update Profile

*   **URL:** POST http://localhost:3000/dashboard
    
*   **Body (Multipart):**
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   {    "id": "4",    "username": "sadid123",    "email": "sadid123@gmail.com",    "password": "123456",    "image": "file (optional)"  }   `

*   **Response:**
    

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   {    "message": "Profile updated successfully",    "user": {      "id": "4",      "username": "sadid123",      "email": "sadid123@gmail.com",      "avatar": "profile123.jpg"    }  }   `

Session Management
------------------

*   **Singleton Pattern:** SessionManager holds the current user data.
    
*   **Store user:** SessionManager.instance.setUser(user)
    
*   **Retrieve user:** SessionManager.instance.user
    
*   **Clear user on logout:** SessionManager.instance.clear()
    

Screens & Navigation
--------------------

1.  **Home Screen:** Shows products, categories, and top bar with user avatar.
    
2.  **Dashboard/Profile Screen:** Update user information and profile picture.
    
3.  **Wishlist Screen:** Shows favorited products.
    
4.  **Bottom Navigation:**
    
    *   Home, Browse, Wishlist, Bag, Account
        

Navigation is handled using:

Plain textANTLR4BashCC#CSSCoffeeScriptCMakeDartDjangoDockerEJSErlangGitGoGraphQLGroovyHTMLJavaJavaScriptJSONJSXKotlinLaTeXLessLuaMakefileMarkdownMATLABMarkupObjective-CPerlPHPPowerShell.propertiesProtocol BuffersPythonRRubySass (Sass)Sass (Scss)SchemeSQLShellSwiftSVGTSXTypeScriptWebAssemblyYAMLXML`   Navigator.pushReplacementNamed(context, '/routeName', arguments: data);   `

*   User data is passed through arguments and stored in SessionManager.
    

Notes & Considerations
----------------------

*   **Profile Images:**
    
    *   Uploaded via Multer in backend
        
    *   Accessed from /uploads folder via http://localhost:3000/uploads/{filename}
        
*   **Error Handling:**
    
    *   Backend returns proper JSON errors for DB failures.
        
    *   Flutter shows SnackBar messages for success/failure.
        
*   **Offline / Network Errors:**
    
    *   Flutter handles network exceptions when loading images or API data.
        
*   **Null Safety:**
    
    *   All user fields checked for null before rendering.
