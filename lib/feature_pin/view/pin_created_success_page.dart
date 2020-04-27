import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/localized_strings.dart';
import 'package:lykke_mobile_mavn/app/resources/svg_assets.dart';
import 'package:lykke_mobile_mavn/base/router/router.dart';
import 'package:lykke_mobile_mavn/feature_utility/result_feedback/view/result_feedback_page.dart';

class PinCreatedSuccessPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final router = useRouter();
    return ResultFeedbackPage(
      widgetKey: const Key('pinCreatedSuccessWidget'),
      title: useLocalizedStrings().pinCreatedSuccessTitle,
      details: useLocalizedStrings().pinCreatedSuccessDetails,
      buttonText: useLocalizedStrings().getStartedButton,
      onButtonTap: router.navigateToLandingPage,
      endIcon: SvgAssets.success,
      hasLogo: true,
      hasBackButton: false,
    );
  }
}
