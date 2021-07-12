part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeBottomNavBarScreen extends AppState{}

class HomeLoadingScreenState extends AppState{}
class HomeSuccessScreenState extends AppState{}
class HomeErrorScreenState extends AppState{
  final String error;
  HomeErrorScreenState(this.error);
}
