//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: MobileManagementForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
        if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Mobile', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Mobile', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
       /* onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONARDXFFJ_694846', 'FindMobile', undefined, true, false, 'VC_MOBILEMATM_689502', false);*/
      }
        
    };