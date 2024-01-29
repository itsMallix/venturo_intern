import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? nominalDiskon;
  String? nominalPesanan;
  List<Item>? items;

  OrderModel({
    this.nominalDiskon,
    this.nominalPesanan,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        nominalDiskon: json["nominal_diskon"],
        nominalPesanan: json["nominal_pesanan"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nominal_diskon": nominalDiskon,
        "nominal_pesanan": nominalPesanan,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  int? harga;
  String? catatan;

  Item({
    this.id,
    this.harga,
    this.catatan,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        harga: json["harga"],
        catatan: json["catatan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "harga": harga,
        "catatan": catatan,
      };
}
