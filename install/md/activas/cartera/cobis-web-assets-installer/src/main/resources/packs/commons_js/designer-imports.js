//Designer Generator v 6.1.0 - release SPR 2016-21 20/10/2016
/*
 * carga archivos javascript minificados del framework de designer  en caso de que variable
 * sessionStorage.getItem('debuggingMode') sea true
 */
(function (angular, params) {
    'use strict';
    var cultureValue = 'es',
        temCult = cultureValue,
        path1 = params.md_id + '/' + params.sb_id + '/' + params.ts_id + '/' + params.ts_vr + '/' + params.vc_id,
        min = '.min',
        min2 = '',
        desVer = params.dsgnr_vrsn,
        designerVersion;
    
    if (angular.isDefined(desVer)) {
        designerVersion = Number(desVer.substring(6, 10));
    }
	if (sessionStorage) {
        if (sessionStorage.getItem('debuggingMode') === 'true') {
            min = '';
	    }
        if (sessionStorage && sessionStorage.getItem('culture')) {
            cultureValue = JSON.parse(sessionStorage.getItem('culture'));
            temCult = cultureValue.substring(0, 2);
        }
    }
	
	var styleDsngr = JSON.parse(sessionStorage.getItem('actualStyle'));
	var styles = sessionStorage.getItem('styles');
	if(styles != null)
		styles = JSON.parse(styles);
	var newStyle = 'theme';
	if((styleDsngr != undefined || styleDsngr != null) && (styles != undefined || styles != null)){
		var dataStyle;
		for(var item in styles){
			if(styles[item].nombre === styleDsngr){
				dataStyle = styles[item];
			}
		}
		newStyle = dataStyle.styleDsgr;
	}
	document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/kendo.all.min.js"></script>');
	document.write('<script src="/CTSProxy/services/cobis/web/scripts/lib/kendo/cultures/kendo.culture.' + temCult + min + '.js"></script>');
    document.write('<script src="/CTSProxy/services/cobis/web/scripts/lib/kendo/lang/kendo.messages.' + temCult + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtComboBox' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtDatePicker' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtMaskedTextBox' + min + '.js"></script>');	
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/kiui.min.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtComboMultiSelect' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtDateTimePicker' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtTimePicker' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/jszip.min.js"></script> ');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/angular/angular-cookies.min.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/script/script.js"></script>');
	document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/cobis.commons' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/module.cobis' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designerCommons' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designerBreadcrumbs' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designerDirectives' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designerCRUD' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designerCustomEvents' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designer' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/commons/designerPopover' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/scripts/lib/kendo/ExtGrid' + min + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/views/' + params.md_id + '/assets/scripts/' + params.md_id + '.js"></script>');
    if (designerVersion >= 1524) {
        min2 = min;
    }
    document.write('<script src="' + params.cn_pt + '/cobis/web/views/' + path1 + min2 + '.js"></script>');
    document.write('<script src="' + params.cn_pt + '/cobis/web/views/' + path1 + '_CUSTOM.js"></script>');
    document.write('<link href="'  + params.cn_pt + '/cobis/web/styles/' + newStyle + '.css" rel="stylesheet" />');
    document.write('<link href="'  + params.cn_pt + '/cobis/web/views/' + params.md_id + '/assets/styles/' + params.md_id + '.css" rel="stylesheet" />');
}(window.angular, window.params));