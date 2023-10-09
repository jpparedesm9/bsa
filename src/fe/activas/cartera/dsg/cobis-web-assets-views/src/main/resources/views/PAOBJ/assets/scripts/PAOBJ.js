/*global designerEvents, console */
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('PAOBJ',[], function () {
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

document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');