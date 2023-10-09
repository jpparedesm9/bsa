/* variables locales de T_ASSTSFIQJZFID_726*/
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

    
        var task = designerEvents.api.accountstatusform;
    

    //"TaskId": "T_ASSTSFIQJZFID_726"
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
    args.model.Loan.clientName = customerCode + " - " + CustomerName;
    args.model.Loan.clientID = customerCode;
    
    //Limpiar cajas de texto antes de buscar
    
    
};

    // (Button) 
    task.executeCommand.CM_TASSTSFI_AS9 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
    };

// (Button) 
    task.executeCommandCallback.CM_TASSTSFI_AS9 = function(entities, executeCommandCallback) {
        executeCommandCallback.commons.execServer = false;		
		var itemReporte = "AccountStatus";
		var flag = 0;
		var tittle ='';

		if(executeCommandCallback.success){
            for (var i = 0; i <= entities.AccountStatus.data().length - 1; i++) {				
                if(entities.AccountStatus.data()[i].toPrint === true){
            		flag = 1;
		     		var date = new Date(entities.AccountStatus.data()[i].date);
		     		var year = date.getFullYear();
		     		var month = date.getMonth()+1
		     		var day = date.getDate();
		     		var dateEn = day +"/" + month + "/" + year
		     		var sequential = 0;
		     		
                    var args = [['report.module', 'cartera'],['report.name', itemReporte],
            		            ['PBankNumber',entities.AccountStatus.data()[i].bankNumber],['PDate',dateEn],['PSequential',entities.AccountStatus.data()[i].sequential]];	
                    tittle = cobis.translate('ASSTS.LBL_ASSTS_ESTADOCAE_42774');								
                    ASSETS.Utils.generarReporte(null, args, tittle);
                }
            }
            if(flag===0){
		     	 var mns = cobis.translate('ASSTS.LBL_ASSTS_DEBESELCL_95286');
            	 executeCommandEventArgs.commons.messageHandler.showMessagesInformation(mns, true);
            }		
		}        
    };

// (Button) 
    task.executeCommand.CM_TASSTSFI_S64 = function(entities, executeCommandEventArgs) {
		executeCommandEventArgs.commons.execServer = false;
		var ds = executeCommandEventArgs.commons.api.vc.model['AccountStatus'];
        var dsData = ds.data();
		var flag = 1;
		var send = 'N';
        for (var i = 0; i < dsData.length; i++) {
            var dsRow = dsData[i];
			if(dsRow.toPrint === true){
				send = 'S';
				if(dsRow.email === '' || dsRow.email === undefined || dsRow.email === null){
					flag = 2;
					executeCommandEventArgs.commons.messageHandler.showMessagesInformation("ASSTS.MSG_ASSTS_CLIENTEUN_99499");
				}
			}
        }
		
		if(send === 'N'){
			var mns = cobis.translate('ASSTS.LBL_ASSTS_DEBESELCL_95286');
			executeCommandEventArgs.commons.messageHandler.showMessagesInformation(mns, true);
		}else{
			if(flag == 1){
			executeCommandEventArgs.commons.execServer = true;
			}	
		}
    };

// (Button) 
    task.executeCommandCallback.CM_TASSTSFI_S64 = function(entities, executeCommandCallback) {
        executeCommandCallback.commons.execServer = false;
        
    };

//Entity: Loan
    //Loan. (Button) View: AccountStatusForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONPMSVXME_604859 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.Loan = true;
    };

//Entity: Loan
    //Loan. (Button) View: AccountStatusForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONPMSVXME_604859 = function(  entities, executeCommandCallback ) {
        executeCommandCallback.commons.execServer = false;
        if(executeCommandCallback.success){
            executeCommandCallback.commons.api.viewState.enable('CM_TASSTSFI_AS9',true);
            executeCommandCallback.commons.api.viewState.enable('CM_TASSTSFI_S64',true);
        } else {
        	executeCommandCallback.commons.api.grid.removeAllRows('AccountStatus');
        }
    };

//AccountStatusQuery Entity: 
    task.executeQuery.Q_ACCOUNSS_3580 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

task.gridInitColumnTemplate.QV_3580_21558 = function (idColumn) {
        if (idColumn === 'toPrint') {
        return "<input type=\'checkbox\' ng-model='dataItem.toPrint' name=\'toPrint\' id=\'VA_CHECKBOXDCCDNZV_992859\' #if (toPrint) {# checked #}else{# unchecked #} # />";
    }
};

task.gridInitEditColumnTemplate.QV_3580_21558 = function (idColumn) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: AccountStatusForm
    task.initData.VC_ACCOUNTSSA_935726 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
    };

//Entity: Loan
    //Loan.clientName (TextInputButton) View: AccountStatusForm
    
    task.textInputButtonEvent.VA_CLIENTNAMEEZJBH_766859 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
        nav.customAddress = {
            id: "findCustomer"
            , url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER
            , files: ["/customer/services/find-customers-srv.js"
                 , "/customer/controllers/find-customers-ctrl.js"]
          }];
        nav.customDialogParameters = {};
        
    };

//Entity: Loan
    //Loan.clientName (TextInputButton) View: AccountStatusForm
    
    task.textInputButtonEventGrid.VA_CLIENTNAMEEZJBH_766859 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: AccountStatusForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
        document.getElementById('VA_CLIENTNAMEEZJBH_766859').readOnly=true;
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSFI_AS9");
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSFI_S64"); 
    };

//gridRowSelecting QueryView: QV_3580_21558
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_3580_21558 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };



}));