import 'package:adwiah/Utils/storageController.dart';
import 'package:adwiah/View/Home/home.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class CarCountries extends StatelessWidget {
  CarCountries({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final InitialAppController controller;
  StorageHelperController storgctrl = Get.find<StorageHelperController>();
  int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                color: controller.countriesList[index].active!
                    ? const Color(0xff5C376D)
                    : const Color(0xff5C376D).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: context.diagonalInches >= 7
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.width,
              height:
                  50 + ((context.diagonalInches / 6.0).floorToDouble() * 20),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.countriesList[index].country!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  controller.countriesList[index].active!
                      ? Text('Last Update 3/8/2021',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.5)))
                      : Text(
                          'Data under updating ...',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.5)),
                        )
                ],
              ))),
        ),
      ),
      onTap: () async {
        if (controller.countriesList[index].active!) {
          await storgctrl.saveCountryId(
              controller.countriesList[index].countryId!.toString());
          storgctrl.readCountryId();
          Get.offAll(Home());
        }
      },
    );
  }
}
