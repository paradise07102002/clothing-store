import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getOrderById.dart';
class OrderDetailPage extends StatelessWidget {
  final int orderId;

  OrderDetailPage({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: FutureBuilder<GetOrderById>(
        future: fetchOrderById(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data?.result == null || snapshot.data!.result!.isEmpty) {
            return Center(child: Text('No order details found.'));
          } else {
            Result order = snapshot.data!.result!.first;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${order.id ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Customer ID: ${order.customerId ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Total: \$${order.total ?? 0}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Promotion ID: ${order.promotionId ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Payment Status: ${order.paymentStatus ?? false ? "Paid" : "Pending"}', style: TextStyle(fontSize: 18, color: order.paymentStatus == true ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Address: ${order.address ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Customer Name: ${order.customer?.fullName ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Payment Method: ${order.payment?.title ?? "N/A"}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Promotion: ${order.promotion?.name ?? "N/A"}', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
