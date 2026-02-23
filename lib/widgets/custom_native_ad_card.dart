import 'package:flutter/material.dart';
import 'package:justbaat_ads/justbaat_ads.dart';

/// A custom native ad card that wraps the SDK's [NativeAdWidget]
/// with a dark-themed card UI matching the Google Ads sponsored ad style.
///
/// The SDK's default CTA is hidden; the custom yellow INSTALL button
/// triggers [JustbaatAds.triggerNativeAdCtaClick] instead.
class CustomNativeAdCard extends StatefulWidget {
  /// The div ID from your ad configuration (optional).
  final String? divId;

  /// Height reserved for the native ad platform view inside the card.
  final double nativeAdHeight;

  /// Callback when the native ad is loaded successfully.
  final VoidCallback? onAdLoaded;

  /// Callback when the native ad fails to load.
  final Function(String)? onAdFailed;

  const CustomNativeAdCard({
    Key? key,
    this.divId,
    this.nativeAdHeight = 300,
    this.onAdLoaded,
    this.onAdFailed,
  }) : super(key: key);

  @override
  State<CustomNativeAdCard> createState() => _CustomNativeAdCardState();
}

class _CustomNativeAdCardState extends State<CustomNativeAdCard> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Hidden NativeAdWidget (mounted for SDK ad loading & CTA) ──
        Offstage(
          offstage: true,
          child: SizedBox(
            width: 1,
            height: 1,
            child: NativeAdWidget(
              divId: widget.divId,
              height: 1,
              width: 1,
              hideDefaultCta: true,
              onAdLoaded: widget.onAdLoaded,
              onAdFailed: widget.onAdFailed,
            ),
          ),
        ),

        // ── Visible custom UI card ──
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Banner area with large Google Ads logo ──
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF383838),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: CustomPaint(
                      painter: _GoogleAdsLogoPainter(),
                    ),
                  ),
                ),
              ),

              // ── Sponsored info row ──
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Row(
                  children: [
                    // Small Google Ads icon
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: CustomPaint(
                        painter: _GoogleAdsLogoPainter(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // "Sponsored" text
                    const Text(
                      'Sponsored',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // "AD" badge
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0C14B),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'AD',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Description text ──
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Stay up to date with your Ads Check how your ads are',
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

              // ── Custom INSTALL button (triggers SDK CTA click) ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      JustbaatAds.triggerNativeAdCtaClick();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0C14B),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'INSTALL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// CustomPainter that draws the Google Ads "A" logo
// ────────────────────────────────────────────────────────────────────────────

class _GoogleAdsLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // ── Yellow left leg of the "A" ──
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC04)
      ..style = PaintingStyle.fill;

    final yellowPath = Path();
    yellowPath.moveTo(w * 0.15, h * 0.95);
    yellowPath.lineTo(w * 0.30, h * 0.95);
    yellowPath.lineTo(w * 0.55, h * 0.05);
    yellowPath.lineTo(w * 0.42, h * 0.05);
    yellowPath.close();
    canvas.drawPath(yellowPath, yellowPaint);

    // ── Blue right leg of the "A" ──
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final bluePath = Path();
    bluePath.moveTo(w * 0.70, h * 0.95);
    bluePath.lineTo(w * 0.85, h * 0.95);
    bluePath.lineTo(w * 0.58, h * 0.05);
    bluePath.lineTo(w * 0.45, h * 0.05);
    bluePath.close();
    canvas.drawPath(bluePath, bluePaint);

    // ── Green circle at the base ──
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;

    final double circleRadius = w * 0.10;
    canvas.drawCircle(
      Offset(w * 0.35, h * 0.78),
      circleRadius,
      greenPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
