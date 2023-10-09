/* variables locales de T_AMOUNTZDGDPDF_678*/
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

    
        var task = designerEvents.api.amountform;
    

    //"TaskId": "T_AMOUNTZDGDPDF_678"

    //Entity: Amount
    //Amount.authorizedAmount (TextInputBox) View: AmountForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXLEH_921190 = function(  entities, changedEventArgs ) {
            changedEventArgs.commons.execServer = false;
            
            if (changedEventArgs.newValue > 0) {
                changedEventArgs.rowData.cycleParticipation = 'S'
            }
            else {
                changedEventArgs.rowData.cycleParticipation = 'N'
            }
            
            var percentage = LATFO.COMMONS.getPercentage(changedEventArgs.commons.api.vc.model.Amount.data().map(function(item){return item.authorizedAmount}));                
            entities.Credit.warrantyAmount = percentage;
       changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "authorizedAmount", changedEventArgs.newValue);
        
            // Seccion para el bloqueo de columnas
            
            // Incremento
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
            
            //  Monto Maximo Propuesto 
            $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
        
           if (stage == 'APROBAR') {
        
                //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            
               changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXYVS_120190');
            
           }
        
      
        
    };

//Entity: Amount
//Amount.amount (TextInputBox) View: AmountForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_TEXTINPUTBOXSRP_129190 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;
    changedEventArgs.rowData.authorizedAmount = changedEventArgs.rowData.amount;
	if (changedEventArgs.newValue > 0) {
        changedEventArgs.rowData.cycleParticipation = 'S'
    }
    else {
        changedEventArgs.rowData.cycleParticipation = 'N'
    }
    //changedEventArgs.commons.serverParameters.Amount = true;
    var index = $("#QV_6248_19660").data("kendoGrid").dataSource.indexOf(changedEventArgs.rowData);
    var nextRowData = $("#QV_6248_19660").data("kendoGrid").dataSource.data()[index + 1];
    if (nextRowData != undefined) {
        setTimeout(function (argRowData) {
            var control = $("#VA_TEXTINPUTBOXSRP_129190-" + argRowData.secuential);
            var instanceControl = control[0];
            var uiControl = $("#" + instanceControl.id);
            var visibleControl1 = uiControl.siblings("input:visible");
            visibleControl1.focus();
            // visibleControl1.get(0).setSelectionRange(0,0);
        }, 300, nextRowData);
    }
    //changedEventArgs.commons.api.grid.updateRow("Amount", index, changedEventArgs.rowData);
    changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "amount", changedEventArgs.newValue);
    changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "authorizedAmount", changedEventArgs.newValue);
  
    //Monto maximo propuesto
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    
    //Incremento
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
    
};

//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: AmountForm
    task.changeGroup.VC_AMOUNTIRVT_828678 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;     
        if(entities.Group.code === null){
			changeGroupEventArgs.commons.api.viewState.disable('VC_ZFXQOGVCIH_421740',true);
		}        
    };

//Entity: Credit
    //Credit. (Button) View: AmountForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONAICSAKZ_975190 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Group = true;
        executeCommandEventArgs.commons.serverParameters.Amount = true;
        executeCommandEventArgs.commons.execServer = true;    
    };

//Start signature to Callback event to VA_VABUTTONAICSAKZ_975190
task.executeCommandCallback.VA_VABUTTONAICSAKZ_975190 = function(entities, executeCommandCallbackEventArgs) {
 if (stage == 'APROBAR') {
        
                //Monto maximo propuesto
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");

                //Incremento
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");

                //MontoSolicitado
                $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
            
            
           }      
};

//Entity: Credit
//Credit. (Button) View: AmountForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONGPPUIHN_830190 = function (entities, executeCommandEventArgs) {
    if ((executeCommandEventArgs.commons.api.parentVc.model.Task.taskSubject == 'INGRESAR SOLICITUD') && (entities.Credit.creditCode > 0 )) {
        entities.Credit.nameActivity = nameActivity;
        executeCommandEventArgs.commons.serverParameters.Credit = true;
        executeCommandEventArgs.commons.execServer = true;
    }
    else {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("LOANS.LBL_LOANS_NOSEPUEUN_82756")
    }    
};

//Entity: Credit
//Credit. (Button) View: AmountForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommandCallback.VA_VABUTTONGPPUIHN_830190 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success == true) {
        executeCommandCallbackEventArgs.commons.api.viewState.disable('VC_PXLAAVTEYF_485974', true);
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span      input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXLEH_921190']").prop("disabled", "disabled");
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXUPR_288190']").prop("disabled", "disabled");
        $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    }
};

//Entity: Credit
    //Credit. (Button) View: AmountForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONNPVXIJW_123190 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.serverParameters.Amount = true;
        executeCommandEventArgs.commons.serverParameters.Group = true;
        executeCommandEventArgs.commons.serverParameters.Credit = true;        
        executeCommandEventArgs.commons.execServer = true;
    };

//Start signature to Callback event to VA_VABUTTONNPVXIJW_123190
task.executeCommandCallback.VA_VABUTTONNPVXIJW_123190 = function(entities, executeCommandCallbackEventArgs) {
	if (executeCommandCallbackEventArgs.success == true ){ //**ACHP
        
        var percentage = LATFO.COMMONS.getPercentage(executeCommandCallbackEventArgs.commons.api.vc.model.Amount.data()
                                                 .map(function(item){return item.authorizedAmount}), porcentaje);         
        entities.Credit.warrantyAmount = percentage;
        
	    executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES"; //**ACHP
		LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.amountRequested == null || entities.Credit.amountRequested  == 'null' ? 0 : entities.Credit.amountRequested ), 2), 1);
    	LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Aprobado', BUSIN.CONVERT.CURRENCY.Format((entities.Credit.approvedAmount == null || entities.Credit.approvedAmount  == 'null' ? 0 : entities.Credit.approvedAmount ), 2), 1);	
	}else{
		executeCommandCallbackEventArgs.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO"; //para que no vaya con cualquier monto, si se vuelve a ejecutar con datos incorrectos
	}
	//Monto maximo propuesto
	$("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    //Incremento
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
     //MontoSolicitado
	if(stage=='APROBAR'){
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXSRP_129190']").prop("disabled", "disabled");
	}
};

