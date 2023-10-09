
/* variables locales de T_REAJUSTESRCSN_872*/

/* variables locales de T_LOANHEADERNFI_316*/

/* variables locales de T_REAJUSTECAMMB_801*/

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

    
        var task = designerEvents.api.reajuste;
    

    /*"TaskId": "T_REAJUSTESRCSN_872",*/
    //Your code here

    	//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: REAJUSTE
    task.initData.VC_REAJUSTEKP_207872 = function (entities, initDataEventArgs){
        try{
	       var commons = initDataEventArgs.commons;
	       var api=initDataEventArgs.commons.api;
           var parameters=api.navigation.getCustomDialogParameters();		
           entities.LoanInstancia = parameters.parameters.loanInstancia;
	       commons.execServer = true; 
        } catch(err){
			ASSETS.Utils.managerException(err);
        }
        
    };

	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: REAJUSTE
    task.render = function (entities, renderEventArgs){
        try {
            ASSETS.Header. setDataStyle ("VC_REAJUSTEKP_207872", "VC_VPRGARGERZ_116872", entities, renderEventArgs);
    	} catch(err) {
            ASSETS.Utils.managerException(err);
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

	//showGridRowDetailIcon QueryView: QV_5831_17646
    //Evento ShowGridRowDetailIcon: Evento que define si presentar u ocultar el ícono de detalle de grilla
    task.showGridRowDetailIcon.QV_5831_17646 = function (entities, showGridRowDetailIconEventArgs) {
        return true;
    };

	//gridInitDetailTemplate QueryView: QV_5831_17646
//
task.gridInitDetailTemplate.QV_5831_17646 = function (entities, gridInitDetailTemplateEventArgs) {
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
			ASSETS.Utils.managerException(err);
        }
};

	//gridRowDeleting QueryView: QV_5831_17646
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_5831_17646 = function (entities, gridRowDeletingEventArgs) {
        gridRowDeletingEventArgs.commons.execServer = true;
        //gridRowDeletingEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
    };

	//gridRowUpdating QueryView: QV_5831_17646
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_5831_17646 = function (entities, gridRowUpdatingEventArgs) {
        gridRowUpdatingEventArgs.commons.execServer = true;
        //gridRowUpdatingEventArgs.commons.serverParameters.ReadjustmentLoanCab = true;
    };



}));