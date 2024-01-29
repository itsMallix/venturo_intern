class MenuModel {
  MenuModel({
    required this.statusCode,
    required this.datas,
  });
  late final int statusCode;
  late final List<Datas> datas;

  MenuModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    datas = List.from(json['datas']).map((e) => Datas.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['datas'] = datas.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Datas {
  Datas({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tipe,
    required this.gambar,
  });
  late final int id;
  late final String nama;
  late final int harga;
  late final String tipe;
  late final String gambar;

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    harga = json['harga'];
    tipe = json['tipe'];
    gambar = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['harga'] = harga;
    _data['tipe'] = tipe;
    _data['gambar'] = gambar;
    return _data;
  }
}
