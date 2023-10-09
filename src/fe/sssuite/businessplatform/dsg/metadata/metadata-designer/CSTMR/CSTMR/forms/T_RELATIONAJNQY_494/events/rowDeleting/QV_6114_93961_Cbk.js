//Start signature to callBack event to QV_6114_93961
task.gridRowDeletingCallback.QV_6114_93961 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
    if (banBorrado == true){        
        if(gridRowDeletingCallbackEventArgs.success){	        gridRowDeletingCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTROM_33731',true);
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            //banBorrado=false;
        }
    }
};