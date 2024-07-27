import 'package:flutter/material.dart';
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getHistoryOrder.dart';
import 'package:clothing_store/pages/detailOrder.dart';

class OrderHistoryPage extends StatefulWidget {
  final int userId;

  const OrderHistoryPage({super.key, required this.userId});

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Future<GetHistoryOrder> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = fetchHistoryOrders(widget.userId);
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _futureOrders = fetchHistoryOrders(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: FutureBuilder<GetHistoryOrder>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data?.result == null || snapshot.data!.result!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          } else {
            List<Result> orders = snapshot.data!.result!;
            return RefreshIndicator(
              onRefresh: _refreshOrders,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  Result order = orders[index];
                  bool paymentStatus = order.paymentStatus ?? false;
                  return Card(
                    child: ListTile(
                      title: Text('Order ID: ${order.id ?? "N/A"}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total: \$${order.total ?? 0}'),
                          Text(
                            'Status: ${paymentStatus ? "Paid" : "Pending"}',
                            style: TextStyle(
                              color: paymentStatus ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailPage(orderId: order.id!),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
