import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_venturo/models/model_menu.dart';
import 'package:flutter_venturo/models/model_order.dart';
import 'package:flutter_venturo/models/model_order_cancel.dart';
import 'package:flutter_venturo/models/model_voucher.dart';
import 'package:flutter_venturo/utils/constant.dart';
import 'package:get/get.dart';

class MealController extends GetxController {
  RxBool isCheckout = false.obs;
  final Dio _dio = Dio();
  final menuList = <DataMenu>[].obs;
  final noteList = <String>[].obs;
  RxInt totalPrice = 0.obs;
  RxMap quantities = <int, RxInt>{}.obs;
  RxMap notes = <int, RxString>{}.obs;
  RxList<DataVoucher> voucherList = <DataVoucher>[].obs;
  Rx<DataVoucher?> selectedVoucher = Rx<DataVoucher?>(null);

  // get onCheckoutPage => null;

  @override
  void onInit() {
    super.onInit();
    getMenuData();
    getVoucherData();
  }

  Future<void> getMenuData() async {
    try {
      final response = await _dio.get(baseUrlMenu);
      final List<dynamic> responseData = response.data['datas'];
      menuList.value = responseData.map((e) => DataMenu.fromJson(e)).toList();
    } catch (e) {}
  }

  void updateTotalPrice() {
    int total = 0;
    for (var entry in quantities.entries) {
      int itemId = entry.key;
      int quantity = entry.value();

      if (menuList.isNotEmpty) {
        DataMenu? item = menuList.firstWhereOrNull((menu) => menu.id == itemId);
        if (item != null) {
          total += item.harga! * quantity;
        }
      }
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
      "Success",
      "Catatan ditambahkan",
      backgroundColor: Colors.green,
    );
  }

  Future<void> getVoucherData() async {
    try {
      final response = await _dio.get(baseUrlVoucher);
      final List<dynamic> responseData = response.data['datas'];
      voucherList.value =
          responseData.map((e) => DataVoucher.fromJson(e)).toList();
    } catch (err) {}
  }

  void useVoucher(DataVoucher? voucher) {
    selectedVoucher.value = voucher;

    try {
      if (voucher != null) {
        int voucherDiscount = voucher.nominal!;
        int cashBack = totalPrice.value - voucherDiscount;

        if (cashBack < 0) {
          totalPrice.value = 0;
        } else {
          totalPrice.value = cashBack;
        }

        Get.snackbar(
          "Success",
          "Voucher Berhasil Dipakai",
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          "Gagal",
          "Voucher Tidak Valid",
          backgroundColor: Colors.red,
        );
      }
    } catch (err) {
      Get.snackbar(
        "Gagal",
        "Voucher Tidak Valid",
        backgroundColor: Colors.red,
      );
    }
  }

  void resetVoucher() {
    selectedVoucher.value = null;
  }

  Future<void> postOrder({
    int? voucherId,
    required int nominalDiskon,
    required int nominalPesanan,
    required List<Item> items,
  }) async {
    try {
      OrderModel orderModel = OrderModel(
        nominalDiskon: nominalDiskon.toString(),
        nominalPesanan: nominalPesanan.toString(),
        items: items,
      );

      String orderJson = orderModelToJson(orderModel);

      Map<String, dynamic> requestData = {
        'voucher_id': voucherId,
        'nominal_diskon': nominalDiskon,
        'nominal_pesanan': nominalPesanan,
        'items': json.decode(orderJson)['items'],
      };

      final response = await _dio.post(
        baseUrlOrder,
        data: requestData,
      );

      if (response.statusCode == 201) {
        print('Order created successfully');
      } else {
        print('Failed to create order. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during API call: $error');
    }
  }

  void resetOrderData() {
    quantities.clear();
    notes.clear();
    totalPrice.value = 0;
    selectedVoucher.value = null;
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      final CancelOrderModel cancelOrderModel =
          CancelOrderModel(orderId: orderId);

      final response = await _dio.post(
        baseUrlCancelOrder,
        data: cancelOrderModel.toMap(),
      );

      if (response.statusCode == 200) {
        print('Order canceled successfully');
      } else {
        print('Failed to cancel order. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during API call: $error');
    }
  }
}
