import 'package:flutter/material.dart';
import 'package:flutter_venturo/component/theme_colors.dart';
import 'package:flutter_venturo/component/theme_text.dart';
import 'package:flutter_venturo/controller/meal_controller.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.mealController,
    required this.voucherController,
  });

  final MealController mealController;
  final TextEditingController voucherController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
            height: 190,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: const BoxDecoration(
              color: ColorSystem.grey,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Total Pesanan (${mealController.quantities.length} Menu) :",
                      style: TextSystem.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Rp ${mealController.totalPrice.value}",
                      style: TextSystem.subtitle.copyWith(
                        color: ColorSystem.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.airplane_ticket),
                    const SizedBox(width: 10),
                    Text(
                      "Voucher",
                      style: TextSystem.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          Container(
                            padding: const EdgeInsets.all(20),
                            height: 215,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: ColorSystem.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.airplane_ticket,
                                      color: ColorSystem.blue,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "Punya Kode Voucher?",
                                      style: TextSystem.subtitle.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  "Masukkan kode voucher disini",
                                  style: TextSystem.content,
                                ),
                                TextField(
                                  controller: voucherController,
                                  cursorColor: ColorSystem.blue,
                                  style: TextSystem.content,
                                  decoration: InputDecoration(
                                    focusColor: ColorSystem.blue,
                                    hintText: "masukkan kode voucer",
                                    hintStyle: TextSystem.content,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        voucherController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 45,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: ColorSystem.blue,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      "Validasi Voucher",
                                      style: TextSystem.subtitle.copyWith(
                                        color: ColorSystem.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Input Voucher  >",
                        style: TextSystem.content.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 90,
              width: 400,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: ColorSystem.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.shopping_basket_outlined,
                    color: ColorSystem.blue,
                    size: 40,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Pembayaran",
                        style: TextSystem.content,
                      ),
                      Text(
                        "${mealController.totalPrice.value}",
                        style: TextSystem.subtitle.copyWith(
                          color: ColorSystem.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorSystem.blue,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Pesan Sekarang",
                      style: TextSystem.content.copyWith(
                        color: ColorSystem.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
