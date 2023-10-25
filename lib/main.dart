import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:model1/pages/admin_signup.dart';
import 'package:model1/pages/home.dart';
import 'package:model1/pages/login.dart';
import 'package:model1/routes/page_routes.dart';
import 'package:model1/routes/page_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:model1/services/auth.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 'AIzaSyB5OXV5DYXzQUP_Ufp72ny3WA7YLMfk0j8', appId: "1:296926526317:android:e0934fc84f808914fab864", messagingSenderId: '296926526317', projectId: 'stuevents-80fc3')
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  final MyPageRoutes myPageRoutes = MyPageRoutes();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData ){
          return MaterialApp.router(
            routeInformationProvider: myPageRoutes.router.routeInformationProvider,
            routeInformationParser: myPageRoutes.router.routeInformationParser,
            routerDelegate: myPageRoutes.router.routerDelegate,
            debugShowCheckedModeBanner: false,
          );
        }
        else{
          return MaterialApp(
            debugShowCheckedModeBanner: false,
           home: login(),
          );
        }
      }
    );
  }
}
