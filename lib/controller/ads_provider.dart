import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zchatapp/ads/ad_helper.dart';

class AdsProvider with ChangeNotifier {
  RewardedAd? rewardedAd;
  AdManagerBannerAd? bannerAd1;
  AdManagerBannerAd? bannerAd2;
  AdManagerBannerAd? bannerAd3;
  AdManagerBannerAd? bannerAd4;
  BannerAd? inlineBannerAd;
  bool isLoaded1 = false;
  bool isLoaded2 = false;
  bool isLoaded3 = false;
  bool isLoaded4 = false;
  bool isLoaded5 = false;

  void createInlineloginBanner(BuildContext context) async {
    bannerAd1 = AdManagerBannerAd(
      adUnitId: AdHelper.bannerAdUnitId1,
      // '/6499/example/banner',
      request: const AdManagerAdRequest(),
      sizes: [
        AdSize.banner,
      ],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoaded1 = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('AdManagerBannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  void homescreenInlineBannerAd(context) async {
    inlineBannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: AdHelper.bannerAdUnitId2,
      // '/6499/example/banner',
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isLoaded2 = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    inlineBannerAd?.load();
    notifyListeners();
  }

  void createInlineBannerAd5(BuildContext context) {
    bannerAd3 = AdManagerBannerAd(
      adUnitId: AdHelper.bannerAdUnitId3,
      // '/6499/example/banner',
      request: const AdManagerAdRequest(),
      sizes: [
        AdSize.mediumRectangle,
      ],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoaded3 = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('AdManagerBannerAd failed to load: $err');
          isLoaded3 = false;
          notifyListeners();
          ad.dispose();
        },
      ),
    )..load();
  }

  void createInlineBannerAd4(BuildContext context) {
    bannerAd2 = AdManagerBannerAd(
      adUnitId: AdHelper.bannerAdUnitId4,
      // '/6499/example/banner',
      request: const AdManagerAdRequest(),
      sizes: [
        AdSize.banner,
      ],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoaded5 = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('AdManagerBannerAd failed to load: $err');
          isLoaded5 = false;
          ad.dispose();
        },
      ),
    )..load();
  }

  void chatscreeninlineBannerAd(context) async {
    bannerAd4 = AdManagerBannerAd(
      adUnitId: AdHelper.bannerAdUnitId5,
      // '/6499/example/banner',
      request: const AdManagerAdRequest(),
      sizes: [
        AdSize.banner,
      ],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          isLoaded4 = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('AdManagerBannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  // void loadRewardedAd() {
  //   RewardedAd.load(
  //     adUnitId: AdHelper.rewardedAdUnitId,
  //     request: const AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         ad.fullScreenContentCallback = FullScreenContentCallback(
  //           onAdDismissedFullScreenContent: (ad) {
  //             notifyListeners();
  //             ad.dispose();
  //             rewardedAd = null;
  //             notifyListeners();
  //             loadRewardedAd();
  //           },
  //         );
  //         rewardedAd = ad;
  //         notifyListeners();
  //       },
  //       onAdFailedToLoad: (err) {
  //         log('Failed to load a rewarded ad: ${err.message}');
  //       },
  //     ),
  //   );
  // }
}
