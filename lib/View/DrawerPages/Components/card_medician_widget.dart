import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardMedicianWidget extends StatelessWidget {
  CardMedicianWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final InitialAppController controller;
  int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        InkWell(
          onTap: () async {
            var url = controller.medicalCentersList[index].centerUrl!;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        controller.medicalCentersList[index].centerName!,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: const Color(0xff1c2340),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xff5C376D),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () async {
                var url = controller.medicalCentersList[index].centerUrl!;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
