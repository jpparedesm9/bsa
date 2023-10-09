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
    if(requestType=='R'){
        var result =changedEventArgs.newValue - changedEventArgs.rowData.oldBalance;
        changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "resultAmount", result);    
    }
    //changedEventArgs.commons.api.grid.updateRow("Amount", index, changedEventArgs.rowData);
    changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "amount", changedEventArgs.newValue);
    changedEventArgs.commons.api.grid.updateRowData(changedEventArgs.rowData, "authorizedAmount", changedEventArgs.newValue);
  
    //Monto maximo propuesto
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXWXN_691190']").prop("disabled", "disabled");
    
    //Incremento
    $("#QV_6248_19660").find("table > tbody tr").find("td > span > span input[id^='VA_TEXTINPUTBOXAFW_332190']").prop("disabled", "disabled");
    
};