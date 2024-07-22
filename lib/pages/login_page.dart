import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/email_service.dart';
import 'intro_screen.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool showPhoneInput = true; // Show phone input by default
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final EmailService emailService = EmailService();
  String? verificationCode; // משתנה לשמירת קוד האימות שנשלח

  void _toggleInput(bool showPhone) {
    setState(() {
      showPhoneInput = showPhone;
    });
  }

  void sendVerification() async {
    final email = emailController.text;
    print('Send verification called with email: $email');
    if (email.isNotEmpty) {
      final code = emailService.generateVerificationCode();
      setState(() {
        verificationCode = code; // שמירת קוד האימות
      });

      print('Generated verification code: $code');
      await emailService.sendVerificationEmail(email, code);
      print('Sending verification email to $email');

      // אם האימייל לא נרשם, נרשום אותו
      if (!(await emailService.isEmailRegistered(email))) {
        await emailService.registerEmail(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('האימייל נרשם ב-Firebase')),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('קוד האימות נשלח לאימייל שלך')),
      );
      _showVerificationDialog(); // הצגת חלון הזנת קוד האימות
    } else {
      print('Email field is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('נא להזין כתובת אימייל')),
      );
    }
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('הזן את קוד האימות'),
          content: TextField(
            controller: codeController,
            decoration: InputDecoration(hintText: 'הכנס קוד'),
          ),
          actions: [
            TextButton(
              onPressed: _verifyCode,
              child: Text('אישור'),
            ),
          ],
        );
      },
    );
  }

  void _verifyCode() {
    final enteredCode = codeController.text;
    if (enteredCode == verificationCode) {
      // קוד נכון, העברה ל-IntroScreen
      Navigator.of(context).pop(); // סגירת חלון הדיאלוג
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroScreen()),
      );
    } else {
      // קוד שגוי, הצגת הודעת שגיאה
      Navigator.of(context).pop(); // סגירת חלון הדיאלוג
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('קוד אימות שגוי')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "lib/images/espresso.png", // Make sure to add the correct path to your image
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                'הי ברוכים הבאים',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _toggleInput(true); // Show phone input
                    },
                    child: Text('Phone'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _toggleInput(false); // Show email input
                    },
                    child: Text('Email'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (showPhoneInput) ...[
                Text(
                  'הזן את מספר הטלפון שלך להמשך',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '+972',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'טלפון',
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  'הזן את כתובת האימייל שלך להמשך',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'אימייל',
                  ),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendVerification,
                child: Text('שלח לי קוד אישי'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
