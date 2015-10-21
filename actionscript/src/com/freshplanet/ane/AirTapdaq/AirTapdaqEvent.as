package com.freshplanet.ane.AirTapdaq {

    import flash.events.Event;

    public class AirTapdaqEvent extends Event{

        static public const WILL_DISPLAY_INTERSTITIAL                   : String = "willDisplayInterstitial";
        static public const DID_DISPLAY_INTERSTITIAL                    : String = "didDisplayInterstitial";
        static public const DID_CLOSE_INTERSTITIAL                      : String = "didCloseInterstitial";
        static public const DID_CLICK_INTERSTITIAL                      : String = "didClickInterstitial";
        static public const DID_FAIL_TO_LOAD_INTERSTITIAL               : String = "didFailToLoadInterstitial";
        static public const HAS_NO_INTERSTITIALS_AVAILABLE              : String = "hasNoInterstitialsAvailable";
        static public const HAS_INTERSTITIALS_AVAILABLE_FOR_ORIENTATION : String = "hasInterstitialsAvailableForOrientation";

        public function AirTapdaqEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
        }
    }
}
