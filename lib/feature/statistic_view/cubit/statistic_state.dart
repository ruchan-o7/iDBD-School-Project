part of 'statistic_cubit.dart';

@immutable
abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class StatsLoaded extends StatisticState {
  Map<String, dynamic> stats;
  List<String?> picUrlList;
  StatsLoaded({
    required this.stats,
    required this.picUrlList,
  });
}

class StatsLoading extends StatisticState {}
