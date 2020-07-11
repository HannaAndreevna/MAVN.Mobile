import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/color_styles.dart';
import 'package:lykke_mobile_mavn/app/resources/image_assets.dart';
import 'package:lykke_mobile_mavn/app/resources/localized_strings.dart';
import 'package:lykke_mobile_mavn/app/resources/text_styles.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/base_bloc_output.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/earn_rule_list_bloc.dart';
import 'package:lykke_mobile_mavn/base/common_blocs/generic_list_bloc_output.dart';
import 'package:lykke_mobile_mavn/base/constants/bottom_bar_navigation_constants.dart';
import 'package:lykke_mobile_mavn/base/router/router.dart';
import 'package:lykke_mobile_mavn/feature_balance/bloc/balance/balance_bloc.dart';
import 'package:lykke_mobile_mavn/feature_bottom_bar/bloc/bottom_bar_page_bloc.dart';
import 'package:lykke_mobile_mavn/feature_bottom_bar/bloc/bottom_bar_refresh_bloc_output.dart';
import 'package:lykke_mobile_mavn/feature_home/ui_elements/home_sliver_widget.dart';
import 'package:lykke_mobile_mavn/feature_home/ui_elements/popular_offers_swiper.dart';
import 'package:lykke_mobile_mavn/feature_home/ui_elements/shortcut/home_shortcut_carousel.dart';
import 'package:lykke_mobile_mavn/feature_home/view/earn_token_section.dart';
import 'package:lykke_mobile_mavn/feature_notification/bloc/notification_count_bloc.dart';
import 'package:lykke_mobile_mavn/feature_notification/bloc/notification_mark_as_read_bloc.dart';
import 'package:lykke_mobile_mavn/feature_notification/ui_components/notification_icon_widget.dart';
import 'package:lykke_mobile_mavn/library_bloc/core.dart';
import 'package:lykke_mobile_mavn/library_custom_hooks/scroll_controller_hook.dart';
import 'package:lykke_mobile_mavn/library_custom_hooks/throttling_hook.dart';
import 'package:lykke_mobile_mavn/library_fcm/bloc/firebase_messaging_bloc.dart';
import 'package:lykke_mobile_mavn/library_fcm/bloc/firebase_messaging_bloc_output.dart';
import 'package:lykke_mobile_mavn/library_ui_components/error/generic_error_widget.dart';
import 'package:lykke_mobile_mavn/library_ui_components/error/network_error.dart';
import 'package:lykke_mobile_mavn/library_ui_components/misc/spinner.dart';

class HomePage extends HookWidget {
  static const double _sliverImageSize = 200;

