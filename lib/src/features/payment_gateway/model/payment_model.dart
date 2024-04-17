
class PaymentModel {
  final String? id;
  final String? saltKey;
  final String? saltIndex;
  final String? merchantId;
  PaymentModel({
    this.id,
    this.saltKey,
    this.saltIndex,
    this.merchantId,
  });

  PaymentModel copyWith({
    String? id,
    String? saltKey,
    String? saltIndex,
    String? merchantId,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      saltKey: saltKey ?? this.saltKey,
      saltIndex: saltIndex ?? this.saltIndex,
      merchantId: merchantId ?? this.merchantId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'saltKey': saltKey,
      'saltIndex': saltIndex,
      'merchantId': merchantId,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] != null ? map['id'] as String : null,
      saltKey: map['saltKey'] != null ? map['saltKey'] as String : null,
      saltIndex: map['saltIndex'] != null ? map['saltIndex'] as String : null,
      merchantId: map['merchantId'] != null ? map['merchantId'] as String : null,
    );
  }

}
