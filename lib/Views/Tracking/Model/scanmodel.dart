class ScanResult {
  final String message;
  final Product product;

  ScanResult({
    required this.message,
    required this.product,
  });

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      message: json['message'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final String id;
  final String userId;
  final String categoryId;
  final String categoryName;
  final String description;
  final String productName;
  final List<String> productImages;
  final int price;
  final int vatAmount;
  final int discount;
  final int quantitySold;
  final String taxClass;
  final String sku;
  final int quantity;
  final String barcode;
  final int weight;
  final int height;
  final int length;
  final int width;
  final String countryOfOrigin;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String qrcode;

  Product({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.productName,
    required this.productImages,
    required this.price,
    required this.vatAmount,
    required this.discount,
    required this.quantitySold,
    required this.taxClass,
    required this.sku,
    required this.quantity,
    required this.barcode,
    required this.weight,
    required this.height,
    required this.length,
    required this.width,
    required this.countryOfOrigin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.qrcode,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      description: json['description'],
      productName: json['productName'],
      productImages: List<String>.from(json['productImages']),
      price: json['price'],
      vatAmount: json['vatAmount'],
      discount: json['discount'],
      quantitySold: json['quantitySold'],
      taxClass: json['taxClass'],
      sku: json['sku'],
      quantity: json['quantity'],
      barcode: json['barcode'],
      weight: json['weight'],
      height: json['height'],
      length: json['length'],
      width: json['width'],
      countryOfOrigin: json['countryOfOrigin'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      qrcode: json['qrcode'],
    );
  }
}
