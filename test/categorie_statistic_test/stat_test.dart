import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, dynamic> _data;
  setUp(() {
    _data = {
      "history": {"asd": "asdasda", "asdasd": "dsadasd"},
      "fiction": {"asdasdasd": "asdasdas", "asdasdasds": "asdasd"}
    };
  });
  test('Sample Test', () {
    Map<String, dynamic> _temp = {};
    final list = List.from(_data.keys);
    for (var i = 0; i < _data.values.length; i++) {
      _temp[list[i]] = _data.values.length;
    }
    // print(_temp);
    // print(_temp["history"]);
  });

  test(
    "print keys",
    () {
      // print(_data.keys.elementAt(0));
      // print(_data.values.elementAt(0));
    },
  );
}
