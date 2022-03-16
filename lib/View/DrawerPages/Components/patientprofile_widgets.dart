import 'package:adwiah/widgets/accordion_widget.dart';
import 'package:flutter/material.dart';

class PatientProfileWidgets extends StatelessWidget {
  const PatientProfileWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccordionWidget(
          title: 'العربية',
          content: 'asdfqqwqfwfqwfas',
        ),
        AccordionWidget(
          title: 'English',
          content: 'asdfqqwqfwfqwfas',
        ),
      ],
    );
  }
}
