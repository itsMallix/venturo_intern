import 'package:flutter/material.dart';
import 'package:flutter_venturo/component/theme/theme_colors.dart';
import 'package:flutter_venturo/component/theme/theme_text.dart';
import 'package:flutter_venturo/controller/api_controller.dart';
import 'package:flutter_venturo/models/model_menu.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.menuDatas,
    required this.mealController,
  });

  final DataMenu menuDatas;
  final MealController mealController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
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
                  IconButton(
                    onPressed: () {
                      mealController.minQuantity(menuDatas.id!);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: ColorSystem.blue,
                    ),
                  ),
                  Text(
                    "${mealController.quantities[menuDatas.id!] ?? 0}",
                  ),
                  IconButton(
                    onPressed: () {
                      mealController.addQuantity(menuDatas.id!, 1);
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: ColorSystem.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
