//"TaskId": "T_FLCRE_82_OIIRL51"
//Abrir arbol de actividades economicas
var listCustomer = [];
var taskHeader = {};
var renderSection = 'N';
var modeView = '';
var typeRequest = ''; // Tipo de solicitud Grupal, Interciclos, Normal

task.gridInitColumnTemplate.QV_BOREG0798_55 = function (idColumn) { // QueryView:
    // Borrowers
    if (idColumn === 'DateCIC') {
        return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
    }
};

// QueryView: Borrowers
// Evento GridInitDetailTemplate: InicializaciÃ³n de datos del formulario del
// detalle de un registro de la grilla de datos
task.gridInitEditColumnTemplate.QV_BOREG0798_55 = function (idColumn) {
    // if(idColumn === 'NombreColumna'){
    // return "<span></span>";
    // }
};

//QueryView: GridRefinancingOperations
//Evento GridInitDetailTemplate: InicializaciÃ³n de datos del formulario del detalle de un registro de la grilla de datos 
task.gridInitColumnTemplate.QV_ITRIC1523_63 = function (idColumn) {
    if (idColumn === 'Capitalize') {
        return "<span><input type=\'checkbox\' #if (Capitalize === true) {# checked #}# ng-click=\"vc.grids.QV_ITRIC1523_63.events.customRowClick($event, \'VA_ININGOTONE0435_APIT130\', \'GridRefinancingOperations\', 'QV_ITRIC1523_63')\" ng-disabled= \"!vc.viewState.QV_ITRIC1523_63.column.selected.enabled\"/></span>";
    }
};

task.showButtons = function (args) {
    var api = args.commons.api;
    var parentParameters = args.commons.api.parentVc.customDialogParameters;
    // Boton Principal (Wizard)
    // initDataEventArgs.commons.api.vc.parentVc.executeSaveTask =
    // function(){
    // initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save',
    // undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
    // }

    // Boton Secundario 1 (Wizard)
    // (Para aumentar un boton adicional copiar y pegar el bloque de codigo
    // debajo de estos comentarios)
    // (Posteriormente cambiar el numero de terminacion de la etiqueta Ej.
    // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 =>
    // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
    // (Posteriormente cambiar el numero de terminacion del metodo Ej.
    // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
    // function() =>
    // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
    // function())
    // (Tiene una limitacion de 5 axecute commands)

    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == "Q") {
        args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    } else {
        args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
        args.commons.api.vc.parentVc.executeCommand1 = function () {
            args.commons.api.vc.executeCommand('CM_OIIRL51SVE80', 'Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
        }

        args.commons.api.vc.parentVc.labelExecuteCommand2 = "Imprimir";
        args.commons.api.vc.parentVc.executeCommand2 = function () {
            args.commons.api.vc.executeCommand('CM_OIIRL51INT80', 'Print', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
        }
    }
};

task.loadTaskHeader = function (entities, eventArgs) {

    var client = eventArgs.commons.api.parentVc.model.Task;
    var originalh = entities.OriginalHeader;

    // Titulo de la cabecera (title)
    LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientName);

    // Subtitulos de la cabecera
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == '0' ? '--' : originalh.IDRequested), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Producto', entities.generalData.productTypeName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.symbolCurrency, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', entities.OriginalHeader.Term, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', entities.generalData.paymentFrecuencyName, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', cobis.userContext.getValue(cobis.constant.USER_OFFICE).value, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((entities.OfficerAnalysis.OfficierName != null) ? entities.OfficerAnalysis.OfficierName.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.generalData.loanType, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);

    // Actualizo el grupo de designer
    LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');

};

task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var row = args.model.DebtorGeneral.data()[0];

    row.set('CustomerCode', args.commons.api.vc.dialogParameters.CodeReceive);
    if (args.commons.api.vc.dialogParameters.commercialName !== '') {
        row.set('CustomerName', args.commons.api.vc.dialogParameters.commercialName);
    } else {
        row.set('CustomerName', args.commons.api.vc.dialogParameters.name);
    }

    row.set('Role', 'C');
    row.set('Identification', args.commons.api.vc.dialogParameters.documentId);
    row.set('Qualification', args.commons.api.vc.dialogParameters.califCartera);
    row.set('TypeDocumentId', "03");
    if (args.commons.api.vc.dialogParameters.documentId != null) {
        if (args.commons.api.vc.dialogParameters.documentId.length == 10) {
            row.set('TypeDocumentId', "01");
        } else if (args.commons.api.vc.dialogParameters.documentId.length == 13) {
            row.set('TypeDocumentId', "02");
        }
    }
};

// RESULTADO DE BUSQUEDA DE OPERACIONES
task.closeModalEvent.VC_OSRCH32_AOEAR_233 = function (args) {

    var debtors = angular.copy(args.commons.api.vc.model.DebtorGeneral.data());
    var band = false;
    // Recupero el resultado
    var result = args.result;

    // AÃ±ado los registros a la grilla de deudores
    for (var i = 0; i < result.debtors.length; i++) {
        for (var j = 0; j < debtors.length; j++) {
            if (debtors[j].CustomerCode == result.debtors[i].CustomerCode) {
                band = true;
                break;
            } else {
                band = false;
            }
        }
        if (!band) {
            args.commons.api.grid.addRow('DebtorGeneral', result.debtors[i], false);
        }
    }

    args.commons.api.grid.addAllRows('RefinancingOperations', result.operations, false);

    // var criteria = { field: "IsBase", operator:"eq" ,value: true} ;
    // var selectedRow =
    // args.commons.api.grid.selectRow("QV_ITRIC1523_63",criteria);
};

