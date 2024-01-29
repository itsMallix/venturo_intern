import 'package:flutter/material.dart';
import 'package:flutter_venturo/component/theme/theme_colors.dart';
import 'package:flutter_venturo/component/theme/theme_text.dart';
import 'package:flutter_venturo/controller/api_controller.dart';
import 'package:get/get.dart';

class ScreenCheckout extends StatelessWidget {
  final MealController mealController;

  const ScreenCheckout({Key? key, required this.mealController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterMenu = mealController.menuList
        .where((menu) =>
            mealController.quantities.containsKey(menu.id) &&
            mealController.quantities[menu.id]!() > 0)
        .toList();

    return Scaffold(
      body: Obx(
        () => mealController.menuList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 50,
                ),
                scrollDirection: Axis.vertical,
                itemCount: filterMenu.length,
                itemBuilder: (context, index) {
                  final menuDatas = filterMenu[index];
                  return Card(
                    color: ColorSystem.grey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorSystem.grey,
                            ),
                            child: Image.network(menuDatas.gambar!),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menuDatas.nama!,
                                style: TextSystem.title,
                              ),
                              Text(
                                "Rp ${menuDatas.harga}",
                                style: TextSystem.subtitle.copyWith(
                                  color: ColorSystem.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit_note_rounded,
                                    color: ColorSystem.blue,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${mealController.notes[menuDatas.id!] ?? "Tambahkan Catatan"}",
                                  )
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                "|",
                                style: TextSystem.title.copyWith(
                                  color: Colors.grey,
                                  fontSize: 40,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                "${mealController.quantities[menuDatas.id!]}",
                                style: TextSystem.subtitle.copyWith(
                                  color: ColorSystem.blue,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
