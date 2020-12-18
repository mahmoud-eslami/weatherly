part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class BottomSheetOpened extends HomeState {
  final bool openOpt;

  BottomSheetOpened({@required this.openOpt});

  @override
  List<Object> get props => [openOpt];

  @override
  String toString() {
    return 'BottomSheetOpened{openOpt: $openOpt}';
  }
}
