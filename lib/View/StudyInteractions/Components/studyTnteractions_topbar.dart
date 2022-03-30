import 'package:adwiah/View/Initial/View_Model/initial_data_view_model.dart';
import 'package:adwiah/Widgets/AlphaScroll/ViewModel/alphabet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyInteractionsTopBar extends StatefulWidget {
  void Function()? onpressed;
  StudyInteractionsTopBar({this.onpressed, Key? key}) : super(key: key);
  @override
  _StudyInteractionsTopBarState createState() =>
      _StudyInteractionsTopBarState();
}

class _StudyInteractionsTopBarState extends State<StudyInteractionsTopBar> {
  final searchController = TextEditingController();
  var byNameColor = const Color(0xff5C376D);
  var byNameTextColor = Colors.white;
  var byAtcColor = Colors.white;
  var byAtcTextColor = Colors.black;
  AlphaBetController ctrl = Get.find<AlphaBetController>();
  InitialAppController controller = Get.find<InitialAppController>();
  @override
  void initState() {
    super.initState();
    ctrl.studyIngorTrand.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          alignment: WrapAlignment.center,
          children: <Widget>[
            FittedBox(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 130,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: byNameTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        height: 45,
                        onPressed: () {
                          setState(() {
                            byNameColor = const Color(0xff5C376D);
                            byNameTextColor = Colors.white;
                            byAtcColor = Colors.white;
                            byAtcTextColor = Colors.black;
                          });
                          ctrl.studyIngorTrand.value = true;
                          // this.widget.sortByName();
                        },
                        color: byNameColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      MaterialButton(
                        minWidth: 130,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: FittedBox(
                          child: Text(
                            'TradeNames',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: byAtcTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        height: 45,
                        onPressed: () {
                          setState(() {
                            byNameColor = Colors.white;
                            byNameTextColor = Colors.black;
                            byAtcColor = const Color(0xff5C376D);
                            byAtcTextColor = Colors.white;
                          });
                          ctrl.studyIngorTrand.value = false;
                          // this.widget.sortByAtc();
                        },
                        color: byAtcColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.search(
                        val: value,
                        brand: !ctrl.studyIngorTrand.value,
                      );
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xff1c2340), width: 2.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0)),
                        hintText: 'Search...'),
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: MaterialButton(
                    minWidth: 70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    onPressed: widget.onpressed,
                    color: const Color(0xff5C376D),
                    child: const Text(
                      'Study',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                // IconButton(icon: Icon(Icons.check_box_rounded
                // ,color:Color(0xffed5565),size: 40,
                // ), onPressed: ()=>this.widget.studyInteractions())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
