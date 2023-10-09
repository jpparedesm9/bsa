//Start signature to Callback event to VA_VABUTTONEAKDTLW_523769
task.executeCommandCallback.VA_VABUTTONEAKDTLW_523769 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    console.log('Ingresa VA_VABUTTONEAKDTLW_523769');
    clienteId=entities.LoginCallCenter.idCliente;
    if(executeCommandCallbackEventArgs.success==false)
        {
            clienteId=0;
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_9614ZTSONZLMVRK_410769');
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONTOSIJNF_422769');
        }
    if(executeCommandCallbackEventArgs.success==true)
        {
			entities.Amount.amountApproved='';
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
            executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_9614ZTSONZLMVRK_410769');
			executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONTOSIJNF_422769');
        }
     filtro = {
            clientCode: clienteId
        };
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_82692', filtro);
    
};