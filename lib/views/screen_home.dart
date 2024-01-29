import 'package:flutter/material.dart';
import 'package:flutter_venturo/component/theme_colors.dart';
import 'package:flutter_venturo/component/theme_text.dart';
import 'package:flutter_venturo/component/widget/widget_bottom_bar.dart';
import 'package:flutter_venturo/component/widget/widget_card_menu.dart';
import 'package:flutter_venturo/controller/meal_controller.dart';
import 'package:get/get.dart';

class ScreenHome extends StatelessWidget {
  final MealController mealController = Get.find();
  final voucherController = TextEditingController();
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                itemCount: mealController.menuList.length,
                itemBuilder: (context, index) {
                  final menuDatas = mealController.menuList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: menuDatas.nama!,
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: Image.network(menuDatas.gambar!),
                            ),
                            TextField(
                              controller: noteController,
                              decoration: const InputDecoration(
                                hintText: "add Note",
                                hintStyle: TextSystem.content,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorSystem.blue,
                              ),
                              onPressed: () {
                                mealController.addNotes(
                                  menuDatas.id!,
                                  noteController.text,
                                );
                              },
                              child: Text(
                                "Save Changes",
                                style: TextSystem.subtitle.copyWith(
                                  color: ColorSystem.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: MenuCard(
                      menuDatas: menuDatas,
                      mealController: mealController,
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomBar(
        mealController: mealController,
        voucherController: voucherController,
      ),
    );
  }
}
