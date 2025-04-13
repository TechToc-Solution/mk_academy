import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:no_screenshot/no_screenshot.dart';

final noScreenshot = NoScreenshot.instance;

String lang = "en";
const double kBorderRadius = 15;
const double kSizedBoxHeight = 25;
const double kVerticalPadding = 15;
const double kHorizontalPadding = 10;
const String verCode = "1.0.0";
bool isGuest = CacheHelper.getData(key: "token") == null ? true : false;
