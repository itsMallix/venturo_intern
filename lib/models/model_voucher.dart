import 'dart:convert';

VoucherModel voucherModelFromJson(String str) =>
    VoucherModel.fromJson(json.decode(str));

String voucherModelToJson(VoucherModel data) => json.encode(data.toJson());

class VoucherModel {
  int? statusCode;
  List<Data>? datas;

  VoucherModel({
    this.statusCode,
    this.datas,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
        statusCode: json["status_code"],
        datas: json["datas"] == null
            ? []
            : List<Data>.from(json["datas"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datas": datas == null
            ? []
            : List<dynamic>.from(datas!.map((x) => x.toJson())),
      };
}

class Data {
  int? id;
  String? kode;
  int? nominal;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.kode,
    this.nominal,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        kode: json["kode"],
        nominal: json["nominal"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nominal": nominal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