//AmountQuery Entity: 
    task.executeQuery.Q_AMOUNTKL_6248 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

task.gridInitColumnTemplate.QV_6248_19660 = function(idColumn, gridInitColumnTemplateEventArgs) {
    if (angular.isDefined(gridInitColumnTemplateEventArgs.commons.api.vc.parentVc)) {
        stage = gridInitColumnTemplateEventArgs.commons.api.vc.parentVc.customDialogParameters.Task.urlParams.Etapa;
    } else {
        stage = "";
    }
    if (idColumn == 'creditBureau') {
        return "<div class='cb-indicator cb-flex cb-column'>" +
            "<div class='cb-flex cb-grow cb-center cb-middle cb-indicator-value'>{{dataItem.creditBureau}}</div>" +
            "<div ng-show='{{dataItem.riskLevel == \"VERDE\"}}' style='background-color:green;height:3px;'></div>" +
            "<div ng-show='{{dataItem.riskLevel == \"AMARILLO\"}}' style='background-color:yellow;height:3px;'></div>" +
            "<div ng-show='{{dataItem.riskLevel == \"ROJO\"}}' style='background-color:red;height:3px;'></div>" +
            "<div class='cb-footer-label'>{{'LOANS.LBL_LOANS_NIVELDERI_38662'|translate}}</div>" +
            "</div>";
    }

    if (idColumn == 'amount' && stage != 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.amount\" id=\"VA_TEXTINPUTBOXSRP_129190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.amount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.amount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.amount.decimals\" style=\"width: 100%\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'amount')\" tabindex=\"10000\"></input>";
    } else if (idColumn == 'amount' && stage == 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.amount\"  disabled=\"disabled\" id=\"VA_TEXTINPUTBOXSRP_129190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.amount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.amount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.amount.decimals\" style=\"width: 100%\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'amount')\" tabindex=\"10000\"></input>";
    }


    if (idColumn == 'authorizedAmount' && stage != 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.authorizedAmount\" id=\"VA_TEXTINPUTBOXLEH_921190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.authorizedAmount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.authorizedAmount.decimals\" style=\"width: 100%\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'authorizedAmount')\"></input>";
    } else if (idColumn == 'authorizedAmount' && stage == 'CONSULTA') {
        return "<input type=\"text\" ng-model=\"dataItem.authorizedAmount\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXLEH_921190-{{dataItem.secuential}}\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.authorizedAmount.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.authorizedAmount.decimals\" style=\"width: 100%\" k-on-change=\"vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'authorizedAmount')\"></input>";
    }

    if (idColumn == 'voluntarySavings' && (stage != 'CONSULTA' && stage != 'APROBAR')) {
        return "<input type=\"text\" ng-model=\"dataItem.voluntarySavings\" id=\"VA_TEXTINPUTBOXUPR_288190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.voluntarySavings.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.voluntarySavings.decimals\" style=\"width: 100%\"></input>";
    } else if (idColumn == 'voluntarySavings' && (stage == 'CONSULTA' || stage == 'APROBAR')) {
        return "<input type=\"text\" ng-model=\"dataItem.voluntarySavings\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXUPR_288190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.voluntarySavings.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.voluntarySavings.decimals\" style=\"width: 100%\"></input>";
    }

    if (idColumn == 'proposedMaximumSaving') {
        return "<input type=\"text\" ng-model=\"dataItem.proposedMaximumSaving\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXWXN_691190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.proposedMaximumSaving.decimals\" style=\"width: 100%\"></input>";
    }
    //if(idColumn == 'NombreColumna'){
    //  return  "#=nombreColumna#" ;
    //}  
    if (idColumn == 'increment') {
        return "<input type=\"text\" ng-model=\"dataItem.increment\" disabled=\"disabled\" id=\"VA_TEXTINPUTBOXAFW_332190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.increment.validationCode}}\" kendo-numeric-text-box datatypes-Limit=\"N\" k-spinners=\"false\" k-format=\"vc.viewState.QV_6248_19660.column.increment.format\" k-decimals=\"vc.viewState.QV_6248_19660.column.increment.decimals\" style=\"width: 100%\"></input>";
    }

    if (idColumn === 'safePackage' && stage == 'APROBAR') {
        cobis.showMessageWindow.loading(true);
        return "<input id=\"VA_TEXTINPUTBOXYVS_120190\" kendo-ext-combo-box=\"comboBox.VA_TEXTINPUTBOXYVS_120190\" k-data-source=\"vc.catalogs.VA_TEXTINPUTBOXYVS_120190\" data-validation-code=\"{{vc.viewState.QV_6248_19660.column.safePackage.validationCode}}\" ng-model=\"dataItem.safePackage\"  k-auto-bind=\"true\" k-ng-delay=\"vc.afterInitData\"  k-data-text-field=\"'value'\" k-data-value-field=\"'code'\" k-index=0 style=\"width: 100%\"/>";

    }
};

task.gridInitEditColumnTemplate.QV_6248_19660 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };

//Entity: Amount
//Amount.safePackage (ComboBox) View: AmountForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TEXTINPUTBOXYVS_120190 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.Amount = true;
};



}));