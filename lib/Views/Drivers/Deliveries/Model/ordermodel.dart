// import 'dart:convert';


// class OrderResponse {
//   final bool? success;
//   final String? message;
//   final List<SendOrder>? sendOrders;

//   OrderResponse({
//     this.success,
//     this.message,
//     this.sendOrders,
//   });

//   factory OrderResponse.fromJson(String source) =>
//       OrderResponse.fromMap(json.decode(source));

//   factory OrderResponse.fromMap(Map<String, dynamic>? map) {
//     if (map == null) return OrderResponse();

//     return OrderResponse(
//       success: map['success'] as bool? ?? false,
//       message: map['message'] as String? ?? '',
//       sendOrders: map['sendOrders'] != null
//           ? List<SendOrder>.from(
//               (map['sendOrders'] as List).map((x) => SendOrder.fromMap(x)))
//           : [],
//     );
//   }
// }

// class SendOrder {
//   final String? id;
//   final User? userId;
//   final String? shippingAddress;
//   final List<CartItem>? cartItems;
//   final String? paymentMethod;
//   final double? shippingPrice;
//   final double? totalAmount;
//   final String? reference;
//   final String? country;
//   final String? status;
//   final String? orderId;
//   final String? trackingNumber;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   // Additional Fields for Package Orders
//   final String? senderName;
//   final String? senderPhone;
//   final String? pickupAddress;
//   final String? receiverName;
//   final String? receiverPhoneNumber;
//   final String? receiverAddress;
//   final String? itemName;
//   final double? weightOfPackage;
//   final String? packageCategory;
//   final int? numberOfPackages;
//   final double? length;
//   final double? width;
//   final double? height;
//   final String? shipmentMethod;
//   final bool? isPaid;
//   final double? tax;

//   SendOrder({
//     this.id,
//     this.userId,
//     this.shippingAddress,
//     this.cartItems,
//     this.paymentMethod,
//     this.shippingPrice,
//     this.totalAmount,
//     this.reference,
//     this.country,
//     this.status,
//     this.orderId,
//     this.trackingNumber,
//     this.createdAt,
//     this.updatedAt,
//     this.senderName,
//     this.senderPhone,
//     this.pickupAddress,
//     this.receiverName,
//     this.receiverPhoneNumber,
//     this.receiverAddress,
//     this.itemName,
//     this.weightOfPackage,
//     this.packageCategory,
//     this.numberOfPackages,
//     this.length,
//     this.width,
//     this.height,
//     this.shipmentMethod,
//     this.isPaid,
//     this.tax,
//   });

//   factory SendOrder.fromMap(Map<String, dynamic>? map) {
//     if (map == null) return SendOrder();

//     return SendOrder(
//       id: map['_id'] as String?,
//       userId: map['userId'] != null ? User.fromMap(map['userId']) : null,
//       shippingAddress: map['shippingAddress'] as String?,
//       cartItems: map['cartItems'] != null
//           ? List<CartItem>.from(
//               (map['cartItems'] as List).map((x) => CartItem.fromMap(x)))
//           : [],
//       paymentMethod: map['paymentMethod'] as String?,
//       shippingPrice: (map['shippingPrice'] as num?)?.toDouble(),
//       totalAmount: (map['totalAmount'] as num?)?.toDouble() ??
//           (map['amount'] as num?)?.toDouble() ??
//           0.0,
//       reference: map['reference'] as String?,
//       country: map['country'] as String?,
//       status: map['status'] as String?,
//       orderId: map['orderId'] as String?,
//       trackingNumber: map['trackingNumber'] as String?,
//       createdAt:
//           map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
//       updatedAt:
//           map['updatedAt'] != null ? DateTime.tryParse(map['updatedAt']) : null,

//       // Additional fields for package-type orders
//       senderName: map['senderName'] as String?,
//       senderPhone: map['phoneNumber'] as String?,
//       pickupAddress: map['pickupAddress'] as String?,
//       receiverName: map['receiverName'] as String?,
//       receiverPhoneNumber: map['receiverPhoneNumber'] as String?,
//       receiverAddress: map['receiverAddress'] as String?,
//       itemName: map['itemName'] as String?,
//       weightOfPackage: (map['weightOfPackage'] as num?)?.toDouble(),
//       packageCategory: map['packageCategory'] as String?,
//       numberOfPackages: map['numberOfPackages'] as int?,
//       length: (map['length'] as num?)?.toDouble(),
//       width: (map['width'] as num?)?.toDouble(),
//       height: (map['height'] as num?)?.toDouble(),
//       shipmentMethod: map['shipmentMethod'] as String?,
//       isPaid: map['isPaid'] as bool?,
//       tax: (map['tax'] as num?)?.toDouble(),
//     );
//   }
// }

// class User {
//   final String? id;
//   final String? fullName;
//   final String? phoneNumber;

//   User({
//     this.id,
//     this.fullName,
//     this.phoneNumber,
//   });

//   factory User.fromMap(Map<String, dynamic>? map) {
//     if (map == null) return User();

//     return User(
//       id: map['_id'] as String?,
//       fullName: map['fullName'] as String?,
//       phoneNumber: map['phoneNumber']?.toString(),
//     );
//   }
// }

// class CartItem {
//   final String? productId;
//   final int? quantity;
//   final double? price;
//   final double? vatAmount;
//   final String? picture;
//   final String? sku;
//   final String? productName;
//   final double? subTotal;

//   CartItem({
//     this.productId,
//     this.quantity,
//     this.price,
//     this.vatAmount,
//     this.picture,
//     this.sku,
//     this.productName,
//     this.subTotal,
//   });

//   factory CartItem.fromMap(Map<String, dynamic>? map) {
//     if (map == null) return CartItem();

//     return CartItem(
//       productId: map['productId'] as String?,
//       quantity: map['quantity'] as int? ?? 0,
//       price: (map['price'] as num?)?.toDouble() ?? 0.0,
//       vatAmount: (map['vatAmount'] as num?)?.toDouble() ?? 0.0,
//       picture: map['picture'] as String?,
//       sku: map['sku'] as String?,
//       productName: map['productName'] as String?,
//       subTotal: (map['subTotal'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }

