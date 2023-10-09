//gridRowInserting QueryView: QV_6114_93961
        //Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
        task.gridRowInserting.QV_6114_93961 = function (entities, gridRowInsertingEventArgs) {            
            var grid = gridRowInsertingEventArgs.commons.api.grid;
            if (gridRowInsertingEventArgs.rowData.secuentialPersonLeft ==0 || gridRowInsertingEventArgs.rowData.secuentialPersonRight == 0){                
                gridRowInsertingEventArgs.commons.execServer = false;
                gridRowInsertingEventArgs.commons.messageHandler.showMessagesError('Error en la creación del registro',true); 
                banBorrado = false;
                grid.removeRow('RelationPerson', 0); 
                //grid.refresh('QV_6114_93961');
                
            }
            else{
                gridRowInsertingEventArgs.commons.execServer = true;
                gridRowInsertingEventArgs.commons.serverParameters.RelationPerson = true;
                banBorrado= true;
            }
            
        };