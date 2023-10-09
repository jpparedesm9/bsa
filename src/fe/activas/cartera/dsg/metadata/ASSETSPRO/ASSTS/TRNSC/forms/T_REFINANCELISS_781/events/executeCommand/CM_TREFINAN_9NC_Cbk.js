//Start signature to Callback event to CM_TREFINAN_9NC
task.executeCommandCallback.CM_TREFINAN_9NC = function(entities, executeCommandCallbackEventArgs) {
var viewState = executeCommandCallbackEventArgs.commons.api.viewState;        
     if (executeCommandCallbackEventArgs.success){         
         viewState.disable('CM_TREFINAN_9NC',true)
         viewState.disable('CM_TREFINAN_A4R',true);     
         viewState.show("VA_OPERATIONPZCOUQ_327515");         
         executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess("ASSTS.LBL_ASSTS_SALDOOTOR_36723",true);
      }else{
         viewState.enable('CM_TREFINAN_9NC',false);
         viewState.enable('CM_TREFINAN_A4R',false);     
      }
};