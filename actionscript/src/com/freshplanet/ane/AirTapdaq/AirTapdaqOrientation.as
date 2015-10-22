package com.freshplanet.ane.AirTapdaq {

    public class AirTapdaqOrientation {

        /***************************
         *
         * PUBLIC
         *
         ***************************/

        static public const PORTRAIT    : AirTapdaqOrientation = new AirTapdaqOrientation(Private, 0);
        static public const LANDSCAPE   : AirTapdaqOrientation = new AirTapdaqOrientation(Private, 1);
        static public const UNIVERSAL   : AirTapdaqOrientation = new AirTapdaqOrientation(Private, 2);

        public function get value():int {
            return _value;
        }

        /***************************
         *
         * PRIVATE
         *
         ***************************/

        private var _value:int;

        public function AirTapdaqOrientation(access:Class, value:int) {

            if (access != Private)
                throw new Error("Private constructor call!");

            _value = value;
        }
    }
}

final class Private {}