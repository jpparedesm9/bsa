
/* variables locales de T_APPLYCLAUSEEE_533*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_AMORTIZATIOON_261*/

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

    
        var task = designerEvents.api.applyclause;
    

    //"TaskId": "T_APPLYCLAUSEEE_533"

    	// (Button) 
    task.executeCommand.CM_APPLYCLA_C1S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to callBack event to CM_APPLYCLA_C1S
    task.executeCommandCallback.CM_APPLYCLA_C1S = function(entities, executeCommandEventArgs) {
        //here your code
        ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
        ASSETS.Amortization.resizeGrid("QV_8237_80795");
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ApplyClause
    task.initData.VC_APPLYCLASS_521533 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia =parameters.parameters.loanInstancia;
		commons.execServer = true;
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ApplyClause
    task.initDataCallback.VC_APPLYCLASS_521533 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ApplyClause
    task.render = function (entities, renderEventArgs){
         renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_APPLYCLASS_521533","VC_ZFLEAUPGRQ_436533",entities, renderEventArgs); 
                 
        ASSETS.Amortization.showTableAmortization(entities, renderEventArgs);
        
        ASSETS.Amortization.CapitalBalance(entities.Amortization.data());
        ASSETS.Amortization.resizeGrid("QV_8237_80795");
        
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

	//gridRowSelecting QueryView: QV_8237_80795
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_8237_80795 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        //Open Modal
        var nav = gridRowSelectingEventArgs.commons.api.navigation;
        nav.label = gridRowSelectingEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_DESGLOSCO_45546');
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'MNTNN',
            taskId: 'T_AMORTIZATIDTE_881',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_AMORTIZATE_895881'
        };
        nav.queryParameters = {
            mode: 2
        };
        nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
        };        
        nav.customDialogParameters = {
            dividend: gridRowSelectingEventArgs.rowData.share,
            loanBankID: entities.Loan.loanBankID
        };        
        nav.openModalWindow('QV_8237_80795', gridRowSelectingEventArgs.rowData);
        
    };



}));