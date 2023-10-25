import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:model1/pages/admin_panel.dart';
import 'package:model1/routes/page_routes.dart';
import 'package:model1/services/auth.dart';

import '';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class adminSign extends StatefulWidget {
  const adminSign({super.key});

  @override
  State<adminSign> createState() => _adminSignState();
}

class _adminSignState extends State<adminSign> {

  TextEditingController otpController = TextEditingController();
  TextEditingController pass = TextEditingController();
  EmailOTP myauth = EmailOTP();

  List clgNames = ['PTU', 'SMVEC', 'MVIT', 'SVMC'];
  List clgMails = [
    'nandhaarasan@gmail.com',
    'nandhakumarannkit@gmail.com',
    'nandhaarasan@gmail.com',
    'nandhakumarannkit@gmail.com'
  ];
  List foundMatch = [];
  TextEditingController txt = TextEditingController();
  TextEditingController txtmail = TextEditingController();
  void runfilter(String txt) {
    if (txt.isEmpty) {
      foundMatch = clgNames;
    } else {
      foundMatch = clgNames
          .where((element) =>
              element.toString().toLowerCase().contains(txt.toLowerCase()))
          .toList();
    }
    setState(() {
      foundMatch;
    });
  }

  String clg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Register"),
      ),
      body: ListView(
        children: [
          TextField(onChanged: (value) => runfilter(value), controller: txt),
          TextField(
            controller: pass,
          ),
          Container(
            height: 85,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, i) => GestureDetector(
                onTap: () {
                  setState(() {
                    clg = foundMatch[i];
                    txt.text = clg;
                    foundMatch = [];
                    if (clg.toLowerCase() == 'smvec') {
                      txtmail.text = clgMails[1];
                    } else if (clg.toLowerCase() == 'ptu') {
                      txtmail.text = clgMails[0];
                    } else if (clg.toLowerCase() == 'mvit') {
                      txtmail.text = clgMails[2];
                    } else if (clg.toLowerCase() == 'svmc') {
                      txtmail.text = clgMails[3];
                    }
                  });
                },
                child: Card(
                  child: Text(foundMatch[i]),
                ),
              ),
              itemCount: foundMatch.length,
            ),
          ),
          Container(
            child: Text(txtmail.text),
          ),
          Center(
            child: TextButton(
              child: Text("SEND OTP"),
              onPressed: () async {
                myauth.setConfig(
                    appEmail: "nandhakumarannkit@gmail.com",
                    appName: "Email OTP",
                    userEmail: txtmail.text,
                    otpLength: 6,
                    otpType: OTPType.digitsOnly);
                if (await myauth.sendOTP() == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP has been sent"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Oops, OTP send failed"),
                  ));
                }
              },
            ),
          ),
          Center(
            child: TextField(
              controller: otpController,
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () async {
                if (await myauth.verifyOTP(otp: otpController.text) == true) {

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("OTP is verified"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              },
              child: Text("VERIFY OTP"),
            ),
          ),
        ],
      ),
    );
  }
}
