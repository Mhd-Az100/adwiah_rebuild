import 'package:adwiah/Widgets/AlphaScroll/ViewModel/alphabet_view_model.dart';
import 'package:adwiah/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sized_context/sized_context.dart';

class IngredientsTopBar extends StatefulWidget {
  IngredientsTopBar({Key? key}) : super(key: key);
  @override
  _IngredientsTopBarState createState() => _IngredientsTopBarState();
}

class _IngredientsTopBarState extends State<IngredientsTopBar> {
  final searchController = TextEditingController();
  var byNameColor = const Color(0xff5C376D);
  var byNameTextColor = Colors.white;
  var byAtcColor = Colors.white;
  var byAtcTextColor = Colors.black;
  var activ = 'name';
  AlphaBetController ctrl = Get.find<AlphaBetController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            alignment: WrapAlignment.center,
            children: <Widget>[
              FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withAlpha(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GetBuilder<AlphaBetController>(
                          builder: (c) {
                            return MaterialButton(
                              minWidth: 130,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'By Name',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: byNameTextColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              height: 45 +
                                  ((context.diagonalInches / 6.0)
                                          .floorToDouble() *
                                      20),
                              onPressed: () {
                                setState(() {
                                  byNameColor = const Color(0xff5C376D);
                                  byNameTextColor = Colors.white;
                                  byAtcColor = Colors.white;
                                  byAtcTextColor = Colors.black;
                                  activ = 'name';
                                });
                                ctrl.sortbyname.value = true;
                              },
                              color: byNameColor,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          minWidth: 130,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: FittedBox(
                            child: Text(
                              'By Atc',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: byAtcTextColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          height: 45 +
                              ((context.diagonalInches / 6.0).floorToDouble() *
                                  20),
                          onPressed: () {
                            setState(() {
                              byNameColor = Colors.white;
                              byNameTextColor = Colors.black;
                              byAtcColor = const Color(0xff5C376D);
                              byAtcTextColor = Colors.white;
                              activ = 'atc';
                            });
                            ctrl.sortbyname.value = false;
                          },
                          color: byAtcColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SearchBar(
                searchController: searchController,
                // widget: widget
              ),
            ],
          ),
        ],
      ),
    );
  }
}
