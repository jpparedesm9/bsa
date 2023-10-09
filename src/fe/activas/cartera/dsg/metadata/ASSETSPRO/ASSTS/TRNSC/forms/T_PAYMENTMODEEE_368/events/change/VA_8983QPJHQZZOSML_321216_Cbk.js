//Start signature to Callback event to VA_8983QPJHQZZOSML_321216
task.changeCallback.VA_8983QPJHQZZOSML_321216 = function(entities, changeCallbackEventArgs) {
//here your code
    if(changeEventArgs.commons.api.navigation.getCustomDialogParameters().difference <
            entities.PaymentForm.payAmount){
            console.log(changeEventArgs.commons.api.navigation.getCustomDialogParameters().difference);
        }
};