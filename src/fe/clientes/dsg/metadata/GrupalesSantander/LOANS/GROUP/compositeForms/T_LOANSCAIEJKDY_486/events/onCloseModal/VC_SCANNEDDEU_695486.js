//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: ScannedDocuments
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        //onCloseModalEventArgs.commons.serverParameters.entityName = true;
        var response = onCloseModalEventArgs.result;
        if (response != undefined) {
            var filtro ={groupId:response.selectedData.groupId}
            //Refresh de la grilla para llenar la entidad
            onCloseModalEventArgs.commons.api.grid.refresh('QV_1763_79525');
            
            /*if (onCloseModalEventArgs.result.params.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                if (response.addRow != undefined && response.addRow === 'S') {
                    if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                        onCloseModalEventArgs.commons.api.grid.addRow('Member', onCloseModalEventArgs.result.response.data, true);


                    }
                }
                //onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
                
                //onCloseModalEventArgs.commons.execServer = true;
            } else if (onCloseModalEventArgs.result.response.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('Member', onCloseModalEventArgs.result.response.index, onCloseModalEventArgs.result.response.data, true);

                }
                //onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
                //onCloseModalEventArgs.commons.execServer = true;
            }*/
        }
    };