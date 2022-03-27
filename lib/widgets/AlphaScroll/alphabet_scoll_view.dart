import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/disease.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:adwiah/View/Brands/brands_bybrand.dart';
import 'package:adwiah/View/Disease/similard_diseases_view.dart';
import 'package:adwiah/View/Ingredients/ingred_details_view.dart';
import 'package:adwiah/View/StudyInteractions/ViewModel/interactions_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/ViewModel/alphabet_view_model.dart';
import 'package:adwiah/Widgets/card_list_widget.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_bubble/speech_bubble.dart';

class AzItem extends ISuspensionBean {
  final String? title;
  final String? tag;
  final IngredientModel? ingredient;
  DiseaseModel? disease;
  final BrandModel? brands;
  void Function()? ontapCard;
  AzItem(
      {this.tag,
      this.title,
      this.ingredient,
      this.brands,
      this.ontapCard,
      this.disease});

  @override
  String getSuspensionTag() => tag!;
}

class AlphabetScrollPage extends StatelessWidget {
  // List<AzItem> itemsaz = [];
  AlphaBetController ctrl = Get.find<AlphaBetController>();
  StudyInteractionsController ctrlstudy =
      Get.find<StudyInteractionsController>();
  AlphabetScrollPage(
      {Key? key,
      this.ingredient,
      this.brands,
      this.className,
      this.sortbyname,
      this.disease})
      : super(key: key);

  List<IngredientModel>? ingredient = [];
  List<BrandModel>? brands = [];
  List<DiseaseModel>? disease = [];
  String? className;
  bool? sortbyname;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      ctrl.initList(ingredient, brands, disease);
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
              Get.to(SimilarDiseasesScreen(
                  id: item.disease!.id.toString(), name: item.title!));
            }

            break;
          case "study_ing":
            {
              var temping = InteractioObject(
                  name: item.ingredient!.name,
                  id: item.ingredient!.id.toString());

              ctrlstudy.setObjects(temping: temping);
            }

            break;
          case "study_brand":
            {
              var tempbrand = InteractioObject(
                  name: item.brands!.brandName,
                  id: item.brands!.brandId.toString());

              ctrlstudy.setObjects(tempbrand: tempbrand);
            }

            break;
          default:
        }
      },
    );
  }
}
