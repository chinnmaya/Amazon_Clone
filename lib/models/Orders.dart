import 'dart:convert';

class Order {
  final String id;

  final String address;
  final String image;
  final String userId;
  final int orderedAt;
  final int status;
  final double totalPrice;
  final String name;
  final String paymentmethod;

  Order(
      {required this.id,
      required this.image,
      required this.address,
      required this.orderedAt,
      required this.status,
      required this.userId,
      required this.totalPrice,
      required this.name,
      required this.paymentmethod});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
      'name': name,
      'paymentmethod': paymentmethod,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      paymentmethod: map['paymentmethod'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
