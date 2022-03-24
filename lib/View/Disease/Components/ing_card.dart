import 'package:adwiah/View/Disease/brandsByIng.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IngCard extends StatelessWidget {
  String? name, id;

  IngCard({this.name, this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
        child: InkWell(
          onTap: () {
            Get.to(() => BrandsByIngScreen(id, name));
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Color(0xff5c376d), width: 1.5)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          name!,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
