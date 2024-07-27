// import 'package:clothing_store/model/payment/paypal.dart';
// import 'package:flutter/material.dart';
//
// import 'api_payment.dart';
//
// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   late Future<List<PaymentMethod>> futurePaymentMethods;
//   int? selectedPaymentMethodId;
//
//   @override
//   void initState() {
//     super.initState();
//     futurePaymentMethods = fetchPaymentMethods();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Select Payment Method')),
//       body: Center(
//         child: FutureBuilder<List<PaymentMethod>>(
//           future: futurePaymentMethods,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final paymentMethods = snapshot.data!;
//               return ListView.builder(
//                 itemCount: paymentMethods.length,
//                 itemBuilder: (context, index) {
//                   final paymentMethod = paymentMethods[index];
//                   return ListTile(
//                     title: Text(paymentMethod.title),
//                     onTap: () {
//                       setState(() {
//                         selectedPaymentMethodId = paymentMethod.id;
//                       });
//
//                       if (paymentMethod.title == 'Paypal') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PayPalPaymentPage()),
//                         );
//                       }
//                     },
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
