/* variables locales de T_LOANSEARCHSWA_959*/
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

    
        var task = designerEvents.api.loansearchform;
    

    //"TaskId": "T_LOANSEARCHSWA_959"
var queryString = {};
var isGroup = 'N';
task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = args.commons.api.vc.dialogParameters.CodeReceive;
    var CustomerName = args.commons.api.vc.dialogParameters.name;
    var identification = args.commons.api.vc.dialogParameters.documentId;    
    var customerType = args.commons.api.vc.dialogParameters.customerType;

    var title = '';
    if (args.model.LoanInstancia.idOptionMenu == 14) {
        args.model.LoanSearchFilter.group = 'S';
    }

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
    args.model.LoanSearchFilter.numIdentification = customerCode;
    args.commons.api.viewState.label("VA_CODCLIENTCIXLEY_866508",title);
};

    //Entity: LoanSearchFilter
    //LoanSearchFilter.avanceSearch (CheckBox) View: LoanSearchForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVANCESEARCHMXA_533508 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        var api = changeEventArgs.commons.api;
    api.vc.viewState.VA_CODCURRENCYKYKA_122508.visible = changeEventArgs.newValue;
    api.vc.viewState.VA_DISBURSEMENTDTD_602508.visible = changeEventArgs.newValue;
    api.vc.viewState.VA_STATUSRUGGOTSMF_965508.visible = changeEventArgs.newValue;
    api.vc.viewState.VA_MIGRATEDOPERFRB_417508.visible = changeEventArgs.newValue;
        
    };

//Entity: LoanSearchFilter
    //LoanSearchFilter. (Button) View: LoanSearchForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONBCZSHFM_208508 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.LoanSearchFilter = true;
    };

//LoanQuery_3009 Entity: 
    task.executeQuery.Q_LOANDPQM_3009 = function(executeQueryEventArgs){
        var executeServer = true;
    var transactNumber = executeQueryEventArgs.commons.api.vc.model.LoanSearchFilter.numProcedures;
    var clientCode = parseInt(executeQueryEventArgs.commons.api.vc.model.LoanSearchFilter.numIdentification);
    if (transactNumber > 2147483647) {
        executeServer = false;
    } else {
        if (!isNaN(clientCode)) {
            if (clientCode > 2147483647) {
                executeServer = false;
            }
        }
    }
    
    if (queryString.menu == ASSETS.Constants.MENU_DISBUSMNT) {
        executeQueryEventArgs.parameters.isDisbursment = 'S';
    } else {
        executeQueryEventArgs.parameters.isDisbursment = 'N';
    }
     executeQueryEventArgs.parameters.groupSummary = executeQueryEventArgs.commons.api.vc.model.LoanSearchFilter.groupSummary;
    executeQueryEventArgs.parameters.category = queryString.category;
    executeQueryEventArgs.parameters.group = isGroup;
    executeQueryEventArgs.parameters.paymentType = queryString.type;
    executeQueryEventArgs.commons.execServer = executeServer;
};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanSearchForm
    task.initData.VC_LOANSEARHC_144959 = function (entities, initDataEventArgs){
        queryString = ASSETS.Utils.getQueryStrings();
        

 var viewState = initDataEventArgs.commons.api.viewState;

        
        entities.LoanInstancia.idOptionMenu = queryString.menu;
        entities.LoanInstancia.tipo = queryString.type;
        initDataEventArgs.commons.execServer = true;
        if(queryString.menu == ASSETS.Constants.MENU_QUERYSGENERAL || queryString.menu == ASSETS.Constants.MENU_IMPRESIONDOC){
            viewState.enable('Spacer1633');
            viewState.show('Spacer1633');
        }else{
            viewState.disable('Spacer1633');
            viewState.hide('Spacer1633');
        }
    };

//Start signature to Callback event to VC_LOANSEARHC_144959
task.initDataCallback.VC_LOANSEARHC_144959 = function (entities, initDataCallbackEventArgs) {
   
};

//Entity: LoanSearchFilter
    //LoanSearchFilter.status (ComboBox) View: LoanSearchForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_STATUSRUGGOTSMF_965508 = function(loadCatalogEventArgs ) {
        loadCatalogEventArgs.commons.execServer = true;
    loadCatalogEventArgs.commons.api.vc.model.LoanSearchFilter.category = queryString.category;
    loadCatalogEventArgs.commons.serverParameters.LoanSearchFilter = true;
    };

//Entity: LoanSearchFilter
    //LoanSearchFilter.numIdentification (TextInputButton) View: LoanSearchForm
    
    task.textInputButtonEvent.VA_CODCLIENTCIXLEY_866508 = function(textInputButtonEventArgs ) {
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
    //Validacion para busqueda de operaciones grupales
        if (textInputButtonEventArgs.model.LoanInstancia.idOptionMenu == 14 && textInputButtonEventArgs.model.LoanSearchFilter.isGroup == true) {
        nav.label = cobis.translate('Busqueda de Operaciones Grupales');
        nav.customDialogParameters = {
            client: 0
            , type: 3
			, mode: "findGroup"
        };
    }
    else {
        nav.customDialogParameters = {};
    }
    };

//Entity: LoanSearchFilter
    //LoanSearchFilter.numIdentification (TextInputButton) View: LoanSearchForm
    
    task.textInputButtonEventGrid.VA_CODCLIENTCIXLEY_866508 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoanSearchForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
         entities.LoanSearchFilter.groupSummary='N'
    };

