// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:adwiah/View/BrandsScreen/Components/brandCard.dart';
import 'package:adwiah/View/BrandsScreen/brands_view_model.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DrawerPages/drawer_view.dart';

class BrandsByBrandScreen extends StatelessWidget {
  final id, name;
  BrandsByBrandScreen(this.id, this.name, {Key? key}) : super(key: key);
  // var data = [];
  // List<Widget> subdata = [];

  // @override
  // void initState() {
  //   // initData();
  //   super.initState();
  // }

  // void initData() async {
  //   var token = await storage.read(key: 'token');
  //   var t = await getBrandByBrandId(hostUrl1, this.widget.id, token);
  //   setState(() {
  //     data = jsonDecode(t);
  //   });
  // }
  BrandsController ctrl = Get.find<BrandsController>();

  @override
  Widget build(BuildContext context) {
    ctrl.getbrandByI(id);
    ctrl.getindications(id);
    return Scaffold(
      backgroundColor: const Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(
            child: Header2(),
            height: 220,
          ),
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
            body: Column(
              children: [
                SizedBox(
                  height: 220 - MediaQuery.of(context).padding.top - 60,
                  child: Center(
                    child: FittedBox(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18)),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Center(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: Color(0xff1c2340),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ctrl.loadbrandByid.value
                              ? Column(
                                  children: [
                                    ListView.builder(
                                        itemCount: ctrl.brandByI.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, int index) {
                                          return BrandCard(
                                              ctrl.brandByI[index]);
                                        }),
                                  ],
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffed5565))),
                                ),
                        )),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Visibility(
              visible:
                  MediaQuery.of(context).viewInsets.bottom != 0 ? false : true,
              child: Container(
                  color: const Color(0Xfff5eded),
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: BottomControllBar(0))),
            ),
          ),
        ],
      ),
    );
  }
}
