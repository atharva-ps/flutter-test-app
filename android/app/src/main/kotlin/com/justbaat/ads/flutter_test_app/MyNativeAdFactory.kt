package com.justbaat.ads.flutter_test_app

import android.view.LayoutInflater
import android.view.View
import android.widget.*
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.justbaat.ads.flutter.JustbaatNativeAdFactory

class MyNativeAdFactory(
    private val layoutInflater: LayoutInflater
) : JustbaatNativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: Map<String, Any>?
    ): NativeAdView {
        val adView = layoutInflater.inflate(
            R.layout.my_native_ad, null
        ) as NativeAdView

        // Set ad asset views
        adView.headlineView = adView.findViewById(R.id.ad_headline)
        adView.bodyView = adView.findViewById(R.id.ad_body)
        adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)
        adView.iconView = adView.findViewById(R.id.ad_app_icon)
        adView.mediaView = adView.findViewById(R.id.ad_media)
        adView.advertiserView = adView.findViewById(R.id.ad_advertiser)
        adView.storeView = adView.findViewById(R.id.ad_store)
        adView.priceView = adView.findViewById(R.id.ad_price)
        adView.starRatingView = adView.findViewById(R.id.ad_stars)

        // Media content (large image/video at top)
        adView.mediaView?.mediaContent = nativeAd.mediaContent

        // Headline — show "Sponsored" if advertiser is available, else use headline
        (adView.headlineView as TextView).text = "Sponsored"

        // Body text
        (adView.bodyView as? TextView)?.apply {
            text = nativeAd.body ?: nativeAd.headline ?: ""
            visibility = View.VISIBLE
        }

        // CTA Button (big yellow INSTALL button)
        (adView.callToActionView as? Button)?.apply {
            text = nativeAd.callToAction ?: "INSTALL"
            visibility = if (nativeAd.callToAction != null) View.VISIBLE else View.INVISIBLE
        }

        // App icon
        nativeAd.icon?.let {
            (adView.iconView as? ImageView)?.setImageDrawable(it.drawable)
            adView.iconView?.visibility = View.VISIBLE
        } ?: run { adView.iconView?.visibility = View.GONE }

        // Hidden fields (kept for SDK tracking)
        (adView.advertiserView as? TextView)?.apply {
            text = nativeAd.advertiser
            visibility = View.GONE
        }

        (adView.storeView as? TextView)?.apply {
            text = nativeAd.store
            visibility = View.GONE
        }

        (adView.priceView as? TextView)?.apply {
            text = nativeAd.price
            visibility = View.GONE
        }

        (adView.starRatingView as? RatingBar)?.visibility = View.GONE

        // IMPORTANT: This must be called last!
        adView.setNativeAd(nativeAd)

        return adView
    }
}
