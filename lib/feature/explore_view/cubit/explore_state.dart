part of 'explore_cubit.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class BooksDownloaded extends ExploreState {}

class BooksDownloading extends ExploreState {}
