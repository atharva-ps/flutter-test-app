# Troubleshooting: App Closing Immediately

If the app is closing immediately, check the following:

## 1. Check Logcat for Errors

Run this command to see the actual error:
```bash
cd flutter_test_app
flutter run
# Or check logcat directly:
adb logcat | grep -E "(JustbaatAdsPlugin|AdSdkManager|AndroidRuntime|FATAL)"
```

## 2. Common Issues

### Issue: Plugin Not Found
**Symptom:** "MissingPluginException" in logs

**Solution:**
- Ensure `flutter pub get` was run
- Check that `pubspec.yaml` has correct path: `path: ../flutter_plugin`
- Verify plugin's `pubspec.yaml` has correct `plugin` configuration

### Issue: SDK Module Not Found
**Symptom:** "Project with path ':sdk' could not be found"

**Solution:**
- Check `android/settings.gradle` includes: `include ":sdk"` with path `../../sdk`
- Verify the path is correct relative to `flutter_test_app/android/`

### Issue: Activity Not Available
**Symptom:** "NO_CONTEXT" or "Activity not available" errors

**Solution:**
- The plugin now waits for activity to be ready
- If still failing, increase the delay in `_initializeSdk()` method

### Issue: Build Errors
**Symptom:** Build fails before app starts

**Solution:**
- Run `flutter clean` then `flutter pub get`
- Check that all dependencies are resolved
- Verify Android SDK and build tools are installed

## 3. Test Without SDK Initialization

Temporarily comment out SDK initialization to see if the app runs:

```dart
// Comment out this in initState:
// _initializeSdk();
```

If the app runs without initialization, the issue is with the SDK initialization.

## 4. Check Plugin Registration

Verify the plugin is registered in `android/app/src/main/kotlin/.../MainActivity.kt`:
- Should extend `FlutterActivity`
- No special configuration needed (Flutter auto-discovers plugins)

## 5. Verify Dependencies

Check that the plugin's dependencies are available:
- SDK module builds successfully
- All Android dependencies are resolved
- No version conflicts

## 6. Minimal Test

Create a minimal test to isolate the issue:

```dart
void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(child: Text('Test App')),
    ),
  ));
}
```

If this works, gradually add back features to find what's causing the crash.

