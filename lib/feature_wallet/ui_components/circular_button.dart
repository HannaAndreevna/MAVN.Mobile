import 'package:flutter/material.dart';
import 'package:lykke_mobile_mavn/app/resources/app_theme.dart';
import 'package:lykke_mobile_mavn/app/resources/text_styles.dart';
import 'package:lykke_mobile_mavn/feature_notification/ui_components/badge_widget.dart';
import 'package:lykke_mobile_mavn/library_ui_components/misc/scaled_down_svg.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    @required this.onTap,
    @required this.asset,
    @required this.text,
    @required this.theme,
    this.hasBadge = false,
    Key key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String asset;
  final BaseAppTheme theme;
  final String text;
  final bool hasBadge;

  @override
  Widget build(BuildContext context) => Stack(children: [
        Column(
          children: <Widget>[
            Material(
              child: Ink(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: theme.walletButtonsBorder, width: 2),
                  color: theme.walletButtonsBackground,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    height: 45,
                    width: 45,
                    child: ScaledDownSvg(
                      asset: asset,
                      color: theme.walletButtonsIcon,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: TextStyles.darkBodyBody4Regular,
            )
          ],
        ),
        if (hasBadge) _buildBadge(),
      ]);

  Widget _buildBadge() => Positioned(
        right: 1,
        top: 4,
        child: BadgeWidget(color: theme.appBarBubble),
      );
}
