import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profileview_state.dart';

class ProfileviewCubit extends Cubit<ProfileviewState> {
  ProfileviewCubit() : super(ProfileviewInitial());
}
