//gridRowSelecting QueryView: QV_3992_44545
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_3992_44545 = function (entities,gridRowSelectingEventArgs) {
            gridRowSelectingEventArgs.commons.execServer = false;
            
            gridRowSelectingEventArgs.commons.api.vc.closeModal({          
            resultArgs: {
                index: gridRowSelectingEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: gridRowSelectingEventArgs.commons.api.vc.mode,
                code: gridRowSelectingEventArgs.rowData.loanBankID
            }});
        };