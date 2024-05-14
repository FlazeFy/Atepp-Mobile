import 'package:atepp/modules/helpers/converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TC-H-001 getUTCHourOffset from Converter - Hour must be valid', () {
    int hour = getUTCHourOffset();
    int min = -12;
    int max = 14;

    expect(hour, greaterThanOrEqualTo(min));
    expect(hour, lessThanOrEqualTo(max));
  });

  test(
      'TC-H-002 getDateToContext from Converter - All type with valid date (except tommorow or yesterday)',
      () {
    const yr = 2024;
    const mon = 11;
    const day = 11;
    const hr = 12;
    const min = 30;
    int timezone = getUTCHourOffset();

    DateTime datetime = DateTime(yr, mon, day, hr, min);

    expect(getDateToContext(datetime, "full"), "$yr/$mon/$day $hr:$min");
    expect(getDateToContext(datetime, "24h"), "$hr:$min");
    expect(getDateToContext(datetime, "12h"), "$hr:$min");
    expect(getDateToContext(datetime, "datetime"), "$yr/$mon/$day $hr:$min");
    expect(getDateToContext(datetime, "date"), "$yr-$mon-$day");
    expect(getDateToContext(datetime, "calendar"),
        "$yr-$mon-$day ${hr + timezone}:$min:00");
    expect(getDateToContext(datetime, "random"), "-");
  });
}
