
/* variables locales de T_LOANREFINANNG_618*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_REFINANCELSSO_386*/

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

    
        var task = designerEvents.api.loanrefinancing;
    

    var screenCall="";
//"TaskId": "T_LOANREFINANNG_618"

    	// (Button) 
    task.executeCommand.CM_TLOANREF_1NA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var subModuleId = "TRNSC",
        taskId = "T_LOANDISBURSAA_275",
        vcId = "VC_LOANDISBMN_824275",
        parameters = {loanInstancia : entities.LoanInstancia},
        label="Desembolso";
        ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId,label, executeCommandEventArgs, parameters);
        return true;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanRefinancing
    task.initData.VC_LOANREFINN_713618 = function (entities, initDataEventArgs){
        	initDataEventArgs.commons.execServer = true;        
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
		var parentVc=api.parentVc;
        var parameters=api.navigation.getCustomDialogParameters();        
        entities.LoanInstancia = parameters.parameters.loanInstancia;		
		 
		if(parameters.parameters!=undefined){
			screenCall = parameters.parameters.screenCall;
			if(screenCall=='payment'){			
				parentVc.closeDialog();				
			}		
		}
        commons.execServer = true;;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanRefinancing
    task.initDataCallback.VC_LOANREFINN_713618 = function (entities, initDataEventArgs){
        if(entities.RefinanceLoans.data().length === 0 ){
			initDataEventArgs.commons.api.vc.closeDialog();
			var subModuleId = "CMMNS",
      	        taskId = "T_LOANSEARCHSWA_959",
			    vcId = "VC_LOANSEARHC_144959",
			    parameters = '',
			    label="Búsqueda de Préstamos";
			ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, initDataEventArgs, parameters);        
		}
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanRefinancing
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		var  api = renderEventArgs.commons.api;    
		if(entities.RefinanceLoans.data().length != 0 ){		
			try{
				ASSETS.Header. setDataStyle ("VC_LOANREFINN_713618", "VC_AUCLUAIEKU_127618", entities, renderEventArgs);
				var api=renderEventArgs.commons.api;

	
				var msg_default = api.viewState.translate('ASSTS.MSG_ASSTS_RENOVAPRE_12304'); 				
				var msg_sta = api.viewState.translate('ASSTS.MSG_ASSTS_RENOVAPRE_12305'); 
				var msg_end = api.viewState.translate('ASSTS.MSG_ASSTS_RENOVAPRE_12306'); 
				if (entities.RefinanceDetailLoans.observations == ""){
					entities.RefinanceDetailLoans.observations = msg_default;
				}
				else {
					entities.RefinanceDetailLoans.observations = msg_sta + entities.RefinanceDetailLoans.observations + msg_end;
				}
				
			}
			catch(err){
				alert(err.message);
			}          
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

	//gridRowSelecting QueryView: QV_2890_45043
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_2890_45043 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = true;
            //gridRowSelectingEventArgs.commons.serverParameters.RefinanceLoans = true;
        };

	//gridRowSelecting QueryView: QV_2890_45043
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelectingCallback.QV_2890_45043 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            var subModuleId = "TRNSC",
            taskId = "T_PAYMENTSMANII_157",
            vcId = "VC_PAYMENTSAN_916157",
            parameters = {loanInstancia : entities.LoanInstancia, screenCall:'refinance'},
            label="Detalle de Pago";

            ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, gridRowSelectingEventArgs, parameters);     
        };



}));