import 'package:flutter/material.dart';

class PaymentForm extends StatefulWidget {
  final Function(String address, String promotionCode, String paymentMethod) onSubmit;

  const PaymentForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _addressController = TextEditingController();
  final _promotionCodeController = TextEditingController();
  String _selectedPaymentMethod = 'PayPal';

  @override
  void dispose() {
    _addressController.dispose();
    _promotionCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Payment Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _addressController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
          TextField(
            controller: _promotionCodeController,
            decoration: InputDecoration(labelText: 'Promotion Code'),
            keyboardType: TextInputType.number,
          ),
          DropdownButtonFormField<String>(
            value: _selectedPaymentMethod,
            items: <String>['PayPal', 'Credit Card'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedPaymentMethod = newValue!;
              });
            },
            decoration: InputDecoration(labelText: 'Payment Method'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Submit'),
          onPressed: () {
            widget.onSubmit(
              _addressController.text,
              _promotionCodeController.text,
              _selectedPaymentMethod,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
