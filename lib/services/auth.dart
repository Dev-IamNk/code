import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model1/routes/page_routes.dart';


class Auth {


  final _firebaseauth=FirebaseAuth.instance;

  User? get user => _firebaseauth.currentUser;
  Stream<User?> get  authState  =>_firebaseauth.authStateChanges();


  Future<void> signIn({required email,required pass})async{
    await _firebaseauth.signInWithEmailAndPassword(email: email, password: pass);
  }
  Future<void> signUp({required email,required pass})async{

    await _firebaseauth.createUserWithEmailAndPassword(email: email, password: pass);


  }
  Future<void> signingOut()async{
    await _firebaseauth.signOut();
  }


}

