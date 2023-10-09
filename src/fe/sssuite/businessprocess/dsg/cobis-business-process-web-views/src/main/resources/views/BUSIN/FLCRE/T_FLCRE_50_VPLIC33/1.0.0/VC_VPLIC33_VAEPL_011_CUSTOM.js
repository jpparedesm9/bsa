<!-- Designer Generator v 5.0.0.1506 - release SPR 2015-06 02/04/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.variablepolicy;
	var customDialogParameters;	

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //ViewContainer: VariablePolicy 
    task.initData.VC_VPLIC33_VAEPL_011 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
		var listVariable = [];
		customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		
		if (customDialogParameters.seccion === 'P'){		
		    for (var i=0; i<customDialogParameters.VariablePolicy.data().length; i++){
		    	if( customDialogParameters.VariablePolicy.data()[i].VariableRule === customDialogParameters.Mnemonic){
		    		var varialble = new VariablePolicy(customDialogParameters.VariablePolicy.data()[i].VariableName, customDialogParameters.VariablePolicy.data()[i].VariableValue,customDialogParameters.VariablePolicy.data()[i].VariableDescription);
		    		listVariable.push(varialble);				
		    		}
		    }
			initDataEventArgs.commons.api.grid.addAllRows('VariablePolicy', listVariable, true);
		}else{
			for (var i=0; i<customDialogParameters.VariableEx.data().length; i++){
		    	if( customDialogParameters.VariableEx.data()[i].VariableRule === customDialogParameters.Mnemonic){
		    		var varialble = new VariableExceptions(customDialogParameters.VariableEx.data()[i].VariableName, customDialogParameters.VariableEx.data()[i].VariableValue,customDialogParameters.VariableEx.data()[i].VariableDescription);
		    		listVariable.push(varialble);				
		    		}
		    }
			initDataEventArgs.commons.api.grid.addAllRows('VariableExceptions', listVariable, true);
		}	
		
    };
	 //ViewContainer: VariablePolicy 
    task.render = function(entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;		
		var viewState = renderEventArgs.commons.api.viewState;
		var grid = renderEventArgs.commons.api.grid;
		    if(customDialogParameters.seccion === 'P'){
				viewState.hide('GR_VARABLOIYW12_04');
			} else {
				viewState.hide('GR_VARABLOIYW12_03');
			}
		var columns = ['VariableDescription'];
		BUSIN.API.GRID.hideColumns('QV_UEVRB5831_12', columns, renderEventArgs.commons.api);//QV de politica
		BUSIN.API.GRID.hideColumns('QV_EAIBL2309_87', columns, renderEventArgs.commons.api);//QV de Excepciones
		
    };

}());

VariablePolicy = function(name, value, description){
    this.VariableName = name;
    this.VariableValue = value;
	this.VariableDescription = description; 
}
VariableExceptions = function(name, value, description){
    this.VariableName = name;
    this.VariableValue = value;
	this.VariableDescription = description; 	
}