//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: GroupComposite
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;
    var response = onCloseModalEventArgs.result.response;
    if (response != undefined) {
        if (onCloseModalEventArgs.result.response.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
            if (response.addRow != undefined && response.addRow === 'S') {
                if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                    onCloseModalEventArgs.commons.api.grid.addRow('Member', onCloseModalEventArgs.result.response.data, true);
                    
                    
                }
            }
            onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);

        } else if (onCloseModalEventArgs.result.response.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Member', onCloseModalEventArgs.result.response.index, onCloseModalEventArgs.result.response.data, true);
                
            }
            onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
        }
    }
     

    //if (type == typeConsulta) {
    //    onCloseModalEventArgs.commons.api.grid.hideToolBarButton('QV_7978_25243', 'create');
    //}

};