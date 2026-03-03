import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionService {
  static const entitlementId = 'premium';

  Future<void> configure() async {
    const apiKeyAndroid = String.fromEnvironment('RC_ANDROID_KEY');
    const apiKeyIos = String.fromEnvironment('RC_IOS_KEY');
    final key = Platform.isIOS ? apiKeyIos : apiKeyAndroid;
    if (key.isEmpty) return;

    await Purchases.setLogLevel(LogLevel.warn);
    final config = PurchasesConfiguration(key);
    await Purchases.configure(config);
  }

  Future<bool> hasPremiumAccess() async {
    try {
      final info = await Purchases.getCustomerInfo();
      return info.entitlements.active.containsKey(entitlementId);
    } catch (_) {
      return false;
    }
  }
}
