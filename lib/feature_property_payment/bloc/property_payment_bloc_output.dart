import 'package:lykke_mobile_mavn/library_bloc/core.dart';

abstract class PropertyPaymentState extends BlocState {}

class PropertyPaymentUninitializedState extends PropertyPaymentState {}

class PropertyPaymentLoadingState extends PropertyPaymentState {}

class PropertyPaymentErrorState extends PropertyPaymentState {
  PropertyPaymentErrorState(this.error);

  final String error;

  @override
  List get props => super.props..addAll([error]);
}

class PropertyPaymentInlineErrorState extends PropertyPaymentState {
  PropertyPaymentInlineErrorState(this.error);

  final String error;

  @override
  List get props => super.props..addAll([error]);
}

class PropertyPaymentSuccessEvent extends BlocEvent {}

class PropertyPaymentWalletDisabledEvent extends BlocEvent {}
