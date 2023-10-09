/* variables locales de T_ASSTSDOHFZMES_451*/
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

    
        var task = designerEvents.api.loansearchgroupform;
    

    //"TaskId": "T_ASSTSDOHFZMES_451"
//"TaskId": "T_LOANSEARCHSWA_959"
var queryString = {};
var isGroup = 'N';
task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            groupCode = args.commons.api.vc.dialogParameters.CodeReceive,
            groupName = args.commons.api.vc.dialogParameters.name,
            isGroup = 'S';
        args.model.LoanSearchFilter.numIdentification = groupCode;
    };

    //Entity: LoanSearchFilter
    //LoanSearchFilter.avanceSearch (CheckBox) View: LoanSearchGroupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_AVANCESEARCHJRS_939549 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
  /* 
  var api = changedEventArgs.commons.api;
    api.vc.viewState.VA_DATEFIELDCVISIT_349549.visible = changedEventArgs.newValue;    
    api.vc.viewState.VA_OFFICERKLHXZUAP_236549.visible = changedEventArgs.newValue;
    */
            
    };

//LoanQueryGroup Entity: 
    task.executeQuery.Q_LOANIBUZ_3992 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        executeQueryEventArgs.commons.serverParameters.LoanSearchFilter = true;
    };;

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanSearchGroupForm
    task.initData.VC_LOANSEARUG_773451 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.viewState.hide('VA_AVANCESEARCHJRS_939549');         
    };

//Entity: LoanSearchFilter
    //LoanSearchFilter.officer (ComboBox) View: LoanSearchGroupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_OFFICERKLHXZUAP_236549 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
    loadCatalogDataEventArgs.commons.serverParameters.LoanSearchFilter = true;
    };

//Entity: LoanSearchFilter
    //LoanSearchFilter.numIdentification (TextInputButton) View: LoanSearchGroupForm
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXHCG_720549 = function( textInputButtonEventArgs ) {

    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSTS.LBL_ASSTS_BSQUEDARR_52528');
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



//gridRowSelecting QueryView: QV_3992_44545
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_3992_44545 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = true;
            
            gridRowSelectingEventArgs.commons.serverParameters.Loan = true;
        };

//gridRowSelecting QueryView: QV_3992_44545
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_3992_44545 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
            gridRowSelectingEventArgs.commons.api.vc.closeModal({          
            resultArgs: {
                index: gridRowSelectingEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: gridRowSelectingEventArgs.commons.api.vc.mode,
                code: gridRowSelectingEventArgs.rowData.loanBankID
            }});
        };



}));