  @override
  Widget build(BuildContext context) {
    final localizedStrings = useLocalizedStrings();

    final balanceBloc = useBalanceBloc();
    final earnRuleListBloc = useEarnRuleListBloc();
    final earnRuleListState = useBlocState<GenericListState>(earnRuleListBloc);
    final firebaseMessagingBloc = useFirebaseMessagingBloc();
    final notificationCountBloc = useNotificationCountBloc();
    final notificationCountState = useBlocState(notificationCountBloc);
    final notificationMarkAsReadBloc = useNotificationMarkAsReadBloc();
    final bottomBarPageBloc = useBottomBarPageBloc();
    final throttler = useThrottling(duration: const Duration(seconds: 30));
    final scrollController = useScrollController();

    final router = useRouter();

    void loadPageData() {
      earnRuleListBloc.getList();
      notificationCountBloc.getUnreadNotificationCount();
    }

    void onErrorRetry() {
      loadPageData();
      balanceBloc.retry();
    }

    useBlocEventListener(balanceBloc, (event) {
      if (event is BalanceUpdatedEvent &&
          earnRuleListState is GenericListErrorState) {
        loadPageData();
      }
    });

    useBlocEventListener(bottomBarPageBloc, (event) {
      if (event is BottomBarRefreshEvent &&
          event.index == BottomBarNavigationConstants.homePageIndex) {
        throttler.throttle(loadPageData);
      }
    });

    useBlocEventListener(firebaseMessagingBloc, (event) {
      if (event is FirebaseMessagingNotificationPendingEvent) {
        notificationCountBloc.getUnreadNotificationCount();
      } else if (event is FirebaseMessagingMarkAsReadEvent) {
        notificationMarkAsReadBloc.markAsRead(event.messageGroupId);
      }
    });

    useEffect(
      () {
        loadPageData();
      },
      [earnRuleListBloc],
    );

    final isNetworkError = [
      earnRuleListState,
      notificationCountState,
    ].any((state) => state is BaseNetworkErrorState);

    final isGenericError = [
      earnRuleListState,
    ].any((state) => state is BaseErrorState);

    final isLoading = [
      earnRuleListState,
    ].every((state) => state is BaseLoadingState);

    return Scaffold(
      backgroundColor: ColorStyles.alabaster,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, isScrolling) => [
                SliverAppBar(
                  title: Text(
                    localizedStrings.bottomBarExplore,
                    style: TextStyles.lightHeaderTitle,
                  ),
                  brightness: Brightness.dark,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorStyles.white,
                  elevation: 0,
                  expandedHeight: _sliverImageSize,
                  floating: false,
                  pinned: true,
                  actions: <Widget>[
                    IconButton(
                      tooltip: localizedStrings.notifications,
                      icon: NotificationIconWidget(
                        color: ColorStyles.white,
                      ),
                      onPressed: () {
                        router.pushNotificationListPage();
                        notificationCountBloc.markAsSeen();
                      },
                    ),
                  ],
                  flexibleSpace: Container(
                    color: ColorStyles.salmon,
                    child: FlexibleSpaceBar(
                      background: Image(
                        image: AssetImage(ImageAssets.backgroundFoodItems),
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    if (!isLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: _buildBody(
                          router,
                          isNetworkError,
                          isGenericError,
                          onErrorRetry,
                          earnRuleListState,
                        ),
                      )
                    else
                      Container(),
                    if (isLoading) _buildLoading(),
                  ],
                ),
              ),
            ),
            _buildSliverWidget(context, scrollController)
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    Router router,
    bool isNetworkError,
    bool isGenericError,
    VoidCallback onErrorRetry,
    GenericListState earnRuleListState,
  ) {
    if (isNetworkError) {
      return _buildNetworkError(onErrorRetry);
    }

    if (isGenericError) {
      return _buildGenericError(onErrorRetry);
    }

    return _buildLoadedContent(
      router,
      earnRuleListState,
      onErrorRetry,
    );
  }

  Widget _buildLoadedContent(
    Router router,
    GenericListState earnRuleListState,
    VoidCallback onErrorRetry,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PopularOffersSwiper(),
          HomeShortcutCarouselWidget(earnRuleListState: earnRuleListState),
          const SizedBox(height: 24),
          EarnTokenSection(
            earnRuleListState: earnRuleListState,
            router: router,
            onRetryTap: onErrorRetry,
          )
        ],
      );

  Widget _buildSliverWidget(
      BuildContext context, ScrollController scrollController) {
    //starting widget position
    final defaultTopMargin =
        _sliverImageSize + MediaQuery.of(context).padding.top - 150.0;
    //pixels from top where opacity change should start
    final opacityChangeStart = defaultTopMargin / 2;
    //pixels from top where opacity change should end
    final opacityChangeEnd = opacityChangeStart / 2;

    var top = defaultTopMargin;
    var opacity = 1.0;
    if (scrollController.hasClients) {
      final offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - opacityChangeStart) {
        //offset small => don't decrease opacity
        opacity = 1;
      } else if (offset < defaultTopMargin - opacityChangeEnd) {
        //opacityChangeStart < offset> opacityChangeEnd => decrease opacity
        opacity =
            (defaultTopMargin - opacityChangeEnd - offset) / opacityChangeEnd;
      } else {
        //offset passed opacityChangeEnd => hide widget
        opacity = 0;
      }
    }
    final availableWidth = MediaQuery.of(context).size.width;

    final width = availableWidth - (2 * 24);
    return Positioned(
      top: top + 24,
      left: 24,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: width,
          child: HomeSliverWidget(),
        ),
      ),
    );
  }

  Widget _buildLoading() => const SafeArea(child: Center(child: Spinner()));

  Widget _buildGenericError(VoidCallback onRetryTap) =>
      GenericErrorWidget(onRetryTap: onRetryTap);

  Widget _buildNetworkError(VoidCallback reload) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: NetworkErrorWidget(
            onRetry: reload,
          ),
        ),
      );
}
