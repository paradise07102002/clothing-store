// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'paypal_payment_page.dart';
// import 'package:clothing_store/model/payment/getPayment.dart';
//
// Future<GetPayment?> fetchPaymentMethods() async {
//   final response = await http.get(Uri.parse('http://localhost:5117/api/Cart/getAllPaymentMethod'));
//
//   if (response.statusCode == 200) {
//     return GetPayment.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load payment methods');
//   }
// }
//
// class PaymentMethodsPage extends StatefulWidget {
//   @override
//   _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
// }
//
// class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
//   GetPayment? paymentData;
//   int? selectedPaymentMethodId;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPaymentMethods().then((data) {
//       setState(() {
//         paymentData = data;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Payment Method'),
//       ),
//       body: paymentData == null
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: paymentData!.result!.length,
//         itemBuilder: (context, index) {
//           final paymentMethod = paymentData!.result![index];
//           return ListTile(
//             title: Text(paymentMethod.title ?? ''),
//             leading: Radio<int>(
//               value: paymentMethod.id ?? 0,
//               groupValue: selectedPaymentMethodId,
//               onChanged: (int? value) {
//                 setState(() {
//                   selectedPaymentMethodId = value;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (selectedPaymentMethodId != null) {
//             if (selectedPaymentMethodId == 3) {
//               // PayPal payment process
//               initiatePayPalPayment();
//             }
//           }
//         },
//         child: Icon(Icons.check),
//       ),
//     );
//   }
//
//   void initiatePayPalPayment() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PayPalPaymentPage(
//           url: 'https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-7845542234066763S&zarsrc=30&utm_source=zalo&utm_medium=zalo&utm_campaign=zalo',
//         ),
//       ),
//     );
//   }
// }
