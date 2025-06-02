class UserData {
  final String? id; 
  final String? fullName; 
  final String? email; 
  final String? address; 
  final String? country; 
  final String? phoneNumber; 
  final String? wallet; 
  final String? picture; 
  final String? roles; 
  final String? referralCode; 

  UserData({
    this.id,
    this.fullName,
    this.email,
    this.address,
    this.country,
    this.phoneNumber,
    this.wallet,
    this.picture,
    this.roles,
    this.referralCode,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      country: json['country'] as String?,
      phoneNumber: json['phoneNumber']?.toString(),
      wallet: (json['wallet'] as num?)?.toString(),
      picture: json['picture'] as String?,
      roles: json['roles'] as String?,
      referralCode: json['referralCode'] as String?,
    );
  }

  // Getters to return the field value or "N/A"
  String get safeFullName => fullName ?? "N/A";
  String get safeEmail => email ?? "N/A";
  String get safeAddress => address ?? "N/A";
  String get safeCountry => country ?? "N/A";
  String get safePhoneNumber => phoneNumber ?? "N/A";
  String get safeWallet => wallet != null ? '\$${wallet!.toString()}' : "N/A";
  String get safePicture => picture ?? "N/A";
  String get safeRoles => roles ?? "N/A";
  String get safeReferralCode => referralCode ?? "N/A";
}
