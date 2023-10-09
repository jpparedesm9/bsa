//Start signature to Callback event to VC_SOLIDARIEN_259463
task.initDataCallback.VC_SOLIDARIEN_259463 = function(entities, initDataCallbackEventArgs) {
//here your code
    
    if(initDataCallbackEventArgs.success){
        entities.SolidarityPayment.modificationFeeAux = entities.SolidarityPayment.modificationFee;
    }
    
    
};