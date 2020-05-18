import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/localized_strings.dart';
import 'package:lykke_mobile_mavn/app/resources/svg_assets.dart';
import 'package:lykke_mobile_mavn/base/common_use_cases/get_mobile_settings_use_case.dart';
import 'package:lykke_mobile_mavn/base/router/router.dart';
import 'package:lykke_mobile_mavn/feature_utility/result_feedback/view/result_feedback_page.dart';

class PropertyPaymentSuccessPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tokenSymbol =
        useState(useGetMobileSettingsUseCase(context).execute()?.tokenSymbol);
    final router = useRouter();
    return ResultFeedbackPage(
      widgetKey: const Key('propertyPaymentSuccessWidget'),
      title: LocalizedStrings.transferInProgress,
      details: LocalizedStrings.transferInProgressDetails(tokenSymbol.value),
      buttonText: LocalizedStrings.goToWallet,
      onButtonTap: router.popToRoot,
      endIcon: SvgAssets.success,
    );
  }
}
