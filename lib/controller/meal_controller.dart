import 'package:dio/dio.dart';
import 'package:flutter_venturo/models/model_menu.dart';
import 'package:flutter_venturo/utils/constant.dart';
import 'package:get/get.dart';

class MealController extends GetxController {
  final Dio _dio = Dio();

  final menuList = <Datas>[].obs;
  final noteList = <String>[].obs;
  RxInt totalPrice = 0.obs;
  RxInt quantity = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getMenuData();
  }

  Future<void> getMenuData() async {
    try {
      final response = await _dio.get(baseUrlMenu);
      final List<dynamic> responseData = response.data['datas'];
      menuList.value = responseData.map((e) => Datas.fromJson(e)).toList();
    } catch (e) {
      // Handle error
    }
  }

  void addNote() {}
  void updateTotalPrice(int price) {
    totalPrice += price;
  }

  void addQuantity() {
    quantity++;
  }

  void minQuantity() {
    quantity--;
  }
}
