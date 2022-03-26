// ignore_for_file: prefer_const_constructors

import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/View/Disease/brandsByIng.dart';
import 'package:adwiah/Widgets/FloatingButton/ViewModel/floating_button_view_model_view.dart';
import 'package:adwiah/Widgets/FloatingButton/alternative_trade_names_view.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFloatingButton extends StatefulWidget {
  final Function()? onPressed;
  final String? tooltip;
  final IconData? icon;
  final id;
  final String? name;
  final mode;
  BrandByIdModel? details;

  CustomFloatingButton(
      {this.id = 0,
      this.name,
      this.onPressed,
      this.tooltip,
      this.icon,
      this.mode = 0,
      this.details});

  @override
  _CustomFloatingButtonState createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController? _animationController;
  Animation<Color?>? _buttonColor;
  Animation<double>? _animateIcon;
  Animation<double>? _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 50.0;
  AnimateIconController controller = AnimateIconController();
  FloatingButtonController ctrl = Get.put(FloatingButtonController());
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    _buttonColor = ColorTween(
      begin: Color(0xff5C376D),
      end: Colors.deepPurple,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.0,
        1,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  animate() {
    print(_translateButton!.value);
    widget.onPressed!();
    if (!isOpened) {
      _animationController?.forward();
      controller.animateToEnd();
    } else {
      _animationController?.reverse();
      controller.animateToStart();
    }
    isOpened = !isOpened;
  }

  Widget franceData() {
    return FittedBox(
      child: Row(
        children: [
          isOpened
              ? Material(
                  color: Colors.black.withOpacity(0),
                  child: Text(
                    this.widget.mode != 0 ? 'French Data ' : ' ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
                elevation: 0.0,
                highlightElevation: 0.0,
                hoverElevation: 0.0,
                focusElevation: 0.0,
                disabledElevation: 0.0,
                backgroundColor: Color(0xff5C376D),
                heroTag: "btn4",
                onPressed: () {
                  animate();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => WebViewData()));
                },
                child: Image(
                  image: AssetImage(
                    'assets/img/france.png',
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget equaltradenames() {
    return FittedBox(
      child: Row(
        children: [
          isOpened
              ? Material(
                  color: Colors.black.withOpacity(0),
                  child: Text(
                    widget.mode != 0 ? 'Equal Trade Names ' : 'Trade Names ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              focusElevation: 0.0,
              disabledElevation: 0.0,
              backgroundColor: Color(0xff5C376D),
              heroTag: "btn4",
              onPressed: () {
                animate();
                if (widget.mode == 0) {
                  Get.to(() => BrandsByIngScreen(widget.id, widget.name));
                } else {
                  Get.to(() => AlternativeBrandsScreen(widget.details!));
                }
              },
              child: ImageIcon(
                AssetImage(
                  'assets/img/trade-names.png',
                ),
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget interactions() {
    return FittedBox(
      child: Row(
        children: [
          isOpened
              ? Material(
                  color: Colors.black.withOpacity(0),
                  child: Text(
                    'Interactions ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              focusElevation: 0.0,
              disabledElevation: 0.0,
              backgroundColor: Color(0xff5C376D),
              heroTag: "btn3",
              onPressed: () {
                animate();
                var id = widget.id;
                if (widget.mode == 0)
                  ;
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => GetInteractions([
                //               {"ID": id, "Name": widget.name}
                //             ], widget.id, widget.mode)));
                else
                  ;
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => GetInteractions(
                //               widget.details,
                //               widget.id,
                //               1,
                //             )));
              },
              child: ImageIcon(
                AssetImage(
                  'assets/img/15.png',
                ),
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dosage() {
    return FittedBox(
      child: Row(
        children: [
          isOpened
              ? Material(
                  color: Colors.black.withOpacity(0),
                  child: Text(
                    'Dosage ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              focusElevation: 0.0,
              disabledElevation: 0.0,
              backgroundColor: Color(0xff5C376D),
              heroTag: "btn2",
              onPressed: () {
                animate();
                if (widget.mode == 0)
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => DosageScreen(
                  //               this.widget.id,
                  //               mode: 0,
                  //               name: this.widget.name,
                  //               phaForm: '',
                  //             )));
                  ;
                else
                  ;
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => DosageScreen(
                //               this.widget.details[0]['Brand_ID'],
                //               route: this.widget.details[0]['Route'],
                //               dosageForm: this.widget.details[0]
                //                   ['DosageForm'],
                //               name: this.widget.details[0]['Brand_Name'],
                //               phaForm: this.widget.details[0]
                //                   ['Pharmaceutical_Form'],
                //               mode: 1,
                //             )));
              },
              child: ImageIcon(
                AssetImage(
                  'assets/img/17.png',
                ),
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget monogrph() {
    return FittedBox(
      child: Row(
        children: [
          isOpened
              ? Material(
                  color: Colors.black.withOpacity(0),
                  child: Text(
                    'Monograph ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              elevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              focusElevation: 0.0,
              disabledElevation: 0.0,
              backgroundColor: Color(0xff5C376D),
              heroTag: "btn1",
              onPressed: () {
                animate();
                if (widget.mode == 0)
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             MonographScreen(widget.id)));
                  ;
                else
                  ;
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => MonographScreen(
                //               widget.details[0]['Ing_ID'],
                //               name: this
                //                   .widget
                //                   .details[0]["Brand_Name"]
                //                   .toString()
                //                   .toUpperCase(),
                //               pha: widget.details[0]
                //                   ['Pharmaceutical_Form'],
                //               mode: 1,
                //             )));
              },
              child: ImageIcon(
                AssetImage(
                  'assets/img/7.png',
                ),
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toggle() {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
          elevation: 0.0,
          highlightElevation: 0.0,
          hoverElevation: 0.0,
          focusElevation: 0.0,
          disabledElevation: 0.0,
          heroTag: "primary",
          backgroundColor: _buttonColor?.value,
          onPressed: animate,
          tooltip: 'Toggle',
          child: AnimateIcons(
            controller: controller,
            startIcon: Icons.add,
            endIcon: Icons.close,
            onStartIconPress: () {
              print("Clicked on Add Icon");
              animate();
              return true;
            },
            onEndIconPress: () {
              print("Clicked on Close Icon");
              animate();
              return true;
            },
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            duration: Duration(milliseconds: 500),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton!.value * 6.0,
            0.0,
          ),
          child: SizedBox(
            height: 56,
            width: 56,
          ),
        ),
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value * 5.0,
        //     0.0,
        //   ),
        //   child: widget.mode != 0 ? franceData() : SizedBox(),
        // ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton!.value * 4.0,
            0.0,
          ),
          child: equaltradenames(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton!.value * 3.0,
            0.0,
          ),
          child: monogrph(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton!.value * 2.0,
            0.0,
          ),
          child: dosage(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton!.value,
            0.0,
          ),
          child: interactions(),
        ),
        toggle(),
      ],
    );
  }
}

class LangChangeFloatingButton extends StatefulWidget {
  Function()? onPressed;
  List<Widget>? childrens = [];
  LangChangeFloatingButton({Key? key, childrens, onPressed}) : super(key: key);
  // LangChangeFloatingButton({this.childrens,this.onPressed});

  @override
  State<StatefulWidget> createState() => LangChangeFloatingButtonState();
}

class LangChangeFloatingButtonState extends State<LangChangeFloatingButton>
    with SingleTickerProviderStateMixin {
  List<Widget> childrens = [];
  bool isOpened = false;
  AnimationController? _animationController;
  Animation<Color>? _buttonColor;
  Animation<double>? _animateIcon;
  Animation<double>? _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 50.0;
  AnimateIconController controller = AnimateIconController();

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    _buttonColor = ColorTween(
      begin: Color(0xff5C376D),
      end: Colors.deepPurple,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    )) as Animation<Color>?;
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.0,
        1,
        curve: _curve,
      ),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void initData() {
    childrens = [];
    var i = widget.childrens!.length * 1.0;
    childrens.add(
      Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton!.value * i,
          0.0,
        ),
        child: SizedBox(
          height: 56,
          width: 56,
        ),
      ),
    );
    widget.childrens?.forEach((element) {
      childrens.add(Transform(
        transform: Matrix4.translationValues(
          0.0,
          _translateButton!.value * i,
          0.0,
        ),
        child: InkWell(
          child: element,
          onTap: () {
            animate();
          },
        ),
      ));
      i = i - 1.0;
    });
    childrens.add(toggle());
  }

  animate() {
    setState(() {
      print(_translateButton!.value);
      widget.onPressed!();
      if (!isOpened) {
        _animationController?.forward();
        controller.animateToStart();
      } else {
        _animationController?.reverse();
        controller.animateToEnd();
      }
      isOpened = !isOpened;
    });
  }

  Widget toggle() {
    return SizedBox(
      height: 50,
      width: 50,
      child: FloatingActionButton(
          elevation: 0.0,
          highlightElevation: 0.0,
          hoverElevation: 0.0,
          focusElevation: 0.0,
          disabledElevation: 0.0,
          heroTag: "primary",
          backgroundColor: _buttonColor!.value,
          onPressed: animate,
          tooltip: 'Toggle',
          child: AnimateIcons(
            controller: controller,
            startIcon: Icons.language_outlined,
            endIcon: Icons.close,
            onStartIconPress: () {
              print("Clicked on Add Icon");
              animate();
              return true;
            },
            onEndIconPress: () {
              print("Clicked on Close Icon");
              animate();
              return true;
            },
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            duration: Duration(milliseconds: 500),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: childrens);
  }
}
