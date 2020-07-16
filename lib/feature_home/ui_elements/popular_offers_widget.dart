import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/localized_strings.dart';
import 'package:lykke_mobile_mavn/app/resources/text_styles.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/generic_list_bloc_output.dart';
import 'package:lykke_mobile_mavn/base/router/router.dart';
import 'package:lykke_mobile_mavn/feature_home/bloc/popular_offers_bloc.dart';
import 'package:lykke_mobile_mavn/feature_home/ui_elements/popular_offers_swiper.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/campaign_response_model.dart';
import 'package:lykke_mobile_mavn/library_bloc/core.dart';
import 'package:lykke_mobile_mavn/library_ui_components/misc/secondary_call_to_action.dart';

class PopularOffersWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final localizedStrings = useLocalizedStrings();
    final router = useRouter();

    final popularOffersListBloc = usePopularOffersListBloc();
    final popularOffersListState = useBlocState(popularOffersListBloc);

    final data = useState(<CampaignResponseModel>[]);
    final isErrorDismissed = useState(false);

    void loadData() {
      isErrorDismissed.value = false;
      popularOffersListBloc.getList();
    }

    loadData();

    if (popularOffersListState is GenericListLoadedState) {
      data.value = popularOffersListState.list;
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
                      style: TextStyles.popularOffers,
                      textAlign: TextAlign.start,
                    ),
                    SecondaryCallToActionClass(
                      onTap: router.switchToOffersTab,
                      text: localizedStrings.viewAll,
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: PopularOffersSwiper(
                  data: data.value,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Container();
  }
}
