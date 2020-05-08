// import 'package:first_proj/util/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class EditOrders extends StatefulWidget {

//   String userID;
//   int orderID;
//   EditOrders({this.userID, this.orderID});

//   @override
//   _EditOrdersState createState() => _EditOrdersState();
// }

// class _EditOrdersState extends State<EditOrders> {

//   String progress;
//   String newProg;

//   @override
//   void initState() { 
//     super.initState();
//     progress = 'Not Found';
//     newProg = '';
//   }

//   final CollectionReference userOrder = Firestore.instance.collection('UserOrders');
//   final CollectionReference orders = Firestore.instance.collection('Orders');

//   updateOrder(dynamic snapshot) async {
//     for (int i = 0; i < snapshot.data.length; i++) {
//       if (snapshot.data[i].data['orderID'] == widget.orderID){
//         await userOrder.document(widget.userID).updateData({
        
//       });
//     }
//     await userOrder.document(widget.userID).updateData({
      
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(widget.orderID);
//     return StreamBuilder(
//       stream: Firestore.instance.collection('Orders').document(widget.orderID.toString()).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Loading();
//         } else {
//           print(snapshot.data['orderProgress']);
//           setState(() {
//             progress = snapshot.data['orderProgress'];
//           });
//           return Scaffold(
//             appBar: AppBar(
//               leading: BackButton(
//                 color: Colors.white,
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               title: Text(
//                 "Edit Order",
//                 style: TextStyle(
//                   color: Colors.white,
//                 )
//               ),
//               centerTitle: true,
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   children: <Widget>[
//                     Padding(padding: EdgeInsets.all(5)),
//                     Row(
//                       children: <Widget>[
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Current Progress: ',
//                             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, letterSpacing: 1,),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             '$progress',
//                             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 1,),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30),
//                     TextFormField(
//                       decoration: new InputDecoration(
//                         hintText: "New Progress",
//                       ),
//                       onChanged: (String str) {
//                         print(str);
//                       },
//                     ),
//                   ],
//                 )
//               )
//             )
//           );
//         }
//       }
//     );
//   }
// }