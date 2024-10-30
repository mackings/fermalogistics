
class Transaction {
  
  final String id;
  final String userId;
  final String senderName;
  final String phoneNumber;
  final String pickupAddress;
  final String emailAddress;
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverAddress;
  final String receiverEmailAddress;
  final String itemName;
  final double weightOfPackage;
  final String packageCategory;
  final int numberOfPackages;
  final double length;
  final double width;
  final double height;
  final String shipmentMethod;
  final double amount;
  final bool isPaid;
  final String status;
  final String trackingNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.senderName,
    required this.phoneNumber,
    required this.pickupAddress,
    required this.emailAddress,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverAddress,
    required this.receiverEmailAddress,
    required this.itemName,
    required this.weightOfPackage,
    required this.packageCategory,
    required this.numberOfPackages,
    required this.length,
    required this.width,
    required this.height,
    required this.shipmentMethod,
    required this.amount,
    required this.isPaid,
    required this.status,
    required this.trackingNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      userId: json['userId'],
      senderName: json['senderName'],
      phoneNumber: json['phoneNumber'],
      pickupAddress: json['pickupAddress'],
      emailAddress: json['emailAddress'],
      receiverName: json['recieverName'],
      receiverPhoneNumber: json['recieverPhoneNumber'],
      receiverAddress: json['recieverAddress'],
      receiverEmailAddress: json['recieverEmailAddress'],
      itemName: json['itemName'],
      weightOfPackage: json['weightOfPackage'].toDouble(),
      packageCategory: json['packageCategory'],
      numberOfPackages: json['numberOfPackages'],
      length: json['length'].toDouble(),
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
      shipmentMethod: json['shipmentMethod'],
      amount: json['amount'].toDouble(),
      isPaid: json['isPaid'],
      status: json['status'],
      trackingNumber: json['trackingNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class TransactionResponse {
  final String status;
  final String message;
  final List<Transaction> transactions;

  TransactionResponse({
    required this.status,
    required this.message,
    required this.transactions,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    var transactionsJson = json['transactions'] as List;
    List<Transaction> transactionsList =
        transactionsJson.map((transaction) => Transaction.fromJson(transaction)).toList();

    return TransactionResponse(
      status: json['status'],
      message: json['message'],
      transactions: transactionsList,
    );
  }
}
