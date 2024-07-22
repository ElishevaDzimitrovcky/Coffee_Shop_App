import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  final String username = 'eli701128@gmail.com';
  final String password = 'ncle ylrw kmfi btss';
  final CollectionReference emails =
      FirebaseFirestore.instance.collection('emails');
  String email = "eli701128@gmail.com";

  String generateVerificationCode() {
    final random = Random();
    return List<int>.generate(6, (index) => random.nextInt(10)).join();
  }

  Future<void> sendVerificationEmail(String email, String code) async {
    final smtpServer = gmail(username, password);
    email = email;
    final message = Message()
      ..from = Address(username, 'Coffee Shop')
      ..recipients.add(email)
      ..subject = 'Verification Code'
      ..text = 'Your verification code is: $code';

    try {
      await send(message, smtpServer);
      print('Verification email sent to $email');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      final querySnapshot = await emails.where('email', isEqualTo: email).get();
      print(
          'Checking if email is registered: ${querySnapshot.docs.isNotEmpty}');
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email registration: $e');
      return false;
    }
  }

  Future<void> registerEmail(String email) async {
    try {
      await emails.add({'email': email});
      print('Email $email registered in Firestore');
    } catch (e) {
      print('Error registering email: $e');
    }
  }

  Future<void> sendReceiptEmail(String recipientEmail, String receipt) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Coffee Shop')
      ..recipients.add(recipientEmail)
      ..subject = 'Your Purchase Receipt'
      ..text = receipt;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
