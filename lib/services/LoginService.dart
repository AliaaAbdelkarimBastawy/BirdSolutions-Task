// Import necessary packages
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

// Global variables to store access token and token type
String accessToken = "";
String tokenType = "";

// Function to handle user login
Future<bool> LoginUser(String email, String password) async {
  // Create an instance of Dio for making HTTP requests
  Dio dio = Dio();

  // Set the base URL for the API
  dio.options.baseUrl = "https://my-safe-space.alacrity.technology/api";

  // Set the accept header to JSON format
  dio.options.headers['accept'] = 'Application/Json';

  try {
    print("email");
    print(email);
    print("password");
    print(password);
    // Send a POST request to the login endpoint with user credentials
    Response response = await dio.post(
      '/login',
      data: {
        "email": email,
        "password": password
      },
    );

    if(response.statusCode == 202 || response.statusCode == 200 )
      {
        accessToken = response.data['access_token'].toString();
        tokenType = response.data['token_type'].toString();
        print("Post successfully!");
        return true;
      }
    // If the request is successful, extract access token and token type from the response

  } catch (e) {
    // If an error occurs during the request, print the error message
    print("Failed, this is the Error Message $e");
    print("Post Failed!");

  }

  return false ;

}
