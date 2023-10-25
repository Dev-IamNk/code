import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:model1/routes/name_cons.dart';
import 'package:go_router/go_router.dart';
import 'package:model1/services/auth.dart';
import 'package:model1/services/cloud.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Pondy Colleges",style: TextStyle(color: Colors.purple.shade100),),
        ),
        actions: [

          SizedBox(width: 30),
          IconButton(onPressed: ()async{
            await Auth().signingOut();
          }, icon: Icon(Icons.logout_rounded))
        ],
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('colleges').snapshots(),
        builder: (context,AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return Container();
          }
          if(snapshot.hasData){
          return ListView.builder(
          itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, i) {
      final DocumentSnapshot documentSnapshot =
      snapshot.data!.docs[i];
      return Container(
        margin: EdgeInsets.all(25),
        height: 150,
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).pushNamed(
                MyAppConstants.infoRouteName, pathParameters: {
              "name": documentSnapshot['clgName']
            });
          },
          child: Card(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(),
                ),
                SizedBox(width: 25,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(documentSnapshot['clgName']),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),/*
      drawer: Drawer(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Location"),
              Text("Profile"),
              Text("Log out"),
              Text("Tokens"),
              Text("History")
            ],
          ),
        ),
      ),*/

    );
  }
}
