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

class BottomNavigationOpened extends HomeState {
  final double height;
  final double sunsetPosition;

  BottomNavigationOpened(
      {@required this.sunsetPosition, @required this.height});

  @override
  String toString() {
    return 'BottomNavigationOpened{height: $height}';
  }

  @override
  List<Object> get props => [height];
}