//gridRowSelecting QueryView: QV_3009_96085
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_3009_96085 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        //gridRowSelectingEventArgs.commons.serverParameters.Loan = true;
    };

//Start signature to callBack event to QV_3009_96085
    task.gridRowSelectingCallback.QV_3009_96085 = function(entities, gridRowSelectingEventArgs) {
        //here your code
        gridRowSelectingEventArgs.commons.execServer = true;
    var subModuleId = ""
        , taskId = ""
        , vcId = ""
        , label = ""
        , parameters = {
            loanInstancia: entities.LoanInstancia, 
            menu: queryString.menu, 
            type:queryString.type,
            groupSummary:entities.LoanSearchFilter.groupSummary,
            operationType:gridRowSelectingEventArgs.rowData.desOperationType,//GRUPAL, REVOLVENTE, INDIVIDUAL
            disbursementDate:gridRowSelectingEventArgs.rowData.disbursementDate
        };
    switch (queryString.menu) {
    case ASSETS.Constants.MENU_VALUE_DATE:
        subModuleId = "TRNSC";
        taskId = "T_VALUEDATEMINN_689";
        vcId = "VC_VALUEDATEN_586689";
        label = "Fecha Valor";
        break;
    case ASSETS.Constants.MENU_REVERSE:
        subModuleId = "TRNSC";
        taskId = "T_VALUEDATEMINN_689";
        vcId = "VC_VALUEDATEN_586689";
        label = "Reversas";
        break;
    case ASSETS.Constants.MENU_APPLY_CLAUSE:
        subModuleId = "TRNSC";
        taskId = "T_APPLYCLAUSEEE_533";
        vcId = "VC_APPLYCLASS_521533";
        label = "Cl\u00e1usula Aceleratoria";
        break;
    case ASSETS.Constants.MENU_QUERYSGENERAL:
        subModuleId = "QERYS";
        taskId = "T_GENERALINANNN_443";
        vcId = "VC_GENERALITN_743443";
        label = "Datos Generales";
        break;
    case ASSETS.Constants.MENU_READJUSTMENT:
        subModuleId = "MNTNN";
        taskId = "T_REAJUSTESRCSN_872";
        vcId = "VC_REAJUSTEKP_207872";
        label = "Reajustes del Pr\u00e9stamo";
        break;
    case ASSETS.Constants.MENU_LOANSTATCE:
        subModuleId = "CMMNS";
        taskId = "T_LOANSTATUSGNI_120";
        vcId = "VC_LOANSTATCE_588120";
        label = "Cambio de Estados";
        break;
    case ASSETS.Constants.MENU_PROYECTINST:
        subModuleId = "MNTNN";
        taskId = "T_PROJECTIONNQI_244";
        vcId = "VC_PROJECTIIU_405244";
        label = "Proyecci\u00f3n Cuota";
        break;
    case ASSETS.Constants.MENU_PAYMENTSMANI:
        subModuleId = "TRNSC";
        taskId = "T_PAYMENTSMANII_157";
        vcId = "VC_PAYMENTSAN_916157";
        label = "Pagos/Cancelaciones/Precancelaciones";
        break;
    case ASSETS.Constants.MENU_RENOVATION:
        subModuleId = "TRNSC";
        taskId = "T_LOANREFINANNG_618";
        vcId = "VC_LOANREFINN_713618";
        break;
    case ASSETS.Constants.MENU_INGOTROCARG:
        subModuleId = "MNTNN";
        taskId = "T_PROJECTINGSTR_344";
        vcId = "VC_PROJECTIAA_407344";
        label = "Ingresos Otros Cargos";
        break;
    case ASSETS.Constants.MENU_IMPRESIONDOC:
        subModuleId = "MNTNN";
        taskId = "T_DOCUMENTPRIAN_178";
        vcId = "VC_DOCUMENTIG_406178";
        label = "Impresi\u00f3n de Documentos";
        break;
    case ASSETS.Constants.MENU_PRORROGA:
        subModuleId = "MNTNN";
        taskId = "T_EXTENDSQUONTA_926";
        vcId = "VC_EXTENDSQMN_712926";
        label = "Pr\u00f3rroga";
        break;
    case ASSETS.Constants.MENU_DISBUSMNT:
        subModuleId = "TRNSC";
        taskId = "T_LOANDISBURSAA_275";
        vcId = "VC_LOANDISBMN_824275";
        label = "Desembolso";
        break;
    case ASSETS.Constants.MENU_BLOCK:
        subModuleId = "MNTNN";
        taskId = "T_ASSTSRBSDDMKT_144";
        vcId = "VC_CREDITBLOC_747144";
        label = "Bloqueo y Cancelaci\u00f3n Anticipada de LCR";
        break;
    case ASSETS.Constants.MENU_GROUP:
            subModuleId = "CMMNS";
            taskId = "T_LOANSEARCHSWA_959";
            vcId = "VC_LOANSEARHC_144959";
            label = "Busqueda Operaciones Grupales";
    break;
    }
    if (entities.LoanInstancia.errorValidation != true) {
        ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, gridRowSelectingEventArgs, parameters);
    }
    //gridRowSelectingEventArgs.commons.serverParameters.Loan = true;
    };



}));