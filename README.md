# Flutter Test App for JustBaat Ads Plugin

This is a standalone Flutter application to test the JustBaat Ads Flutter plugin.

> **Next-Gen SDK:** This app is updated to the JustBaat Ads Next-Gen SDK (`justbaat_ads` ^1.1.1 / native SDK v1.1.1), built on Google's `ads-mobile-sdk`. See [Next-Gen SDK Notes](#next-gen-sdk-notes) below.

## Requirements

- Android `minSdkVersion` **24** (required by the Next-Gen SDK)
- `compileSdk` / `targetSdk` 35
- Java 17, Android NDK `27.0.12077973`

## Setup

1. **Navigate to the test app directory:**
   ```bash
   cd flutter_test_app
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Features Tested

- ✅ Banner Ads
- ✅ Interstitial Ads
- ✅ Rewarded Ads
- ✅ Native Ads
- ✅ App Open Ads

## Configuration

Make sure your ad configuration is set up at:
`https://ads-config-worker.amandeep-k.workers.dev/?companyId=sdk-sample-test-new`

The app uses the company ID: `sdk-sample-test-new`

## Next-Gen SDK Notes

- Native ads now use the `com.google.android.libraries.ads.mobile.sdk` namespace instead of the classic `com.google.android.gms.ads` classes.
- The classic `play-services-ads` dependency is excluded across all configurations to avoid duplicate-class build errors (Next-Gen bundles these classes itself).
- Native ad binding uses `registerNativeAd(nativeAd, mediaView)` — `mediaView` is now a read-only property.
- Extra Maven repositories are configured for mediation adapters: `android-sdk.is.com` (ironSource) and `artifact.bytedance.com` (Pangle).
- Bundled mediation adapters: Unity, ironSource, InMobi, Pangle, Vungle.

## Notes

- Dependencies come from the published `justbaat_ads` plugin (see `pubspec.yaml`).
- The app handles lifecycle events automatically.

