class VoucherModel {
  VoucherModel({
    required this.statusCode,
    required this.datas,
  });
  late final int statusCode;
  late final List<Datas> datas;

  VoucherModel.fromJson(Map<String, dynamic> json) {
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
    required this.kode,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String kode;
  late final int nominal;
  late final String createdAt;
  late final String updatedAt;

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nominal = json['nominal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nominal'] = nominal;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
