import 'package:flutter/material.dart';
import 'package:justbaat_ads/justbaat_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize the SDK after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSdk();
    });
  }

  void _initializeSdk() async {
    try {
      // Wait a bit for the activity to be ready
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (!mounted) return;
      
      await JustbaatAds.initialize(
        companyId: 'sample-test-new',
        onSdkReady: () {
          print('SDK is ready!');
          // Don't use ScaffoldMessenger here - context might not be ready
          // Use a global key or state variable instead
        },
      );
    } catch (e, stackTrace) {
      print('Error initializing SDK: $e');
      print('Stack trace: $stackTrace');
      // Don't use ScaffoldMessenger here - context might not be ready
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      JustbaatAds.onActivityResumed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JustBaat Ads Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JustBaat Ads Test'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Ad Section
            const Text(
              'Banner Ad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Temporarily commented out to test
            // const BannerAdWidget(
            //   divId: 'banner_ad_container',
            //   height: 50,
            //   onAdLoaded: _onBannerLoaded,
            //   onAdFailed: _onBannerFailed,
            // ),
            Container(
              height: 50,
              color: Colors.grey[300],
              child: const Center(child: Text('Banner Ad (disabled for testing)')),
            ),
            const SizedBox(height: 24),

            // Interstitial Ad Buttons
            ElevatedButton.icon(
              onPressed: _loadInterstitial,
              icon: const Icon(Icons.download),
              label: const Text('Load Interstitial Ad'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showInterstitial,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Show Interstitial Ad'),
            ),
            const SizedBox(height: 24),

            // Rewarded Ad Buttons
            ElevatedButton.icon(
              onPressed: _loadRewarded,
              icon: const Icon(Icons.download),
              label: const Text('Load Rewarded Ad'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showRewarded,
              icon: const Icon(Icons.star),
              label: const Text('Show Rewarded Ad'),
            ),
            const SizedBox(height: 24),

            // App Open Ad Buttons
            ElevatedButton.icon(
              onPressed: _loadAppOpen,
              icon: const Icon(Icons.download),
              label: const Text('Load App Open Ad'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showAppOpen,
              icon: const Icon(Icons.open_in_new),
              label: const Text('Show App Open Ad'),
            ),
            const SizedBox(height: 24),

            // Native Ad Section
            const Text(
              'Native Ad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Temporarily commented out to test
            // const NativeAdWidget(
            //   divId: 'native_ad_container',
            //   height: 300,
            //   onAdLoaded: _onNativeLoaded,
            //   onAdFailed: _onNativeFailed,
            // ),
            Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(child: Text('Native Ad (disabled for testing)')),
            ),
          ],
        ),
      ),
    );
  }

  void _loadInterstitial() {
    JustbaatAds.loadInterstitial(
      placementId: 'interstitial_placement',
      onAdLoaded: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Interstitial ad loaded!')),
        );
      },
      onAdFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Interstitial failed: $error')),
        );
      },
    );
  }

  void _showInterstitial() {
    JustbaatAds.showInterstitial(
      placementId: 'interstitial_placement',
      enableClickCounting: true,
      threshold: 1,
      onAdDismissed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Interstitial dismissed')),
        );
      },
      onAdFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Interstitial failed: $error')),
        );
      },
    );
  }

  void _loadRewarded() {
    JustbaatAds.loadRewarded(
      placementId: 'rewarded_placement',
      onAdLoaded: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rewarded ad loaded!')),
        );
      },
      onAdFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rewarded failed: $error')),
        );
      },
    );
  }

  void _showRewarded() {
    JustbaatAds.showRewarded(
      placementId: 'rewarded_placement',
      enableClickCounting: true,
      threshold: 5,
      onUserEarnedReward: (reward) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reward earned: ${reward.amount} ${reward.type}'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onAdDismissed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Rewarded ad dismissed')),
        );
      },
      onAdFailedToShow: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rewarded failed: $error')),
        );
      },
    );
  }

  void _loadAppOpen() {
    JustbaatAds.loadAppOpen(
      onAdLoaded: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('App Open ad loaded!')),
        );
      },
      onAdFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('App Open failed: $error')),
        );
      },
    );
  }

  void _showAppOpen() {
    JustbaatAds.showAppOpen(
      onAdDismissed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('App Open dismissed')),
        );
      },
      onAdFailedToShow: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('App Open failed to show')),
        );
      },
    );
  }

  static void _onBannerLoaded() {
    print('Banner ad loaded!');
  }

  static void _onBannerFailed(String error) {
    print('Banner ad failed: $error');
  }

  static void _onNativeLoaded() {
    print('Native ad loaded!');
  }

  static void _onNativeFailed(String error) {
    print('Native ad failed: $error');
  }
}

