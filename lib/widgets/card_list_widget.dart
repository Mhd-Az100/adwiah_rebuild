import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class CardList extends StatelessWidget {
  CardList({Key? key, required this.item, this.ontap}) : super(key: key);
  AzItem item;
  void Function()? ontap;
  DiseaseController controller = Get.find<DiseaseController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 40, 10),
      child: InkWell(
        onTap: ontap,
        child: Tooltip(
          message: item.title,
          child: Container(
            height: 45 + ((context.diagonalInches / 6.0).floorToDouble() * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: const Border.fromBorderSide(BorderSide(width: 2.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: item.disease == null
                  ? Row(
                      children: [
                        item.ingredient != null
                            ? item.ingredient!.type == 2
                                ? Container(
                                    color: Colors.red[900],
                                    width: 4,
                                  )
                                : const SizedBox()
                            : const SizedBox(),
                        const SizedBox(
                          width: 3,
                        ),
                        Flexible(
                          child: Text(
                            // activ == 'name'
                            //     ? subdata[i]['Name'].toString()
                            //     :
                            item.title!,
                            overflow: TextOverflow.ellipsis,
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color:
                                    // subdata[i]['Type'] == 2
                                    //     ? Colors.red[900]:
                                    Colors.black54,
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  : Obx(
                      () => Row(
                        mainAxisAlignment: controller.lang.value == 'en'
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          item.ingredient != null
                              ? item.ingredient!.type == 2
                                  ? Container(
                                      color: Colors.red[900],
                                      width: 4,
                                    )
                                  : const SizedBox()
                              : const SizedBox(),
                          const SizedBox(
                            width: 3,
                          ),
                          Flexible(
                            child: Text(
                              // activ == 'name'
                              //     ? subdata[i]['Name'].toString()
                              //     :

                              controller.lang.value == 'en'
                                  ? item.disease!.valEn!
                                  : item.disease!.valAr!,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                              textAlign: controller.lang.value == 'en'
                                  ? TextAlign.start
                                  : TextAlign.end,
                              style: const TextStyle(
                                  color:
                                      // subdata[i]['Type'] == 2
                                      //     ? Colors.red[900]:
                                      Colors.black54,
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
