import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model1/pages/admin_panel.dart';
import 'package:model1/pages/admin_signup.dart';
import 'package:model1/routes/name_cons.dart';
import 'package:model1/services/auth.dart';
import 'package:model1/routes/page_routes.dart';
import 'signup.dart';
import 'package:go_router/go_router.dart';
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {

  TextEditingController email =TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(color: Colors.black),),
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
                  await Auth().signIn(email: email.text, pass: pass.text);
                }, child: Text("Login")),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("To register , click"),
                    TextButton(onPressed: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>signuup()));
                    }, child: Text("Here")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}