import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'publisher_state.dart';

class PublisherCubit extends Cubit<PublisherState> {
  PublisherCubit() : super(PublisherInitial());
}
