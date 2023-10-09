//Start signature to Callback event to VA_VABUTTONBGFXHFC_174860
task.executeCommandCallback.VA_VABUTTONBGFXHFC_174860 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    if(executeCommandCallbackEventArgs.success){
        entities.SolidarityPayment.modificationFeeAux = entities.SolidarityPayment.modificationFee;
        if(entities.SolidarityPaymentDetail._data.length != 0){
            if(entities.SolidarityPayment.modificationFeeAux == entities.SolidarityPaymentDetail._data["0"].dividend){
                executeCommandCallbackEventArgs.commons.api.grid.enabledColumn('QV_6669_21119', 'paymentAmount'); 
                executeCommandCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONXDXARLH_873860');
            } else{
                executeCommandCallbackEventArgs.commons.api.grid.disabledColumn('QV_6669_21119', 'paymentAmount');
                executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
            }
        } else {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
        }
    }
    
};