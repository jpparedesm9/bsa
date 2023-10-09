/* variables locales de T_ADDRESSKSQYAJ_769*/
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

    
        var task = designerEvents.api.addressform;
    

    //"TaskId": "T_ADDRESSKSQYAJ_769"

var showHeader = true;
var section = null;
var taskHeader = {};
var ban=true;

task.closeModalEvent.findCustomer = function (args) {
    
    args.model.CustomerTmp.code = args.result.selectedData.code;
    args.model.CustomerTmp.businessName = args.result.selectedData.commercialName;
    args.model.CustomerTmp.name = args.result.selectedData.name;
    args.model.CustomerTmp.isGroup = args.result.selectedData.isGroup;
    args.model.CustomerTmp.customerType = args.result.selectedData.customerType;
    args.model.CustomerTmp.documentNumber = args.result.selectedData.documentId;
    args.model.CustomerTmp.documentType = args.result.selectedData.documentType;
    args.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    
};

    //Entity: VirtualAddress
    //VirtualAddress.addressDescription (TextInputBox) View: AddressForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXILB_303566 = function(  entities, changedEventArgs ) {
     changedEventArgs.commons.execServer = false;
        if(!LATFO.UTILS.validarEmail(changedEventArgs.rowData.addressDescription)){
         changedEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
        }        
    };

// (Button) 
task.executeCommand.CM_TADDRESS_C49 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    if (executeCommandEventArgs.commons.api.parentVc.model != null && executeCommandEventArgs.commons.api.parentVc.model != undefined && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage != null && executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage == undefined) {
        executeCommandEventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
    
    if (section != null) {
       var response = {
           operation: "U",
           section: section,
           clientId: entities.CustomerTmp.code
       };
       executeCommandEventArgs.commons.api.vc.parentVc.responseEvent(response);
    }
};

//Entity: CustomerTmp
//CustomerTmp. (Button) View: AddressForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONWVQOBVO_763566 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    //executeCommandEventArgs.commons.serverParameters.CustomerTmp = true;
    entities.Context.addressState = 'S';
    entities.Context.mailState = 'S';
};

//Entity: CustomerTmp
//CustomerTmp. (Button) View: AddressForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONYDIJDRL_132566 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;
    if (entities.CustomerTmp.code == null) {
        entities.CustomerTmp.code = entities.NaturalPerson.personSecuential;
        ban = false;
    }
    executeCommandEventArgs.commons.serverParameters.CustomerTmp = true;
    executeCommandEventArgs.commons.serverParameters.VirtualAddress = true;
    executeCommandEventArgs.commons.serverParameters.PhysicalAddress = true;
    executeCommandEventArgs.commons.serverParameters.Context = true;

};

//Entity: CustomerTmp
    //CustomerTmp. (Button) View: AddressForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONYDIJDRL_132566 = function(  entities, executeCommandCallbackEventArgs ) {
        
        //here your code
        if (executeCommandCallbackEventArgs.success) {
            
            if (ban){
              if (showHeader && taskHeader!=undefined &&  taskHeader!=null ) {

                    if(entities.CustomerTmp.customerType == 'P'){
                        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmp.name, 0);
                    }else{
                        LATFO.INBOX.addTaskHeader(taskHeader, 'title', entities.CustomerTmp.businessName, 0);
                    }
                    LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', entities.CustomerTmp.documentNumber, 1);
                    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', entities.CustomerTmp.documentType, 1);
                    LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', entities.CustomerTmp.code, 2);
                    //LATFO.INBOX.addTaskHeader(taskHeader,'RAZON SOCIAL',entities.LegalPerson.tradename,0);
                    LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'G_ADDRESSXDI_956566');
                    executeCommandCallbackEventArgs.commons.api.viewState.show('G_ADDRESSXDI_956566');
                } else {
                    //Para VCC
                    executeCommandCallbackEventArgs.commons.api.viewState.hide('G_ADDRESSXDI_956566');
                }
            }
            if(entities.PhysicalAddress.data().length != 0){
				for(var i = 0; i <= entities.PhysicalAddress.data().length - 1; i++){
					if(entities.PhysicalAddress.data()[i].businessCode == 0){
						entities.PhysicalAddress.data()[i].businessCode = null;
					}
				}
        }
        }
    };


//PhysicalAddressQuery Entity: 
    task.executeQuery.Q_PHYSICDS_4851 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//VirtualAddressQuery Entity: 
    task.executeQuery.Q_VIRTUALD_9303 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//gridRowRendering QueryView: QV_4851_97960
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_4851_97960 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;
    gridRowRenderingEventArgs.commons.api.grid.showToolBarButton('QV_4851_97960', 'create');

    if (gridRowRenderingEventArgs.rowData.directionNumberInternal == -1) {
        gridRowRenderingEventArgs.rowData.directionNumberInternal = 0;
    }

    if (screenMode == 'Q') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_4851_97960', 'create');
        var dsAddress = entities.PhysicalAddress.data();
        for (var i = 0; i < dsAddress.length; i++) {
            var dsRow = dsAddress[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_4851_97960', dsRow, 'delete');
            gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_4851_97960', dsRow, 'edit');
        }

        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9303_67123', 'create');

        var dsVirtualAddress = entities.VirtualAddress.data();
        for (var i = 0; i < dsVirtualAddress.length; i++) {
            var dsRow = dsVirtualAddress[i];
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', dsRow, 'delete');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', dsRow, 'edit');
        }
    }

    if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_4851_97960', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_4851_97960', gridRowRenderingEventArgs.rowData, 'delete');
    }

};

