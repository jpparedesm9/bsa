/* variables locales de T_ASSTSNZKCUGDD_542*/
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

    
        var task = designerEvents.api.conciliationmanualsearchform;
		var isGroup = 'N';
    

    //"TaskId": "T_ASSTSNZKCUGDD_542"
task.textInputButtonEvent.VA_CUSTOMCODEETRCB_211547 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;

    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDAEC_38534');
    nav.customAddress = {
        id: "findCustomer",
        url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ["/customer/services/find-customers-srv.js"
                                           , "/customer/controllers/find-customers-ctrl.js"]
        }];

};

    //Entity: ConciliationManualSearchFilter
    //ConciliationManualSearchFilter.customCode (TextInputButton) View: ConciliationManualSearchForm
    task.customValidate.VA_CUSTOMCODEETRCB_211547 = function(  entities, customValidateEventArgs ) {
        customValidateEventArgs.commons.execServer = false;

        var customCode = entities.ConciliationManualSearchFilter.customCode;
        if (customCode < 0 || customCode > 2147483647) {
            customValidateEventArgs.errorMessage = 'ASSTS.MSG_ASSTS_VALORESDA_30202';
            customValidateEventArgs.isValid = false;
        }else{
            customValidateEventArgs.isValid = true;
        }
    };

// (Button) 
    task.executeCommand.CM_TASSTSNZ_1SG = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        entities.ConciliationManualSearchFilter.conciliationType = "RV"; // REVERSAR TRANSACCION

        var lengthConciliationManual = entities.ConciliationManualSearch.data().length;

        if (lengthConciliationManual > 0 ) {
            var listConciliationManual = entities.ConciliationManualSearch.data();
            var existSelected = false;

                listConciliationManual.forEach(function(row) {
                    if (row.isSelected) {
                        existSelected = true; // Existe un seleccionado
                    }
                });

            if (existSelected) {
                //Open Modal
                var nav = executeCommandEventArgs.commons.api.navigation;

                nav.address = {
                    moduleId: 'ASSTS',
                    subModuleId: 'CMMNS',
                    taskId: 'T_ASSTSTCQYYGZK_806',
                    taskVersion: '1.0.0',
                    viewContainerId: 'VC_CONCILIAAA_437806'
                };
                nav.queryParameters = {
                    mode: 1
                };
                nav.modalProperties = {
                    size: 'md',
                    height: 200,
                    callFromGrid: false
                };

                //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
                nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
                //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
                //nav.openModalWindow(id, executeCommandEventArgs.modelRow);
            }
        } 
    };

// (Button) 
    task.executeCommand.CM_TASSTSNZ_39S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        entities.ConciliationManualSearchFilter.conciliationType = "AC"; // APLICAR SIN ACCION

        var lengthConciliationManual = entities.ConciliationManualSearch.data().length;

        if (lengthConciliationManual > 0 ) {
            var listConciliationManual = entities.ConciliationManualSearch.data();
            var existSelected = false;

                listConciliationManual.forEach(function(row) {
                    if (row.isSelected) {
                        existSelected = true; // Existe un seleccionado
                    }
                });

            if (existSelected) {
                //Open Modal
                var nav = executeCommandEventArgs.commons.api.navigation;

                nav.address = {
                    moduleId: 'ASSTS',
                    subModuleId: 'CMMNS',
                    taskId: 'T_ASSTSTCQYYGZK_806',
                    taskVersion: '1.0.0',
                    viewContainerId: 'VC_CONCILIAAA_437806'
                };
                nav.queryParameters = {
                    mode: 1
                };
                nav.modalProperties = {
                    size: 'md',
                    height: 200,
                    callFromGrid: false
                };

                //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
                nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
                //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
                //nav.openModalWindow(id, executeCommandEventArgs.modelRow);
            }
        }
    };

// (Button) 
    task.executeCommand.CM_TASSTSNZ_D29 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        entities.ConciliationManualSearchFilter.conciliationType = "AP"; // APLICAR TRANSACCION

        var lengthConciliationManual = entities.ConciliationManualSearch.data().length;

        if (lengthConciliationManual > 0 ) {
            var listConciliationManual = entities.ConciliationManualSearch.data();
            var existSelected = false;

                listConciliationManual.forEach(function(row) {
                    if (row.isSelected) {
                        existSelected = true; // Existe un seleccionado
                    }
                });

            if (existSelected) {
                //Open Modal
                var nav = executeCommandEventArgs.commons.api.navigation;

                nav.address = {
                    moduleId: 'ASSTS',
                    subModuleId: 'CMMNS',
                    taskId: 'T_ASSTSTCQYYGZK_806',
                    taskVersion: '1.0.0',
                    viewContainerId: 'VC_CONCILIAAA_437806'
                };
                nav.queryParameters = {
                    mode: 1
                };
                nav.modalProperties = {
                    size: 'md',
                    height: 200,
                    callFromGrid: false
                };

                //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
                nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
                //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
                //nav.openModalWindow(id, executeCommandEventArgs.modelRow);
            }
        }
    };

