import 'package:adwiah/Widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

typedef callBackWithString = Function(String val);
typedef callBackWithList = Function();

class IngredientsTopBar extends StatefulWidget {
  final callBackWithString callback;
  final callBackWithList sortByAtc;
  final callBackWithList sortByName;
  final byNameText, byAtcText;

  IngredientsTopBar(this.callback, this.sortByAtc, this.sortByName,
      {this.byNameText = 'By Name', this.byAtcText = 'By Atc'});
  @override
  _IngredientsTopBarState createState() => _IngredientsTopBarState();
}

class _IngredientsTopBarState extends State<IngredientsTopBar> {
  final searchController = TextEditingController();
  var byNameColor = Color(0xff5C376D);
  var byNameTextColor = Colors.white;
  var byAtcColor = Colors.white;
  var byAtcTextColor = Colors.black;
  var activ = 'name';
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
                        MaterialButton(
                          minWidth: 130,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: FittedBox(
                            child: Text(
                              this.widget.byNameText,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: byNameTextColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          height: 45 +
                              ((context.diagonalInches / 6.0).floorToDouble() *
                                  20),
                          onPressed: () {
                            setState(() {
                              byNameColor = Color(0xff5C376D);
                              byNameTextColor = Colors.white;
                              byAtcColor = Colors.white;
                              byAtcTextColor = Colors.black;
                              activ = 'name';
                            });
                            this.widget.sortByName();
                          },
                          color: byNameColor,
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
                              this.widget.byAtcText,
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
                              byAtcColor = Color(0xff5C376D);
                              byAtcTextColor = Colors.white;
                              activ = 'atc';
                            });
                            this.widget.sortByAtc();
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
