import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model1/services/cloud.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class info extends StatefulWidget {
  final String clgName;

  info({required this.clgName, Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<info> {

  final CollectionReference ref = FirebaseFirestore.instance.collection('admin');

  late Razorpay razorpay;


  void openCheckout(DocumentSnapshot amount) {
    var options = {
      'key': 'rzp_test_Q5CAkYDmtCpXpb',
      'amount': (double.parse(amount['entryfee']) * 100).toInt(),
      'name': 'Sample App',
      'description': 'Payment for some random product',
      'prefill': {
        'contact': '2323232323',
        'email': 'shdjsdh@gmail.com',
      },
      'external': {
        'wallets': ['paytm'],
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
      onSuccess(response);
    });

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
      onError(response);
    });

    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
      onWallet(response);
    });
  }
  void onSuccess(PaymentSuccessResponse response) {
    Databased().addData(selectedEvent);
  }

  void onError(PaymentFailureResponse response) {
    print("Payment Error");
    print("Code: ${response.code}");
    print("Message: ${response.message}");

  }

  void onWallet(ExternalWalletResponse response) {
    print("External Wallet");
    print("Wallet Name: ${response.walletName}");

  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }
  Map<String,dynamic> selectedEvent={};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(widget.clgName),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('admin').where('clgName', isEqualTo: widget.clgName).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[i];
              return Card(
                child: Container(
                  height: 200,
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Image.network(
                            "https://media.istockphoto.com/id/546015598/vector/hand-holding-retro-mic-microphone-in-front-of-huge-crowd.jpg?s=612x612&w=0&k=20&c=eCAkrBUPlRDByOoKkgLiKEWRKmOiMyGZj3e_Dq7x_PM="),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              documentSnapshot["programName"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Date: ${documentSnapshot['pDate']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Category: ${documentSnapshot['category']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Des: ${documentSnapshot['des']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Members in a team: ${documentSnapshot['members']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Fee: ${documentSnapshot['entryfee']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "College: ${widget.clgName}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                selectedEvent={
                                  "name":FirebaseAuth.instance.currentUser?.email,
                                  'event':documentSnapshot['programName'],
                                  'amnt':documentSnapshot['entryfee']
                                };

                                openCheckout(documentSnapshot);
                              },
                              child: Text("Register Now"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
