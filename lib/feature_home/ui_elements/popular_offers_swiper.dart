import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lykke_mobile_mavn/app/resources/color_styles.dart';
import 'package:lykke_mobile_mavn/app/resources/localized_strings.dart';
import 'package:lykke_mobile_mavn/app/resources/text_styles.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/generic_details_bloc_state.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/campaign_response_model.dart';
import 'package:lykke_mobile_mavn/base/router/router.dart';
import 'package:lykke_mobile_mavn/feature_campaign_list/bloc/campaign_list_bloc.dart';
import 'package:lykke_mobile_mavn/feature_campaign_list/ui_components/campaign_widget.dart';
import 'package:lykke_mobile_mavn/feature_home/bloc/campaign_of_day_bloc.dart';
import 'package:lykke_mobile_mavn/library_bloc/core.dart';
import 'package:lykke_mobile_mavn/library_models/fiat_currency.dart';

class PopularOffersSwiper extends HookWidget {
  static const campaignOfDayHeight = 140.0;

  @override
  Widget build(BuildContext context) {
    final localizedStrings = useLocalizedStrings();
    final router = useRouter();

    // final campaignListBloc = useCampaignListBloc();
    // final campaignListBlocState = useBlocState(campaignListBloc);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    localizedStrings.popularOffers,
                    style: TextStyles.darkHeadersH3,
                    textAlign: TextAlign.start,
                  ),
                  InkWell(
                    onTap: () => print(''),
                    child: Text(
                      localizedStrings.viewAll,
                      textAlign: TextAlign.end,
                      style: TextStyles.transactionHistoryAmount,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Swiper.children(
                children: <Widget>[
                  CampaignWidget(
                    title: "Test name",
                    imageUrl: '',
                    price: FiatCurrency(value: 20, assetSymbol: ''),
                  ),
                  CampaignWidget(
                    title: "Test name",
                    imageUrl: '',
                    price: FiatCurrency(value: 20, assetSymbol: ''),
                  ),
                  CampaignWidget(
                    title: "Test name",
                    imageUrl: '',
                    price: FiatCurrency(value: 20, assetSymbol: ''),
                  ),
                  // CampaignWidget(
                  //   title: campaign.name,
                  //   imageUrl: campaign.imageUrl,
                  //   price: campaign.price,
                  // ),
                  // CampaignWidget(
                  //   title: campaign.name,
                  //   imageUrl: campaign.imageUrl,
                  //   price: campaign.price,
                  // ),
                  // CampaignWidget(
                  //   title: campaign.name,
                  //   imageUrl: campaign.imageUrl,
                  //   price: campaign.price,
                  // ),
                ],
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: ColorStyles.grayNurse,
                    activeColor: ColorStyles.resolutionBlue,
                  ),
                ),
                loop: true,
                outer: false,
                viewportFraction:
                    0.8, // affects whether current item occupies full view
                scale: 0.9, // affects space between items
                // fade: 0.75, // fade non-current items
              ),
            ),
          ],
        ),
      ],
    );
    // }
    // return Container();
  }
}
