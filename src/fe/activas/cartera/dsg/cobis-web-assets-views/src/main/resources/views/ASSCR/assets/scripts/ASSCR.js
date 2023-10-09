/*global designerEvents, console */
/*(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('ASSCR',[], function () {
            return factory();
        });
    } else {
        factory();
    }
}(this, function () {
    "use strict";*/
    /*module.js*/
    //Your code here
//}));

/*global designerEvents, console */
/*(function () {
    "use strict";
    /*module.js*/
//Your code here*/
/*global designerEvents, console */
var ASSETS = {
    Utils: {
        managerException: function (err) {
            cobis.getMessageManager().showMessagesError(err);
            cobis.log.error(err);
        },
        Char_convert: function (original) {
            var chars = ["\u00e1", "\u00e0", "\u00e9", "\u00e8", "\u00ed", "\u00ec", "\u00f3", "\u00f2", "\u00fa", "\u00f9", "\u00c1", "\u00c0", "\u00c9", "\u00c8", "\u00cd", "\u00cc", "\u00d3", "\u00d2", "\u00da", "\u00d9", "\u00f1", "\u00d1"];
            var codes = ["%e1", "%e1", "%e9", "%e9", "%ed", "%ed", "%f3", "%f3", "%fa", "%fa", "%c1", "%c1", "%c9", "%c9", "%cd", "%cd", "%d3", "%d3", "%da", "%da", "%f1", "%d1"];
            if (original !== null && original !== undefined && original.constructor === String) {
                for (var i = 0; i < chars.length; i++) {
                    original = original.replace(chars[i], codes[i]);
                }
            }
            return original;
        },
        IsNull: function (parValue) {
            return (parValue === null || parValue === undefined);
        },
        IsNullOrEmpty: function (parValue) {
            return (ASSETS.Utils.IsNull(parValue) || parValue === '');
        },
        generarReporte: function (reporte, argumentos, title) {

            var Crue = '?myValue=' + Math.random() + '&';
            var formaMapeo = document.createElement("form");
            formaMapeo.target = 'popup_window_' + reporte;
            formaMapeo.method = "POST"; // or "post" if appropriate

            formaMapeo.action = "/CTSProxy/services/cobis/web/reporting/actions/reportingService" + Crue;

            var param = "";
            for (var i = 0; i < argumentos.length; i++) {
                param = param + argumentos[i][0] + '=' + ASSETS.Utils.Char_convert(argumentos[i][1]) + '&'
            }
            param = param.substr(0, param.length - 1);
            var url = formaMapeo.action + param
            if (ASSETS.Utils.IsNullOrEmpty(title)) { title = 'Reporte'; }
            cobis.container.tabs.openNewTab('ctsConsole', url, title, true);
        }
    }
}
