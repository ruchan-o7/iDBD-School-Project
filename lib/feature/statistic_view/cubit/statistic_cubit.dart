import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticInitial());
}
