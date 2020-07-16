import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lykke_mobile_mavn/app/resources/color_styles.dart';
import 'package:lykke_mobile_mavn/feature_campaign_list/ui_components/campaign_widget.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/api/campaign/response_model/campaign_response_model.dart';

class PopularOffersSwiper extends HookWidget {
  const PopularOffersSwiper({
    this.data,
  });

  final List<CampaignResponseModel> data;
  static const int maxItemCount = 10;

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildCampaignWidgetList() {
      if (data != null && data.isNotEmpty) {
        final popularOffers =
            data.length > maxItemCount ? data.take(maxItemCount) : data;

        return popularOffers
            .map(
              (campaign) => CampaignWidget(
                title: campaign.name,
                imageUrl: campaign.imageUrl,
                price: campaign.price,
              ),
            )
            .toList();
      } else {
        return [];
      }
    }

    return Swiper.children(
      children: _buildCampaignWidgetList(),
      pagination: SwiperPagination(
        builder: LineSwiperPaginationBuilder(
          color: ColorStyles.grayNurse,
          activeColor: ColorStyles.resolutionBlue,
        ),
      ),
      loop: data.length >= 3,
      outer: true,
      viewportFraction: 0.7,
      scale: 0.8,
    );
  }
}

class LineSwiperPaginationBuilder extends SwiperPlugin {
  const LineSwiperPaginationBuilder({
    this.activeColor,
    this.color,
  });

  final Color activeColor;
  final Color color;

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    final themeData = Theme.of(context);
    final activeColor = this.activeColor ?? themeData.primaryColor;
    final color = this.color ?? themeData.scaffoldBackgroundColor;

    List<Widget> paginations = [];

    for (var i = 0; i < config.itemCount; i++) {
      paginations.add(
        Container(
          key: Key("pagination_$i"),
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: i == config.activeIndex ? activeColor : color,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            width: 20,
            height: 3,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: paginations,
    );
  }
}
