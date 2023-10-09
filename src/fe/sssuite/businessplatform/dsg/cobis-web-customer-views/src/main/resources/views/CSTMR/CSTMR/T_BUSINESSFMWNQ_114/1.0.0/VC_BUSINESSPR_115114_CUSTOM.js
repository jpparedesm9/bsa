/* variables locales de T_BUSINESSFMWNQ_114*/
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

    
        var task = designerEvents.api.businessform;
    

    //"TaskId": "T_BUSINESSFMWNQ_114"

var showHeader = true;
var section = null;
var taskHeader = {};
var ban =true;

task.closeModalEvent.findCustomer = function (args) {
    
    args.model.CustomerTmpBusiness.code = args.result.selectedData.code;
    args.model.CustomerTmpBusiness.businessName = args.result.selectedData.commercialName;
    args.model.CustomerTmpBusiness.name = args.result.selectedData.name;
    args.model.CustomerTmpBusiness.isGroup = args.result.selectedData.isGroup;
    args.model.CustomerTmpBusiness.customerType = args.result.selectedData.customerType;
    args.model.CustomerTmpBusiness.documentNumber = args.result.selectedData.documentId;
    args.model.CustomerTmpBusiness.documentType = args.result.selectedData.documentType;
    args.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304', 'FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);
    
};

    //Entity: CustomerTmp
    //CustomerTmp. (Button) View: BusinessForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONJPSJYQV_906304 = function(  entities, executeCommandEventArgs ) {
    
    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmpBusiness.code == null){
    entities.CustomerTmpBusiness.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    executeCommandEventArgs.commons.serverParameters.Business= true;
};

//Start signature to Callback event to VA_VABUTTONJPSJYQV_906304
task.executeCommandCallback.VA_VABUTTONJPSJYQV_906304 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if (executeCommandCallbackEventArgs.success) {
        if (ban){
        if (showHeader) {
            if(entities.CustomerTmpBusiness.customerType == 'P'){
                LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpBusiness.name, 0);
            }else{
                LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmpBusiness.businessName, 0);
            }
            LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmpBusiness.documentNumber, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmpBusiness.documentType, 1);
            LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmpBusiness.code, 2);
            LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_BUSINESSSS_428304');
            executeCommandCallbackEventArgs.commons.api.viewState.show('G_BUSINESSSS_428304');
        } else {
            //Para VCC
            executeCommandCallbackEventArgs.commons.api.viewState.hide('G_BUSINESSSS_428304');
        }
      }
        
    }
    
    
};

//undefined Entity: 
    task.executeQuery.Q_BUSINESS_6359 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//gridRowRendering QueryView: QV_6359_40398
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_6359_40398 = function (entities,gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    
    if(screenMode == 'Q'){
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_6359_40398', 'create');        
        var dsBusiness = entities.Business.data();
        for (var i = 0; i < dsBusiness.length; i++) {   
            var dsRow = dsBusiness[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_6359_40398', dsRow, 'delete');   
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_6359_40398', dsRow, 'edit');
        }
        
    }
            
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BusinessForm
task.initData.VC_BUSINESSPR_115114 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = true;
    initDataEventArgs.commons.serverParameters.Business = true;
    initDataEventArgs.commons.serverParameters.CustomerTmpBusiness = true;
    
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc =  initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;


    if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
		
		nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
			url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
			files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
        }];
        nav.customDialogParameters = {
            mode: "findCustomer"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
                
    }
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: BusinessForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
    onCloseModalEventArgs.commons.execServer = false;
    
    
    var isAccept;

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ECONOMICOU_167751') {
        if (typeof onCloseModalEventArgs.result === "boolean") {
            isAccept = onCloseModalEventArgs.result;
        }
        if (isAccept) {
            //Refrescar el grid 
            if (entities.Entity1.refreshGrid == null || entities.Entity1.refreshGrid == false) {
                entities.Entity1.refreshGrid = true;
            } else {
                entities.Entity1.refreshGrid = false;
            }
        }
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
        onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    }
if (onCloseModalEventArgs.closedViewContainerId == 'VC_BUSINESSPP_740722') {
    if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Business', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Business', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
      }
	  onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);//Para que recuper la info de la base a pesar de que dio error
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_REFERENCPP_688957') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('References', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('References', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
    }
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_REPLACEAII_570116') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    entities.NaturalPerson.accountIndividual = onCloseModalEventArgs.result.resultArgs.accountIndividual; 
                }
            }
        }
    }
};

//gridRowDeleting QueryView: QV_6359_40398
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_6359_40398 = function (entities, gridRowDeletingEventArgs) {
    gridRowDeletingEventArgs.commons.execServer = true;
    
    gridRowDeletingEventArgs.commons.serverParameters.Business = true;
};

//Start signature to Callback event to QV_6359_40398
task.gridRowDeletingCallback.QV_6359_40398 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};



}));