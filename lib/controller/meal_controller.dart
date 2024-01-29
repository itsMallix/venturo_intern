import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_venturo/models/model_menu.dart';
import 'package:flutter_venturo/utils/constant.dart';
import 'package:get/get.dart';

class MealController extends GetxController {
  final Dio _dio = Dio();
  final menuList = <Data>[].obs;
  final noteList = <String>[].obs;
  RxInt totalPrice = 0.obs;
  RxMap quantities = <int, RxInt>{}.obs;
  RxMap notes = <int, RxString>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getMenuData();
  }

  Future<void> getMenuData() async {
    try {
      final response = await _dio.get(baseUrlMenu);
      final List<dynamic> responseData = response.data['datas'];
      menuList.value = responseData.map((e) => Data.fromJson(e)).toList();
    } catch (e) {}
  }

  void updateTotalPrice() {
    int total = 0;
    for (var entry in quantities.entries) {
      int itemId = entry.key;
      int quantity = entry.value();
      Data item = menuList.firstWhere((menu) => menu.id == itemId);
      total += item.harga! * quantity;
    }
    totalPrice.value = total;
  }

  void addQuantity(int itemId, int amount) {
    if (quantities.containsKey(itemId)) {
      quantities[itemId]!(quantities[itemId]!() + amount);
    } else {
      quantities[itemId] = (amount).obs;
    }
    updateTotalPrice();
  }

  void minQuantity(int itemId) {
    if (quantities.containsKey(itemId) && quantities[itemId]!() > 0) {
      quantities[itemId]!(quantities[itemId]!() - 1);
      if (quantities[itemId]!() == 0) {
        quantities.remove(itemId);
      }
    }
    updateTotalPrice();
  }

  void addNotes(int itemId, String note) {
    notes[itemId] = note.obs;
    Get.snackbar(
      "Sukse",
      "Catatan ditambahkan",
      backgroundColor: Colors.green,
    );
  }
}
