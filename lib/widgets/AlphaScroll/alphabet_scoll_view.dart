import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:adwiah/View/BrandsScreen/brandsbybrandScreen.dart';
import 'package:adwiah/View/IngredientsScreen/ingred_details_view.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_view_model.dart';
import 'package:adwiah/Widgets/card_list_widget.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_bubble/speech_bubble.dart';

class AzItem extends ISuspensionBean {
  final String? title;
  final String? tag;
  final IngredientModel? ingredient;
  final BrandModel? brands;
  void Function()? ontapCard;
  AzItem({this.tag, this.title, this.ingredient, this.brands, this.ontapCard});

  @override
  String getSuspensionTag() => tag!;
}

class AlphabetScrollPage extends StatelessWidget {
  // List<AzItem> itemsaz = [];
  AlphaBetController ctrl = Get.find<AlphaBetController>();
  AlphabetScrollPage(
      {Key? key, this.ingredient, this.brands, this.className, this.sortbyname})
      : super(key: key);

  List<IngredientModel>? ingredient = [];
  List<BrandModel>? brands = [];
  String? className;
  bool? sortbyname;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ctrl.initList(ingredient, brands);
      return AzListView(
        data: ctrl.itemsaz,
        itemCount: ctrl.itemsaz.length,
        itemBuilder: (context, int index) {
          final item = ctrl.itemsaz[index];
          return _buildListItem(item);
        },
        indexHintBuilder: (context, hint) => SpeechBubble(
          nipLocation: NipLocation.RIGHT,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    hint,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        indexBarOptions: const IndexBarOptions(
            needRebuild: true,
            indexHintAlignment: Alignment.centerRight,
            selectTextStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.red),
            selectItemDecoration: BoxDecoration(),
            indexHintOffset: Offset(10, 20)),
        indexBarAlignment: Alignment.centerRight,
      );
    });
  }

  Widget _buildListItem(
    AzItem item,
  ) {
    return CardList(
      item: item,
      ontap: () {
        switch (className) {
          case "ingreadient":
            {
              Get.to(IngDetailsScreen(
                  item.ingredient!.id.toString(), item.title!));
            }
            break;
          case "brands":
            {
              Get.to(BrandsByBrandScreen(
                  item.brands!.brandId.toString(), item.title));
            }
            break;
          case "disease":
            {
              // Get.to(Dise(5, item.title!));

            }
            break;
          default:
        }
      },
    );
  }
}
