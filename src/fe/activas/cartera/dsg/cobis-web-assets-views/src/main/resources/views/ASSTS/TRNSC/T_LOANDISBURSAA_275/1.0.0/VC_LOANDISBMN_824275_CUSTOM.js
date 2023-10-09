
/* variables locales de T_LOANDISBURSAA_275*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_DISBURSEMENNN_810*/

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

    
        var task = designerEvents.api.loandisbursementmain;
    

    //"TaskId": "T_LOANDISBURSAA_275"

    	// (Button) 
    task.executeCommand.CM_TLOANDIS_S5N = function(entities, executeCommandEventArgs) {
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
      if(entities.LiquidateResult.sumTotal > entities.DisbursementResult.sumTotal){
         executeCommandEventArgs.commons.execServer = false;
         executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_ERRORELDR_83907'),true);
      }else{
      	executeCommandEventArgs.commons.execServer = true;	
      }
    };

	//Start signature to callBack event to CM_TLOANDIS_S5N
    task.executeCommandCallback.CM_TLOANDIS_S5N = function(entities, executeCommandEventArgs) {
        //here your code
        if(executeCommandEventArgs.success){
        
         executeCommandEventArgs.commons.api.vc.viewState.CM_TLOANDIS_S5N.disabled = true;
         //executeCommandEventArgs.commons.api.vc.viewState.CEQV_201QV_5973_48889_606.disabled = false;
         
         //executeCommandEventArgs.commons.api.vc.closeDialog();
         //var subModuleId = "CMMNS",
         //taskId = "T_LOANSEARCHSWA_959",
         //vcId = "VC_LOANSEARHC_144959",
         //parameters = '',
         //label="BÃºsqueda de PrÃ©stamos";
         //ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);        
      }
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanDisbursementMain
    task.initData.VC_LOANDISBMN_824275 = function (entities, initDataEventArgs){
        //initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        var commons = initDataEventArgs.commons;
         var api=initDataEventArgs.commons.api;
         var parameters=api.navigation.getCustomDialogParameters();
         entities.LoanInstancia = parameters.parameters.loanInstancia;
         commons.execServer = true;
    };

	//Start signature to callBack event to VC_LOANDISBMN_824275
    task.initDataCallback.VC_LOANDISBMN_824275 = function(entities, initDataEventArgs) {
        //here your code
        var cmm = initDataEventArgs.commons;
      if(entities.LoanInstancia.errorValidation == true){
         cmm.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_PRSTAMOYS_82498')+entities.Loan.status,true);
      }
      if(!initDataEventArgs.success || entities.LoanInstancia.errorValidation == true){         
         cmm.api.vc.closeDialog();
         var subModuleId = "CMMNS",
         taskId = "T_LOANSEARCHSWA_959",
         vcId = "VC_LOANSEARHC_144959",
         parameters = '',
         label="BÃºsqueda de PrÃ©stamos";
         ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, initDataEventArgs, parameters);        
      }
     
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: LoanDisbursementMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
         try{
         var isCancel =  false; 
        var dataResult ;
        if (onCloseModalEventArgs.closedViewContainerId == "VC_PAYMENTMDE_245368") {
            if (typeof onCloseModalEventArgs.result === "boolean") {
                isCancel = onCloseModalEventArgs.result;
            }
            if (!isCancel && typeof onCloseModalEventArgs.result.data !== "undefined") {
               dataResult = onCloseModalEventArgs.result.data;
               onCloseModalEventArgs.commons.execServer = true;
            }
        }
      }catch(err) {
         console.log('Error='+err);
         onCloseModalEventArgs.commons.execServer = true;
      }
        
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: LoanDisbursementMain
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanDisbursementMain
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        ASSETS.Header.setDataStyle("VC_LOANDISBMN_824275","VC_VBHENKGGPP_117275",entities, renderEventArgs); 
        entities.LoanAdditionalInformation.lblAmountToCancel = 
            cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152')+': '+            
            kendo.toString(entities.LoanAdditionalInformation.amountOperation, 'c') +
            " "+entities.Loan.currencyName + " " +
            cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924')+': '+
            entities.LoanAdditionalInformation.quotation;
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

	//DetailPaymentFormQuery Entity: 
    task.executeQuery.Q_DETAILAP_5973 = function(executeQueryEventArgs){
        executeQueryEventArgs.commons.execServer = true;
        executeQueryEventArgs.commons.serverParameters.DisbursementResult = true;
    };;

	//gridCommand (Button) QueryView: QV_5973_48889
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_5973_48889_606 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DetailPaymentForm = true;
        //Open Modal
      var nav = gridExecuteCommandEventArgs.commons.api.navigation;
      if(entities.LiquidateResult.sumTotal > entities.DisbursementResult.sumTotal){      
         nav.label = cobis.translate('ASSTS.LBL_ASSTS_APAGOKXFB_84081'); //Forma de Pago
         nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_PAYMENTMODEEE_368',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_PAYMENTMDE_245368'
         };
         nav.queryParameters = {
            mode: 1
         };
         nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
         };
         
         nav.customDialogParameters = {
            operationTypeId: entities.Loan.operationTypeID,
            codCurrency: entities.Loan.codCurrency,
            dateToDisburse: entities.LoanAdditionalInformation.dateToDisburse,
            loanAddInf: entities.LoanAdditionalInformation,
            difference: entities.DisbursementResult.difference,
            loanBankID: entities.Loan.loanBankID,
            loan:entities.Loan
         }; 
         nav.openModalWindow("CEQV_201QV_5973_48889_606", gridExecuteCommandEventArgs);      
      }else{         
         gridExecuteCommandEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate('ASSTS.MSG_ASSTS_ELDESEMST_32467'));
      }
    };

	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DisbursementForm
    task.initData.VC_DISBURSEMT_116810 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

	//gridRowDeleting QueryView: QV_5973_48889
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_5973_48889 = function (entities, gridRowDeletingEventArgs) {
        if(gridRowDeletingEventArgs.commons.api.vc.viewState.CM_TLOANDIS_S5N.disabled == false){
         gridRowDeletingEventArgs.commons.execServer = true;
      }else{
         gridRowDeletingEventArgs.commons.execServer = false;
         gridRowDeletingEventArgs.cancel=true;
      }
    };

	//Start signature to callBack event to QV_5973_48889
    task.gridRowDeletingCallback.QV_5973_48889 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        console.log('entities.Loan.loanBankID='+entities.Loan.loanBankID);
    };

	//gridRowSelecting QueryView: QV_5973_48889
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5973_48889 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
        console.log('entities.Loan.loanBankID='+entities.Loan.loanBankID);
        //gridRowSelectingEventArgs.commons.serverParameters.DetailPaymentForm = true;
    };



}));