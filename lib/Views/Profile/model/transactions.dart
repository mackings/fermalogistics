class Transaction {
  final String? id;
  final String? userId;
  final String? senderName;
  final String? phoneNumber;
  final String? pickupAddress;
  final String? emailAddress;
  final String? receiverName;
  final String? receiverPhoneNumber;
  final String? receiverAddress;
  final String? receiverEmailAddress;
  final String? itemName;
  final double? weightOfPackage;
  final String? packageCategory;
  final int? numberOfPackages;
  final double? length;
  final double? width;
  final double? height;
  final String? shipmentMethod;
  final double? amount;
  final bool? isPaid;
  final String? status;
  final String? trackingNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Transaction({
    this.id,
    this.userId,
    this.senderName,
    this.phoneNumber,
    this.pickupAddress,
    this.emailAddress,
    this.receiverName,
    this.receiverPhoneNumber,
    this.receiverAddress,
    this.receiverEmailAddress,
    this.itemName,
    this.weightOfPackage,
    this.packageCategory,
    this.numberOfPackages,
    this.length,
    this.width,
    this.height,
    this.shipmentMethod,
    this.amount,
    this.isPaid,
    this.status,
    this.trackingNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      userId: json['userId'],
      senderName: json['senderName'],
      phoneNumber: json['phoneNumber'],
      pickupAddress: json['pickupAddress'],
      emailAddress: json['emailAddress'],
      receiverName: json['receiverName'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      receiverAddress: json['receiverAddress'],
      receiverEmailAddress: json['receiverEmailAddress'],
      itemName: json['itemName'],
      weightOfPackage: json['weightOfPackage'] != null ? json['weightOfPackage'].toDouble() : null,
      packageCategory: json['packageCategory'],
      numberOfPackages: json['numberOfPackages'],
      length: json['length'] != null ? json['length'].toDouble() : null,
      width: json['width'] != null ? json['width'].toDouble() : null,
      height: json['height'] != null ? json['height'].toDouble() : null,
      shipmentMethod: json['shipmentMethod'],
      amount: json['amount'] != null ? json['amount'].toDouble() : null,
      isPaid: json['isPaid'],
      status: json['status'],
      trackingNumber: json['trackingNumber'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}

class TransactionResponse {
  final String? status;
  final String? message;
  final List<Transaction>? transactions;

  TransactionResponse({
    this.status,
    this.message,
    this.transactions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    var transactionsJson = json['transactions'] as List?;
    List<Transaction>? transactionsList =
        transactionsJson?.map((transaction) => Transaction.fromJson(transaction)).toList();

    return TransactionResponse(
      status: json['status'],
      message: json['message'],
      transactions: transactionsList,
    );
  }
}
