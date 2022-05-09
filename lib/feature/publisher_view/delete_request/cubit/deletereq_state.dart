part of 'deletereq_cubit.dart';

@immutable
abstract class DeletereqState {}

class DeletereqInitial extends DeletereqState {}

class LoadingState extends DeletereqState {}

class DataFetched extends DeletereqState {}
