package com.justbaat.ads.flutter_test_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import com.justbaat.ads.flutter.JustbaatAdsPlugin

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Register your native ad factory with a unique ID
        JustbaatAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "myNativeAdFactory",           // This ID is referenced from Dart
            MyNativeAdFactory(layoutInflater)
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        // Clean up when the engine is destroyed
        JustbaatAdsPlugin.unregisterNativeAdFactory(flutterEngine, "myNativeAdFactory")
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
