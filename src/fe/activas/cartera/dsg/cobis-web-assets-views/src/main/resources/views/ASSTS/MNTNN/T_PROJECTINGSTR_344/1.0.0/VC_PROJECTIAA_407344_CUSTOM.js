
/* variables locales de T_PROJECTINGSTR_344*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_PROJECTIONTOG_425*/

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

    
        var task = designerEvents.api.othercharges;
    

    //"TaskId": "T_PROJECTINGSTR_344"

    	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: OtherCharges
    task.initData.VC_PROJECTIAA_407344 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;
		commons.execServer = true;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: OtherCharges
    task.initDataCallback.VC_PROJECTIAA_407344 = function (entities, initDataEventArgs){
        if(!initDataEventArgs.success){
            initDataEventArgs.commons.api.vc.closeDialog();
			var subModuleId = "CMMNS",
      	        taskId = "T_LOANSEARCHSWA_959",
			    vcId = "VC_LOANSEARHC_144959",
			    parameters = '',
			    label="BÃºsqueda de PrÃ©stamos";
			ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, initDataEventArgs, parameters);        
		}
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: OtherCharges
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        onCloseModalEventArgs.commons.api.grid.refresh("QV_8396_63374",{"instancia":entities.LoanInstancia.idInstancia});
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: OtherCharges
    task.onCloseModalEventCallback = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: OtherCharges
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		var  api = renderEventArgs.commons.api;
        try{
			ASSETS.Header.setDataStyle ("VC_PROJECTIAA_407344", "VC_UJNNOFLWUJ_608344", entities, renderEventArgs);
		}
        catch(err){
            renderEventArgs.commons.messageHandler.showMessagesError(err.message,true);
        }
        
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
        try{
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.api.vc.closeDialog();
            var subModuleId = "CMMNS",
            taskId = "T_LOANSEARCHSWA_959",
            vcId = "VC_LOANSEARHC_144959",
            parameters = '', 
            label = "B\u00fasqueda de Pr\ufffdstamos";
            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);
        }
        catch(err){
            ASSETS.Utils.managerException(err);
        }
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWVITZRQ_108612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
         ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
    };

	//Entity: Loan
    //Loan.loanBankID (TextLink) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VASIMPLELABELLL_867612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
                    ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
    };



}));