//Entity: ConciliationManualSearchFilter
    //ConciliationManualSearchFilter. (Button) View: ConciliationManualSearchForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXDZJZKT_299547 = function(  entities, executeCommandEventArgs ) {
	if(entities.ConciliationManualSearchFilter.customType == null && isGroup== 'N'){
		entities.ConciliationManualSearchFilter.customType = 'P';
	}else if(entities.ConciliationManualSearchFilter.customType == null && isGroup== 'S'){
		entities.ConciliationManualSearchFilter.customType = 'G';
	}
    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.api.grid.removeAllRows('ConciliationManualSearch');
    executeCommandEventArgs.commons.api.grid.refresh('QV_9498_38003');
        //executeCommandEventArgs.commons.serverParameters.ConciliationManualSearchFilter = true;
    };

//ConciliationManualSearchQuery Entity: 
    task.executeQuery.Q_CONCILNH_9498 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//exportColumns QueryView: QV_9498_38003
        //Evento que permite personalizar que columnas se quiere exportar a excel
        task.exportColumns.QV_9498_38003 = function (exportColumnsEventArgs) {
            exportColumnsEventArgs.commons.execServer = false;
            
            exportColumnsEventArgs.exportColumnsToExcel.isSelected = false;
        };

task.gridInitColumnTemplate.QV_9498_38003 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'isSelected'){
            return "<input type=\'checkbox\' #if (isSelected) {# checked #}# ng-click=\"vc.grids.QV_9498_38003.events.customRowClick($event, \'VA_GRIDROWCOMMMAND_129547\', \'ConciliationManualSearch\', \'QV_9498_38003\')\"/>";
        }
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
    };

task.gridInitEditColumnTemplate.QV_9498_38003 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Entity: ConciliationManualSearch
    //ConciliationManualSearch. (Button) View: ConciliationManualSearchForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMAND_129547 = function(  entities, gridRowCommandEventArgs ) {

        gridRowCommandEventArgs.commons.execServer = false;
        
        var api = gridRowCommandEventArgs.commons.api;
        
        var previousValue = gridRowCommandEventArgs.rowData.isSelected;
        
        if (previousValue == false) {
            gridRowCommandEventArgs.rowData.isSelected = true;
        } else {
            gridRowCommandEventArgs.rowData.isSelected = false;
        }
        
        api.grid.updateRow("ConciliationManualSearch", gridRowCommandEventArgs.rowIndex, gridRowCommandEventArgs.rowData);
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ConciliationManualSearchForm
    task.initData.VC_CONCILIALA_363542 = function (entities, initDataEventArgs){
        
        initDataEventArgs.commons.execServer = true;
        
        initDataEventArgs.commons.api.viewState.format('VA_CUSTOMCODEETRCB_211547', '######',0);
        initDataEventArgs.commons.api.viewState.format('VA_GRIDROWCOMMMAND_129547', '######',0);
        
        entities.ConciliationManualSearchFilter.correspondent = 'SANTANDER'; //Santander por defecto
        entities.ConciliationManualSearchFilter.type = 'TO'; //Tipo de Pago Conciliación: Todos por defecto
        entities.ConciliationManualSearchFilter.notConciliationReason = 'C'; //Razon por la que No Concilia: Huerfano Cobis por defecto
        entities.ConciliationManualSearchFilter.conciliate = 'N'; //Estado de Conciliación: No Conciliado por defecto
        entities.ConciliationManualSearchFilter.paymentState = 'T'; //Estado de Pago en COBIS Conciliación: Todos por defecto
        
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ConciliationManualSearchForm
task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
    var grid = onCloseModalEventArgs.commons.api.grid;
    
    if (onCloseModalEventArgs.closedViewContainerId == "findCustomer") {
        onCloseModalEventArgs.commons.execServer = false;
        
        var resp = onCloseModalEventArgs.result.selectedData;
        var title = 'ASSTS.LBL_ASSTS_CDIGOCLEN_93241';

        if (resp != null) {
            entities.ConciliationManualSearchFilter.customCode = resp.code;
            entities.ConciliationManualSearchFilter.customType = resp.customerType;

            switch (resp.customerType) {
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
        }
        onCloseModalEventArgs.commons.api.viewState.label("VA_CUSTOMCODEETRCB_211547", title);
        
    } else if (onCloseModalEventArgs.closedViewContainerId == "VC_CONCILIAAA_437806") {
        onCloseModalEventArgs.commons.execServer = true;
        
        var dialogCloseResult = onCloseModalEventArgs.dialogCloseResult;
        var result = onCloseModalEventArgs.result;
        
        if (dialogCloseResult == 1) {
            onCloseModalEventArgs.commons.execServer = false;
            grid.refresh('QV_9498_31225');
        }else if (dialogCloseResult == undefined && result == true) {
            onCloseModalEventArgs.commons.execServer = false;
            grid.refresh('QV_9498_31225');
        }else{
            entities.ConciliationManualSearchFilter.observation = result;
            /*var listConciliationManual = entities.ConciliationManualSearch.data();
            listConciliationManual.forEach(function(row) {
                if (row.isSelected) {
                    row.observation = result;
                }
            });*/
        }
        
    } else {
        grid.refresh('QV_9498_31225');
    }
};

//Entity: ConciliationManualSearchFilter
    //ConciliationManualSearchFilter.customCode (TextInputButton) View: ConciliationManualSearchForm
    
    task.textInputButtonEventGrid.VA_CUSTOMCODEETRCB_211547 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };



}));