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