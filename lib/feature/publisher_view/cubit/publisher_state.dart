part of 'publisher_cubit.dart';

@immutable
abstract class PublisherState {}

class PublisherInitial extends PublisherState {}

class DataFetching extends PublisherState {}

class DataFetched extends PublisherState {
  PublisherUser? currentUser;
  DataFetched({
    this.currentUser,
  });
}
