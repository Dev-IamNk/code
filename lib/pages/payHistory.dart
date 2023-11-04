import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Payment History",
              style: TextStyle(color: Colors.purple.shade100),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.purple.shade100,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').where('name',isEqualTo: '${FirebaseAuth.instance.currentUser?.email}' ,).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, i) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[i];
                    return Container(
                      padding: EdgeInsets.all(3),
                      height: 190,
                      margin: EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("ID:",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(documentSnapshot['name']),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Event :",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(documentSnapshot['event'].toString().toUpperCase())
                              ],
                            ),
                            Row(
                              children: [
                                Text("Amount: ",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(documentSnapshot['amnt']),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
