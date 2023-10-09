/* variables locales de T_ASSTSOSPSJXWE_883*/
var isGroup = 'N';
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

    
        var task = designerEvents.api.regularizedispersionsrejectedform;
    

    //"TaskId": "T_ASSTSOSPSJXWE_883"
task.gridRowCommand.VA_CHECKBOXIZTQJZZ_773759 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.DetailRejectedDispersions.data().length; i++) {
        if (i === index)
            entities.DetailRejectedDispersions.data()[i].selection = !entities.DetailRejectedDispersions.data()[i].selection;
    }
    ASSETS.API.changeImageChecker(entities, args);
};



    // (Button) 
    task.executeCommand.CM_TASSTSOS_ASN = function(entities, executeCommandEventArgs) {
        var selection = 0;
        if (entities.DetailRejectedDispersions.data().length == 0){
             executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_NOEXISTSG_21670'),true);
            executeCommandEventArgs.commons.execServer = false;
            }
        for (var i=0; i < entities.DetailRejectedDispersions.data().length; i++){
                                
               if (entities.DetailRejectedDispersions.data()[i].selection != undefined || entities.DetailRejectedDispersions.data()[i].selection != false){
                
                   selection = selection + 1
                   
            }
            }
        if (selection == 0){
            executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_SELECCINT_52125'),true);
                   executeCommandEventArgs.commons.execServer = false;
               }else {
                   executeCommandEventArgs.commons.execServer = true; 
               }
        //executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to Callback event to CM_TASSTSOS_ASN
task.executeCommandCallback.CM_TASSTSOS_ASN = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3655_99787');
};

// (Button) 
    task.executeCommand.CM_TASSTSOS_EAN = function(entities, executeCommandEventArgs) {
       var selection = 0;
        if (entities.DetailRejectedDispersions.data().length == 0){
             executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_NOEXISTSG_21670'),true);
            executeCommandEventArgs.commons.execServer = false;
            }
        for (var i=0; i < entities.DetailRejectedDispersions.data().length; i++){
                                
               if (entities.DetailRejectedDispersions.data()[i].selection != undefined || entities.DetailRejectedDispersions.data()[i].selection != false){
                
                   selection = selection + 1
                   
            }
            }
        if (selection == 0){
            executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_SELECCINT_52125'),true);
                   executeCommandEventArgs.commons.execServer = false;
               }else {
                   executeCommandEventArgs.commons.execServer = true; 
               }
        //executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to Callback event to CM_TASSTSOS_EAN
task.executeCommandCallback.CM_TASSTSOS_EAN = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3655_99787');
};

// (Button) 
    task.executeCommand.CM_TASSTSOS_SJO = function(entities, executeCommandEventArgs) {
     var selection = 0;
        if (entities.DetailRejectedDispersions.data().length == 0){
             executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_NOEXISTSG_21670'),true);
            executeCommandEventArgs.commons.execServer = false;
            }
        for (var i=0; i < entities.DetailRejectedDispersions.data().length; i++){
                                
               if (entities.DetailRejectedDispersions.data()[i].selection != undefined || entities.DetailRejectedDispersions.data()[i].selection != false){
                
                   selection = selection + 1
                   
            }
            }
        if (selection == 0){
            executeCommandEventArgs.commons.messageHandler.showMessagesError(cobis.translate('ASSTS.MSG_ASSTS_SELECCINT_52125'),true);
                   executeCommandEventArgs.commons.execServer = false;
               }else {
                   executeCommandEventArgs.commons.execServer = true; 
               }
        //executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to Callback event to CM_TASSTSOS_SJO
task.executeCommandCallback.CM_TASSTSOS_SJO = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3655_99787');
};

//Entity: SearchRejectedDispersions
    //SearchRejectedDispersions. (Button) View: RegularizeDispersionsRejectedForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONCBSQYDU_564759 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    
        
    };

