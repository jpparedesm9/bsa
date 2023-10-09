
/* variables locales de T_VALUEDATEMINN_689*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_VALUEDATEUVDU_861*/

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

    
        var task = designerEvents.api.valuedatemain;
    

    var queryDict = {};
//"TaskId": "T_VALUEDATEMINN_689"

    	// (Button) 
    task.executeCommand.CM_VALUEDAT_NNN = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
		var msgConfirm = "";
		var showMessage = true;
		if (queryDict.menu == ASSETS.Constants.MENU_VALUE_DATE){
			msgConfirm = "ASSTS.MSG_ASSTS_ESTSEGURO_95544";			
		}else if (queryDict.menu == ASSETS.Constants.MENU_REVERSE){
			msgConfirm = "ASSTS.MSG_ASSTS_ESTSEGURV_19605";			
			var selectedRow = executeCommandEventArgs.commons.api.grid.getSelectedRows('QV_1244_89323'); 
			if (selectedRow.length == 0){
				executeCommandEventArgs.commons.messageHandler.showMessagesError(
					"ASSTS.MSG_ASSTS_SELECCINT_52125");
				showMessage = false;
			}
		}		
		if (showMessage){			
			return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm(msgConfirm).then(function(resp){
				var response = false;
				switch(resp.buttonIndex){
					case 0 : //CANCEL
							executeCommandEventArgs.commons.execServer = false;
							break;
					case 1 : //ACCEPT							
							//COMPARE VALUE DATE  WITH LAST PROCESS DATE
							if (queryDict.menu == ASSETS.Constants.MENU_VALUE_DATE){								
								var dateParts = entities.Loan.lastProcessDate.split("/");
								var d = dateParts[1] + '/' + dateParts[0] + '/' + dateParts[2];								
								var dateLP = new Date(d);		
								console.log(entities.ValueDateFilter.valueDate);
								console.log(dateLP);
								if (entities.ValueDateFilter.valueDate > dateLP){
									return executeCommandEventArgs.commons.messageHandler.showMessagesConfirm("ASSTS.MSG_ASSTS_LAFECHADP_53060").then(function(respAux){										
										switch(respAux.buttonIndex){
											case 0 : executeCommandEventArgs.commons.execServer = false;													 
													 break;
											case 1 : executeCommandEventArgs.commons.execServer = true;
													 response = true;
													 break;
										}
										return response;
									});
								}else{
									executeCommandEventArgs.commons.execServer = true;
									response = true;
								}
							}else{							
								executeCommandEventArgs.commons.execServer = true;
								response = true;
							}
							break;
				}
				return response;
			});
		}
        
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ValueDateMain
    task.initData.VC_VALUEDATEN_586689 = function (entities, initDataEventArgs){
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
        var parameters=api.navigation.getCustomDialogParameters();        
        entities.LoanInstancia = parameters.parameters.loanInstancia;
		queryDict = {
			menu: parameters.parameters.menu
		}
		
        commons.execServer = true;	
		entities.ValueDateFilter.option = queryDict.menu;
		if (queryDict.menu == ASSETS.Constants.MENU_VALUE_DATE){
			commons.api.viewState.hide('VA_OBSERVATIONDKBP_175866');
		}else if (queryDict.menu == ASSETS.Constants.MENU_REVERSE){
			$(".breadcrumb .ng-binding").last().text(commons.api.viewState.translate('ASSTS.LBL_ASSTS_REVERSAGQ_88268'));
			commons.api.viewState.hide('VA_LASTPROCESSDEET_724866');
			commons.api.viewState.hide('VA_3610ZOUUEMDZQED_313866');
		}
		if (entities.Loan.status == "NO VIGENTE"){
            api.viewState.disable("CM_VALUEDAT_NNN");
        }
        
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ValueDateMain
    task.initDataCallback.VC_VALUEDATEN_586689 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ValueDateMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_VALUEDATEN_586689","VC_DNIIMAEAVR_174689",entities, renderEventArgs);
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

	//gridRowSelecting QueryView: QV_1244_89323
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_1244_89323 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        	task.sequential =  gridRowSelectingEventArgs.rowData.secuential;
		entities.ValueDateFilter.indexTrn = gridRowSelectingEventArgs.rowIndex;	
    };



}));