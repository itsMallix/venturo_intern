import 'package:flutter/material.dart';
import 'package:flutter_venturo/component/theme/theme_colors.dart';
import 'package:flutter_venturo/component/theme/theme_text.dart';
import 'package:flutter_venturo/component/widget/widget_bottom_sheet_voucher.dart';
import 'package:flutter_venturo/controller/api_controller.dart';
import 'package:flutter_venturo/views/screen_home.dart';
import 'package:get/get.dart';

class BottomBarCheckout extends StatelessWidget {
  const BottomBarCheckout({
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
                Row(
                  children: [
                    const Icon(
                      Icons.airplane_ticket,
                      color: ColorSystem.blue,
                    ),
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
                          VoucherBottomSheet(
                            voucherController: voucherController,
                            mealController: mealController,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          if (voucherController.text.isEmpty)
                            Text(
                              "Input Voucher",
                              style: TextSystem.content.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          if (voucherController.text.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  voucherController.text,
                                  style: TextSystem.content,
                                ),
                                if (mealController.selectedVoucher.value !=
                                    null)
                                  Text(
                                    "Rp ${mealController.selectedVoucher.value!.nominal}",
                                    style: TextSystem.content.copyWith(
                                      color: Colors.red,
                                    ),
                                  )
                              ],
                            ),
                          const SizedBox(width: 5),
                          Text(
                            ">",
                            style: TextSystem.content.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, -2),
                    blurRadius: 5,
                  )
                ],
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
                        "Rp ${mealController.totalPrice.value}",
                        style: TextSystem.subtitle.copyWith(
                          color: ColorSystem.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  if (mealController.quantities.isNotEmpty)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSystem.blue,
                      ),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "",
                            content: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.warning_amber_rounded,
                                  color: ColorSystem.blue,
                                  size: 60,
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 80,
                                  width: 200,
                                  child: Text(
                                    "Apakah anda yakin ingin membatalkan pesanan ini?",
                                    style: TextSystem.subtitle.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                            actions: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorSystem.white,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "Batal",
                                    style: TextSystem.subtitle.copyWith(
                                        color: ColorSystem.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorSystem.blue,
                                  ),
                                  onPressed: () {
                                    Get.offAll(() => ScreenHome());
                                    mealController.resetOrderData();
                                  },
                                  child: Text(
                                    "Yakin",
                                    style: TextSystem.subtitle.copyWith(
                                      color: ColorSystem.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                      },
                      child: Text(
                        "     Batalkan     ",
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
