import 'package:flutter/material.dart';
import '../const.dart';
import 'home_page.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset("lib/images/espresso.png", height: 200),
            ),
            SizedBox(height: 48),
            Text(
              "Brew Day",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "How do you like your coffee?",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 48),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ),
              child: Container(
                padding: EdgeInsets.all(25),
                margin: EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Enter Shop",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
