package com.freshplanet.ane.AirTapdaq {

    import flash.events.EventDispatcher;
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;
    import flash.system.Capabilities;

    public class AirTapdaq extends EventDispatcher {

        /***************************
         *
         * PUBLIC
         *
         ***************************/

        /**
         *
         */
        public static function get isSupported():Boolean {
            return _isIOS();// || _isAndroid();
        }

        /**
         *
         * @param applicationId
         * @param clientKey
         * @return
         */
        public static function init(applicationId:String, clientKey:String, debug:Boolean = false):AirTapdaq {

            if (!_instance)
                new AirTapdaq(Private, applicationId, clientKey, debug);
            else
                _log("ignoring new init");

            return _instance;
        }

        public function showInterstitial():void {
            _context.call("AirTapdaqShowInterstitial");
        }

        /***************************
         *
         * PRIVATE
         *
         ***************************/

        private static const EXTENSION_ID : String = "com.freshplanet.ane.AirTapdaq";

        private static var _instance : AirTapdaq = null;

        private var _context : ExtensionContext = null;

        private var _applicationId  : String = null;
        private var _clientKey      : String = null;
        private var _debug          : Boolean = false;

        public function AirTapdaq(access:Class, applicationId:String, clientKey:String, debug:Boolean) {

            if (access != Private)
                throw new Error("Private constructor call!");

            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);

            if (!_context) {

                _log("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
                return;
            }

            _applicationId  = applicationId;
            _clientKey      = clientKey;
            _debug          = debug;

            _context.addEventListener(StatusEvent.STATUS, _onStatus);
            _context.call("AirTapdaqInit", _applicationId, _clientKey, _debug);

            _instance = this;
        }

        private static function _isIOS():Boolean {
            return Capabilities.manufacturer.indexOf("iOS") > -1;
        }

        private static function _isAndroid():Boolean {
            return Capabilities.manufacturer.indexOf("Android") > -1;
        }

        private static function _log(message:String):void {
            trace("AirTapdaq", message);
        }

        private function _onStatus(event:StatusEvent):void {

            if (event.code == "LOGGING") {
                _log(event.level);
            }
            else {

                for (var key:* in AirTapdaqEvent) {

                    if (key == event.code) {

                        this.dispatchEvent(new AirTapdaqEvent(key));
                        break;
                    }
                }
            }
        }
    }
}

final class Private{}