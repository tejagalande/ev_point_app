import 'package:flutter/material.dart';

enum PaymentType {
  eWallet,
  paypal,
  googlePay,
  applePay,
  creditCard,
  debitCard,
}

class PaymentMethod {
  final String id;
  final String name;
  final PaymentType type;
  final IconData? icon;
  final Widget? iconWidget;
  final Color backgroundColor;
  final String? balance;
  final String? details;
  final bool isDefault;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    this.icon,
    this.iconWidget,
    required this.backgroundColor,
    this.balance,
    this.details,
    this.isDefault = false,
  });
}

class PaymentMethodProvider extends ChangeNotifier {
  String? _selectedPaymentId;
  final List<PaymentMethod> _paymentMethods = [];
  bool _isLoading = false;
  String? _errorMessage;

  PaymentMethodProvider() {
    _initializePaymentMethods();
  }

  // Getters
  String? get selectedPaymentId => _selectedPaymentId;
  List<PaymentMethod> get paymentMethods => List.unmodifiable(_paymentMethods);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Initialize sample payment methods
  void _initializePaymentMethods() {
    _paymentMethods.addAll([
      PaymentMethod(
        id: '1',
        name: 'E-Wallet',
        type: PaymentType.eWallet,
        backgroundColor: const Color(0xFF00C853),
        balance: '\$957.50',
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/wallet.png',
            color: Colors.white,
          ),
        ),
        isDefault: true,
      ),
      PaymentMethod(
        id: '2',
        name: 'PayPal',
        type: PaymentType.paypal,
        backgroundColor: const Color(0xFF0070BA),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/paypal.png',
            color: Colors.white,
          ),
        ),
      ),
      PaymentMethod(
        id: '3',
        name: 'Google Pay',
        type: PaymentType.googlePay,
        backgroundColor: Colors.white,
        iconWidget: Image.asset(
          'assets/icons/google_pay.png',
          width: 40,
          height: 40,
        ),
      ),
      PaymentMethod(
        id: '4',
        name: 'Apple Pay',
        type: PaymentType.applePay,
        backgroundColor: Colors.black,
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/apple_pay.png',
            color: Colors.white,
          ),
        ),
      ),
      PaymentMethod(
        id: '5',
        name: 'Visa',
        type: PaymentType.creditCard,
        backgroundColor: const Color(0xFF1434CB),
        details: '•••• •••• •••• 5567',
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/visa.png',
            color: Colors.white,
          ),
        ),
      ),

      PaymentMethod(
        id: '5',
        name: 'Visa',
        type: PaymentType.creditCard,
        backgroundColor: const Color(0xFF1434CB),
        details: '•••• •••• •••• 5567',
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/visa.png',
            color: Colors.white,
          ),
        ),
      ),

      PaymentMethod(
        id: '5',
        name: 'Visa',
        type: PaymentType.creditCard,
        backgroundColor: const Color(0xFF1434CB),
        details: '•••• •••• •••• 5567',
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/visa.png',
            color: Colors.white,
          ),
        ),
      ),
      
    ]);

    // Set default payment method
    final defaultMethod = _paymentMethods.firstWhere(
      (method) => method.isDefault,
      orElse: () => _paymentMethods.first,
    );
    _selectedPaymentId = defaultMethod.id;
  }

  // Select payment method
  void selectPaymentMethod(String paymentId) {
    _selectedPaymentId = paymentId;
    notifyListeners();
    debugPrint('Selected payment method: $paymentId');
  }

  // Get selected payment method
  PaymentMethod? getSelectedPaymentMethod() {
    if (_selectedPaymentId == null) return null;
    return _paymentMethods.firstWhere(
      (method) => method.id == _selectedPaymentId,
    );
  }

  // Add new payment method
  Future<void> addPaymentMethod(PaymentMethod method) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // await paymentRepository.addPaymentMethod(method);
      
      _paymentMethods.add(method);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to add payment method: ${e.toString()}';
      notifyListeners();
      debugPrint('Error adding payment method: $e');
    }
  }

  // Remove payment method
  Future<void> removePaymentMethod(String paymentId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // await paymentRepository.removePaymentMethod(paymentId);
      
      _paymentMethods.removeWhere((method) => method.id == paymentId);
      
      // If removed method was selected, select another one
      if (_selectedPaymentId == paymentId && _paymentMethods.isNotEmpty) {
        _selectedPaymentId = _paymentMethods.first.id;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to remove payment method: ${e.toString()}';
      notifyListeners();
      debugPrint('Error removing payment method: $e');
    }
  }

  // Load payment methods from API
  Future<void> loadPaymentMethods() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      // final response = await paymentRepository.fetchPaymentMethods();
      // _paymentMethods.clear();
      // _paymentMethods.addAll(response);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load payment methods: ${e.toString()}';
      notifyListeners();
      debugPrint('Error loading payment methods: $e');
    }
  }

  // Set default payment method
  Future<void> setDefaultPaymentMethod(String paymentId) async {
    try {
      // TODO: Replace with actual API call
      // await paymentRepository.setDefaultPaymentMethod(paymentId);
      
      _selectedPaymentId = paymentId;
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting default payment method: $e');
      rethrow;
    }
  }

  // Clear selected payment method
  void clearSelection() {
    _selectedPaymentId = null;
    notifyListeners();
  }

  // Get payment methods by type
  List<PaymentMethod> getPaymentMethodsByType(PaymentType type) {
    return _paymentMethods.where((method) => method.type == type).toList();
  }
}
