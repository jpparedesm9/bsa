//gridRowInserting QueryView: QV_9303_67123
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_9303_67123 = function (entities, gridRowInsertingEventArgs) {
            //CustomerTmp se llena desde la VCC o desde la pantalla de Prospectos
            gridRowInsertingEventArgs.rowData.personSecuential=entities.CustomerTmp.code;
            if(LATFO.UTILS.validarEmail(gridRowInsertingEventArgs.rowData.addressDescription)){
                 gridRowInsertingEventArgs.commons.execServer = true;
            }else{
                gridRowInsertingEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELCORRESC_17906',true);
                gridRowInsertingEventArgs.commons.execServer = false;
                gridRowInsertingEventArgs.commons.api.grid.removeRow('VirtualAddress',0);
            }
        };