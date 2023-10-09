/*global designerEvents, console */
(function () {
    "use strict";

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

    var task = designerEvents.api.warrantiescreation;
var hasGuarantor = false;
var loadStoreKeeper = 0;
var updateWarranty = false;
    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de cabecera.
    //  task.changeWithError.allGroup = true;

    //  descomentar la siguiente linea para que siempre se ejecute el evento change en todos los controles de grilla.
    //  task.changeWithError.allGrid = true;

    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: 
    //.saveBtn (Button) View: warrantiesCreation
    //Evento ExecuteCommand: Permite personalizar la acciÃ³n a ejecutar de un command o de un ActionControl. 
task.executeCommand.VA_ARANSCATIO0717_0000605 = function (entities, executeCommandEventArgs) {
    entities.generalData.isNew = true;
    if (task.validateBeforeSave(entities, executeCommandEventArgs, "I")) {
        executeCommandEventArgs.commons.execServer = true;
    } else {
        executeCommandEventArgs.commons.execServer = false;
    }
};

    //CallBack .saveBtn (Button) View: warrantiesCreation 
task.executeCommandCallback.VA_ARANSCATIO0717_0000605 = function (entities, executeCommandCallback) {
    executeCommandCallback.commons.api.vc.parentVc.model.Save = new Date();
     var api = executeCommandCallback.commons.api;
     updateWarranty = false;
    if (executeCommandCallback.success) {
        executeCommandCallback.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625', '', 2000, false);
		task.callSpecificationItems(entities, executeCommandCallback,false);//SRO no borrar
        var viewState = executeCommandCallback.commons.api.viewState;
        if (entities.WarrantyGeneral.code != null) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_CODE053']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_EXTE434']);
        }
        $("#NAVIGATIONBUTTONBAR").css("visibility", "visible");
        executeCommandCallback.commons.api.vc.parentVc.viewState.SAVEBUTTON.disabled = true;
		if (api.parentVc != undefined){
            api.parentVc.setContainerView(entities.WarrantyGeneral.externalCode);
        }
    }
};

    //Entity: WarrantyGeneral
    //WarrantyGeneral.coverage (ComboBox) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ARANSCATIO0709_CVER937 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    var newCoverage = changedEventArgs.newValue;
    // CAMBIA EL PORCENTAJE SEGUN LA COBERTURA SELECCIONADA
    var arreglo = changedEventArgs.commons.api.vc.catalogs.VA_ARANSCATIO0709_CVER937.data();
    for (var i = 0; i < arreglo.length; i++) {
        if (arreglo[i].code == newCoverage) {
            entities.WarrantyGeneral.percentageCoverage = arreglo[i].attributes[0];
        }
    }

};

    //Entity: WarrantyGeneral
    //WarrantyGeneral.coverage (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_ARANSCATIO0709_CVER937 = function (loadCatalogEventArgs) {
    var serverParameters = loadCatalogEventArgs.commons.api.vc.serverParameters;
    serverParameters.WarrantyGeneral = true;
    loadCatalogEventArgs.commons.execServer = false;
};
    //Entity: WarrantyGeneral
    //WarrantyGeneral.initialValue (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ARANSCATIO0709_ILAE518 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
};

    //Entity: WarrantySituation
    //WarrantySituation.classWarranty (RadioButtonList) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ARANSCATIO0714_CLAS015 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    // changedEventArgs.commons.serverParameters.WarrantySituation = true;
};

    //Entity: WarrantySituation
    //WarrantySituation.classWarranty (RadioButtonList) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo. 
