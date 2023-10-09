//Start signature to Callback event to VA_VABUTTONFPBVJYH_744873
task.executeCommandCallback.VA_VABUTTONFPBVJYH_744873 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    executeCommandCallbackEventArgs.commons.api.viewState.disable("CM_TASSTSHP_4SA");
    executeCommandCallbackEventArgs.commons.api.viewState.disable("CM_TASSTSHP_ZAX");
    
    if (executeCommandCallbackEventArgs.success)
    {
        switch(entities.Group.collateralPaymentStatus) {
        case 'S':
            executeCommandCallbackEventArgs.commons.api.viewState.enable("CM_TASSTSHP_4SA");
            executeCommandCallbackEventArgs.commons.api.viewState.enable("CM_TASSTSHP_ZAX");      
            break;
        case 'N':
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_GARANTAEO_91614", true);//GARANTÍA LÍQUIDA YA HA SIDO CANCELADA  
            break;
        case null:
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError("ASSTS.LBL_ASSTS_DATOSGAUA_97282", true);//DATOS DE GARANTÍA LÍQUIDA NO REGISTRADOS
            break;
        default:
            break;
        }
    }
};