import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        IconButton(
            onPressed: () async {},
            icon: const FaIcon(
              FontAwesomeIcons.facebook,
            )),
        IconButton(
            onPressed: () async {},
            icon: const Icon(FontAwesomeIcons.instagram)),
        IconButton(
            onPressed: () async {},
            icon: const Icon(
              FontAwesomeIcons.telegram,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.youtube,
            )),
      ],
    );
  }
}