//DetailRejectedDispersionsQuery Entity: 
    task.executeQuery.Q_DETAILTI_3655 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true; 
        var custom = "";
		var group = "";
		if (executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.action == null || executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.action != '1'){
            executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_294');
			executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_212');
            executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_480');
			$('#CEQV_201QV_3655_99787_294').attr("disabled",true);
            $('#CEQV_201QV_3655_99787_480').attr("disabled",true);
            $('#CEQV_201QV_3655_99787_212').attr("disabled",true);
			executeQueryEventArgs.commons.api.grid.hideColumn('QV_3655_99787','selection');
        }else{
			executeQueryEventArgs.commons.api.grid.showToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_294');
            executeQueryEventArgs.commons.api.grid.showToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_480');
            executeQueryEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787','CEQV_201QV_3655_99787_212');
            $('#CEQV_201QV_3655_99787_294').attr("disabled",false);
            $('#CEQV_201QV_3655_99787_480').attr("disabled",false);
            $('#CEQV_201QV_3655_99787_212').attr("disabled",false);
			executeQueryEventArgs.commons.api.grid.showColumn('QV_3655_99787','selection');
        }
		
		if (isGroup == 'N'){
			custom = executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.customerCode;
		}else{
			group = executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.customerCode;
        }
		
			
        var filtro = {
			customerCode : custom,
			groupCode : group,
            action: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.action,
            account: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.account,
            startDate: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.startDate,
            endDate: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.endDate,
            type: executeQueryEventArgs.commons.api.vc.model.SearchRejectedDispersions.type 
        };
        executeQueryEventArgs.commons.api.vc.parentVc = {}
        executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    };;

//gridCommand (Button) QueryView: QV_3655_99787
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_3655_99787_212 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DetailRejectedDispersions = true;
        ASSETS.API.checker(entities,gridExecuteCommandEventArgs);
    };

//gridCommand (Button) QueryView: QV_3655_99787
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_3655_99787_480 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DetailRejectedDispersions = true;
        ASSETS.API.checker(entities,gridExecuteCommandEventArgs);
    };

task.gridInitColumnTemplate.QV_3655_99787 = function (idColumn) {
        if (idColumn === 'selection') {
        return "<input type=\'checkbox\' name=\'selection\' id=\'VA_CHECKBOXIZTQJZZ_773759' #if (selection === true) {# checked #}# ng-click=\"vc.grids.QV_3655_99787.events.customRowClick($event, \'VA_CHECKBOXIZTQJZZ_773759', \'DispersionsRejected\', \'QV_3655_99787\')\"/>";
    }
    };

task.gridInitEditColumnTemplate.QV_3655_99787 = function (idColumn) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: RegularizeDispersionsRejectedForm
    task.initData.VC_REGULARIOE_732883 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: RegularizeDispersionsRejectedForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        var resp = onCloseModalEventArgs.commons.api.vc.dialogParameters;
        var customerCode = resp.CodeReceive;
        var CustomerName = resp.name;
		var customerType = resp.customerType;	
		var title = '';
		switch (customerType) {
		case 'P':
			title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
			isGroup = 'N';
			break;
		case 'C':
			title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';
			isGroup = 'N';
			break;
		case 'S':
			title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
			isGroup = 'S';
			break;
		case 'G':
			title = 'ASSTS.LBL_ASSTS_CDIGOGRPU_89879';
			isGroup = 'S';
			break;
		}
		
        entities.SearchRejectedDispersions.customerCode = customerCode;
		onCloseModalEventArgs.commons.api.viewState.label("VA_CUSTOMERCODEOES_830759",title);
    };

//Entity: SearchRejectedDispersions
    //SearchRejectedDispersions.customerCode (TextInputButton) View: RegularizeDispersionsRejectedForm
    
    task.textInputButtonEvent.VA_CUSTOMERCODEOES_830759 = function( textInputButtonEventArgs ) {

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

//Entity: SearchRejectedDispersions
    //SearchRejectedDispersions.customerCode (TextInputButton) View: RegularizeDispersionsRejectedForm
    
    task.textInputButtonEventGrid.VA_CUSTOMERCODEOES_830759 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RegularizeDispersionsRejectedForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        //task.showButtons(renderEventArgs)
        ASSETS.API.changeImageChecker(entities, renderEventArgs);
        
        $('#CEQV_201QV_3655_99787_294').attr("disabled",false);
        $('#CEQV_201QV_3655_99787_480').attr("disabled",false);
        $('#CEQV_201QV_3655_99787_212').attr("disabled",false);

		entities.SearchRejectedDispersions.action = 1;
    };



}));