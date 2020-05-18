import 'package:flutter/foundation.dart';
import 'package:lykke_mobile_mavn/library_bloc/core.dart';

abstract class AcceptHotelReferralState extends BlocState {}

class AcceptHotelReferralUninitializedState extends AcceptHotelReferralState {}

class AcceptHotelReferralLoadingState extends AcceptHotelReferralState {}

class AcceptHotelReferralSuccessState extends AcceptHotelReferralState {}

class AcceptHotelReferralErrorState extends AcceptHotelReferralState {
  AcceptHotelReferralErrorState({@required this.error});

  final String error;
}

class HotelReferralSubmissionStoredKey extends BlocEvent {}