//Abrir arbol de actividades economicas
task.openFindProgram = function (argsI) {
    var nav = argsI.commons.api.navigation;
    nav.label = cobis.translate("BUSIN.DLB_BUSIN_OOMICPRPE_26369");
    nav.customAddress = {
        id: 'process',
        url: 'businessprocess/busin-tree-economicActivity-page.html',
        useMinification: false
    };
    nav.scripts = {
        module: 'businessprocess',
        files: ["/businessprocess/services/busin-tree-economicActivity-srv.js",
      "/businessprocess/controllers/busin-tree-economicActivity-ctrl.js",
      "/businessprocess/busin-tree-economicActivity.js"]
    };
    nav.modalProperties = {
        size: 'lg'
    };
};

//Se cierra arbol de actividades economicas
task.closeModalEvent.process = function (args) {
    if (args.result != "") {
        args.model.EntidadInfo.destinoEconomico = args.result.itemCode;
        args.model.EntidadInfo.destEconomicoDescription = args.result.itemName;
    }
};

task.validateEntities = function (entities) {
    var band = false;
    var originalh = entities.OriginalHeader;
    var officerAnalisis = entities.OfficerAnalysis
    if (originalh.AmountRequested !== null
        // &&originalh.Quota!==null
        && originalh.PaymentFrequency !== null && originalh.Term !== null && officerAnalisis.City !== null && officerAnalisis.Province !== null) {
        band = true;
    }
    return band;
};
task.renderConfigurationFieldByProduct = function (entities, args) {
    //Llamada a la configuraciÃ³n adicional por producto bancario
    var viewState = args.commons.api.viewState;
    var api = args.commons.api;
    var nav = args.commons.api.navigation;
    var viewState = args.commons.api.viewState;
    var parentParameters = args.commons.api.parentVc.customDialogParameters;
    var mode = '';
    // GR_AIUTOAVIEW91_04 - Es el grupo donde se va a mostrar los datos renderizados
    var ctrsToShow = ['GR_AIUTOAVIEW91_04'];
    BUSIN.API.show(viewState, ctrsToShow);
    //Si es modo consulta solo se debe mostrar los campos sin permitir ingresar o modificar datos
    if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == "Q") {
        modeView = parentParameters.Task.urlParams.MODE;
    }
    //se necesita por problemas con el scope
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
    nav.customDialogParameters = api.vc.customDialogParameters;
    nav.customDialogParameters.Type = "SECCION_RENDERIZADA";
    nav.customDialogParameters.BankignProductId = entities.OriginalHeader.ProductType;
    nav.customDialogParameters.Request = entities.OriginalHeader.IDRequested
    nav.customDialogParameters.BankingProductName = entities.generalData.productTypeName;
    nav.customDialogParameters.ModeView = modeView;
    nav.registerCustomView('GR_AIUTOAVIEW91_04');
}

task.validateproduct = function (entities, args) {
    var band = true;
    var originalh = entities.OriginalHeader;
    var dataProduct = entities.generalData;
    if (parseInt(originalh.Term) > parseInt(originalh.termLimit)) {
        args.commons.messageHandler.showMessagesError('El Plazo permitido por el producto es de hasta ' + originalh.termLimit);
        band = false;
    }
    return band;
};

task.validateRenderSection = function (entities, args) {
    var dicCompanyProductType = {};
    if (entities.dicCompanyProductType) {
        dicCompanyProductType = entities.dicCompanyProductType;
    }
    entities.Values = [];
    var validation = true;
    /*Check validation field by field*/
    angular.forEach(dicCompanyProductType.dictFunctionalityGroups, function (dicFuncGroup) {
        angular.forEach(dicFuncGroup.dictionaryFields, function (field) {
            if (validation) {
                if (!angular.element("#RFIELD" + field.id).data("kendoValidator").validate() && validation) {
                    validation = false;
                }
                if (field.fieldvalues != null && field.fieldvalues.length == 1 && field.fieldvalues[0].valueSourceId == 'P') {
                    if (angular.isDefined(field.value)) {
                        var content = field.value.split("-");
                        if (content.length > 1) {
                            entities.FieldByProductValues = {
                                requestId: entities.OriginalHeader.IDRequested,
                                productId: entities.OriginalHeader.ProductType,
                                fieldId: field.id,
                                value: field.value
                            };
                        }
                    }
                } else {
                    entities.FieldByProductValues = {
                        requestId: entities.OriginalHeader.IDRequested,
                        productId: entities.OriginalHeader.ProductType,
                        fieldId: field.id,
                        value: field.value
                    };
                }
                entities.Values.push(entities.FieldByProductValues);
            }
        });
    });

    if (validation) {
        return true;
    } else {
        return false;
    }
}
var DebtorGeneral = function (idClient, name, role, idType, idNumber) {
    this.CustomerCode = idClient;
    this.CustomerName = name;
    this.Role = role;
    this.TypeDocumentId = idType;
    this.Identification = idNumber;
};