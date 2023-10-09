/* variables locales de T_DUMMYBLNARFME_347*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.dummyform;
    

    //"TaskId": "T_DUMMYBLNARFME_347"

    //Entity: AuxData
    //AuxData. (Button) View: DummyForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONCSFGVOC_624175 = function(  entities, executeCommandEventArgs ) {

		executeCommandEventArgs.commons.execServer = false;
		var params = [['report.module','cartera'],['report.name','reglamentoInterno' ],['idTramite', entities.AuxData.application]];
		task.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_LIQUI');
        
    };

//Entity: AuxData
    //AuxData. (Button) View: DummyForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONGUFAWQK_389175 = function(  entities, executeCommandEventArgs ) {

		executeCommandEventArgs.commons.execServer = false;
		var params = [['report.module','cartera'],['report.name','contratoInclusion' ],['idTramite', entities.AuxData.application]];
		task.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_LIQUI');
    
        
    };

//Entity: AuxData
    //AuxData. (Button) View: DummyForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
   task.executeCommand.VA_VABUTTONRFQUVDC_996175 = function(  entities, executeCommandEventArgs ) {

		executeCommandEventArgs.commons.execServer = false;
		var params = [['report.module','cartera'],['report.name','solicitudCreditoGrupal' ],['idTramite', entities.AuxData.application]];
		task.generarReporte(null, params, 'COMMONS.MENU.MNU_REPORT_LIQUI');
        
        
        
    }
	
	task.generarReporte=function(reporte, argumentos, title) {
		
			var Crue = '?myValue=' + Math.random() + '&';
            var formaMapeo = document.createElement("form");
            formaMapeo.target = 'popup_window_' + reporte;
            formaMapeo.method = "POST"; // or "post" if appropriate
		
			if(task.IsNullOrEmpty(reporte))
				formaMapeo.action = "${contextPath}/cobis/web/reporting/actions/reportingService" + Crue;
			else
				formaMapeo.action = "${contextPath}/cobis/web/reports/" + reporte + Crue;
			
		    var param = "";
            for ( var i = 0; i < argumentos.length; i++) {
				param = param + argumentos[i][0] + '=' + task.Char_convert(argumentos[i][1]) + '&'
            }
			param =  param.substr(0, param.length-1);
            var url =  formaMapeo.action + param
			if (task.IsNullOrEmpty(title)) {title='Reporte';}
			cobis.container.tabs.openNewTab('ctsConsole', url ,title, true);			
			
    }
	task.IsNullOrEmpty= function (parValue) {
        return (task.IsNull(parValue) || parValue === '');
    }
	task.IsNull= function (parValue) {
            return (parValue === null || parValue === undefined);
     }
	
	task.Char_convert= function (original) {
            var chars = ["\u00e1", "\u00e0", "\u00e9", "\u00e8", "\u00ed", "\u00ec", "\u00f3", "\u00f2", "\u00fa", "\u00f9", "\u00c1", "\u00c0", "\u00c9", "\u00c8", "\u00cd", "\u00cc", "\u00d3", "\u00d2", "\u00da", "\u00d9", "\u00f1", "\u00d1"];
            var codes = ["%e1", "%e1", "%e9", "%e9", "%ed", "%ed", "%f3", "%f3", "%fa", "%fa", "%c1", "%c1", "%c9", "%c9", "%cd", "%cd", "%d3", "%d3", "%da", "%da", "%f1", "%d1"];
            if (original !== null && original !== undefined && original.constructor === String) {
                for (var i = 0; i < chars.length; i++) {
                    original = original.replace(chars[i], codes[i]);
                }
            }
            return original;
     }



}));