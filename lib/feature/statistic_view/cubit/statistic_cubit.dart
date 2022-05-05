import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_project_ibdb/core/network/network_manager.dart';
import 'package:school_project_ibdb/feature/search_view/service/search_book_service.dart';
import 'package:school_project_ibdb/product/base_model/book_response_mode.dart';
import 'package:school_project_ibdb/product/utils/firebase/firestore_func.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  StatisticCubit() : super(StatisticInitial()) {
    getData();
  }
  final SearchBookService _service = SearchBookService(NetworkManager.instance);
  final FirestoreFunctions _functions = FirestoreFunctions();
  late Map<String, dynamic> stats;
  List<String?> picUrlList = [];
  getData() async {
    emit(StatsLoading());
    stats = await _functions.getStatistics();
    await spreadCateNames(stats);
    emit(StatsLoaded(stats: stats, picUrlList: picUrlList));
  }

  spreadCateNames(Map<String, dynamic> data) async {
    for (var i = 0; i < data.keys.length; i++) {
      await getPictureEachCategories(data.keys.elementAt(i));
    }
  }

  getPictureEachCategories(String cateName) async {
    // final _random = Random();
    final BookResponseModel? _temp = await _service.randomSearchWithCategories(cateName);
    if (_temp?.kind != null) {
      picUrlList.add(_temp?.items?.first.volumeInfo?.imageLinks?.thumbnail ?? "");
    }
  }
}
