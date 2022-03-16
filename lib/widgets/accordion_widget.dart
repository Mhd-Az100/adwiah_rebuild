import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

class AccordionWidget extends StatelessWidget {
  AccordionWidget({Key? key, this.title, this.content}) : super(key: key);
  String? title;
  String? content;
  @override
  Widget build(BuildContext context) {
    return GFAccordion(
        collapsedTitleBackgroundColor: const Color(0xff5C376D),
        collapsedIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        contentBackgroundColor: Colors.transparent,
        titleChild: Center(
          child: Text(
            title!,
            style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
        titleBorderRadius: const BorderRadius.all(Radius.circular(10)),
        expandedTitleBackgroundColor: const Color(0xff5C376D),
        content: content);
  }
}
