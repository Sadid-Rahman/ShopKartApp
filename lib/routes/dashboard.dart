// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shopkart/functions/api.dart';

class SessionManager {
  SessionManager._privateConstructor();
  static final SessionManager instance = SessionManager._privateConstructor();

  Map<String, dynamic>? _user;

  Map<String, dynamic>? get user => _user;
  void setUser(Map<String, dynamic> user) => _user = user;
  void clear() => _user = null;
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, dynamic>? user;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      user = args;
      SessionManager.instance.setUser(args); // store in session

      usernameController.text = user!['username'];
      emailController.text = user != null && user!['email'] != null ? user!['email'] : '';
    } else {
      user = SessionManager.instance.user;
    }
  }


  final _formKey = GlobalKey<FormState>();

  String username = "CurrentUsername";
  String email = "user@example.com";
  String password = "";
  XFile? profileImage;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImage = image;
      });
    }
  }

  void saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Update user info logic here, e.g., API call
      setState(() {
        username = usernameController.text;
        email = emailController.text;
        password = passwordController.text;
      });
      String id = user != null && user!['id'] != null ? user!['id'].toString() : '';
      updateUserProfile(username, email, password, profileImage, id).then((updatedUser) {
        if (updatedUser != null) {
          // Update session
          SessionManager.instance.setUser(updatedUser);

          // Clear the form
          usernameController.clear();
          emailController.clear();
          passwordController.clear();
          setState(() {
            profileImage = null;
          });

          // Navigate to home with updated user
          Navigator.pushReplacementNamed(context, '/home', arguments: updatedUser);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile')),
          );
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  void logout() {
    SessionManager.instance.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/home', arguments: {'logout': true}, (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage != null ? FileImage( File(profileImage!.path))
                        : const AssetImage('assets/default_avatar.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.blue,
                      ),
                      onPressed: pickProfileImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty && value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: saveChanges,
                    child: const Text(
                      'Save Changes', 
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800],
                  ),
                  onPressed: logout,
                    child: const Text('Logout',style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
