import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sono_first/providers/authentication_provider.dart';
import 'package:sono_first/services/navigation_service.dart';
import 'package:sono_first/splash_screen.dart';
// import 'package:provider/provider.dart';
import 'package:sono_first/ui/bottom_nav.dart';
import 'package:sono_first/ui/register_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'ui/chats_page.dart';
import 'ui/home.dart';
import 'ui/login.dart';
// import 'package:sono_first/ui/guideline.dart';
//import 'package:sono_first/ui/bottom_nav.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  runApp(
    SplashScreen(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          MainApp(),
        );
      },
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(key: UniqueKey(), onInitializationComplete: () {}),
//     );
//   }
// }

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext _context) {
            return AuthenticationProvider();
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SonoFirst',
        theme: ThemeData(
          backgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext _context) => const Login(),
          '/bottomNav': (BuildContext _context) => const BottomNav(),
          '/home': (BuildContext _context) => const Home(),
          '/chat': (BuildContext _context) => ChatsPage(),
          '/register': (BuildContext _context) => RegisterPage(),
        },
      ),
    );
  }
}
