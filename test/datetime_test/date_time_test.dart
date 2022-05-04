import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  test('Week of Year', () {
    int numOfWeeks(int year) {
      DateTime _dateTime = DateTime.now();
      return _dateTime.weekday;
    }

    numOfWeeks(2022);
  });
}


//year and month