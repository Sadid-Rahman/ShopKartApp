import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

Future<List> fetchCategory()async{
  try{
    final res = await http.get(Uri.parse('http://localhost:3000/categories'));
    if(res.statusCode == 200){
      final data = json.decode(res.body);
      //print(data);
      return List.from(data);
    }else{
      //print('Error: ${res.statusCode}');
      return [];
      
    }
  }
  catch(error){
    //print(error);
    return [];
  }
}

Future<List> fetchProducts()async{
  try{
    final res = await http.get(Uri.parse('http://localhost:3000/wishlist'));
    if(res.statusCode == 200){
      final data = json.decode(res.body);
      //print(data);
      return List.from(data);
    }else{
      //print('Error: ${res.statusCode}');
      return [];
      
    }
  }
  catch(error){
    //print(error);
    return [];
  }
}

Future<Map<String, dynamic>?> userLogin(String email, String password) async {
  try {
    final res = await http.post(
      Uri.parse('http://localhost:3000/loginSignup/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['user']; // return the user object
    } else {
      return null;
    }
  } catch (e) {
    //print('Error: $e');
    return null;
  }
}

Future<void> userSignup(String username, String email, String password, XFile? profileImage) async {
  try {
    var uri = Uri.parse('http://localhost:3000/loginSignup/signup');
    var request = http.MultipartRequest('POST', uri);

    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profileImage.path,
      ));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      //print('Signup successful');
      //var responseBody = await response.stream.bytesToString();
      //print(responseBody);
    } else {
      //print('Signup failed: ${response.statusCode}');
    }
  } catch (e) {
    //print('Error: $e');
  }
}

Future<Map<String, dynamic>?> updateUserProfile(
    String username,
    String email,
    String password,
    XFile? profileImage,
    String id
  ) async {
  try {
    var uri = Uri.parse('http://localhost:3000/dashboard');
    var request = http.MultipartRequest('POST', uri);

    request.fields['id'] = id;
    request.fields['username'] = username;
    request.fields['email'] = email;
    request.fields['password'] = password;

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profileImage.path,
      ));
    }

    var streamedResponse = await request.send();
    var responseBody = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode == 200) {
      final data = json.decode(responseBody);
      return data['user'] as Map<String, dynamic>?;
    } else {
      //print('Update failed: ${streamedResponse.statusCode} - $responseBody');
      return null;
    }
  } catch (e) {
    //print('Error updating profile: $e');
    return null;
  }
}




