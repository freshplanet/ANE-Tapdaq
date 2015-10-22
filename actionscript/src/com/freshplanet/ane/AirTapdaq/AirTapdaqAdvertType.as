package com.freshplanet.ane.AirTapdaq {

    public class AirTapdaqAdvertType {

        /***************************
         *
         * PUBLIC
         *
         ***************************/

        static public const INTERSTITIAL_PORTRAIT   : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "interstitialPortrait");
        static public const INTERSTITIAL_LANDSCAPE  : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "interstitialLandscape");
        
//        static public const NATIVE_SQUARE_LARGE                 : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeSquareLarge");
//        static public const NATIVE_SQUARE_MEDIUM                : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeSquareMedium");
//        static public const NATIVE_SQUARE_SMALL                 : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeSquareSmall");
//        static public const NATIVE_NEWSFEED_PORTRAIT_LARGE      : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeNewsfeedPortraitLarge");
//        static public const NATIVE_NEWSFEED_PORTRAIT_MEDIUM     : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeNewsfeedPortraitMedium");
//        static public const NATIVE_NEWSFEED_PORTRAIT_SMALL      : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeNewsfeedPortraitSmall");
//        static public const NATIVE_NEWSFEED_LANDSCAPE_LARGE     : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeNewsfeedLandscapeLarge");
//        static public const NATIVE_NEWSFEED_LANDSCAPE_MEDIUM    : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeNewsfeedLandscapeMedium");
//        static public const NATIVE_NEWSFEED_LANDSCAPE_SMALL     : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeNewsfeedLandscapeSmall");
//        static public const NATIVE_FULLSCREEN_PORTRAIT_LARGE    : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeFullscreenPortraitLarge");
//        static public const NATIVE_FULLSCREEN_PORTRAIT_MEDIUM   : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeFullscreenPortraitMedium");
//        static public const NATIVE_FULLSCREEN_PORTRAIT_SMALL    : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeFullscreenPortraitSmall");
//        static public const NATIVE_FULLSCREEN_LANDSCAPE_LARGE   : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeFullscreenLandscapeLarge");
//        static public const NATIVE_FULLSCREEN_LANDSCAPE_MEDIUM  : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeFullscreenLandscapeMedium");
//        static public const NATIVE_FULLSCREEN_LANDSCAPE_SMALL   : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeFullscreenLandscapeSmall");
//        static public const NATIVE_STRIP_PORTRAIT_LARGE         : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeStripPortraitLarge");
//        static public const NATIVE_STRIP_PORTRAIT_MEDIUM        : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeStripPortraitMedium");
//        static public const NATIVE_STRIP_PORTRAIT_SMALL         : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeStripPortraitSmall");
//        static public const NATIVE_STRIP_LANDSCAPE_LARGE        : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeStripLandscapeLarge");
//        static public const NATIVE_STRIP_LANDSCAPE_MEDIUM       : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeStripLandscapeMedium");
//        static public const NATIVE_STRIP_LANDSCAPE_SMALL        : AirTapdaqAdvertType = new AirTapdaqAdvertType(Private, "nativeStripLandscapeSmall");


        public function get value():String {
            return _value;
        }

        /***************************
         *
         * PRIVATE
         *
         ***************************/

        private var _value:String = null;

        public function AirTapdaqAdvertType(access:Class, value:String) {

            if (access != Private)
                throw new Error("Private constructor call!");

            _value = value;
        }
    }
}

final class Private {}