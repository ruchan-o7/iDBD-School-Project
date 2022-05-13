import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'changepass_state.dart';

class ChangepassCubit extends Cubit<ChangepassState> {
  ChangepassCubit() : super(ChangepassInitial());
}
