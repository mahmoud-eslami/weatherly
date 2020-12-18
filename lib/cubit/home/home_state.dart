part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class BottomSheetOpened extends HomeState {
  final HomeDimsModel homeDimsModel;

  BottomSheetOpened({@required this.homeDimsModel});

  @override
  String toString() {
    return 'BottomSheetOpened{homeDimsModel: $homeDimsModel}';
  }

  @override
  List<Object> get props => [homeDimsModel];
}
