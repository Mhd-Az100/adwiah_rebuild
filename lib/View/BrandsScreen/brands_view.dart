import 'package:adwiah/View/BrandsScreen/brands_view_model.dart';
import 'package:adwiah/View/BrandsScreen/brandsbybrandScreen.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/alphabet_scoll_view.dart';
import 'package:adwiah/Widgets/bottombar.dart';
import 'package:adwiah/Widgets/card_list_search_widget.dart';
import 'package:adwiah/Widgets/header.dart';
import 'package:adwiah/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsScreen extends StatefulWidget {
  BrandsScreen({Key? key}) : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  InitialAppController controller = Get.find<InitialAppController>();
  BrandsController ctrl = Get.put(BrandsController());
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.onsearch.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(height: 250, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            drawer: NavDrawer(),
            body: Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text("Trade Names",
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: const TextStyle(fontSize: 24)),
                    // actions: <Widget>[BarcodeReader(mode: 1)],
                  ),
                  drawer: NavDrawer(),
                  body: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Stack(children: <Widget>[
                      Column(
                        children: <Widget>[
                          SearchBar(
                            searchController: searchController,
                            brand: true,
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Obx(() {
                            return controller.onsearch.value
                                ? (controller.listSearchBrand.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .listSearchBrand.length,
                                            itemBuilder: (context, index) {
                                              return CardListSearch(
                                                  ontap: () {
                                                    Get.to(BrandsByBrandScreen(
                                                        controller
                                                            .listSearchBrand[
                                                                index]
                                                            .brandId
                                                            .toString(),
                                                        controller
                                                            .listSearchBrand[
                                                                index]
                                                            .brandName!));
                                                  },
                                                  brand: controller
                                                      .listSearchBrand[index]);
                                            }),
                                      )
                                    : const Center(
                                        child: Text(
                                          'not found !',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'cairo',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ))
                                : Expanded(
                                    child: AlphabetScrollPage(
                                      brands: controller.brandList,
                                      className: "brands",
                                    ),
                                  );
                          })
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: BottomControllBar(0)),
          )
        ],
      ),
    );
  }
}
