/* variables locales de T_CLCOLIQAJNDTG_333*/
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

    
        var task = designerEvents.api.loadcollectiveperson;
    

    //"TaskId": "T_CLCOLIQAJNDTG_333"
var gridPosition = 0;
var gridLength = 0;

var disableFileUploadButton = function(){
    $(".input-group-btn:eq(1)").find('button').attr("disabled","disabled");
}


    //Entity: CollectivePersonFile
    //CollectivePersonFile.fileName (FileUpload) View: LoadCollectivePerson
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_4965WEUNXYQPSHI_453908 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    
        
    };

//Entity: CollectivePersonFile
    //CollectivePersonFile. (Button) View: LoadCollectivePerson
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONEHPSTNT_850908 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
        if(entities.CollectivePersonFile.fileName!=="")
            {
    executeCommandEventArgs.commons.api.vc.removeFile('VA_4965WEUNXYQPSHI_453908')
            }
    executeCommandEventArgs.commons.api.grid.refresh('QV_8718_49718');
    executeCommandEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');
    
    CLCOL.fileLoadingPercent(0,"VA_VASIMPLELABELLL_690908");
    executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_216908');
    executeCommandEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_690908');
    executeCommandEventArgs.commons.api.viewState.enable("VA_VABUTTONSFBIETG_385908");
        $("#VA_VASIMPLELABELLL_989908").text(0);
        $("#VA_VASIMPLELABELLL_366908").text(0);
        $("#VA_VASIMPLELABELLL_901908").text(0);
        entities.CollectivePersonFile.successRecords = "0";
    };

//Entity: CollectivePersonFile
    //CollectivePersonFile. (Button) View: LoadCollectivePerson
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONSFBIETG_385908 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.CollectivePersonFile = true;
    };

//Start signature to Callback event to VA_VABUTTONSFBIETG_385908
task.executeCommandCallback.VA_VABUTTONSFBIETG_385908 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    executeCommandCallbackEventArgs.commons.execServer = false;
    if(entities.CollectivePersonRecord.data().length>0)
	{
	executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONUKAXPIV_480908');	
	}
	else
	{
		executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');	
	}
};

//Entity: CollectiveProcessProgress
//CollectiveProcessProgress. (Button) View: LoadCollectivePerson
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONUKAXPIV_480908 = function (entities, executeCommandEventArgs) {

    executeCommandEventArgs.commons.execServer = true;
    gridLength = entities.CollectivePersonRecord.data().length;
    var collectiveEntity = entities.CollectivePersonRecord.data()[gridPosition];
    var filtro = {
        position: gridPosition
    };

    executeCommandEventArgs.commons.api.vc.parentVc = {}
    executeCommandEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
    
    if(!executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_216908")
        && !executeCommandEventArgs.commons.api.viewState.isVisible("VA_VASIMPLELABELLL_690908")){
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_216908');
        executeCommandEventArgs.commons.api.viewState.show('VA_VASIMPLELABELLL_690908');
    }
    
    
    
};

//Start signature to Callback event to VA_VABUTTONUKAXPIV_480908
task.executeCommandCallback.VA_VABUTTONUKAXPIV_480908 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        var percentage = ((gridPosition + 1 ) * 100) / gridLength;
        CLCOL.fileLoadingPercent(percentage,"VA_VASIMPLELABELLL_690908");
        if (gridPosition == gridLength - 1) {
            executeCommandCallbackEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');
            executeCommandCallbackEventArgs.commons.api.viewState.disable("VA_VABUTTONSFBIETG_385908");
            disableFileUploadButton();
            gridPosition = 0;
            
            $("#VA_VASIMPLELABELLL_989908").text(gridLength);
            $("#VA_VASIMPLELABELLL_366908").text(entities.CollectivePersonFile.successRecords);
            $("#VA_VASIMPLELABELLL_901908").text(gridLength - entities.CollectivePersonFile.successRecords);

            return;
        }
        gridPosition++;
        executeCommandCallbackEventArgs.commons.api.vc.executeCommand('VA_VABUTTONUKAXPIV_480908', 'VA_VABUTTONUKAXPIV_480908', null, false, false, 'G_LOADCOLIPC_406908', false);
    }
};


//undefined Entity: 
    task.executeQuery.Q_COLLECON_8718 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: LoadCollectivePerson
task.initData.VC_LOADCOLLEV_719333 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.disable('VA_VABUTTONUKAXPIV_480908');
    initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_216908');
    initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_690908');
    $("#VA_VASIMPLELABELLL_989908").text(0);
    $("#VA_VASIMPLELABELLL_366908").text(0);
    $("#VA_VASIMPLELABELLL_901908").text(0);    
};



}));