part of 'home_view_cubit.dart';

@immutable
abstract class HomeViewState {}

class HomeViewInitial extends HomeViewState {}

class HomeViewThemeChanged extends HomeViewState {}

class BooksLoaded extends HomeViewState {}

class BooksUnloaded extends HomeViewState {}
