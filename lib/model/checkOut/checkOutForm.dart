// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../payment/paypal.dart';
// import 'package:clothing_store/model/payment/paypal.dart';
// import 'checkOut.dart';
//
// class CheckOutForm extends StatefulWidget {
//   @override
//   _CheckOutFormState createState() => _CheckOutFormState();
// }
//
// class _CheckOutFormState extends State<CheckOutForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? address;
//   int? total;
//   int? promotionId;
//   int? paymentId;
//
//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//
//       CheckOut checkout = CheckOut(
//         address: address,
//         total: total,
//         promotionId: promotionId,
//         paymentId: paymentId,
//       );
//
//       final response = await http.post(
//         Uri.parse('http://localhost:5117/api/Cart/1/CheckOut?userId=1'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(checkout.toJson()),
//       );
//
//       if (response.statusCode == 200) {
//         // Thanh toán thành công
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => PayPalPaymentPage()),
//         );
//       } else {
//         // Xử lý lỗi
//         print('Error: ${response.body}');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Check Out'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   address = value;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Total Amount'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the total amount';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   total = int.tryParse(value!);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Promotion Code'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a promotion code';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   promotionId = int.tryParse(value!);
//                 },
//               ),
//               DropdownButtonFormField<int>(
//                 decoration: InputDecoration(labelText: 'Payment Method'),
//                 items: [
//                   DropdownMenuItem(
//                     value: 1,
//                     child: Text('Banking'),
//                   ),
//                   DropdownMenuItem(
//                     value: 2,
//                     child: Text('Cash'),
//                   ),
//                   DropdownMenuItem(
//                     value: 3,
//                     child: Text('Paypal'),
//                   ),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     paymentId = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select a payment method';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Pay Now'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
