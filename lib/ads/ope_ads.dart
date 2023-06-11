import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;

Future<void> loadAd() async {
  await AppOpenAd.load(
      adUnitId: 'ca-app-pub-9884983574056106/9216446555',
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
        // print('open ad is loaded');
        openAd = ad;
        // openAd!.show();
      }, onAdFailedToLoad: (error) {
        // print('ad failed to load $error');
      }),
      orientation: AppOpenAd.orientationPortrait);
}

void showAd() {
  if (openAd == null) {
    // print('trying tto show before loading');
    loadAd();
    return;
  }

  openAd!.fullScreenContentCallback =
      FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
    // print('onAdShowedFullScreenContent');
  }, onAdFailedToShowFullScreenContent: (ad, error) {
    ad.dispose();
    // print('failed to load $error');
    openAd = null;
    loadAd();
  }, onAdDismissedFullScreenContent: (ad) {
    ad.dispose();
    // print('dismissed');
    openAd = null;
    loadAd();
  });

  openAd!.show();
}
