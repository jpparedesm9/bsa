//Start signature to Callback event to VA_MODIFICATIONEEE_697860
task.changeCallback.VA_MODIFICATIONEEE_697860 = function(entities, changeCallbackEventArgs) {
//here your code
    
    if(changeCallbackEventArgs.success){
        if(entities.SolidarityPaymentDetail._data.length != 0){
            if(entities.SolidarityPayment.modificationFeeAux == entities.SolidarityPaymentDetail._data["0"].dividend){
                changeCallbackEventArgs.commons.api.grid.enabledColumn('QV_6669_21119', 'paymentAmount');
                changeCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONXDXARLH_873860');
            } else{
                changeCallbackEventArgs.commons.api.grid.disabledColumn('QV_6669_21119', 'paymentAmount');
                changeCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
            }
        } else {
            changeCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONXDXARLH_873860');
        }
        
    }
    
};