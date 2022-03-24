import 'package:adwiah/View/Disease/disease_details_view.dart';
import 'package:adwiah/View/Disease/ViewModel/disease_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisCard extends StatelessWidget {
  String? name, id;
  DisCard({
    Key? key,
    this.name,
    this.id,
  }) : super(key: key);
  DiseaseController controller = Get.find<DiseaseController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiseaseDetailScreen(
                      name!,
                      id!,
                    )));
      },
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Material(
              color: const Color(0xff5C376D),
              borderRadius: BorderRadius.circular(10),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Obx(() => Expanded(
                          child: Text(
                            name!,
                            textAlign: controller.lang.value == "en"
                                ? TextAlign.left
                                : TextAlign.right,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
