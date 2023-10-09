<!-- Designer Generator v 6.1.0 - release SPR 2016-21 20/10/2016 -->
/* global designerEvents, console */ (function() {
    "use strict";

    // *********** COMENTARIOS DE AYUDA **************
    // Para imprimir mensajes en consola
    // console.log("executeCommand");

    // Para enviar mensaje use
    // eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando
	// comando personalizado');

    // Para evitar que se continue con la validación a nivel de servidor
    // eventArgs.commons.execServer = false;

    var task = designerEvents.api.reajuste;

    // descomentar la siguiente linea para que siempre se ejecute el evento
	// change en todos los controles de cabecera.
    // task.changeWithError.allGroup = true;

    // descomentar la siguiente linea para que siempre se ejecute el evento
	// change en todos los controles de grilla.
    // task.changeWithError.allGrid = true;

    	// showGridRowDetailIcon QueryView: QV_5831_17646
    // Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el
	// ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_5831_17646 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };
    
    // **********************************************************
    // Acciones de QUERY VIEW
    // **********************************************************
    // hasDetail QueryView: QV_5831_17646
    // Evento GridInitDetailTemplate: Inicialización de datos del formulario del
	// detalle de un registro de la grilla de datos
    task.gridInitDetailTemplate.QV_5831_17646 = function(entities, gridInitDetailTemplateArgs) {        
         gridInitDetailTemplateArgs.commons.execServer = false;
         
        try
        {
        	var nav = gridInitDetailTemplateArgs.commons.api.navigation;

          nav.address = {
              moduleId : 'ASSTS',
              subModuleId : 'MNTNN',
              taskId : 'T_REAJUSTEDEFTF_264',
              taskVersion : '1.0.0',
              viewContainerId : 'VC_REAJUSTEMF_502264'
          };
          
          nav.customDialogParameters = {
              readjustmentLoanCab:gridInitDetailTemplateArgs.modelRow              
          };
          nav.openDetailTemplate('QV_5831_17646', gridInitDetailTemplateArgs.modelRow);
        }
        catch(err)
        {
         alert(err.message);
        }
    };
   
	// gridRowDeleting QueryView: QV_5831_17646
    // Se ejecuta antes de que los datos eliminados en una grilla sean
	// comprometidos.
    task.gridRowDeleting.QV_5831_17646 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        // gridRowDeletingEventArgs.commons.serverParameters.ReadjustmentLoanCab
		// = true;
    };
    
	// gridRowUpdating QueryView: QV_5831_17646
    // Se ejecuta antes de que los datos modificados en una grilla sean
	// comprometidos.
    task.gridRowUpdating.QV_5831_17646 = function (entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = true;
        // gridRowUpdatingEventArgs.commons.serverParameters.ReadjustmentLoanCab
		// = true;
    };
    
    	// Evento initData : Inicialización de datos del formulario, después de
		// este evento se realiza el seguimiento de cambios en los datos
    // ViewContainer: REAJUSTE
    task.initData.VC_REAJUSTEKP_207872 = function (entities, initDataEventArgs){       	
        try
        {
    var customParams = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
   
   if (customParams !== undefined)
   {
      entities.Loan = customParams.Loan;
   }
   else
   {
   // entities.Loan.loanBankID = "140150123275";
   entities.Loan.loanBankID = "140150123275";
   }
        initDataEventArgs.commons.execServer = true;  
        }
        catch(err)
        {
         alert(err.message);
        }      
    };
    
    	// Evento ExecuteLabelCommand: Permite personalizar la acción a ejecutar
		// de un label de un input control.
    task.executeLabelCommand.VA_VASIMPLELABELLL_867612 = function( entities, executeLabelCommandEventArgs ) {
        executeLabelCommandEventArgs.commons.execServer = false;        
    };
    
    task.render = function(entities, renderEventArgs){
   ASSETS.Header. setDataStyle ("VC_REAJUSTEKP_207872", "VC_HLCOFBWFEL_155316", entities, renderEventArgs);
    }
}());