task.loadCatalog.VA_ARANSCATIO0714_CLAS015 = function (loadCatalogEventArgs) {
    loadCatalogEventArgs.commons.execServer = false;
};

    //Entity: WarrantySituation
    //WarrantySituation.legalSufficiency (RadioButtonList) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_ARANSCATIO0714_ELCY714 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    // changedEventArgs.commons.serverParameters.WarrantySituation = true;
};

    //Entity: WarrantySituation
    //WarrantySituation.legalSufficiency (RadioButtonList) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_ARANSCATIO0714_ELCY714 = function (loadCatalogEventArgs) {
    loadCatalogEventArgs.commons.execServer = false;
    return [{
        code: 'S',
        value: "Si"
    }, {
        code: 'N',
        value: "No"
    }, {
        code: 'O',
        value: "No Aplica"
    }];
    //loadCatalogDataEventArgs.commons.serverParameters.WarrantySituation = true;
};

    //Entity: WarrantySituation
    //WarrantySituation.guaranteeFund (CheckBox) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0715_GAEP916 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    };

    //Entity: WarrantySituation
    //WarrantySituation.inspectType (CheckBox) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0715_IPTE389 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
        if (entities.WarrantySituation.inspectType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_RDII635']);
            entities.WarrantySituation.inspectReason = null;
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        } else {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NSPC524']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_RDII635']);
        }
        // changedEventArgs.commons.serverParameters.WarrantySituation = true;
    };

    //Entity: WarrantySituation
    //WarrantySituation.judicialCollectionType (CheckBox) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0715_JILL987 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
        var api = changedEventArgs.commons.api;
        if (entities.WarrantySituation.judicialCollectionType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NDTE308']);
            api.viewState.enableValidation('VA_ARANSCATIO0715_TEAE147', VisualValidationTypeEnum.Required);
            api.viewState.enableValidation('VA_ARANSCATIO0715_NDTE308', VisualValidationTypeEnum.Required);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NDTE308']);
            entities.WarrantySituation.retirementDate = null;
            entities.WarrantySituation.returnDate = null;
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        }
    };



    //Entity: WarrantySituation
    //WarrantySituation.suitable (RadioButtonList) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0714_SUIE758 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        // changedEventArgs.commons.serverParameters.WarrantySituation = true;
    };

    //Entity: WarrantySituation
    //WarrantySituation.suitable (RadioButtonList) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0714_SUIE758 = function (loadCatalogEventArgs) {
        loadCatalogEventArgs.commons.execServer = false;
        return [{
            code: 'S',
            value: "Si"
        }, {
            code: 'N',
            value: "No"
        }, {
            code: 'O',
            value: "No Aplica"
        }];
        //loadCatalogDataEventArgs.commons.serverParameters.WarrantySituation = true;
    };

    //Entity: WarrantySituation
    //WarrantySituation.sharedType (CheckBox) View: warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0715_TYPE600 = function (entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
        var api = changedEventArgs.commons.api;
        //if(changedEventArgs.newValue){                  
        if (entities.WarrantySituation.sharedType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NTLL256']);
            api.viewState.enableValidation('VA_ARANSCATIO0715_NTLL256', VisualValidationTypeEnum.Required);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NTLL256']);
            entities.WarrantySituation.totalInitialValue = 0;
            api.viewState.disableValidation('VA_ARANSCATIO0715_NTLL256', VisualValidationTypeEnum.Required);
        }
    };

    //Entity: WarrantyLocation
    //WarrantyLocation.city (ComboBox) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0711_CITY886 = function (loadCatalogEventArgs) {
        var serverParameters = loadCatalogEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyLocation = true;
        loadCatalogEventArgs.commons.execServer = true;
    };

    //Entity: WarrantyLocation
    //WarrantyLocation.parish (ComboBox) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0711_PARI601 = function (loadCatalogEventArgs) {
        var serverParameters = loadCatalogEventArgs.commons.api.vc.serverParameters;
        serverParameters.WarrantyLocation = true;
        loadCatalogEventArgs.commons.execServer = true;
    };

    //Entity: WarrantyLocation
    //WarrantyLocation.province (ComboBox) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0711_RVNE334 = function (loadCatalogEventArgs) {
        loadCatalogEventArgs.commons.execServer = false;

    };
    //Entity: WarrantyLocation
    //WarrantyLocation.storeKeeper (ComboBox) View: warrantiesCreation
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ARANSCATIO0711_SOER604 = function (loadCatalogEventArgs) {
        loadCatalogEventArgs.commons.execServer = true;
    };

    //Entity: WarrantyGeneral
    //WarrantyGeneral.fixedTerm (TextInputButton) View: warrantiesCreation
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_ARANSCATIO0709_IDER508 = function (textInputButtonEventArgs) {

        var nav = FLCRE.API.getApiNavigation(textInputButtonEventArgs, 'T_FLCRE_94_BYLET28', 'VC_BYLET28_DTBCT_453');
        nav.label = cobis.translate('BUSIN.DLB_BUSIN_PLAZOFIJO_08224');
        nav.modalProperties = {
            size: 'lg'
        };
        nav.queryParameters = {
            mode: textInputButtonEventArgs.commons.constants.mode.Insert
        };
        nav.customDialogParameters = {
            customerSearch: textInputButtonEventArgs.commons.api.vc.model.CustomerSearch.data(),
            warrantyGeneral: textInputButtonEventArgs.commons.api.vc.model.WarrantyGeneral,
            warrantyType: textInputButtonEventArgs.commons.api.vc.model.WarrantyGeneral.warrantyType,
            currencyCode: textInputButtonEventArgs.commons.api.vc.model.WarrantyGeneral.currency
        }; 

        textInputButtonEventArgs.commons.execServer = false;
    };

    //Entity: WarrantyGeneral
    //WarrantyGeneral.accountAho (TextInputButton) View: warrantiesCreation
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_ACCOUNTAHOJMZWG_417O07 = function (textInputButtonEventArgs) {

        var nav = FLCRE.API.getApiNavigation(textInputButtonEventArgs, 'T_FLCRE_94_BYLET28', 'VC_BYLET28_DTBCT_453');
        nav.label = cobis.translate('BUSIN.LBL_BUSIN_CUENTAARH_14595');
        nav.modalProperties = {
            size: 'lg'
        };
        nav.queryParameters = {
            mode: textInputButtonEventArgs.commons.constants.mode.Insert
        };
        nav.customDialogParameters = {
            customerSearch: textInputButtonEventArgs.commons.api.vc.model.CustomerSearch.data(),
            warrantyGeneral: textInputButtonEventArgs.commons.api.vc.model.WarrantyGeneral,
            warrantyType: textInputButtonEventArgs.commons.api.vc.model.WarrantyGeneral.warrantyType,
            currencyCode: textInputButtonEventArgs.commons.api.vc.model.WarrantyGeneral.currency
        }; 

        textInputButtonEventArgs.commons.execServer = false;
    };

    //Resultado de envio de Plazo Fijo
    task.closeModalEvent.VC_BYLET28_DTBCT_453 = function (args) {
        console.log("Evento CloseModal VC_BYLET28_DTBCT_453");
        var result = args.result;
        if (result.value != '' && "DPF" == result.warrantyType) {
            args.model.WarrantyGeneral.fixedTerm = result.value;
            args.model.WarrantyGeneral.fixedTermAmount = result.amount;
            args.model.WarrantyGeneral.documentNumber = result.code;
            args.model.WarrantyGeneral.initialValue = result.amount;
        }
        if (result.value != '' && "AHORRO" == result.warrantyType) {
            args.model.WarrantyGeneral.accountAho = result.value;
            args.model.WarrantyGeneral.balanceAvailable = result.amount;
            args.model.WarrantyGeneral.documentNumber = result.code;
        }
    };


    task.closeModalEvent.VC_CRNTO32_RRNYM_717 = function (args) {
        console.log("Evento CloseModal VC_CRNTO32_RRNYM_717");
        //var result = args.result;
        //alert("Close Modal");
    };


    //Entity: WarrantyGeneral
    //WarrantyGeneral.guarantor (TextInputButton) View: warrantiesCreation
    //Evento TextInputButtonEvent: Permite abrir una ventana modal y enviar parametros hacia la misma, en los argumentos del objeto. 
    task.textInputButtonEvent.VA_ARANSCATIO0709_RNTR310 = function (textInputButtonEventArgs) {
        textInputButtonEventArgs.commons.execServer = false;
        task.openFindProgram(textInputButtonEventArgs);
        //textInputButtonEventArgs.commons.serverParameters.WarrantyGeneral = true;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Cancelar (Button) 
    task.executeCommand.CM_RRCAI67NLA20 = function (entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal("");
    };

    //Guardar (Button) 
    task.executeCommand.CM_RRCAI67UAR18 = function(entities, executeCommandEventArgs) {
        var operation = "U";
        entities.generalData.isNew = true;
        if (task.validateBeforeSave(entities, executeCommandEventArgs, operation)) {
            executeCommandEventArgs.commons.execServer = true;
        } else {
            executeCommandEventArgs.commons.execServer = false;
        }
        
    };



    //Callback guardar (actualizar)
    task.executeCommandCallback.CM_RRCAI67UAR18 = function (entities, executeCommandCallbackEventArgs) {
        updateWarranty = true;
        var typeWarranty = entities.WarrantyGeneral.warrantyType;
        var api = executeCommandCallbackEventArgs.commons.api;
        if (executeCommandCallbackEventArgs.success) {
            if (typeWarranty == 'PERSONAL') {
                var dataWarranty = task.addPersonalWarrantyList(executeCommandCallbackEventArgs, updateWarranty);
            } else {
                var dataWarranty = task.addOtherWarrantyList(executeCommandCallbackEventArgs, updateWarranty);
            }
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.vc.closeModal(dataWarranty);
            task.callSpecificationItems(entities, executeCommandCallbackEventArgs, false);
            if (api.parentVc != undefined){
                api.parentVc.setContainerView(entities.WarrantyGeneral.externalCode);
            }
        }
    };

        //**********************************************************
    //  Eventos de QUERY
    //**********************************************************    
    //QueryCustomer  Entity: CustomerSearch 
    task.executeQuery.Q_QRYLIENT_5474 = function (executeQueryEventArgs) {
        executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters.CustomerSearch = true;
    };

    //gridRowInserting QueryView: GridCustomer
    //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
    task.gridRowInserting.QV_QRYLI5474_83 = function (entities, gridRowInsertingEventArgs) {
        gridRowInsertingEventArgs.commons.execServer = false;
        var lastClientId = gridRowInsertingEventArgs.rowData.CustomerId;
        var lastWarrantyType = gridRowInsertingEventArgs.rowData.warrantyType;
        FLCRE.UTILS.CUSTOMER.removeDuplicateCustomerByCode(entities, gridRowInsertingEventArgs, lastClientId, lastWarrantyType);
        if (lastClientId === 0){
           gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_DUPLITIEN_05473');
           gridRowInsertingEventArgs.commons.api.grid.removeRow('CustomerSearch', 0);  
        }
    };
    task.gridRowUpdating.QV_QRYLI5474_83 = function (entities, gridRowUpdatingEventArgs) {
       gridRowUpdatingEventArgs.commons.execServer = false;
       var lastClientId = gridRowUpdatingEventArgs.rowData.CustomerId;
       var lastWarrantyType = gridRowUpdatingEventArgs.rowData.warrantyType;
       FLCRE.UTILS.CUSTOMER.removeDuplicateCustomerByCode(entities, gridRowUpdatingEventArgs, lastClientId, lastWarrantyType); 
    }
    

    //gridRowDeleting QueryView: GrdWarrantyPolicies
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_ERWRL4097_89 = function (entities, gridRowDeletingEventArgs) {

        var warrantyGeneral = gridRowDeletingEventArgs.commons.api.vc.model.WarrantyGeneral;
        var rowDeleted = gridRowDeletingEventArgs.rowData;
        rowDeleted.branchOffice = warrantyGeneral.branchOffice;
        rowDeleted.custodyType = warrantyGeneral.warrantyType;
        rowDeleted.custody = warrantyGeneral.code;

        gridRowDeletingEventArgs.commons.execServer = true;
        // gridRowDeletingEventArgs.commons.serverParameters.WarrantyPoliciy = true;
    };
    //gridBeforeEnterInLineRow QueryView: GrdWarrantyPolicies
    //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
    task.gridBeforeEnterInLineRow.QV_ERWRL4097_89 = function (entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;

        var grid = gridABeforeEnterInLineRowEventArgs.commons.api.grid;
        if (entities.WarrantyPoliciy) {
            grid.disabledColumn('QV_ERWRL4097_89', 'numberPolicy');
            grid.disabledColumn('QV_ERWRL4097_89', 'insurance');
        }
        var nav = FLCRE.API.getApiNavigation(gridABeforeEnterInLineRowEventArgs, 'T_FLCRE_76_CRNTO32', 'VC_CRNTO32_RRNYM_717');
        nav.label = cobis.translate('BUSIN.DLB_BUSIN_PLIZAMMVK_53577');
        // nav.queryParameters = { mode: gridABeforeEnterInLineRowEventArgs.commons.constants.mode.Update };
        // nav.customDialogParameters = { maxRelation : task.getMaxPrelation(entities)};		
        nav.openModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId, null);
    };

    task.gridRowSelecting.QV_ERWRL4097_89 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
    };

    //gridBeforeEnterInLineRow QueryView: GridCustomer
    //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
    task.gridBeforeEnterInLineRow.QV_QRYLI5474_83 = function (entities, gridABeforeEnterInLineRowEventArgs) {
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        var deleteNewRow = false;
        FLCRE.UTILS.CUSTOMER.openFindCustomer(entities, gridABeforeEnterInLineRowEventArgs, {}, deleteNewRow);
    };

    //gridRowSelecting QueryView: GridCustomer
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_QRYLI5474_83 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;        
    };

    //gridCommand (Button) QueryView: GridCustomer
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201_QV_QRYLI5474_83_514 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        var selectedRow = gridExecuteCommandEventArgs.commons.api.grid.getSelectedRows('QV_QRYLI5474_83');
        var wPrincipal = selectedRow[0] != undefined ? selectedRow[0].Principal : false;
        if (FLCRE.UTILS.CUSTOMER.deleteCustomerGeneral(gridExecuteCommandEventArgs, true)) {
            gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_SGCSLERER_06336');
            //Si se eliminó el cliente principal, se marca el primer cliente del grid como principal
            if (wPrincipal) {
                task.setPrincipalCustomer(entities, gridExecuteCommandEventArgs);
            }
        }
    };

    task.setPrincipalCustomer = function (entities, args) {
        //Marcar el primer cliente como principal
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        for (var i = 0; i < customerList.length; i++) {
            if (!customerList[i].Principal) {
                customerList[i].Principal = true;
                break;
            }
        }
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    //Evento InitData: Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos.
    //ViewContainer: warrantiesCreation 
    task.initData.VC_RRCAI67_WACRI_884 = function (entities, initDataEventArgs) {       
        var viewState = initDataEventArgs.commons.api.viewState;
        var api = initDataEventArgs.commons.api;
        var params = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();

        entities.WarrantySituation.amount = 'I';
        var queryString = {}; //JSA
        api.viewState.readOnly('VA_LICENSEDATEEIIR_288E85', true);
        api.viewState.disable('VA_LICENSEDATEEIIR_288E85', true); 
        queryString = FLCRE.UTILS.getQueryStrings(); //JSA
        // Entidades Temporal
        entities.generalData = {};
        entities.generalData.isNew = true;
        viewState.hide("VA_ARANSCATIO0709_CVER937");
        loadStoreKeeper = 0;
        api.viewState.hide('GR_ARANSCATIO07_17');
        api.viewState.hide('VC_RRCAI67_GUSME_893'); //Adicional IYU 
        api.viewState.hide('VC_RRCAI67_GUPOB_764'); //Polizas IYU

        if (params.loadSearchCollateral== true) {
            initDataEventArgs.commons.execServer = false;
            //SRO 1
            task.hideFields(viewState);
            task.validateManType(queryString, viewState);
            task.showCollateralSearch(initDataEventArgs);
        }

        if (params.isNew == true) { //modo Insert - isNew is true cuando es llamado desde el arbol
            //Acciones sobre la barra de botones de la tarea
            api.viewState.hide('CM_RRCAI67UAR18');
            api.viewState.hide('CM_RRCAI67NLA20');
            api.viewState.disable('VC_RRCAI67_GUPOB_764', true);
            
            //Acciones sobre la barra de botones de navegación
			if (api.vc.parentVc!=undefined){
                api.vc.parentVc.executeSave_T_FLCRE_35_RRCAI67 = function () {
                    api.vc.executeCommand('VA_ARANSCATIO0717_0000605', 'saveBtn', undefined, false, false, '', false);
                }
			}
			
            var viewState = initDataEventArgs.commons.api.viewState;
            task.validatePersonalWarranty(params.typeGuaranteeData.typeOfGuarantee, viewState);
            task.validateDPFWarranty(params.typeGuaranteeData.typeOfGuarantee, viewState);
            task.validateAccountAhoWarranty(params.typeGuaranteeData.typeOfGuarantee, viewState);
            task.setGeneralData(entities, params, viewState, initDataEventArgs);
            task.setSituationData(entities, params, viewState);
            task.hideSituationFields(entities, viewState);
            initDataEventArgs.commons.execServer = false;
			task.callSpecificationItems(entities, initDataEventArgs, true);//SRO
            
        } 
		if (params.currentRow!=null)//Editar del inbox
		{
            task.validatePersonalWarranty(params.currentRow.Type, viewState);
            task.validateDPFWarranty(params.currentRow.Type, viewState);
            task.validateAccountAhoWarranty(params.currentRow.Type, viewState);
			
            task.hideSituationFields(entities, viewState);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_CODE053']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_EXTE434']);

            entities.generalData.isNew = false;
		}
        
	
		if (params.model!=undefined && params.model.Task!=undefined) {//INBOX
            entities.WarrantyGeneral.tramitNumber = params.model.Task.ownerIdentifier;//VALIDAR
            initDataEventArgs.commons.execServer = true;
        }
	
        if (params.currentRow != null && params.menu == true) {
            task.hideFields(viewState);
            task.validateManType(queryString, viewState);

            initDataEventArgs.commons.execServer = true;
        }
        entities.WarrantyDescription.controlVisit = 'S'        
    };

    	//Start signature to Callback event to VC_RRCAI67_WACRI_884
    //Start signature to Callback event to VC_RRCAI67_WACRI_884
    task.initDataCallback.VC_RRCAI67_WACRI_884 = function (entities, initDataCallbackEventArgs) {
        var viewState = initDataCallbackEventArgs.commons.api.viewState;
        var api = initDataCallbackEventArgs.commons.api;
        var wPrincipal = true;
        var queryString = {};
		var params = initDataCallbackEventArgs.commons.api.navigation.getCustomDialogParameters();
        queryString = FLCRE.UTILS.getQueryStrings();

        if (params.menu != true) {
            if (params.isNew != true) {
                if (entities.WarrantyGeneral.status != 'P') {
                    viewState.disable('VA_ARANSCATIO0709_MONY430', true);
                } else {
                    viewState.enable('VA_ARANSCATIO0709_MONY430', true);
                }
            } 
			
			if (api.parentVc.parentVc.customDialogParameters!= undefined)
			{
			    var customDialogParameters = api.parentVc.parentVc.customDialogParameters;
				
				if (entities.CustomerSearch.data()[0]!=null && entities.CustomerSearch.data()[0]!=undefined) //Se agrega esta validación porque servicio devuelve CustomerSearch como undefined //VALIDAR
				{
				
                    var data = {
                        CustomerId: customDialogParameters.model.Task.clientId,
                        Customer: customDialogParameters.model.Task.clientName,
                        OfficerId: entities.CustomerSearch.data()[0].OfficerId,
                        Officer: customDialogParameters.model.Task.nameDestination,
                        Principal: wPrincipal
                    };
                    initDataCallbackEventArgs.commons.api.grid.updateRow('CustomerSearch', 0, data);
				}
			}
				
            if (entities.WarrantyGeneral.initialValue == 0 && "S" == entities.WarrantyGeneral.mandatoryDocument) {
                api.viewState.enableValidation('VA_ARANSCATIO0709_OEBE980', VisualValidationTypeEnum.Required);
            }
            if (entities.WarrantyGeneral.documentNumber == 0) {
                entities.WarrantyGeneral.documentNumber = "";
            }
            if (entities.WarrantyLocation.storeKeeper == 0) {
                entities.WarrantyLocation.storeKeeper = "";
            }
            task.showFieldsVerified(entities, viewState);
            task.renderAditionalData(entities, customDialogParameters, initDataCallbackEventArgs);
            initDataCallbackEventArgs.commons.execServer = true;
        } else {
            initDataCallbackEventArgs.commons.execServer = false;
        }
        task.enableDisableControls(entities, initDataCallbackEventArgs);
        if(entities.WarrantyGeneral.status == 'C' && queryString.option == 2){
            initDataCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62359', false);
            viewState.disable('CM_RRCAI67UAR18', true);
            initDataCallbackEventArgs.commons.execServer = true;
        }
        if(entities.WarrantyGeneral.status == 'A' && queryString.option == 2){
            onCloseModalEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62358', false);
            viewState.disable('CM_RRCAI67UAR18', true);
            initDataCallbackEventArgs.commons.execServer = true;
        }
    };

    //Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: warrantiesCreation
    task.render = function (entities, renderEventArgs) {
        var api = renderEventArgs.commons.api;
        var viewState = api.viewState;
        var params = renderEventArgs.commons.api.navigation.getCustomDialogParameters();
        var typeOfGuarantee = "";

        viewState.readOnly('VA_ARANSCATIO0709_IDER508', true); //plazo fijo
        viewState.readOnly('VA_ACCOUNTAHOJMZWG_417O07', true); //cuenta de ahorros
        BUSIN.API.addStyle('cb-group-flex', viewState, ['GR_ARANSCATIO07_15']);

        if (params != undefined && params.typeGuaranteeData != undefined) {
            typeOfGuarantee = params.typeGuaranteeData.typeOfGuarantee;
        } else {
            //SRO
			//VALIDAR
            //if (renderEventArgs.commons.api.parentVc != undefined && renderEventArgs.commons.api.parentVc.customDialogParameters != undefined && api.parentVc.customDialogParameters.isContainer != true) {
			if (params.menu != true && renderEventArgs.commons.api.navigation.getCustomDialogParameters().currentRow!=null)
            {
			    typeOfGuarantee = renderEventArgs.commons.api.parentVc.customDialogParameters.currentRow.Type;
                params.typeGuaranteeData = renderEventArgs.commons.api.parentVc.customDialogParameters.currentRow;
            }
        }

        if ('PERSONAL' == typeOfGuarantee) { //PERSONAL
            //viñeta de datos adicionales
            viewState.disable('VC_RRCAI67_GUSME_893', true);
        }
    };

    task.validatePersonalWarranty = function (typeOfGuarantee, viewState) {
        //En la Garantía Personal se presenta el campo Garante		
        if ("PERSONAL" == typeOfGuarantee) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            viewState.disable('VC_RRCAI67_GUPOB_764', true);
            viewState.readOnly('VA_ARANSCATIO0709_RNTR310', true);
            hasGuarantor = true;
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            //viewState.enable('VC_RRCAI67_GUPOB_764', true); //POLIZAS DESHABILITADAS
            viewState.readOnly('VA_ARANSCATIO0709_RNTR310', false);
            hasGuarantor = false;
        }
    };

    task.validateDPFWarranty = function (typeOfGuarantee, viewState) {
        //En la Garantía Plazo Fijo se presenta el campo Plazo Fijo		
        if ("DPF" == typeOfGuarantee) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_IDER508']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0709_DRMA851']);
            //BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_OEBE980']); //numero de documento
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_RNTR310']);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_IDER508']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_DRMA851']);
            //BUSIN.API.enable(viewState, ['VA_ARANSCATIO0709_OEBE980']);
        }
    };
    
   task.validateAccountAhoWarranty = function (typeOfGuarantee, viewState) {
        //En la Garantía Plazo Fijo se presenta el campo Plazo Fijo		
        if ("AHORRO" == typeOfGuarantee) {
            BUSIN.API.show(viewState, ['VA_ACCOUNTAHOJMZWG_417O07']);
            BUSIN.API.show(viewState, ['VA_BALANCEAVAILALL_926O07']);
            //BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_OEBE980']); //numero de documento
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_RNTR310']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0709_RNTR310']);
        } else {
            BUSIN.API.hide(viewState, ['VA_ACCOUNTAHOJMZWG_417O07']);
            BUSIN.API.hide(viewState, ['VA_BALANCEAVAILALL_926O07']);
           // BUSIN.API.enable(viewState, ['VA_ARANSCATIO0709_OEBE980']);
        }
    };
    
    

    task.setGeneralData = function (entities, params, viewState, initDataEventArgs) {
        entities.WarrantyGeneral.currency = 0; //asignar el valor del contexto			
        if (initDataEventArgs.commons.api.parentVc.parentVc != undefined && initDataEventArgs.commons.api.parentVc.parentVc.parentVc != undefined && (initDataEventArgs.commons.api.parentVc.parentVc.parentVc.id == "inbox" || initDataEventArgs.commons.api.parentVc.parentVc.parentVc.id == 'inboxWizardVC')) {
            entities.WarrantyGeneral.currency = initDataEventArgs.commons.api.parentApi().parentVc.model.OriginalHeader.CurrencyRequested;
        }
        entities.WarrantyGeneral.warrantyType = params.typeGuaranteeData.typeOfGuarantee;
        entities.WarrantyGeneral.description = params.typeGuaranteeData.descripcionGuarantee;
        entities.WarrantyGeneral.mandatoryDocument = params.typeGuaranteeData.documentNumber;
        entities.WarrantyGeneral.appraisalValue = 0;
        entities.WarrantyGeneral.initialValue = 0;
        entities.WarrantyGeneral.currentValue = 0;
        entities.WarrantyGeneral.fixedTermAmount = 0;
        entities.WarrantyGeneral.status = "P"; //Propuesta			
        var f = new Date();
        entities.WarrantyGeneral.admissionDate = f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear();
        entities.WarrantyGeneral.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.WarrantyGeneral.filial = cobis.userContext.getValue(cobis.constant.USER_FILIAL);
    };


    task.setSituationData = function (entities, params, viewState) {
        entities.WarrantySituation.classWarranty = params.typeGuaranteeData.classGuarantee;
        entities.WarrantySituation.periodicity = params.typeGuaranteeData.periodicity;
        entities.WarrantySituation.suitable = params.typeGuaranteeData.appropriate;
        entities.WarrantySituation.legalSufficiency = "O";
        entities.WarrantySituation.totalInitialValue = 0;
        entities.WarrantySituation.sharedType = false;
        entities.WarrantySituation.judicialCollectionType = false;
        if ("S" == params.typeGuaranteeData.guaranteeFund) {
            entities.WarrantySituation.guaranteeFund = true;
        } else {
            entities.WarrantySituation.guaranteeFund = false;
        }
    };

    task.hideSituationFields = function (entities, viewState) {
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_CODE053']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0709_EXTE434']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_TEAE147']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NTLL256']);
        if (entities.WarrantySituation.periodicity == null || entities.WarrantySituation.periodicity == 'N') {
            entities.WarrantySituation.inspectType = false;
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_RDII635']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        } else {
            entities.WarrantySituation.inspectType = true;
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        }
    };

    task.showFieldsVerified = function (entities, viewState) {
        if (entities.WarrantySituation.sharedType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NTLL256']);
        }
        if (entities.WarrantySituation.judicialCollectionType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        }
        if (entities.WarrantySituation.inspectType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_RDII635']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_RDII635']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NSPC524']);
        }
    };

    task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters;
        var isGuarantor = args.commons.api.vc.customDialogParameters == "guarantor" ? true : false;
        if (isGuarantor) {
            args.model.WarrantyGeneral.guarantor = resp.CodeReceive + "-" + resp.name;
        } else {
            var row = args.model.CustomerSearch.data()[0];
            var wPrincipal = true;
            //Determinar si la garantía ya tiene asociado el cliente principal
            var customerList = args.commons.api.vc.model.CustomerSearch.data();
            for (var i = 0; i < customerList.length; i++) {
                if (customerList[i].Principal) {
                    wPrincipal = false;
                    break;
                }
            }
            row.set('CustomerId', args.commons.api.vc.dialogParameters.CodeReceive);
            if (args.commons.api.vc.dialogParameters.commercialName !== '') {
                row.set('Customer', args.commons.api.vc.dialogParameters.commercialName);
            } else {
                row.set('Customer', args.commons.api.vc.dialogParameters.name);
            }
            row.set('OfficerId', args.commons.api.vc.dialogParameters.officerId);
            row.set('Officer', args.commons.api.vc.dialogParameters.officerName);
            row.set('identificationType', args.commons.api.vc.dialogParameters.documentType);
            row.set('identification', args.commons.api.vc.dialogParameters.documentId);
            row.set('Principal', wPrincipal);
        }
    };

 task.addPersonalWarrantyList = function (args, isUpdate) {
        //Buscar el id del cliente principal de la garantía
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        var customerId;
        for (var i = 0; i < customerList.length; i++) {
            if (customerList[i].Principal) {
                customerId = customerList[i].CustomerId;
                break;
            }
        }
        var guarantorDescription = args.commons.api.vc.model.WarrantyGeneral.guarantor;
        var indexBegin = guarantorDescription.indexOf("-");
        var indexEnd = guarantorDescription.length;
        var guarantorName = guarantorDescription.substring(indexBegin + 1, indexEnd);
        var personalGuarantorData = {
            CodeWarranty: args.commons.api.vc.model.WarrantyGeneral.externalCode,
            Type: args.commons.api.vc.model.WarrantyGeneral.warrantyType,
            Description: args.commons.api.vc.model.WarrantyGeneral.description,
            GuarantorPrimarySecondary: guarantorName, //cambiar por el nombre del garante
            ClassOpen: args.commons.api.vc.model.WarrantySituation.classWarranty,
            IdCustomer: customerId,
            State: args.commons.api.vc.model.WarrantyGeneral.status,
            DateCIC: null,
            isHeritage: "N", //obtener el valor
            CurrentValue: null,
            Currency: null
        };
        if (isUpdate) {
            return personalGuarantorData;
        } else {
            args.commons.api.parentApi().parentApi().grid.addRow("PersonalGuarantor", personalGuarantorData);
        }


    };

 task.addOtherWarrantyList = function (args, isUpdate) {
        //Buscar el id del cliente principal de la garantía
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        var customerId;
        var customerName;
        for (var i = 0; i < customerList.length; i++) {
            if (customerList[i].Principal) {
                customerId = customerList[i].CustomerId;
                customerName = customerList[i].Customer;
                break;
            }
        }
        var appraisalDate = "";
        if (args.commons.api.vc.model.WarrantyGeneral.appraisalDate != null) {
            appraisalDate = BUSIN.CONVERT.NUMBER.Format(args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getMonth() + 1), "0", 2) + "/" + args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getFullYear();
        }
        var otherWarrantyData = {
            CodeWarranty: args.commons.api.vc.model.WarrantyGeneral.externalCode,
            Type: args.commons.api.vc.model.WarrantyGeneral.warrantyType,
            Description: args.commons.api.vc.model.WarrantyGeneral.description,
            InitialValue: args.commons.api.vc.model.WarrantyGeneral.initialValue,
            DateAppraisedValue: appraisalDate,
            ValueApportionment: 0,
            ClassOpen: args.commons.api.vc.model.WarrantySituation.classWarranty,
            ValueAvailable: args.commons.api.vc.model.WarrantyGeneral.fixedTermAmount,
            IdCustomer: customerId,
            NameGar: customerName,
            State: args.commons.api.vc.model.WarrantyGeneral.status,
            Flag: true,
            IsNew: true,
            ValueVNR: 0,
            RelationshipGuarantees: 0,
            isHeritage: "N", //obtener el valor
            relation: 0
        };
        if (isUpdate) {
            return otherWarrantyData;
        } else {
            args.commons.api.parentApi().parentApi().grid.addRow("OtherWarranty", otherWarrantyData);
        }

    };

    //Abrir búsqueda de garantes
 task.openFindProgram = function (argsI) {
     var params = "guarantor";
     FLCRE.UTILS.CUSTOMER.openFindGuarantor(argsI, params);
 };

 task.renderAditionalData = function (entities, parentParameters, args) {
     //Llamada a la configuraciÃ³n adicional por producto bancario		
     var api = args.commons.api;
     var nav = args.commons.api.navigation;
     var typeOfWarranty = "",
         codeWarranty = "";
     var customDialogParameters = nav.getCustomDialogParameters();

     //if (api.parentVc != undefined && api.parentVc.customDialogParameters != undefined && api.parentVc.customDialogParameters.isContainer != true) {
	 if (customDialogParameters.isNew != true) {
         api.vc.removeChildVc('FINPMITEMRENDER');
         nav.label = "RENDER";
         nav.customAddress = {
             id: 'FINPMITEMRENDER',
             url: 'fpm/templates/render-items-values.html', //no head
             useMinification: false
         };
         nav.scripts = [{
             module: cobis.modules.FPM,
             files: ['fpm/fpm-tree-process.js', 'fpm/services/fpm-tree-process-srv.js', 'fpm/controllers/fpm-tree-process-ctrl.js', '/fpm/services/render-items-values-srv.js', '/fpm/controllers/render-items-values-ctrl.js']
         }];
         if (api.vc.customDialogParameters == undefined) {
             api.vc.customDialogParameters = customDialogParameters;
         }

         nav.customDialogParameters = api.vc.customDialogParameters;
         nav.customDialogParameters.Type = "SECCION_RENDERIZADA";
         nav.customDialogParameters.Request = parentParameters.Task.bussinessInformationIntegerTwo;


         if (nav.customDialogParameters.typeGuaranteeData != undefined) {
             nav.customDialogParameters.BankingProductName = nav.customDialogParameters.typeGuaranteeData.descripcionGuarantee;
             typeOfWarranty = nav.customDialogParameters.typeGuaranteeData.typeOfGuarantee;
             codeWarranty = (nav.customDialogParameters.typeGuaranteeData.CodeWarranty === undefined || nav.customDialogParameters.typeGuaranteeData.CodeWarranty === null) ? '' : nav.customDialogParameters.typeGuaranteeData.CodeWarranty;
         } else {
             nav.customDialogParameters.BankingProductName = api.vc.parentVc.customDialogParameters.currentRow.Description;
             typeOfWarranty = api.vc.parentVc.customDialogParameters.currentRow.Type;
             codeWarranty = (api.vc.parentVc.customDialogParameters.currentRow.CodeWarranty === undefined || api.vc.parentVc.customDialogParameters.currentRow.CodeWarranty === null) ? '' : api.vc.parentVc.customDialogParameters.currentRow.CodeWarranty;
         }



     }
 };

 task.validateRenderSection = function (entities, parentParameters, args) {

     var customDialogParameters = args.commons.api.parentVc.customDialogParameters;
     var dicCompanyProductType = {};
     if (entities.dicCompanyProductType) {
         dicCompanyProductType = entities.dicCompanyProductType;
     }
     entities.Values = [];
     var validation = true;
     /*Check validation field by field*/
     if (validation && entities.WarrantyGeneral.warrantyType != 'PERSONAL') {
         angular.forEach(dicCompanyProductType.dictFunctionalityGroups, function (dicFuncGroup) {
             angular.forEach(dicFuncGroup.dictionaryFields, function (field) {
                 //SMO TEMPORAL
                 if (!angular.element("#RFIELD" + field.id).data("kendoValidator").validate() && validation) {
                     validation = false;
                 }
                 if (field != null && field.id != null) {
                     if (field.fieldvalues != null && field.fieldvalues.length == 1 && field.fieldvalues[0].valueSourceId == 'P') {
                         if (angular.isDefined(field.value)) {
                             var content = field.value.split("-");
                             if (content.length > 1) {
                                 entities.FieldByProductValues = {
                                     requestId: parentParameters.Task.bussinessInformationIntegerTwo, //entities.OriginalHeader.IDRequested,
                                     productId: customDialogParameters.BankignProductId, //customDialogParameters.typeGuaranteeData.typeOfGuarantee, //entities.OriginalHeader.ProductType,
                                     fieldId: field.id,
                                     value: content[0]
                                 }
                             } else {
                                 entities.FieldByProductValues = {
                                     requestId: parentParameters.Task.bussinessInformationIntegerTwo, //entities.OriginalHeader.IDRequested,
                                     productId: customDialogParameters.BankignProductId, //customDialogParameters.typeGuaranteeData.typeOfGuarantee, //entities.OriginalHeader.ProductType,
                                     fieldId: field.id,
                                     value: field.value
                                 }
                             }
                         }
                     } else {
                         entities.FieldByProductValues = {
                             requestId: parentParameters.Task.bussinessInformationIntegerTwo, //entities.OriginalHeader.IDRequested,
                             productId: customDialogParameters.BankignProductId, //customDialogParameters.typeGuaranteeData.typeOfGuarantee, //entities.OriginalHeader.ProductType,
                             fieldId: field.id,
                             value: field.value
                         }
                     };
                     entities.Values.push(entities.FieldByProductValues);
                 }

             });
         });
     }

     if (validation) {
         return true;
     } else {
         return false;
     }
 };

 task.validateBeforeSave = function (entities, args, operation) {
     entities.WarrantySituation.totalInitialValue = 0
     entities.WarrantySituation.sharedType = false;
     var rows = entities.CustomerSearch.data().length;
     var contadorSupported = 0;     
     var contadorOwner = 0;
     var queryString = {}; //JSA
     queryString = FLCRE.UTILS.getQueryStrings(); //JSA
     if (rows == 0){
       args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62351', false);       
       return;
     }
     
     if (queryString.option != 2){
         if (entities.WarrantyGeneral.initialValue  <= 0 || entities.WarrantyGeneral.appraisalValue <= 0){
            args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62350', false);       
            return;
         }
     }
     if ("DPF" == entities.WarrantyGeneral.warrantyType && (entities.WarrantyGeneral.fixedTerm == undefined || entities.WarrantyGeneral.fixedTerm == null || entities.WarrantyGeneral.fixedTerm == "")) {
         args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_CAMPOPLTO_34376', true);
         return;
     }
     if ("AHORRO" == entities.WarrantyGeneral.warrantyType && (entities.WarrantyGeneral.accountAho == undefined || entities.WarrantyGeneral.accountAho == null || entities.WarrantyGeneral.accountAho == "")) {
         args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_CAMPOCUIT_44382', true);
         return;
     }
     for (var i = 0; i < rows; i++){
         if (entities.CustomerSearch.data()[i].warrantyType == FLCRE.CONSTANTS.TypeWarranty.Supported){
            contadorSupported = contadorSupported + 1;
         }
         if (entities.CustomerSearch.data()[i].warrantyType == FLCRE.CONSTANTS.TypeWarranty.Owner){
            contadorOwner = contadorOwner + 1;
         }
     }

     if (contadorOwner == 0 && contadorSupported == 0){
        args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62352', false);       
        return;
     }
     if (contadorOwner == 0 && rows < 2){
        args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62353', false);       
        return;
     }
     rows = entities.SharedEntityWarranty.data().length
     if (entities.SharedWarrantyInfo.shared == 'S' && rows == 0){        
        args.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62354', false);       
        return;
     }else{
        entities.WarrantySituation.sharedType = true;
        for (var x=0; x < rows; x++){
           entities.WarrantySituation.totalInitialValue = entities.WarrantySituation.totalInitialValue + entities.SharedEntityWarranty.data()[x].value;
        }
     }
     var saveWarranty = true;
     var api = args.commons.api;
     var customParameters = args.commons.api.parentVc.customDialogParameters;
     var customDialogParameters = args.commons.api.parentVc.customDialogParameters;
     var customDialogParameters = api.navigation.getCustomDialogParameters().Mode == args.commons.constants.mode.Insert ? api.parentVc.parentVc.customDialogParameters : api.parentVc.customDialogParameters;
     if (api.navigation.getCustomDialogParameters().Mode == args.commons.constants.mode.Insert && api.parentVc != undefined && api.parentVc.customDialogParameters != undefined && api.parentVc.customDialogParameters.isContainer != true) {
         var showMessageErrorPage = false;
         var processDate = api.parentVc.customDialogParameters.processDate;
         entities.generalData.isNew = true;
     }

     if ((customParameters != undefined || customParameters.typeGuaranteeData != undefined) && saveWarranty == true) {
         var numErrors = args.commons.api.errors.getErrorsGroup('GR_ARANSCATIO07_09', false);
         var numLocalizationErrors = args.commons.api.errors.getErrorsGroup('GR_ARANSCATIO07_11', false);
         var numSituationErrors = args.commons.api.errors.getErrorsGroup('GR_ARANSCATIO07_15', false);
         var numNewSituationErrors = args.commons.api.errors.getErrorsGroup('G_CLASSSIAIA_336W85', false);
         var numAditionalDataErrors = task.validateRenderSection(entities, customDialogParameters, args); //args.commons.api.errors.getErrorsGroup('GR_ITAEDEARVE21_02', false);
         if (numErrors > 0 || numLocalizationErrors > 0 || numSituationErrors > 0 || numNewSituationErrors > 0 || !numAditionalDataErrors) {
             saveWarranty = false;
             showMessageErrorPage = true;
             var errorTab = $("#VC_RRCAI67_WACRI_884_tab").data("kendoTabStrip");
             var numErrorTab = 0;
             if (numErrors > 0) {
                 numErrorTab = 0;
             } else if (numLocalizationErrors > 0) {
                 numErrorTab = 1;
             } else if (numSituationErrors > 0 || numNewSituationErrors> 0) {
                 numErrorTab = 2;
             } else if (!numAditionalDataErrors) {
                 numErrorTab = 3;
             }
             errorTab.select(numErrorTab);
         }
         if ("S" == entities.WarrantyGeneral.mandatoryDocument && (entities.WarrantyGeneral.documentNumber == undefined || entities.WarrantyGeneral.documentNumber == null)) {
             saveWarranty = false;
             args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MATOYDUME_09219', true);
         }
         if (hasGuarantor && (api.vc.model.WarrantyGeneral.guarantor == null || api.vc.model.WarrantyGeneral.guarantor == "")) {
             saveWarranty = false;
             args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSSEGUARO_46360', true);
         }
         if (showMessageErrorPage) {
             args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ESICINSPG_05163', true);
         }
         if (entities.WarrantyGeneral.guarantor != null) {
             var guarantorDescription = entities.WarrantyGeneral.guarantor;
             var indexEnd = guarantorDescription.indexOf("-");
             var guarantorId = guarantorDescription.substring(0, indexEnd).trim();
             for (var i = 0; i < entities.CustomerSearch.data().length; i++) {
                 if (entities.CustomerSearch.data()[i].CustomerId == guarantorId) {
                     saveWarranty = false;
                     args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_RANTOESSG_12402', true);
                 }
             }
         }


         if (saveWarranty == true && task.validateRenderSection(entities, customDialogParameters, args)) {
             //args.commons.execServer = true;				
             var serverParameters = args.commons.api.vc.serverParameters;
             if (operation == "I") {
                 entities.generalData.isNew = true;
                 //var serverParameters = args.commons.api.vc.serverParameters;
                 serverParameters.WarrantyGeneral = true;
                 serverParameters.WarrantyLocation = true;
                 serverParameters.WarrantySituation = true;
                 serverParameters.CustomerSearch = true;
                 serverParameters.Values = true;
                 serverParameters.WarrantyDescription  = true;
                 serverParameters.SharedEntityWarranty  = true;
                 return true;
             } else {
                 entities.generalData.isNew = false;
                 serverParameters.WarrantyGeneral = true;
                 serverParameters.WarrantyLocation = true;
                 serverParameters.WarrantySituation = true;
                 serverParameters.CustomerSearch = true;
                 serverParameters.Values = true;
                 serverParameters.generalData = true;
                 serverParameters.WarrantyDescription  = true;
                 serverParameters.SharedEntityWarranty  = true;
                 return true;
             }
         } else {
             return false;
         }
     } else {
         return false;
     }

 };
	

