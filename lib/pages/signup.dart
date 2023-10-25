import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model1/pages/login.dart';
import 'package:model1/services/auth.dart';
class signuup extends StatefulWidget {
   signuup({super.key});

  @override
  State<signuup> createState() => _signupState();
}

class _signupState extends State<signuup> {
  TextEditingController email =TextEditingController();
  TextEditingController pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Signup",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(25),
            child: Column(
              children: [
                TextField(controller: email,decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter you email here"
                ),),
                TextField(controller: pass,decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                ),),
                ElevatedButton(onPressed: ()async{
                  await Auth().signUp(email: email.text, pass: pass.text);
                }, child: Text("Signin")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Already have stuevent account? "),
                  ],
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
                }, child: Text("Click Here")),

              ],
            ),
          )
        ],
      ),);
  }
}