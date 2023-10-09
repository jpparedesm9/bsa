//Start signature to callBack event to QV_4851_97960
task.gridRowUpdatingCallback.QV_4851_97960 = function(entities, gridRowUpdatingCallbackEventArgs) {
    if(gridRowUpdatingCallbackEventArgs.success){        
        gridRowUpdatingCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818','', 2000,false);
        if(entities.VirtualAddress.addressId == 1){
            entities.NaturalPerson.email = gridRowUpdatingCallbackEventArgs.rowData.email;
        }
    }
};