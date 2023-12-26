import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/auth_controllers.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 65, 137),
      appBar: AppBar(
        title: Text('Register', style: GoogleFonts.dmSerifDisplay(
            fontSize: 23, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 56, 65, 137),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              // Add an Image widget above the text fields
              Image.asset(
                'assets/logo.png', // Replace with the actual path to your image
                height: 400,
                width: 400, // Adjust the height as needed
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white), // Set label color to white
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set focused border color to white
                  ),
                ),
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
              SizedBox(height: 25),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white), // Set label color to white
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set border color to white
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Set focused border color to white
                  ),
                ),
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
              SizedBox(height: 30),
              Obx(() {
                return Container(
                  width: double.infinity, // Set width to maximum
                  child: ElevatedButton(
                    onPressed: _authController.isLoading.value
                        ? null
                        : () {
                      _authController.registerUser(
                        _emailController.text,
                        _passwordController.text,
                      );
                    },
                    child: _authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text('Register'),
                  ),
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
}
