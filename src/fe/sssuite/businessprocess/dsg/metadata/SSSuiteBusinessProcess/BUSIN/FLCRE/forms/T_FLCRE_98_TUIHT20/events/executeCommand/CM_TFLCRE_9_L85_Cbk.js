//Start signature to callBack event to CM_TFLCRE_9_L85
task.executeCommandCallback.CM_TFLCRE_9_L85 = function(entities, executeCommandEventArgs) {
//here your code
var ctrsToenable = ['CM_TFLCRE_9_342'];// monto solicitado y monto aprobado
var viewState = executeCommandEventArgs.commons.api.viewState;
BUSIN.API.enable(viewState,ctrsToenable);
};