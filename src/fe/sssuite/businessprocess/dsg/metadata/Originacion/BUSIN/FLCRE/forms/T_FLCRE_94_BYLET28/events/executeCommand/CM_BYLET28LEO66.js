// (Button) 
    task.executeCommand.CM_BYLET28LEO66 = function(entities, executeCommandEventArgs) {
        var warrantyType=executeCommandEventArgs.commons.api.vc.customDialogParameters.warrantyType;
        var rowFixedTerm;
        var rowAccount;
        var gridFixedTerm=executeCommandEventArgs.commons.api.vc.grids.QV_FDMYL8126_98;
        var gridAccount=executeCommandEventArgs.commons.api.vc.grids.QV_6427_29743;

        if ("DPF" == warrantyType) {
            if(gridFixedTerm.selectedItem!=null||gridFixedTerm.selectedItem!=undefined){
                rowFixedTerm={code:gridFixedTerm.selectedItem.numBanco,
                        value:gridFixedTerm.selectedItem.numBanco+" - "+entities.CustomerSearch.Customer+" - "+((entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=undefined||entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=null)?entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible:0),
                        amount:((entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=undefined||entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible!=null)?entities.FixedTermOperation.data()[rowIndexTerm].montoDisponible:0),
                        warrantyType:warrantyType};
                executeCommandEventArgs.commons.api.vc.closeModal(rowFixedTerm);
                executeCommandEventArgs.commons.execServer = false;//true;
            }else{
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PFJOECARG_00138','',3000,true);
                //executeCommandEventArgs.commons.messageHandler.showMessagesError('Se requiere seleccionar un Plazo Fijo');
                executeCommandEventArgs.commons.execServer = false;
            }
        }
        if ("AHORRO" == warrantyType) {
            if(gridAccount.selectedItem!=null||gridAccount.selectedItem!=undefined){
                rowAccount={code:gridAccount.selectedItem.accountBank,
                        value:gridAccount.selectedItem.accountBank+" - "+entities.CustomerSearch.Customer+" - "+((entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=undefined||entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=null)?entities.AccountInfomation.data()[rowIndexAccount].availableBalance:0),
                        amount:((entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=undefined||entities.AccountInfomation.data()[rowIndexAccount].availableBalance!=null)?entities.AccountInfomation.data()[rowIndexAccount].availableBalance:0),
                        warrantyType:warrantyType};
                executeCommandEventArgs.commons.api.vc.closeModal(rowAccount);
                executeCommandEventArgs.commons.execServer = false;//true;
            }else{
                executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PFJOECARG_00138','',3000,true);
                //executeCommandEventArgs.commons.messageHandler.showMessagesError('Se requiere seleccionar una Cuenta de Ahorro');
                executeCommandEventArgs.commons.execServer = false;
            }
        }
        // executeCommandEventArgs.commons.serverParameters.entityName = true;
    };