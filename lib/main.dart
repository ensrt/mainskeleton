import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kartoyun/auth_pages/login_page.dart';
import 'package:kartoyun/auth_pages/register_page.dart';
import 'package:kartoyun/home_page.dart';
import 'package:kartoyun/kart_pages/kart_oyna.dart';
import 'package:kartoyun/profil_pages/profil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: 'login_page', // Başlangıç rotası
      routes: {
        'home_page': (context) => HomePage(),  // Ana Sayfa
        'kart_oyna': (context) => KartOynama(),  // Kart Oyna Sayfası
        'profil': (context) => Profil(),  // Profil Sayfası
        'register_page': (context) => RegisterPage(),
        'login_page': (context) => LoginPage(),
      },
    );
  }
}