task.validateHipWarranty = function (superiorTypeOfGuarantee, viewState) {
    if ("HIP" == superiorTypeOfGuarantee) {
        viewState.enableValidation('VA_ARANSCATIO0709_AIUE963', VisualValidationTypeEnum.Required);
    } else {
        viewState.disableValidation('VA_ARANSCATIO0709_AIUE963', VisualValidationTypeEnum.Required);
    }
};


	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: warrantiesCreation
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        var api = onCloseModalEventArgs.commons.api
        var queryString = {};
        queryString = FLCRE.UTILS.getQueryStrings();
        var nav = onCloseModalEventArgs.commons.api.navigation;

        if(onCloseModalEventArgs.result!=undefined && onCloseModalEventArgs.result.parameterGuarantee !=undefined){
            if(onCloseModalEventArgs.result.parameterGuarantee.Description == 'PERSONAL'){
                api.viewState.show('VA_ARANSCATIO0709_RNTR310', true);
            }else{
                api.viewState.hide('VA_ARANSCATIO0709_RNTR310', true);
            }
            if(onCloseModalEventArgs.result.parameterGuarantee.Status == 'C' && queryString.option == 2){
                onCloseModalEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62359', false);
                api.viewState.disable('CM_RRCAI67UAR18', true);
                onCloseModalEventArgs.commons.execServer = true;
            }
            if(onCloseModalEventArgs.result.parameterGuarantee.Status == 'A' && queryString.option == 2){
                onCloseModalEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62358', false);
                api.viewState.disable('CM_RRCAI67UAR18', true);
                onCloseModalEventArgs.commons.execServer = true;
            }
            entities.WarrantyGeneral.externalCode = onCloseModalEventArgs.result.parameterGuarantee.GuaranteeCode;
            entities.WarrantyGeneral.warrantyType = onCloseModalEventArgs.result.parameterGuarantee.GuaranteeType;
            entities.WarrantyGeneral.office = onCloseModalEventArgs.result.parameterGuarantee.Office;
            onCloseModalEventArgs.commons.execServer = true;
        }
        if(onCloseModalEventArgs.result!=undefined && onCloseModalEventArgs.result.compartida == 'S'){
            var rows = entities.SharedEntityWarranty.data().length       
            if (rows != null && rows > 0){
                for (var i = 0; i < rows; i++) {              
                    if (entities.SharedEntityWarranty.data()[i].entity == onCloseModalEventArgs.result.entity){
                        onCloseModalEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62357', false);
                       return;
                }
            }
        }
         api.grid.addRow('SharedEntityWarranty',onCloseModalEventArgs.result);  
         entities.WarrantyGeneral.currentValue = entities.WarrantyGeneral.currentValue - onCloseModalEventArgs.result.value;
      }
    };

	//Start signature to Callback event to VC_RRCAI67_WACRI_884
