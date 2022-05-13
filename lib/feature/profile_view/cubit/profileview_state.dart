part of 'profileview_cubit.dart';

@immutable
abstract class ProfileviewState {}

class ProfileviewInitial extends ProfileviewState {}

class RefreshPage extends ProfileviewState {}

class Loading extends ProfileviewState {}

class Loaded extends ProfileviewState {}
