import 'package:flutter/material.dart';

class AddNewPaymentProvider extends ChangeNotifier {
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  AddNewPaymentProvider() {
    cardHolderNameController.addListener(notifyListeners);
    cardNumberController.addListener(notifyListeners);
    expiryDateController.addListener(notifyListeners);
    cvvController.addListener(notifyListeners);
  }

  void addNewPayment(BuildContext context) {
    if (cardHolderNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter card holder name")),
      );
      return;
    }
    if (cardNumberController.text.length != 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card number must be 16 digits")),
      );
      return;
    }
    if (expiryDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select expiry date")),
      );
      return;
    }
    if (cvvController.text.length != 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("CVV must be 3 digits")));
      return;
    }

    // Implement add payment logic here
    // For now, just pop the screen
    Navigator.pop(context);
  }

  Future<void> selectExpiryDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 20), // Allow up to 20 years in future
    );

    if (picked != null) {
      // Format as MM/YY
      final String month = picked.month.toString().padLeft(2, '0');
      final String year = picked.year.toString().substring(2);
      expiryDateController.text = "$month/$year";

      // Shift focus to next field (CVV)
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  void dispose() {
    cardHolderNameController.removeListener(notifyListeners);
    cardNumberController.removeListener(notifyListeners);
    expiryDateController.removeListener(notifyListeners);
    cvvController.removeListener(notifyListeners);
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }
}
