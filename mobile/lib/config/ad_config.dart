import 'package:flutter/foundation.dart';

class AdConfig {
  static const String _productionAppId =
      'ca-app-pub-1738145743199175~REPLACE_WITH_REAL_ID';

  static const String _productionBannerAdUnitId =
      'ca-app-pub-1738145743199175/REPLACE_WITH_REAL_ID';

  static const String _testBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';

  static bool get adsEnabled => true;

  static String get bannerAdUnitId {
    if (kDebugMode) return _testBannerAdUnitId;
    return _productionBannerAdUnitId;
  }

  static String get appId => _productionAppId;
}
