import 'package:flutter/material.dart';
import 'package:lykke_mobile_mavn/app/resources/text_styles.dart';

class SecondaryCallToActionClass extends StatelessWidget {
  const SecondaryCallToActionClass({@required this.text, @required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.end,
          style: TextStyles.secondaryCallToAction,
        ),
      );
}
