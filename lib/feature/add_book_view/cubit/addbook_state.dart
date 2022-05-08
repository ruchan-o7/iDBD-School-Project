part of 'addbook_cubit.dart';

@immutable
abstract class AddbookState {}

class AddbookInitial extends AddbookState {}

class ImageUploaded extends AddbookState {
  File image;
  ImageUploaded({
    required this.image,
  });
}

class DateChanged extends AddbookState {}

class RefreshPage extends AddbookState {}
