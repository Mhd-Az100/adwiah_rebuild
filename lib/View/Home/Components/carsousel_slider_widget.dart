import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Carosel extends StatefulWidget {
  final List imgList;
  final List<Widget> routesList;
  Carosel(this.imgList, this.routesList);
  @override
  _CaroselState createState() => _CaroselState();
}

class _CaroselState extends State<Carosel> {
  int _current = 0;
  List<Widget>? imageSliders;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageSliders = this
        .widget
        .imgList
        .map((item) => InkWell(
              onTap: () {
                Get.to(() => widget.routesList[_current]);
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.25 -
                    90 -
                    MediaQuery.of(context).padding.top,
                child: Image.asset(
                  item,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ))
        .toList();
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.32 -
          90 -
          MediaQuery.of(context).padding.top,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 0.8,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imageSliders,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList.map((url) {
              int index = widget.imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                      : const Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
