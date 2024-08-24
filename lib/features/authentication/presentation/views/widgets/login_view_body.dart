import 'package:flutter/material.dart';
import 'package:qanoni/core/utils/constants/colors.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Qanoni",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: QColors.textSecondary),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person, color: QColors.secondary),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: QColors.secondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: QColors.textSecondary),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: QColors.secondary),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: QColors.secondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: QColors.secondary,
              ),
              child: Text(
                'Login Now',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: QColors.secondary,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: QColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: QColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle sign-up logic here
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: QColors.secondary,
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // Handle Google sign-up logic here
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: QColors.secondary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/google-logo.png',
                    height: 24, // Adjust the height as needed
                  ),
                  SizedBox(width: 10), // Space between icon and text
                  Text(
                    'Sign Up with Google',
                    style: TextStyle(
                      color: QColors.secondary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the login screen
              },
              child: Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: QColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: QColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
