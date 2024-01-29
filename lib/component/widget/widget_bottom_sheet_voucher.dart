import 'package:flutter/material.dart';
import 'package:flutter_venturo/component/theme/theme_colors.dart';
import 'package:flutter_venturo/component/theme/theme_text.dart';
import 'package:flutter_venturo/controller/api_controller.dart';
import 'package:flutter_venturo/models/model_voucher.dart';
import 'package:get/get.dart';

class VoucherBottomSheet extends StatelessWidget {
  const VoucherBottomSheet({
    super.key,
    required this.mealController,
    required this.voucherController,
  });

  final TextEditingController voucherController;
  final MealController mealController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: () async {
              String voucherCode = voucherController.text;

              DataVoucher? selectedVoucher =
                  mealController.voucherList.firstWhere(
                (voucher) {
                  return voucher.kode == voucherCode;
                },
              );
              mealController.useVoucher(selectedVoucher);
            },
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
    );
  }
}