task.onCloseModalEventCallbak = function(entities, onCloseModalCallbackEventArgs) {
	var customDialogParameters = onCloseModalCallbackEventArgs.commons.api.navigation.getCustomDialogParameters();
    if(onCloseModalCallbackEventArgs.success){
        var api = onCloseModalCallbackEventArgs.commons.api;
        var viewState = onCloseModalCallbackEventArgs.commons.api.viewState;

        onCloseModalCallbackEventArgs.commons.execServer = false;

        if (api.parentVc != undefined){
            api.parentVc.setContainerView(entities.WarrantyGeneral.externalCode);
        }
		var isNew = false;
		var queryString = FLCRE.UTILS.getQueryStrings();
		if(queryString.option == 8){
			isNew = true;
		}
		task.callSpecificationItems(entities, onCloseModalCallbackEventArgs,isNew);//SRO
        task.enableDisableControls(entities, onCloseModalCallbackEventArgs);
		
	}
};


task.enableDisableControls = function (entities, onCloseModalCallbackEventArgs) {
    var api = onCloseModalCallbackEventArgs.commons.api;
    var rows = entities.CustomerSearch.data();
    var rowsSharedEntities = entities.SharedEntityWarranty.data();
    var queryString = {}; //JSA
    queryString = FLCRE.UTILS.getQueryStrings(); //JSA

    if (entities.SharedWarrantyInfo.shared == 'N') {
        api.viewState.hide('G_SHAREDWATN_707230');
    } else if (entities.SharedWarrantyInfo.shared == 'S' && rowsSharedEntities != null && rowsSharedEntities != undefined && rowsSharedEntities.length > 0) {
        api.viewState.show('G_SHAREDWATN_707230');
    }

    if ("AHORRO" == entities.WarrantyGeneral.warrantyType) {
        api.viewState.show('VA_ACCOUNTAHOJMZWG_417O07');
        api.viewState.show('VA_BALANCEAVAILALL_926O07');
        api.viewState.readOnly('VA_ACCOUNTAHOJMZWG_417O07',true);
        api.viewState.readOnly('VA_BALANCEAVAILALL_926O07',true);
    } else {
        api.viewState.hide('VA_ACCOUNTAHOJMZWG_417O07');
        api.viewState.hide('VA_BALANCEAVAILALL_926O07');
    }

    if ("DPF" == entities.WarrantyGeneral.warrantyType) {
        api.viewState.show('VA_ARANSCATIO0709_IDER508');
        api.viewState.show('VA_ARANSCATIO0709_DRMA851');
        api.viewState.readOnly('VA_ARANSCATIO0709_IDER508',true);
        api.viewState.readOnly('VA_ARANSCATIO0709_DRMA851',true);
    } else {
        api.viewState.hide('VA_ARANSCATIO0709_IDER508');
        api.viewState.hide('VA_ARANSCATIO0709_DRMA851');
    }

    if(entities.WarrantyGeneral.warrantyType == 'PERSONAL'){
        api.viewState.show('VA_ARANSCATIO0709_RNTR310', true);
    }else{
        api.viewState.hide('VA_ARANSCATIO0709_RNTR310', true);
    }

    if (entities.WarrantyGeneral.status != 'P' && queryString.option == '2') {
        api.viewState.disable('VA_CLASSWARRANTYYY_283W85',true);
        api.viewState.readOnly('VA_ADMISSIBILITYYY_351W85',true);
    }

    api.grid.hideToolBarButton('QV_QRYLI5474_83', 'CEQV_201_QV_QRYLI5474_83_514');

    if (queryString.option == '8') {


        if(rows != undefined && rows != null && rows.length > 0){
            api.grid.hideToolBarButton('QV_QRYLI5474_83', 'create');
            for (var i = 0; i < rows.length; i++) {
                api.grid.hideGridRowCommand('QV_QRYLI5474_83', rows[i], 'edit');			
                api.grid.hideGridRowCommand('QV_QRYLI5474_83', rows[i], 'delete');

            }
        }
        
        if(rowsSharedEntities != undefined && rowsSharedEntities != null && rowsSharedEntities.length > 0){
            //api.grid.hideToolBarButton('QV_6063_45257', 'create');
            api.grid.hideToolBarButton('QV_2783_87838', 'create');

            for (var i = 0; i < rowsSharedEntities.length; i++) {
                api.grid.hideGridRowCommand('QV_2783_87838', rowsSharedEntities[i], 'delete');
            }
        }
    }
};
	//Entity: WarrantyLocation
