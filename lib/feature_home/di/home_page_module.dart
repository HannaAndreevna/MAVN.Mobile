import 'package:lykke_mobile_mavn/feature_home/bloc/campaign_of_day_bloc.dart';
import 'package:lykke_mobile_mavn/feature_home/bloc/expiring_voucher_bloc.dart';
import 'package:lykke_mobile_mavn/feature_home/bloc/pending_voucher_bloc.dart';
import 'package:lykke_mobile_mavn/feature_home/bloc/popular_offers_bloc.dart';
import 'package:lykke_mobile_mavn/library_dependency_injection/core.dart';

class HomePageModule extends Module {
  PendingVoucherBloc get pendingVoucherBloc => get();
  ExpiringVoucherBloc get expiringVoucherBloc => get();
  CampaignOfDayBloc get campaignOfDayBloc => get();
  PopularOffersBloc get popularOffersBloc => get();

  @override
  void provideInstances() {
    provideSingleton(() => PendingVoucherBloc(get()));
    provideSingleton(() => ExpiringVoucherBloc(get()));
    provideSingleton(() => CampaignOfDayBloc(get()));
    provideSingleton(() => PopularOffersBloc(get()));
  }
}
