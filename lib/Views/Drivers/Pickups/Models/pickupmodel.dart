import 'dart:convert';

class PickupModel {
  final bool success;
  final String message;
  final List<SendOrder> sendOrders;

  PickupModel({
    required this.success,
    required this.message,
    required this.sendOrders,
  });

  factory PickupModel.fromJson(String source) =>
      PickupModel.fromMap(json.decode(source));

  factory PickupModel.fromMap(Map<String, dynamic> map) {
    return PickupModel(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      sendOrders: map['sendOrders'] != null
          ? List<SendOrder>.from(map['sendOrders'].map((x) => SendOrder.fromMap(x)))
          : [],
    );
  }
}

class SendOrder {
  final String id;
  final User userId;
  final String shippingAddress;
  final List<CartItem> cartItems;
  final String paymentMethod;
  final int shippingPrice;
  final int totalAmount;
  final String reference;
  final String country;
  final String status;
  final String orderId;
  final String trackingNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  SendOrder({
    required this.id,
    required this.userId,
    required this.shippingAddress,
    required this.cartItems,
    required this.paymentMethod,
    required this.shippingPrice,
    required this.totalAmount,
    required this.reference,
    required this.country,
    required this.status,
    required this.orderId,
    required this.trackingNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SendOrder.fromMap(Map<String, dynamic> map) {
    return SendOrder(
      id: map['_id'] ?? '',
      userId: User.fromMap(map['userId']),
      shippingAddress: map['shippingAddress'] ?? '',
      cartItems: map['cartItems'] != null
          ? List<CartItem>.from(map['cartItems'].map((x) => CartItem.fromMap(x)))
          : [],
      paymentMethod: map['paymentMethod'] ?? '',
      shippingPrice: map['shippingPrice'] ?? 0,
      totalAmount: map['totalAmount'] ?? 0,
      reference: map['reference'] ?? '',
      country: map['country'] ?? '',
      status: map['status'] ?? '',
      orderId: map['orderId'] ?? '',
      trackingNumber: map['trackingNumber'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}

class User {
  final String id;
  final String fullName;
  final String phoneNumber;

  User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'].toString(),
    );
  }
}

class CartItem {
  final String productId;
  final int quantity;
  final double price;
  final double vatAmount;
  final String picture;
  final String sku;
  final String productName;
  final double subTotal;

  CartItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.vatAmount,
    required this.picture,
    required this.sku,
    required this.productName,
    required this.subTotal,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      vatAmount: (map['vatAmount'] ?? 0).toDouble(),
      picture: map['picture'] ?? '',
      sku: map['sku'] ?? '',
      productName: map['productName'] ?? '',
      subTotal: (map['subTotal'] ?? 0).toDouble(),
    );
  }
}
