import 'package:flutter/foundation.dart';
import 'package:lykke_mobile_mavn/library_bloc/core.dart';

abstract class AcceptLeadReferralState extends BlocState {}

class AcceptLeadReferralUninitializedState extends AcceptLeadReferralState {}

class AcceptLeadReferralLoadingState extends AcceptLeadReferralState {}

class AcceptLeadReferralSuccessState extends AcceptLeadReferralState {}

class AcceptLeadReferralErrorState extends AcceptLeadReferralState {
  AcceptLeadReferralErrorState({@required this.error});

  final String error;
}

class LeadReferralSubmissionStoredKey extends BlocEvent {}
