//gridRowUpdating QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9303_67123 = function (entities, gridRowUpdatingEventArgs) {
            if(LATFO.UTILS.validarEmail(gridRowUpdatingEventArgs.rowData.addressDescription)){
                 gridRowUpdatingEventArgs.commons.execServer = true;
        entities.Context.mailState = 'S';
            }else{
                gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
                gridRowUpdatingEventArgs.commons.execServer = false;
            }
        };