import 'package:cardgame/Login.dart';
import 'package:cardgame/game_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/auth_controllers.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize GetX controllers and dependencies
  await Get.putAsync(() async => await SharedPreferences.getInstance());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: _authController.isLoggedIn.value ? '/home' : '/login',
        getPages: [
          GetPage(name: '/login', page: () => LoginPage()),
          GetPage(
            name: '/home',
            page: () => game(),
          ),
        ],
      );
  }
}
