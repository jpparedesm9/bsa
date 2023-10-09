
/* variables locales de T_EXTENDSQUONTA_926*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_EXTENDSQUOATT_575*/

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

    
        var task = designerEvents.api.extendsquotaformmain;
    

    //"TaskId": "T_EXTENDSQUONTA_926"

    	// (Button) 
    task.executeCommand.CM_EXTENDSQ_O3T = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        executeCommandEventArgs.commons.api.viewState.hide('G_EXTENDSUUA_352662');
        executeCommandEventArgs.commons.api.viewState.hide('G_EXTENDSAUQ_349662');
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ExtendsQuotaFormMain
    task.initData.VC_EXTENDSQMN_712926 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;
		commons.execServer = true;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ExtendsQuotaFormMain
    task.initDataCallback.VC_EXTENDSQMN_712926 = function (entities, initDataEventArgs){
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

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ExtendsQuotaFormMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle ("VC_EXTENDSQMN_712926", "VC_DFZRKBDHHZ_908926", entities, renderEventArgs);
    	 
        
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

	//Entity: ExtendsQuota
    //ExtendsQuota.extendsDate (DateField) View: ExtendsQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.Spacer2497 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;    
        
       // entities.CurrentQuotas.quota = changeEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].quota;
        //entities.CurrentQuotas.endDate= changeEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].endDate;
        //changeEventArgs.commons.serverParameters.ExtendsQuota = true;
    };

	//Entity: ExtendsQuota
    //ExtendsQuota.extendsDate (DateField) View: ExtendsQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.changeCallback.Spacer2497 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        if (entities.ExtendsQuotaExt._data.length>0){
             changeEventArgs.commons.api.viewState.show('G_EXTENDSUUA_352662');
        }else{
           changeEventArgs.commons.api.viewState.hide('G_EXTENDSUUA_352662');       
        } 
        
    };

	//showGridRowDetailIcon QueryView: QV_2921_98487
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_2921_98487 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

	//Entity: ExtendsQuota
    //ExtendsQuota.extendsDate (DateField) View: ExtendsQuotaForm
    
    task.customValidate.Spacer2497 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if (entities.ExtendsQuota.extendsDate === null || entities.ExtendsQuota.extendsDate === ""){
		   customValidateEventArgs.errorMessage='Formato Invalido'; 
        customValidateEventArgs.isValid = false; 
		entities.ExtendsQuota.extendsDate="";
            
            } else{
		customValidateEventArgs.isValid = true; 
        }
        
    };

	//CurrentQuotasQuery Entity: 
    task.executeQuery.Q_CURRENAT_2921 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };;

	//ExtendsQuotaExtQuery Entity: 
    task.executeQuery.Q_EXTENDEX_5312 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

	//gridInitDetailTemplate QueryView: QV_2921_98487
    //
    task.gridInitDetailTemplate.QV_2921_98487 = function (entities, gridInitDetailTemplateEventArgs) {
        gridInitDetailTemplateEventArgs.commons.execServer = false;
        
    };

	//gridRowSelecting QueryView: QV_2921_98487
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_2921_98487 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
		gridRowSelectingEventArgs.commons.api.viewState.show('G_EXTENDSAUQ_349662');
      
       // var fecha = new Date(gridRowSelectingEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].endDate);
        entities.ExtendsQuota.extendsDate =  entities.ExtendsQuota.processDate;
        entities.ExtendsQuota.numberQuota =  gridRowSelectingEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].quota;
        entities.ExtendsQuota.expirationDate = gridRowSelectingEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].endDate;  
        
    };



}));