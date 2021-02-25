import 'package:firebase_admob/firebase_admob.dart';

final bannerAdIdAndroid = "ca-app-pub-7831186229252322/6565373735";
final intertstitialAdIdAndroid = "ca-app-pub-7831186229252322/7884973074";

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['treino', 'academia', 'supino'],
  contentUrl: 'https://flutter.io',
  childDirected: false,
  testDevices: <String>[],
);

BannerAd myBanner;
InterstitialAd myInterstitial;
bool isInterstitialAdReady;

void startBanner() {
  myBanner = BannerAd(
    adUnitId: bannerAdIdAndroid,
    size: AdSize.fullBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.opened) {
        // MobileAdEvent.opened
        // MobileAdEvent.clicked
        // MobileAdEvent.closed
        // MobileAdEvent.failedToLoad
        // MobileAdEvent.impression
        // MobileAdEvent.leftApplication
      } else if (event == MobileAdEvent.failedToLoad) {
        print("FAILED TO LOAD SAPORRA");
      }
      print("BannerAd event is $event");
    },
  );
}

BannerAd getBanner(AdSize size) {
  return BannerAd(
    adUnitId: bannerAdIdAndroid,
    size: size,
    listener: (MobileAdEvent event) {
      if (event == MobileAdEvent.opened) {
        // MobileAdEvent.opened
        // MobileAdEvent.clicked
        // MobileAdEvent.closed
        // MobileAdEvent.failedToLoad
        // MobileAdEvent.impression
        // MobileAdEvent.leftApplication
      } else if (event == MobileAdEvent.failedToLoad) {
        print("FAILED TO LOAD SAPORRA");
      }
      print("BannerAd event is $event");
    },
  );
}

InterstitialAd buildInterstitial() {
  return InterstitialAd(
      adUnitId: intertstitialAdIdAndroid,
      targetingInfo: MobileAdTargetingInfo(testDevices: <String>[]),
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) {
          myInterstitial?.show();
        }
        if (event == MobileAdEvent.clicked || event == MobileAdEvent.closed) {
          myInterstitial.dispose();
        }
      });
}
