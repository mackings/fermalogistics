import 'dart:convert';

class OrderResponse {
  final bool? success;
  final String? message;
  final List<SendOrder>? sendOrders;

  OrderResponse({
    this.success,
    this.message,
    this.sendOrders,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      success: json['success'],
      message: json['message'],
      sendOrders: json['sendOrders'] != null
          ? List<SendOrder>.from(
              json['sendOrders'].map((x) => SendOrder.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'sendOrders': sendOrders != null
          ? List<dynamic>.from(sendOrders!.map((x) => x.toJson()))
          : null,
    };
  }
}

class SendOrder {
  final String? id;
  final UserId? userId;
  final String? shippingAddress;
  final List<CartItem>? cartItems;
  final String? paymentMethod;
  final double? shippingPrice;
  final double? totalAmount;
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
    this.cartItems,
    this.paymentMethod,
    this.shippingPrice,
    this.totalAmount,
    this.reference,
    this.country,
    this.status,
    this.orderId,
    this.trackingNumber,
    this.createdAt,
    this.updatedAt,
    this.receiverDetail,
  });

  factory SendOrder.fromJson(Map<String, dynamic> json) {
    return SendOrder(
      id: json['_id'],
      userId: json['userId'] != null ? UserId.fromJson(json['userId']) : null,
      shippingAddress: json['shippingAddress'],
      cartItems: json['cartItems'] != null
          ? List<CartItem>.from(json['cartItems'].map((x) => CartItem.fromJson(x)))
          : null,
      paymentMethod: json['paymentMethod'],
      shippingPrice: json['shippingPrice']?.toDouble(),
      totalAmount: json['totalAmount']?.toDouble(),
      reference: json['reference'],
      country: json['country'],
      status: json['status'],
      orderId: json['orderId'],
      trackingNumber: json['trackingNumber'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
      'cartItems': cartItems != null
          ? List<dynamic>.from(cartItems!.map((x) => x.toJson()))
          : null,
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
      fullName: json['fullName'],
      receiverEmail: json['receiverEmail'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      receiverAddress: json['receiverAddress'],
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
      id: json['_id'],
      fullName: json['fullName'],
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
  final int? quantity;
  final String? productName;
  final double? price;
  final double? vatAmount;
  final String? picture;
  final String? sku;
  final double? subTotal;

  CartItem({
    this.productId,
    this.quantity,
    this.productName,
    this.price,
    this.vatAmount,
    this.picture,
    this.sku,
    this.subTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
      productName: json['productName'],
      price: json['price']?.toDouble(),
      vatAmount: json['vatAmount']?.toDouble(),
      picture: json['picture'],
      sku: json['sku'],
      subTotal: json['subTotal']?.toDouble(),
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
