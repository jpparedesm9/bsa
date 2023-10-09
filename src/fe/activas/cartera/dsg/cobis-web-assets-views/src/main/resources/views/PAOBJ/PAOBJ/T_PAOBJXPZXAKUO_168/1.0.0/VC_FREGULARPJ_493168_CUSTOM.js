/* variables locales de T_PAOBJXPZXAKUO_168*/
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

    
        var task = designerEvents.api.fregularizarpagosobjetados;
    

    //"TaskId": "T_PAOBJXPZXAKUO_168"
var queryString = {};
var isGroup = 'N';
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = args.commons.api.vc.dialogParameters.CodeReceive;
    var CustomerName = args.commons.api.vc.dialogParameters.name;
    var identification = args.commons.api.vc.dialogParameters.documentId;    
    var customerType = args.commons.api.vc.dialogParameters.customerType;

    var title = '';

    switch (customerType) {
    case 'P':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOCLEI_32810';
        isGroup = 'N';
        break;
    case 'C':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOCLEI_32810';
        isGroup = 'N';
        break;
    case 'S':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOGROU_63314';
        isGroup = 'S';
        break;
    case 'G':
        title = 'PAOBJ.LBL_PAOBJ_CDIGOGROU_63314';
        isGroup = 'S';
        break;
    }
    args.model.DatosBusquedaPagoObjetado.criterioBusqueda = customerCode;
    args.model.DatosBusquedaPagoObjetado.esGrupo = isGroup;
    args.commons.api.viewState.label("VA_1WFWHEAZGTYHGIU_390505",title);
};

task.gridRowCommand.VA_CHECKBOXSAGRGOQ_593505 = function (rowData, gridRowCommandEventArgs) {
    var viewState = gridRowCommandEventArgs.commons.api.viewState;
    var anterior = true;
    gridRowCommandEventArgs.commons.execServer = false;
    gridRowCommandEventArgs.stopPropagation = true;
    anterior = gridRowCommandEventArgs.rowData.seleccionar;
    if (anterior == false) {
        gridRowCommandEventArgs.rowData.seleccionar = true;
    } else {
        gridRowCommandEventArgs.rowData.seleccionar = false;
    }
};

    // (Button) 
    task.executeCommand.CM_TPAOBJXP_796 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var index = cobis.container.tabs.getCurrentTabIndex();
        cobis.container.tabs.removeTab(index);
    };

// (Button) 
    task.executeCommand.CM_TPAOBJXP_PBZ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;        
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

//Start signature to Callback event to CM_TPAOBJXP_PBZ
task.executeCommandCallback.CM_TPAOBJXP_PBZ = function(entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_3724_71065');
};

//Entity: DatosBusquedaPagoObjetado
    //DatosBusquedaPagoObjetado. (Button) View: FRegularizarPagosObjetados
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONLJHGJNV_588505 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        // entities.ResultadoPagosObjetados = [];
        executeCommandEventArgs.commons.api.grid.refresh('QV_3724_71065');
    };

//undefined Entity: 
task.executeQuery.Q_RESULTTO_3724 = function(executeQueryEventArgs){
    executeQueryEventArgs.commons.execServer = true;

    if (angular.isUndefined(executeQueryEventArgs.commons.api.vc.parentVc)) {
        executeQueryEventArgs.commons.api.vc.parentVc = {};
    }
    
    console.log(executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.esGrupo);
    console.log(executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.criterioBusqueda);

    executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = {
        parameters: {
            esGrupo: executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.esGrupo,
            criterioBusqueda: executeQueryEventArgs.commons.api.vc.model.DatosBusquedaPagoObjetado.criterioBusqueda
        }
    };
};

//Start signature to Callback event to Q_RESULTTO_3724
task.executeQueryCallback.Q_RESULTTO_3724 = function(entities, executeQueryCallbackEventArgs) {
    for (var i = 0; i < entities.ResultadoPagosObjetados.data().length; i++) {
            entities.ResultadoPagosObjetados.data()[i].seleccionar = false;
    }
};

task.gridInitColumnTemplate.QV_3724_71065 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
        //debugger;
        if (idColumn === 'seleccionar') {
            //return "<input type=\'checkbox\' name=\'seleccionar\' id=\'VA_CHECKBOXSAGRGOQ_593505' #if (seleccionar === true) {# checked #}# />";
            
            return "<input type=\'checkbox\' name=\'seleccionar\' id=\'VA_CHECKBOXSAGRGOQ_593505' #if (seleccionar === true) {# checked #}# ng-click=\"vc.grids.QV_3724_71065.events.customRowClick($event, \'VA_CHECKBOXSAGRGOQ_593505\',\'ResultadoPagosObjetados\', \'QV_3724_71065\')\"/>";
        }
    };

task.gridInitEditColumnTemplate.QV_3724_71065 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: FRegularizarPagosObjetados
    task.initData.VC_FREGULARPJ_493168 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;        
    };

//Entity: DatosRegularizarPagos
    //DatosRegularizarPagos.attribute1 (ComboBox) View: FRegularizarPagosObjetados
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_1MAZDGHHFBBVYEE_972505 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.DatosRegularizarPagos = true;
    };

//Start signature to Callback event to VA_1MAZDGHHFBBVYEE_972505
task.loadCatalogCallback.VA_1MAZDGHHFBBVYEE_972505 = function(entities, loadCatalogCallbackEventArgs) {
//here your code
};

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: FRegularizarPagosObjetados
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };

//Entity: Entity2
    //Entity2.attribute1 (TextInputButton) View: FRegularizarPagosObjetados
    
    task.textInputButtonEvent.VA_1WFWHEAZGTYHGIU_390505 = function( textInputButtonEventArgs ) {
        textInputButtonEventArgs.commons.execServer = false;
            var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = cobis.translate('PAOBJ.LBL_PAOBJ_BU00FASDE_39896');
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
            
            //Validacion para busqueda de operaciones grupales
            //if (textInputButtonEventArgs.model.LoanInstancia.idOptionMenu == 14 && textInputButtonEventArgs.model.LoanSearchFilter.isGroup == true) {
            //nav.label = cobis.translate('Busqueda de Operaciones Grupales');
            nav.customDialogParameters = {
                client: 0
                , type: 3
                , mode: "findGroup"
            };
        
        nav.customDialogParameters = {};        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: FRegularizarPagosObjetados
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;        
    };

//gridRowSelecting QueryView: QV_3724_71065
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_3724_71065 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
        };



}));