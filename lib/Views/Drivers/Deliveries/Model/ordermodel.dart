import 'dart:convert';

class OrderResponse {
  final bool success;
  final String message;
  final List<SendOrder> sendOrders;

  OrderResponse({
    required this.success,
    required this.message,
    required this.sendOrders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json['success'],
      message: json['message'],
      sendOrders: (json['sendOrders'] as List)
          .map((order) => SendOrder.fromJson(order))
          .toList(),
    );
  }
}

class SendOrder {
  final String id;
  final User userId;
  final String shippingAddress;
  final List<CartItem> cartItems;
  final String paymentMethod;
  final num shippingPrice;
  final num totalAmount;
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

  factory SendOrder.fromJson(Map<String, dynamic> json) {
    return SendOrder(
      id: json['_id'],
      userId: User.fromJson(json['userId']),
      shippingAddress: json['shippingAddress'],
      cartItems:
          (json['cartItems'] as List).map((item) => CartItem.fromJson(item)).toList(),
      paymentMethod: json['paymentMethod'],
      shippingPrice: json['shippingPrice'],
      totalAmount: json['totalAmount'],
      reference: json['reference'],
      country: json['country'],
      status: json['status'],
      orderId: json['orderId'],
      trackingNumber: json['trackingNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class User {
  final String id;
  final String fullName;
  final int phoneNumber;

  User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

class CartItem {
  final String productId;
  final int quantity;
  final int price;
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

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
      price: json['price'],
      vatAmount: json['vatAmount'].toDouble(),
      picture: json['picture'],
      sku: json['sku'],
      productName: json['productName'],
      subTotal: json['subTotal'].toDouble(),
    );
  }
}

