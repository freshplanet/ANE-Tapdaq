package com.freshplanet.ane.AirTapdaq {

    public class AirTapdaqConfig {

        /***************************
         *
         * PUBLIC
         *
         ***************************/

        /**
         *
         * @param applicationId
         * @param clientKey
         */
        public function AirTapdaqConfig(applicationId:String, clientKey:String) {

            _applicationId  = applicationId;
            _clientKey      = clientKey;
        }

        /**
         *
         * @param enabled
         */
        public function setIsDebugEnabled(enabled:Boolean):void {
            _debug = enabled;
        }

        /**
         *
         * @param types
         */
        public function useAdvertTypes(types:Array):void {

            for each (var type:AirTapdaqAdvertType in types) {

                if (_advertTypesEnabled.indexOf(type.value) == -1) {
                    _advertTypesEnabled.push(type.value);
                }
            }
        }

        /**
         *
         * @param cap (default 2)
         */
        public function setDailyFrequencyCap(cap:uint):void {
            _frequencyCap = cap;
        }

        /***************************
         *
         * PRIVATE
         *
         ***************************/

        private var _applicationId      : String    = null;
        private var _clientKey          : String    = null;
        private var _advertTypesEnabled : Array     = [];
        private var _frequencyCap       : int       = 2;
        private var _debug              : Boolean   = false;

        internal function get applicationId():String {
            return _applicationId;
        }

        internal function get clientKey():String {
            return _clientKey;
        }

        internal function get advertTypesEnabled():Array {
            return _advertTypesEnabled.slice();
        }

        internal function get frequencyCap():int {
            return _frequencyCap;
        }

        internal function get debug():Boolean {
            return _debug;
        }
    }
}
