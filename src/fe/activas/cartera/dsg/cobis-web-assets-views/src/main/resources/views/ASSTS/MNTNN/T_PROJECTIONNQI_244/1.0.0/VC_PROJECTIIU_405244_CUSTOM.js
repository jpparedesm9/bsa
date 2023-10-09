
/* variables locales de T_PROJECTIONNQI_244*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_PROJECTIONATU_621*/

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

    
        var task = designerEvents.api.projectionquotaformmain;
    

    //"TaskId": "T_PROJECTIONNQI_244"

    	// (Button) 
    task.executeCommand.CM_TPROJECT_N0M = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        if (entities.Loan.status == 'NO VIGENTE' || entities.Loan.status == 'CANCELADO' || entities.Loan.status == 'CREDITO' || entities.Loan.status == 'COMEX') {
            executeCommandEventArgs.commons.execServer = false;
            executeCommandEventArgs.commons.messageHandler.showMessagesInformation('ASSTS.MSG_ASSTS_ESTADONPO_17159', true);
        }
    };

	//Start signature to Callback event to CM_TPROJECT_N0M
task.executeCommandCallback.CM_TPROJECT_N0M = function(entities, executeCommandCallbackEventArgs) {
//here your code
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ProjectionQuotaFormMain
    task.initData.VC_PROJECTIIU_405244 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
    var api = initDataEventArgs.commons.api;
    var parameters = api.navigation.getCustomDialogParameters();
    entities.LoanInstancia = parameters.parameters.loanInstancia;
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: ProjectionQuotaFormMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        entities.ProjectionQuota.typeCalculation = 'S';
        var api = renderEventArgs.commons.api;
        api.vc.viewState.VA_TIPOUWNWJMGVYCI_648517.disabled = false;
        ASSETS.Header.setDataStyle("VC_PROJECTIIU_405244", "VC_XAGJYCIGBI_296244", entities, renderEventArgs);
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

	//Entity: ProjectionQuota
    //ProjectionQuota.projectionDays (TextInputBox) View: ProjectionQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DIASPROYECCIONO_148517 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
    };

	//Entity: ProjectionQuota
    //ProjectionQuota.projectionDate (DateField) View: ProjectionQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_FECHAPROYECCOIN_790517 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
    };

	//Entity: ProjectionQuota
    //ProjectionQuota.projectionDate (DateField) View: ProjectionQuotaForm
    
    task.customValidate.VA_FECHAPROYECCOIN_790517 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
        if (entities.ProjectionQuota.projectionDate === null || entities.ProjectionQuota.projectionDate === "") {
            customValidateEventArgs.errorMessage = 'Formato Invalido';
            customValidateEventArgs.isValid = false;
            entities.ProjectionQuota.projectionDate = "";
            entities.ProjectionQuota.projectionDays = "";
        } else {
            customValidateEventArgs.isValid = true;
        }
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ProjectionQuotaForm
    task.initData.VC_PROJECTITO_707621 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        
    };



}));