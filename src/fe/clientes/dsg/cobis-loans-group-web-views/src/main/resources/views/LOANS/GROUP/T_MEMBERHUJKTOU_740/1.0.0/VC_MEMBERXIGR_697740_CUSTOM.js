/* variables locales de T_MEMBERHUJKTOU_740*/
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

    
        var task = designerEvents.api.memberform;
    

    //"TaskId": "T_MEMBERHUJKTOU_740"

    //Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: MemberForm
    task.changeGroup.VC_MEMBERXIGR_697740 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;
        if(entities.Group.code === null){
			changeGroupEventArgs.commons.api.viewState.disable('VC_ZFXQOGVCIH_421740',true);
		}        
    };

//MemberQuery Entity: 
    task.executeQuery.Q_MEMBERZI_7978 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Entity: Member
    //Member. (Button) View: MemberForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMAAA_212848 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
    
//Open Modal
var nav = gridRowCommandEventArgs.commons.api.navigation;

nav.label = 'Relaciones';
nav.address = {
    moduleId: 'CSTMR',
    subModuleId: 'CSTMR',
    taskId: 'T_RELATIONAJNQY_494',
    taskVersion: '1.0.0',
    viewContainerId: 'VC_RELATIONQE_861494'
};
nav.queryParameters = {
    mode: 1
};
nav.modalProperties = {
    size: 'lg',
    callFromGrid: false
};
nav.customDialogParameters = {
    modeRelation:'ModeRelation',
   codigoCli:gridRowCommandEventArgs.rowData.customerId
}

//Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
//nav.openModalWindow(args.commons.controlId, null);
//Si la llamada es desde un evento de un control perteneciente a una grilla de la página
nav.openModalWindow('QV_7978_25243', gridRowCommandEventArgs.modelRow);

    
        
    };

//Entity: Member
//Member. (ImageButton) View: MemberForm

task.gridRowCommand.VA_GRIDROWCOMMMNNA_977848 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;

    var nav = gridRowCommandEventArgs.commons.api.navigation;
    //views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html
    nav.label = 'Mantenimiento de Personas Naturales';
    nav.address = {
        moduleId: 'CSTMR',
        subModuleId: 'CSTMR',
        taskId: 'T_CUSTOMERCOETP_680',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_CUSTOMEROI_208680'
    };
    nav.queryParameters = {
        mode: 9
    };
    nav.modalProperties = {
        size: 'lg',
        height: 900,
        callFromGrid: true
    };
    nav.customDialogParameters = {
        clientId: gridRowCommandEventArgs.rowData.customerId
    };
    //   nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, null);  //Si la llamada es desde un evento de un control 
    nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, gridRowCommandEventArgs.rowData);

};

//gridRowRendering QueryView: QV_7978_25243
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7978_25243 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','VA_GRIDROWCOMMMNNA_977848');//ocultar lupa
    if (typeOrigin == LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        if (stage == LOANS.CONSTANTS.Stage.INGRESO || stage == LOANS.CONSTANTS.Stage.APROBAR || stage == LOANS.CONSTANTS.Stage.ELIMINAR) {
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'edit');
            gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAA_212848');
            gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_7978_25243', 'create'); // Se oculta el boton de nuevo de la grilla en la etapa de ingreso PXSG
			gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData, 'delete');//Se oculta boton de Eliminar enla etapa de ingreso PXSG
            
        }
        if (stage == 'APROBAR') {
		    gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_7978_25243', gridRowRenderingEventArgs.rowData,      'delete');
            //ocultar columnas vacias
            gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','VA_GRIDROWCOMMMAAA_212848');
            gridRowRenderingEventArgs.commons.api.grid.hideColumn('QV_7978_25243','cmdEdition');
            gridRowRenderingEventArgs.commons.api.grid.showColumn('QV_7978_25243','VA_GRIDROWCOMMMNNA_977848');//mostrar lupa
	   }
    }
};

//gridRowDeleting QueryView: QV_7978_25243
//Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
task.gridRowDeleting.QV_7978_25243 = function (entities, gridRowDeletingEventArgs) {
    if (typeOrigin === LOANS.CONSTANTS.TypeOrigin.FLUJO) { //CUANDO INGRESA POR EL FLUJO
        gridRowDeletingEventArgs.rowData.creditCode =  entities.Credit.creditCode; //gridRowDeletingEventArgs.commons.api.vc.parentVc.model.Task.bussinessInformationIntegerTwo; //se comenta xq se pierde el codigo del credito
    }
    gridRowDeletingEventArgs.rowData.groupId = entities.Group.code;
    gridRowDeletingEventArgs.commons.serverParameters.Member = true;
    gridRowDeletingEventArgs.commons.execServer = true;
};

//Start signature to Callback event to QV_7978_25243
task.gridRowDeletingCallback.QV_7978_25243 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};



}));