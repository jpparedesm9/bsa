/* variables locales de T_CLCOLETZFPPIC_497*/
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

    
        var task = designerEvents.api.loadexternaladvisor;
    

    var gridPosition = 0;
var gridLength = 0;


    //Entity: Entity1
    //Entity1.attribute1 (FileUpload) View: LoadExternalAdvisor
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_1BNOXXDXEIKXBOP_815757 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
        entities.CollectiveAdvisorFile.ejecution=1;
    
        
    };

//Entity: Entity1
    //Entity1. (Button) View: LoadExternalAdvisor
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONMZTUDER_769757 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
       /* executeCommandEventArgs.commons.api.grid.showToolBarButton('QV_3718_27394','create')
        executeCommandEventArgs.commons.api.grid.showToolBarButton('QV_3718_27394','CEQV_201QV_3718_27394_509')*/
        //executeCommandEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394','export')
    
        //executeCommandEventArgs.commons.serverParameters.Entity1 = true;
    };

//Start signature to Callback event to VA_VABUTTONMZTUDER_769757
task.executeCommandCallback.VA_VABUTTONMZTUDER_769757 = function(entities, executeCommandCallbackEventArgs) {
//here your code
     if (executeCommandCallbackEventArgs.success) {
         if(entities.CollectiveAdvisorFile.ejecution<=2){
             executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONMZTUDER_769757', 'VA_VABUTTONMZTUDER_769757', null, false, false, 'G_LOADEXTVDO_653757', false);
             
         }
         
         if(entities.CollectiveAdvisor.data().length>0)
             {
                 executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONXICAMDT_820757');
             }
        //Mostrar exportar
        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','show');
        
        executeCommandCallbackEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394', 'CEQV_201QV_3718_27394_509');
     }
};

//Entity: CollectiveAdvisorFile
    //CollectiveAdvisorFile. (Button) View: LoadExternalAdvisor
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONQOPUGSB_200757 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
        if(entities.CollectiveAdvisorFile.nameFile!=="")
            {
              executeCommandEventArgs.commons.api.vc.removeFile('VA_1BNOXXDXEIKXBOP_815757')
            }
        executeCommandEventArgs.commons.api.viewState.disable('VA_VABUTTONXICAMDT_820757');
        executeCommandEventArgs.commons.api.grid.refresh('QV_3718_27394');
        entities.CollectiveAdvisorFile.ejecution=1;
         
        CLCOL.fileLoadingPercent(0,"VA_VASIMPLELABELLL_164757");
        executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_604757');
        executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_164757');

        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','hide');
        executeCommandEventArgs.commons.api.grid.showToolBarButton('QV_3718_27394', 'CEQV_201QV_3718_27394_509');
    };

//Entity: CollectiveProcessProgress
    //CollectiveProcessProgress. (Button) View: LoadExternalAdvisor
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONXICAMDT_820757 = function(  entities, executeCommandEventArgs ) {


    
    executeCommandEventArgs.commons.execServer = true;
    gridLength = entities.CollectiveAdvisor.data().length;
    var asesorEntity = entities.CollectiveAdvisor.data()[gridPosition];
    var filtro = {
        position: gridPosition
    };

    executeCommandEventArgs.commons.api.vc.parentVc = {}
    executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    
    if(!executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_604757")
        && !executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_164757")){
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_604757');
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_164757');
    }
    };

//Start signature to Callback event to VA_VABUTTONXICAMDT_820757
task.executeCommandCallback.VA_VABUTTONXICAMDT_820757 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    if (executeCommandCallbackEventArgs.success) {
        var percentage =  ((gridPosition + 1) * 100) / gridLength;
        CLCOL.fileLoadingPercent(percentage,"VA_VASIMPLELABELLL_164757");
        if (gridPosition == gridLength - 1) {
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONXICAMDT_820757');
            gridPosition = 0;
            return;
        }
        gridPosition++;
        executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONXICAMDT_820757', 'VA_VABUTTONXICAMDT_820757', null, false, false, 'G_LOADEXTLSS_819757', false);

    }
};

//undefined Entity: 
    task.executeQuery.Q_COLLECRT_3718 = function(executeQueryEventArgs){
       /* executeQueryEventArgs.commons.execServer = false;
            if (executeQueryEventArgs.commons.api.vc.model.CollectiveAdvisor.data().length === 0) {
        executeQueryEventArgs.commons.api.vc.parentVc = {};
    }
    else */
            {
                executeQueryEventArgs.commons.execServer = true;
                executeQueryEventArgs.commons.api.grid.setAppendRecordsParams('QV_3718_27394', ['idSecuencial'], executeQueryEventArgs);
            }

        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Start signature to Callback event to Q_COLLECRT_3718
task.executeQueryCallback.Q_COLLECRT_3718 = function(entities, executeQueryCallbackEventArgs) {
//here your code
};

//gridCommand (Button) QueryView: QV_3718_27394
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_3718_27394_509 = function (entities, gridExecuteCommandEventArgs) {
        		var reporte='advisorReportHist'
	        var args = [['report', 'cartera'],
                        ['title', 'ListaAsesoresExternos']					
					];				
                CLCOL.REPORT.GenerarReporte(reporte,args,'Reporte Asesores Externos');

    gridExecuteCommandEventArgs.commons.execServer = false;
    gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394', 'CEQV_201QV_3718_27394_509');
        //gridExecuteCommandEventArgs.commons.serverParameters.CollectiveAdvisor = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoadExternalAdvisor
    task.initData.VC_LOADEXTERA_441497 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.viewState.disable('VA_VABUTTONXICAMDT_820757');
        initDataEventArgs.commons.api.viewState.hide('VA_4140WTEPCJSGRJB_313757');
        
        initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_604757');
        initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_164757');
        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','hide');

       /* initDataEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394','create')
        initDataEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394','CEQV_201QV_3718_27394_509')*/
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: LoadExternalAdvisor
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','hide');
    };



}));