//WarrantyLocation.documentCity (ComboBox) View: T_localizationView
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_DOCUMENTCITYYOL_507E85 = function (loadCatalogDataEventArgs) {

    loadCatalogDataEventArgs.commons.execServer = true;

    //loadCatalogDataEventArgs.commons.serverParameters.WarrantyLocation = true;
};

	//Entity: WarrantyLocation
//WarrantyLocation.warrantyCity (ComboBox) View: T_localizationView
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_WARRANTYCITYHRC_437E85 = function (loadCatalogDataEventArgs) {

    loadCatalogDataEventArgs.commons.execServer = true;

    //loadCatalogDataEventArgs.commons.serverParameters.WarrantyLocation = true;
};

	//Entity: WarrantyDescription
    //WarrantyDescription.periodicity (ComboBox) View: WarrantyDescription
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PERIODICITYETNZ_810235 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.WarrantyDescription = true;
    };

	//Entity: SharedWarrantyInfo
    //SharedWarrantyInfo.shared (CheckBox) View: SharedWarranty
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8733SGHHBCGPQMZ_918230 = function(  entities, changedEventArgs ) {
		var api = changedEventArgs.commons.api;
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
			
		if(changedEventArgs.newValue == 'N'){
         if (entities.SharedEntityWarranty.data().length == 0)
         {
            api.viewState.hide('G_SHAREDWATN_707230');
            entities.WarrantyGeneral.currentValue = entities.WarrantyGeneral.appraisalValue
         }else{
            entities.SharedWarrantyInfo.shared = 'S'
            changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62355', false);
         }
		}else if(changedEventArgs.newValue == 'S'){
			api.viewState.show('G_SHAREDWATN_707230');
		}
    };

     task.hideFields = function(viewState){
        viewState.hide('VA_ARANSCATIO0709_CODE053');
        viewState.hide('VA_ARANSCATIO0709_EXTE434');
        viewState.hide('VA_ARANSCATIO0709_ILAE518');
        viewState.hide('VA_ARANSCATIO0709_MONY430');
        viewState.hide('VA_ARANSCATIO0709_AIUE963');
        viewState.hide('VA_ARANSCATIO0709_VADT830');
        viewState.hide('VA_ARANSCATIO0709_CVER937');
        viewState.hide('VA_ARANSCATIO0709_IDER508');
        viewState.hide('VA_ARANSCATIO0709_DRMA851');
        viewState.hide('VA_ACCOUNTAHOJMZWG_417O07');
        viewState.hide('VA_BALANCEAVAILALL_926O07');
        viewState.hide('VA_ARANSCATIO0709_OSUI766');
        viewState.hide('VA_ARANSCATIO0709_RNTR310');
        viewState.hide('VA_GUARANTORTYPEEE_866O07');
        viewState.hide('VA_ARANSCATIO0709_RTIO767');
        viewState.hide('VA_ARANSCATIO0709_INRT049');
        viewState.hide('VA_ARANSCATIO0711_RVNE334');
        viewState.hide('VA_ARANSCATIO0711_CITY886');
        viewState.hide('VA_ARANSCATIO0711_PARI601');
        viewState.hide('CM_RRCAI67NLA20');
        viewState.hide('CM_RRCAI67UAR18', true);
        viewState.hide('GR_ARANSCATIO07_14');
        viewState.hide('GR_ARANSCATIO07_15');
    };

    task.validateManType = function(queryString, viewState){

        //Generales
        viewState.readOnly('VA_ARANSCATIO0709_ESOE640', queryString.option == 8);
        viewState.readOnly('VA_SUITABILITYBRTD_975O07', queryString.option == 8);
        //Situacion/Clase
        viewState.readOnly('VA_ADMISSIBILITYYY_351W85', queryString.option == 8);
        viewState.readOnly('VA_CONSTITUTIONWGI_434W85', queryString.option == 8);
        viewState.readOnly('VA_LASTVALUATIONNN_406W85', queryString.option == 8);
        viewState.readOnly('VA_EXPIRATIONTLEAG_155W85', queryString.option == 8);
        viewState.readOnly('VA_LEGALSTATUSXQXS_936W85', queryString.option == 8);
        viewState.readOnly('VA_INSTRUCTIONCUCF_353W85', queryString.option == 8);
        switch (queryString.option) {
            case "8":
                viewState.disable('VA_CLASSWARRANTYYY_283W85', true);
                viewState.disable('VA_AMOUNTDTFTGPVCH_154W85', true);
                viewState.disable('VA_PENALTYMOPKRWEK_852W85', true);
                viewState.disable('VA_DEPLETIVEPEROPR_902W85', true);
                viewState.disable('VA_EXPIRATIONCOLTN_883W85', true);
                viewState.disable('VA_COMMERCIALORYIS_667W85', true);
                viewState.disable('VA_SINISTERPHKURIC_776W85', true);
                viewState.disable('VA_ARANSCATIO0709_RNTR310', true);
                viewState.disable('VA_LICENSEDATEEIIR_288E85', true);

                viewState.readOnly('VA_ARANSCATIO0709_OEBE980', true);
                viewState.readOnly('VA_ARANSCATIO0709_NVLE498', true);
                viewState.readOnly('VA_ARANSCATIO0709_RNTR310', true);
                viewState.readOnly('VA_LICENSEDATEEIIR_288E85', true);
                break;
            case "2":
                viewState.enable('VA_AMOUNTDTFTGPVCH_154W85', true);
                viewState.disable('VA_PENALTYMOPKRWEK_852W85', true);
                viewState.disable('VA_DEPLETIVEPEROPR_902W85', true);
                viewState.disable('VA_EXPIRATIONCOLTN_883W85', true);
                viewState.disable('VA_COMMERCIALORYIS_667W85', true);
                viewState.enable('VA_SINISTERPHKURIC_776W85', true);
                viewState.enable('VA_ARANSCATIO0709_RNTR310', true);
                viewState.enable('VA_LICENSEDATEEIIR_288E85', true);

                viewState.readOnly('VA_ARANSCATIO0709_OEBE980', false);
                viewState.readOnly('VA_ARANSCATIO0709_NVLE498', true);
                viewState.readOnly('VA_ARANSCATIO0709_RNTR310', false);
                viewState.readOnly('VA_LICENSEDATEEIIR_288E85', false);
                viewState.readOnly('VA_ARANSCATIO0709_IDER508', true);
                viewState.readOnly('VA_ACCOUNTAHOJMZWG_417O07', true);
                viewState.disable('VA_ARANSCATIO0709_IDER508', true);
                viewState.disable('VA_ACCOUNTAHOJMZWG_417O07', true);
                break;
            default:
                viewState.enable('VA_CLASSWARRANTYYY_283W85', true);
                viewState.enable('VA_AMOUNTDTFTGPVCH_154W85', true);
                viewState.enable('VA_PENALTYMOPKRWEK_852W85', true);
                viewState.enable('VA_DEPLETIVEPEROPR_902W85', true);
                viewState.enable('VA_EXPIRATIONCOLTN_883W85', true);
                viewState.enable('VA_COMMERCIALORYIS_667W85', true);
                viewState.enable('VA_SINISTERPHKURIC_776W85', true);
                viewState.enable('VA_ARANSCATIO0709_RNTR310', true);
                viewState.enable('VA_LICENSEDATEEIIR_288E85', true);

                viewState.readOnly('VA_ARANSCATIO0709_OEBE980', false);
                viewState.readOnly('VA_ARANSCATIO0709_NVLE498', false);
                viewState.readOnly('VA_ARANSCATIO0709_RNTR310', false);
                viewState.readOnly('VA_LICENSEDATEEIIR_288E85', false);
        }
        //Localizacion
        viewState.readOnly('VA_DOCUMENTLOCAIIN_297E85', queryString.option == 8);
        viewState.readOnly('VA_DOCUMENTCITYYOL_507E85', queryString.option == 8);
        viewState.readOnly('VA_WARRANTYCITYHRC_437E85', queryString.option == 8);
        viewState.readOnly('VA_ACCOUNTINGOFEIE_892E85', queryString.option == 8);
        viewState.readOnly('VA_ARANSCATIO0711_ADDE588', queryString.option == 8);
        viewState.readOnly('VA_PHONEQGOOWRFNPX_974E85', queryString.option == 8);
        viewState.readOnly('VA_ARANSCATIO0711_SOER604', queryString.option == 8);
        viewState.readOnly('VA_ARANSCATIO0711_POTR327', queryString.option == 8);
        viewState.readOnly('VA_LICENSENUMBERRR_482E85', queryString.option == 8);
        viewState.readOnly('VA_LICENSEDATEEIIR_288E85', queryString.option == 8);
        //Descripcion
        viewState.readOnly('VA_DESCRIPTIONKCCH_290235', queryString.option == 8);
        if (queryString.option == 8){
            viewState.disable('VA_CONTROLVISITCWN_191235', true);
        }else{
            viewState.enable('VA_CONTROLVISITCWN_191235', true);
        }
        viewState.readOnly('VA_PERIODICITYETNZ_810235', queryString.option == 8);
        //Compartida            
        if (queryString.option == 8){
            viewState.disable('VA_8733SGHHBCGPQMZ_918230', true);
        }else{
            viewState.enable('VA_8733SGHHBCGPQMZ_918230', true);
        }
        //Boton Guardar
        if (queryString.option == 8){
            viewState.hide('CM_RRCAI67UAR18', true);
            viewState.disable('CM_RRCAI67UAR18', true);
        }else{
            viewState.show('CM_RRCAI67UAR18', true);
            viewState.enable('CM_RRCAI67UAR18', true);
        }
    };
    
    task.change.VA_CONTROLVISITCWN_191235 = function(  entities, changedEventArgs ) {
      changedEventArgs.commons.execServer = false; 
      var viewState = changedEventArgs.commons.api.viewState;
        if (entities.WarrantyDescription.controlVisit === 'S') {
            BUSIN.API.show(viewState, ['VA_PERIODICITYETNZ_810235']);            
            BUSIN.API.hide(viewState, ['VA_REASONQIMDHESAS_983235']);
        } else {
            BUSIN.API.show(viewState, ['VA_REASONQIMDHESAS_983235']);
            BUSIN.API.hide(viewState, ['VA_PERIODICITYETNZ_810235']);
        }
    };
    	//Entity: WarrantyGeneral
    //WarrantyGeneral.appraisalValue (TextInputBox) View: T_warrantiesCreation
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0709_AIUE963 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;        
    var rows = entities.SharedEntityWarranty.data().length;
    var api = changedEventArgs.commons.api;
    if (entities.WarrantyGeneral.appraisalValue > entities.WarrantyGeneral.initialValue){
       changedEventArgs.isValid = false;
       changedEventArgs.focus = true;
       entities.WarrantyGeneral.appraisalValue = "";       
       FLCRE.UTILS.clearNumericField("VA_ARANSCATIO0709_AIUE963");
       changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62356', false);       
    
    }
    api.vc.model.WarrantyGeneral.currentValue = api.vc.model.WarrantyGeneral.appraisalValue;
        if (rows != null && rows > 0){
           for (var i = 0; i < rows; i++) {
               var porcentaje = entities.SharedEntityWarranty.data()[i].sharedPercentage              
               var valorComercial = api.vc.model.WarrantyGeneral.appraisalValue;      
               //var valor = entities.SharedEntityWarranty.data()[i].value
               //var valorContable = entities.SharedEntityWarranty.data()[i].bookValue
               var porcentajeComp = entities.SharedEntityWarranty.data()[i].corporation
               var valor = ((valorComercial * porcentaje)/100);
               var valorContable = valorComercial - valor;  
               var data = {//entity: entities.SharedEntityWarranty.data()[i].entity,
                           value: valor,
                           bookValue: valorContable,
                           //corporation: entities.SharedEntityWarranty.corporation,                    
                           //date: entities.SharedEntityWarranty.data()[i].date, 
                           //sharedPercentage:entities.SharedEntityWarranty.data()[i].sharedPercentage,                           
                    };               
               changedEventArgs.commons.api.grid.updateRow('SharedEntityWarranty', i, data);               
               entities.WarrantyGeneral.currentValue = entities.WarrantyGeneral.currentValue - valor;
           }           
        }
    
        //changedEventArgs.commons.serverParameters.WarrantyGeneral = true;
    };
    //Entity: WarrantyLocation
    //WarrantyLocation.storeKeeper (ComboBox) View: T_localizationView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0711_SOER604 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        var api = changedEventArgs.commons.api;
        var viewState = api.viewState;        
        if (entities.WarrantyLocation.storeKeeper != null && entities.WarrantyLocation.storeKeeper != ""){            
              BUSIN.API.hide(viewState, ['VA_ARANSCATIO0711_POTR327']);
              BUSIN.API.hide(viewState, ['VA_LICENSENUMBERRR_482E85']);
              BUSIN.API.hide(viewState, ['VA_LICENSEDATEEIIR_288E85']);            
        }else{
              BUSIN.API.show(viewState, ['VA_ARANSCATIO0711_POTR327']);            
              BUSIN.API.show(viewState, ['VA_LICENSENUMBERRR_482E85']);            
              BUSIN.API.show(viewState, ['VA_LICENSEDATEEIIR_288E85']);            
        }
    };
    
    //Entity: WarrantyLocation
    //WarrantyLocation.repository (TextInputBox) View: T_localizationView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0711_POTR327 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        var api = changedEventArgs.commons.api;
        var viewState = api.viewState;        
        if ((entities.WarrantyLocation.repository != null && entities.WarrantyLocation.repository != "") ||  (entities.WarrantyLocation.licenseNumber != null &&  entities.WarrantyLocation.licenseNumber != "")){            
             BUSIN.API.hide(viewState, ['VA_ARANSCATIO0711_SOER604']);
        }else{
             BUSIN.API.show(viewState, ['VA_ARANSCATIO0711_SOER604']);            
        }  
    };
    
    //Entity: WarrantyLocation
    //WarrantyLocation.licenseNumber (TextInputBox) View: T_localizationView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_LICENSENUMBERRR_482E85 = function(  entities, changedEventArgs ) {
         changedEventArgs.commons.execServer = false;
         var api = changedEventArgs.commons.api;
         var viewState = api.viewState;
         var queryString = {};
         queryString = FLCRE.UTILS.getQueryStrings();

         if (entities.WarrantyLocation.licenseNumber != null &&  entities.WarrantyLocation.licenseNumber != ""){
            if (queryString.option == '8'){
                viewState.readOnly('VA_LICENSEDATEEIIR_288E85', true);
                viewState.disable('VA_LICENSEDATEEIIR_288E85', true);
            }else{
                viewState.readOnly('VA_LICENSEDATEEIIR_288E85', false);
                viewState.enable('VA_LICENSEDATEEIIR_288E85', true);
            }
            //entities.WarrantyLocation.licenseDateExpiration = null;
         }else{
            if (queryString.option != '8'){
                entities.WarrantyLocation.licenseDateExpiration = null;
            }
            viewState.readOnly('VA_LICENSEDATEEIIR_288E85', true); 
            viewState.disable('VA_LICENSEDATEEIIR_288E85', true);
         }
         if ((entities.WarrantyLocation.repository != null && entities.WarrantyLocation.repository != "") ||  (entities.WarrantyLocation.licenseNumber != null &&  entities.WarrantyLocation.licenseNumber != "")){            
              BUSIN.API.hide(viewState, ['VA_ARANSCATIO0711_SOER604']);                           
         }else{
              BUSIN.API.show(viewState, ['VA_ARANSCATIO0711_SOER604']);            
         }              
    };
    
    //gridRowDeleting QueryView: QV_2783_87838
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_2783_87838 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = false;
         if (entities.SharedEntityWarranty.data().length == 0)
         {            
            entities.WarrantyGeneral.currentValue = entities.WarrantyGeneral.appraisalValue
         }
        };
		
		/***************************** Evento para llamar a Pantalla Manual Especificaciones **********************/
		
		task.callSpecificationItems = function(entities, args, isNew){
			var api = args.commons.api,
				nav = args.commons.api.navigation,
				customDialogParameters = api.navigation.getCustomDialogParameters();

			api.vc.removeChildVc('collateral');
			nav.label = "collateral";
			nav.customAddress = {
				id: 'collateral',
				url: 'collateral/collateral-specification.html', 
				useMinification: false
			};
			nav.scripts = [{
             module: 'collateral',
             files: ['collateral/controllers/collateral-specification-ctrl.js', 'collateral/services/collateral-specification-srv.js']
			}];
			
			nav.customDialogParameters = {
					collateralId: entities.WarrantyGeneral.code,
					collateralType: entities.WarrantyGeneral.warrantyType,
					branchOffice: entities.WarrantyGeneral.office,
					isNew: isNew
			};
			nav.registerCustomView('G_SPECIFIIRY_631679')
		
		};
		
		task.showCollateralSearch = function(args){
			var nav = args.commons.api.navigation;
			nav.address = {
                moduleId: 'BUSIN',
                subModuleId: 'FLCRE',
                taskId: 'T_FLCRE_24_GURNH31',
                taskVersion: '1.0.0',
                viewContainerId: 'VC_GURNH31_OMREA_904'
            };
            nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
            nav.modalProperties = {
                size: 'lg'
            };
            nav.queryParameters = {
                mode: args.commons.constants.mode.Update
            };
            nav.customDialogParameters = {
                maxRelation: 0
            };
            nav.openModalWindow(args.commons.controlId);
		};
        
}());