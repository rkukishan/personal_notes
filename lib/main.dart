import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_notes/ui/add_notes_screen.dart';
import 'package:personal_notes/ui/delete_notes.dart';
import 'package:personal_notes/ui/home_page_screen.dart';
import 'package:personal_notes/ui/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
      title: 'Personal Notes',
      routes: {
        "/": (context) => const SplashScreen(),
        "homepagescreen": (context) => const HomePageScreen(),
        "addnotesscreen": (context) => const AddNotesScreen(),
        "deletenotesscreen": (context) => DeleteNotesScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // home: SplashScreen(),
    );
  }
}
