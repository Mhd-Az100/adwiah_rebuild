import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:adwiah/View/IngredientsScreen/Components/card_list_widget.dart';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:speech_bubble/speech_bubble.dart';

class AzItem extends ISuspensionBean {
  final String? title;
  final String? tag;
  AzItem({this.tag, this.title});

  @override
  String getSuspensionTag() => tag!;
}

class AlphabetScrollPage extends StatefulWidget {
  AlphabetScrollPage({Key? key, this.ingredient, this.brands})
      : super(key: key);
  List<IngredientModel>? ingredient = [];
  List<BrandModel>? brands = [];
  @override
  State<AlphabetScrollPage> createState() => _AlphabetScrollPageState();
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<AzItem> itemsaz = [];

  @override
  void initState() {
    super.initState();
    initList(
        widget.ingredient?.length == 0 ? widget.brands : widget.ingredient);
  }

  void initList(var items) {
    itemsaz = widget.ingredient!
        .map((item) =>
            AzItem(title: item.name, tag: item.name![0].toUpperCase()))
        .toList();
    SuspensionUtil.sortListBySuspensionTag(itemsaz);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: itemsaz,
      itemCount: itemsaz.length,
      itemBuilder: (context, int index) {
        final item = itemsaz[index];
        return _buildListItem(item, widget);
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
  }

  Widget _buildListItem(AzItem item, dynamic modelData) {
    return CardList(
      item: item,
    );
  }
}
