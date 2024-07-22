import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase.dart';

import 'model/coffee_shop.dart';
import 'pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoffeeShope>(create: (_) => CoffeeShope()), // שימוש ב-ChangeNotifierProvider
      ],
      child: MaterialApp(
        title: 'Coffee App',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
