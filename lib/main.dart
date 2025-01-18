// lib/main.dart
import 'package:flutter/material.dart';
import 'package:medjoy/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Supabase if needed
  // await Supabase.initialize(...);

  runApp(const MedJoyApp());
}

class MedJoyApp extends StatelessWidget {
  const MedJoyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedJoy',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.signIn,
      // Or set to '/home' if you want to start on the home screen for testing
    );
  }
}
