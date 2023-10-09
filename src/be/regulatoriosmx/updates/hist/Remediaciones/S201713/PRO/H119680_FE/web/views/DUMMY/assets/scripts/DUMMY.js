/*global designerEvents, console */
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('DUMMY',[], function () {
            return factory();
        });
    } else {
        factory();
    }
}(this, function () {
    "use strict";
    /*module.js*/
    //Your code here
}));