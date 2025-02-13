import 'dart:convert';


class OrderResponse {
  final bool? success;
  final String? message;
  final List<SendOrder> sendOrders;

  OrderResponse({
    this.success,
    this.message,
    List<SendOrder>? sendOrders,
  }) : sendOrders = sendOrders ?? [];

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      sendOrders: (json['sendOrders'] as List?)
              ?.map((x) => SendOrder.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'sendOrders': sendOrders.map((x) => x.toJson()).toList(),
    };
  }
}

class SendOrder {
  final String? id;
  final UserId? userId;
  final String? shippingAddress;
  final List<CartItem> cartItems;
  final String? paymentMethod;
  final double shippingPrice;
  final double totalAmount;
  final String? reference;
  final String? country;
  final String? status;
  final String? orderId;
  final String? trackingNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ReceiverDetail? receiverDetail;

  SendOrder({
    this.id,
    this.userId,
    this.shippingAddress,
    List<CartItem>? cartItems,
    this.paymentMethod,
    double? shippingPrice,
    double? totalAmount,
    this.reference,
    this.country,
    this.status,
    this.orderId,
    this.trackingNumber,
    this.createdAt,
    this.updatedAt,
    this.receiverDetail,
  })  : cartItems = cartItems ?? [],
        shippingPrice = shippingPrice ?? 0.0,
        totalAmount = totalAmount ?? 0.0;

  factory SendOrder.fromJson(Map<String, dynamic> json) {
    return SendOrder(
      id: json['_id'] as String?,
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      shippingAddress: json['shippingAddress'] as String?,
      cartItems: (json['cartItems'] as List?)
              ?.map((x) => CartItem.fromJson(x))
              .toList() ??
          [],
      paymentMethod: json['paymentMethod'] as String?,
      shippingPrice: (json['shippingPrice'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      reference: json['reference'] as String?,
      country: json['country'] as String?,
      status: json['status'] as String?,
      orderId: json['orderId'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      receiverDetail: json['receiverDetail'] != null
          ? ReceiverDetail.fromJson(json['receiverDetail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(),
      'shippingAddress': shippingAddress,
      'cartItems': cartItems.map((x) => x.toJson()).toList(),
      'paymentMethod': paymentMethod,
      'shippingPrice': shippingPrice,
      'totalAmount': totalAmount,
      'reference': reference,
      'country': country,
      'status': status,
      'orderId': orderId,
      'trackingNumber': trackingNumber,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'receiverDetail': receiverDetail?.toJson(),
    };
  }
}

class ReceiverDetail {
  final String? fullName;
  final String? receiverEmail;
  final String? receiverPhoneNumber;
  final String? receiverAddress;

  ReceiverDetail({
    this.fullName,
    this.receiverEmail,
    this.receiverPhoneNumber,
    this.receiverAddress,
  });

  factory ReceiverDetail.fromJson(Map<String, dynamic> json) {
    return ReceiverDetail(
      fullName: json['fullName'] as String?,
      receiverEmail: json['receiverEmail'] as String?,
      receiverPhoneNumber: json['receiverPhoneNumber'] as String?,
      receiverAddress: json['receiverAddress'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'receiverEmail': receiverEmail,
      'receiverPhoneNumber': receiverPhoneNumber,
      'receiverAddress': receiverAddress,
    };
  }
}

class UserId {
  final String? id;
  final String? fullName;
  final String? phoneNumber;

  UserId({
    this.id,
    this.fullName,
    this.phoneNumber,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }
}

class CartItem {
  final String? productId;
  final int quantity;
  final String? productName;
  final double price;
  final double vatAmount;
  final String? picture;
  final String? sku;
  final double subTotal;

  CartItem({
    this.productId,
    int? quantity,
    this.productName,
    double? price,
    double? vatAmount,
    this.picture,
    this.sku,
    double? subTotal,
  })  : quantity = quantity ?? 0,
        price = price ?? 0.0,
        vatAmount = vatAmount ?? 0.0,
        subTotal = subTotal ?? 0.0;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] as String?,
      quantity: json['quantity'] ?? 0,
      productName: json['productName'] as String?,
      price: (json['price'] ?? 0).toDouble(),
      vatAmount: (json['vatAmount'] ?? 0).toDouble(),
      picture: json['picture'] as String?,
      sku: json['sku'] as String?,
      subTotal: (json['subTotal'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'productName': productName,
      'price': price,
      'vatAmount': vatAmount,
      'picture': picture,
      'sku': sku,
      'subTotal': subTotal,
    };
  }
}

