import 'dart:convert';

class CancelOrderModel {
  CancelOrderModel({
    required this.orderId,
  });

  final String orderId;

  factory CancelOrderModel.fromJson(String str) =>
      CancelOrderModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancelOrderModel.fromMap(Map<String, dynamic> json) =>
      CancelOrderModel(
        orderId: json["order_id"],
      );

  Map<String, dynamic> toMap() => {
        "order_id": orderId,
      };
}
