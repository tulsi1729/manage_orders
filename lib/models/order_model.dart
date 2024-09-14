import 'dart:convert';

class Order {
  final String id;
  final String name;
  final String address;
  final double decidedAmount;
  final double receivedAmount;
  final DateTime time;
  final String uid;
  final bool isCompleted;

  Order({
    required this.id,
    required this.name,
    required this.address,
    required this.decidedAmount,
    required this.receivedAmount,
    required this.time,
    required this.uid,
    required this.isCompleted,
  });

  Order copyWith({
    String? id,
    String? name,
    String? address,
    double? decidedAmount,
    double? receivedAmount,
    DateTime? time,
    String? uid,
    bool? isCompleted,
  }) {
    return Order(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      decidedAmount: decidedAmount ?? this.decidedAmount,
      receivedAmount: receivedAmount ?? this.receivedAmount,
      time: time ?? this.time,
      uid: uid ?? this.uid,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'decidedAmount': decidedAmount,
      'receivedAmount': receivedAmount,
      'time': time.millisecondsSinceEpoch,
      'uid': uid,
      'isCompleted': isCompleted,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      decidedAmount: map['decidedAmount'] as double,
      receivedAmount: map['receivedAmount'] as double,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      uid: map['uid'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, name: $name, address: $address, decidedAmount: $decidedAmount, receivedAmount: $receivedAmount, time: $time, uid: $uid, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
        other.decidedAmount == decidedAmount &&
        other.receivedAmount == receivedAmount &&
        other.time == time &&
        other.uid == uid &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        decidedAmount.hashCode ^
        receivedAmount.hashCode ^
        time.hashCode ^
        uid.hashCode ^
        isCompleted.hashCode;
  }
}
