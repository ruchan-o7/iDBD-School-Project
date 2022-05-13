import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'editorview_state.dart';

class EditorviewCubit extends Cubit<EditorviewState> {
  EditorviewCubit() : super(EditorviewInitial());
}
