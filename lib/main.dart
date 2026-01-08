import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'services/firebase_options.dart'; // generated via flutterfire or manual

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(AlKhairApp());
}

class AlKhairApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'كافتيريا الخير',
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ar'),
      theme: ThemeData(
        primaryColor: Color(0xFF2E7D32), // أخضر
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFFD700)), // ذهبي
        fontFamily: 'Arial',
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}
