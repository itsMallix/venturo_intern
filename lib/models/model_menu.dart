import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  int? statusCode;
  List<DataMenu>? datas;

  MenuModel({
    this.statusCode,
    this.datas,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        statusCode: json["status_code"],
        datas: json["datas"] == null
            ? []
            : List<DataMenu>.from(
                json["datas"]!.map((x) => DataMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datas": datas == null
            ? []
            : List<dynamic>.from(datas!.map((x) => x.toJson())),
      };
}

class DataMenu {
  int? id;
  String? nama;
  int? harga;
  String? tipe;
  String? gambar;

  DataMenu({
    this.id,
    this.nama,
    this.harga,
    this.tipe,
    this.gambar,
  });

  factory DataMenu.fromJson(Map<String, dynamic> json) => DataMenu(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        tipe: json["tipe"],
        gambar: json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "tipe": tipe,
        "gambar": gambar,
      };
}
