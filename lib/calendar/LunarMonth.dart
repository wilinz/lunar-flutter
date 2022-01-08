import 'LunarYear.dart';
import 'NineStar.dart';
import 'Solar.dart';
import 'util/LunarUtil.dart';

/// 农历月
/// @author 6tail
class LunarMonth {
  /// 农历年
  int _year = 0;

  /// 农历月：1-12，闰月为负数，如闰2月为-2
  int _month = 0;

  /// 天数，大月30天，小月29天
  int _dayCount = 0;

  /// 初一的儒略日
  double _firstJulianDay = 0;

  LunarMonth(this._year, this._month, this._dayCount, this._firstJulianDay);

  static LunarMonth? fromYm(int lunarYear, int lunarMonth) {
    return LunarYear.fromYear(lunarYear).getMonth(lunarMonth);
  }

  int getYear() => _year;

  int getMonth() => _month;

  int getDayCount() => _dayCount;

  double getFirstJulianDay() => _firstJulianDay;

  bool isLeap() => _month < 0;

  String getPositionTaiSui() {
    String p;
    int m = _month.abs();
    switch (m) {
      case 1:
      case 5:
      case 9:
        p = '艮';
        break;
      case 3:
      case 7:
      case 11:
        p = '坤';
        break;
      case 4:
      case 8:
      case 12:
        p = '巽';
        break;
      default:
        p = LunarUtil.POSITION_GAN[Solar.fromJulianDay(this.getFirstJulianDay())
            .getLunar()
            .getMonthGanIndex()];
    }
    return p;
  }

  String getPositionTaiSuiDesc() =>
      LunarUtil.POSITION_DESC[getPositionTaiSui()]!;

  NineStar getNineStar() {
    int index = LunarYear.fromYear(_year).getZhiIndex() % 3;
    int m = _month.abs();
    int monthZhiIndex = (13 + m) % 12;
    int n = 27 - (index * 3);
    if (monthZhiIndex < LunarUtil.BASE_MONTH_ZHI_INDEX) {
      n -= 3;
    }
    int offset = (n - monthZhiIndex) % 9;
    return NineStar.fromIndex(offset);
  }

  @override
  String toString() {
    String month = LunarUtil.MONTH[_month.abs()];
    return '$_year年${isLeap() ? '闰' : ''}$month月($_dayCount)天';
  }
}
