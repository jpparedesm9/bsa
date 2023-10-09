<!-- Designer Generator v 6.1.0 - release SPR 2016-21 20/10/2016 -->
/*global designerEvents, console */ (function() {
    "use strict";

    //*********** COMENTARIOS DE AYUDA **************
    //  Para imprimir mensajes en consola 
    //  console.log("executeCommand");

    //  Para enviar mensaje use 
    //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

    //  Para evitar que se continue con la validación a nivel de servidor
    //  eventArgs.commons.execServer = false;

    var task = designerEvents.api.projectionquotaformmain;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: Loan
    //Loan.loanBankID (TextLink) View: View of LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl. 
    task.executeCommand.VA_VASIMPLELABELLL_867612 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
        // executeCommandEventArgs.commons.serverParameters.Loan = true;
    };
//Start signature to callBack event to CM_TPROJECT_N0M
 /*   task.executeCommandCallback.CM_TPROJECT_N0M = function(entities, executeCommandEventArgs) {
        //here your code
		entities.ProjectionQuota.currentAmountDue = parseFloat( entities.ProjectionQuota.currentAmountDue )+  parseFloat('USD');
        entities.ProjectionQuota.amountOverdue = parseFloat(entities.ProjectionQuota.amountOverdue ) + " USD";
        entities.ProjectionQuota.prepaymentAmount = parseFloat(entities.ProjectionQuota.prepaymentAmount )+ " USD";
		
    };*/
//Entity: ProjectionQuota
    //ProjectionQuota.projectionDays (TextInputBox) View: ProjectionQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DIASPROYECCIONO_148517 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        
    };
    //Entity: ProjectionQuota
    //ProjectionQuota.fechaProyeccion (DateField) View: View of ProjectionQuotaForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl. 
    task.change.VA_FECHAPROYECCOIN_790517 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = true;
        // changedEventArgs.commons.serverParameters.ProjectionQuota = true;
	    };
	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONWVITZRQ_108612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
    };

	//Entity: Loan
    //Loan. (Button) View: LoanHeaderInfoForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONORYJAMS_468612 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
          executeCommandEventArgs.commons.api.vc.closeDialog();
        var subModuleId = "CMMNS",
          taskId = "T_LOANSEARCHSWA_959",
          vcId = "VC_LOANSEARHC_144959",
          parameters = '',
          label="Búsqueda de Préstamos";
      ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, executeCommandEventArgs, parameters);
    };
 
	
	
    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Command1 (Button) 
   task.executeCommand.CM_TPROJECT_N0M = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = true;
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento Render: Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales.
    //ViewContainer: ViewContainerBase 
    task.render = function(entities, renderEventArgs) {
	 renderEventArgs.commons.execServer = false;
	  entities.ProjectionQuota.typeCalculation='S';
	  var  api = renderEventArgs.commons.api; 
      api.vc.viewState.VA_TIPOUWNWJMGVYCI_648517.disabled = false;
 	ASSETS.Header.setDataStyle ("VC_PROJECTIIU_405244", "VC_SQRMWXXWBH_255244", entities, renderEventArgs);
    	          };
		   
		   
		   task.executeCommand.VA_VASIMPLELABELLL_867612 = function( entities, executeCommandEventArgs ) {
                executeCommandEventArgs.commons.execServer = false;
                ASSETS.Header.showPopupDetail(entities, executeCommandEventArgs);
  }


    //Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ProjectionQuotaFormMain
    task.initData.VC_PROJECTIIU_405244 = function (entities, initDataEventArgs){
	
        initDataEventArgs.commons.execServer = false;
                var commons = initDataEventArgs.commons;
		var api=initDataEventArgs.commons.api;
		var parameters=api.navigation.getCustomDialogParameters();		
		entities.LoanInstancia = parameters.parameters.loanInstancia;
		commons.execServer = true;
        
    };
	
	
		//Entity: ProjectionQuota
    //ProjectionQuota.projectionDate (DateField) View: ProjectionQuotaForm
    
    task.customValidate.VA_FECHAPROYECCOIN_790517 = function( entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;
		if (entities.ProjectionQuota.projectionDate === null || entities.ProjectionQuota.projectionDate === ""){
		   customValidateEventArgs.errorMessage='Formato Ivalido'; 
        customValidateEventArgs.isValid = false; 
		entities.ProjectionQuota.projectionDate="";
		entities.ProjectionQuota.projectionDays="";
		} else{
		customValidateEventArgs.isValid = true; 
        }
    };
	


}());