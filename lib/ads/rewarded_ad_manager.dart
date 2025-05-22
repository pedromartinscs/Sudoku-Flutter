import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdManager {
  RewardedAd? _rewardedAd;
  bool _isLoaded = false;

  /*
  void loadAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void showAd(Function onRewarded) {
    if (_isLoaded && _rewardedAd != null) {
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onRewarded();
      });
    } else {
      print('Ad not ready');
    }
  }
  */
}