//gridRowRendering QueryView: QV_9303_67123
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_9303_67123 = function (entities, gridRowRenderingEventArgs) {

    gridRowRenderingEventArgs.commons.execServer = false;
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
    gridRowRenderingEventArgs.commons.api.grid.showToolBarButton('QV_9303_67123', 'create');

    if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9303_67123', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'delete');

        if (posDataModRequest != null) {
            if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || entities.Context.roleEnabledDataModRequest != 'S' || entities.Context.mailState != 'N') {
                gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'edit');
            } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S' && entities.Context.mailState == 'N') {
                gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_9303_67123', gridRowRenderingEventArgs.rowData, 'edit');
            }
        }
    }

};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: AddressForm
task.initData.VC_ADDRESSYWA_591769 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = true;
    initDataEventArgs.commons.serverParameters.CustomerTmp = true;
    initDataEventArgs.commons.serverParameters.VirtualAddress = true;
    initDataEventArgs.commons.serverParameters.PhysicalAddress = true;
    
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc =  initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined  || parentVc == null ? {} : parentVc.model;

    //Se oculta la columna Direccion
    initDataEventArgs.commons.api.grid.hideColumn('QV_4851_97960', 'addressDescription');

    if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
		initDataEventArgs.commons.execServer = false;
		initDataEventArgs.commons.api.viewState.show('G_ADDRESSXDI_956566');
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
        
    initDataEventArgs.commons.api.viewState.hide('CM_TADDRESS_C49', true);
        
    } else if (customDialogParameters != null && customDialogParameters != undefined && parentParameters.Task == undefined) {
        //si es desde la VCC
        showHeader = false;
        section = customDialogParameters.section;
        entities.CustomerTmp.code = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters.clientId;
    } else if ((customDialogParameters != null || customDialogParameters != undefined) && parentParameters.Task != undefined) {
        showHeader = false;
        var task = parentParameters.Task;
        if (task != null) {
            entities.CustomerTmp.code  = task.clientId;
        }
    }
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AddresForm
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
            if(entities.PhysicalAddress.data().length > 0){
                onCloseModalEventArgs.commons.api.viewState.enable('VC_RIZJHPLTPZ_320966');
                var customerId = entities.CustomerTmp.code;
                if (customerId != undefined) {
                    var filtro ={
                        customerId:customerId,
                        processInstance:"0"
                    };
                    var filtro2 = {
                        origen: "P",
                        screeMode: screenMode
                    };
                    onCloseModalEventArgs.commons.api.vc.parentVc = {}
                    onCloseModalEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro2;

                    //Refresh de la grilla para llenar la entidad
                    onCloseModalEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
                }
            }
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

//gridRowDeleting QueryView: QV_4851_97960
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_4851_97960 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            gridRowDeletingEventArgs.commons.serverParameters.PhysicalAddress = true;
        };

//Start signature to Callback event to QV_4851_97960
task.gridRowDeletingCallback.QV_4851_97960 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

//gridRowDeleting QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_9303_67123 = function (entities, gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.VirtualAddress = true;
        };

//Start signature to Callback event to QV_9303_67123
task.gridRowDeletingCallback.QV_9303_67123 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

//gridRowInserting QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_9303_67123 = function (entities, gridRowInsertingEventArgs) {
            //CustomerTmp se llena desde la VCC o desde la pantalla de Prospectos
            gridRowInsertingEventArgs.rowData.personSecuential=entities.CustomerTmp.code;
            if(LATFO.UTILS.validarEmail(gridRowInsertingEventArgs.rowData.addressDescription)){
                 gridRowInsertingEventArgs.commons.execServer = true;
            }else{
                gridRowInsertingEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
                gridRowInsertingEventArgs.commons.execServer = false;
                gridRowInsertingEventArgs.commons.api.grid.removeRow('VirtualAddress',0);
            }
        };

//Start signature to callBack event to QV_9303_67123
    task.gridRowInsertingCallback.QV_9303_67123 = function(entities, gridRowInsertingEventArgs) {
        if(gridRowInsertingEventArgs.success){
          if (section != null){
                var response = { 
                    operation: "U",
                    section: section,
                    clientId: gridRowInsertingEventArgs.rowData.personSecuential
                }; 
        }

        }else{
            cobis.showMessageWindow.loading(false);
        }
    };

//gridRowUpdating QueryView: QV_4851_97960
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_4851_97960 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.commons.serverParameters.PhysicalAddress = true;
             
            
        };

//gridRowUpdating QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9303_67123 = function (entities, gridRowUpdatingEventArgs) {
            if(LATFO.UTILS.validarEmail(gridRowUpdatingEventArgs.rowData.addressDescription)){
                 gridRowUpdatingEventArgs.commons.execServer = true;
        entities.Context.mailState = 'S';
            }else{
                gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
                gridRowUpdatingEventArgs.commons.execServer = false;
            }
        };

//Start signature to callBack event to QV_9303_67123
    task.gridRowUpdatingCallback.QV_9303_67123 = function(entities, gridRowUpdatingEventArgs) {
        //here your code
    };



}));