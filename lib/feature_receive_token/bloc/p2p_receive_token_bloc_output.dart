import 'package:lykke_mobile_mavn/library_bloc/core.dart';
import 'package:meta/meta.dart';

abstract class ReceiveTokenPageState extends BlocState {}

class ReceiveTokenPageUninitializedState extends ReceiveTokenPageState {}

class ReceiveTokenPageLoadingState extends ReceiveTokenPageState {}

class ReceiveTokenPageErrorState extends ReceiveTokenPageState {
  ReceiveTokenPageErrorState({
    @required this.errorTitle,
    @required this.errorSubtitle,
    @required this.iconAsset,
  });

  final String errorTitle;
  final String errorSubtitle;
  final String iconAsset;

  @override
  List get props => super.props..addAll([errorTitle, errorSubtitle, iconAsset]);
}

class ReceiveTokenPageSuccess extends ReceiveTokenPageState {
  ReceiveTokenPageSuccess(this.email);

  final String email;
}
