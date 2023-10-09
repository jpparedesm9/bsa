//Start signature to callBack event to CM_GURNH31OOS11
    task.executeCommandCallback.CM_GURNH31OOS11 = function(entities, executeCommandEventArgs) {
       if(executeCommandCallbackEventArgs.success){
			//BANDERA QUE INDICA SI EL TIPO DE GARANTIA ES PERSONAL
		    var result = {parameterGuarantee: guareanteeDialogParameters }
			executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
		}
    };