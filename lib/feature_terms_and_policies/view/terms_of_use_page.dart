import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/localized_strings.dart';
import 'package:lykke_mobile_mavn/app/resources/svg_assets.dart';
import 'package:lykke_mobile_mavn/base/common_use_cases/get_mobile_settings_use_case.dart';
import 'package:lykke_mobile_mavn/feature_terms_and_policies/view/titled_web_page.dart';

class TermsOfUsePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final getMobileSettingsUseCase = useGetMobileSettingsUseCase(context);
    final privacyAndTermsUrl =
        useState<String>(getMobileSettingsUseCase.execute()?.termsOfUseUrl);
    return TitledWebPage(
      url: privacyAndTermsUrl.value,
      title: LocalizedStrings.termsOfUse,
      asset: SvgAssets.settingsTerms,
    );
  }
}
