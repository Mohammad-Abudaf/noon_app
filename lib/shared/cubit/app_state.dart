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

class CategoriesLoadingScreenState extends AppState{}
class CategoriesSuccessScreenState extends AppState{}
class CategoriesScreenState extends AppState{
  final String error;
  CategoriesScreenState(this.error);
}

class ChangeFavoriteSuccess extends AppState{}
class ChangeFavoriteState extends AppState{
  final Favorite favorite;
  ChangeFavoriteState({this.favorite});
}
class ChangeFavoriteError extends AppState{
  final String error;
  ChangeFavoriteError(this.error);
}

class LoadingFavScreenState extends AppState{}
class SuccessFavSuccessScreenState  extends AppState{}
class ErrorFavScreenState extends AppState{
  final String error;
  ErrorFavScreenState(this.error);
}


class LoadingProfileScreenState extends AppState{}
class SuccessProfileSuccessScreenState  extends AppState{}
class ErrorProfileScreenState extends AppState{
  final String error;
  ErrorProfileScreenState(this.error);
}



