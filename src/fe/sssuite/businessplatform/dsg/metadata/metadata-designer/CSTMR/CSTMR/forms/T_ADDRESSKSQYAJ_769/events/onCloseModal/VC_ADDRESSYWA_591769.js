//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AddresForm
   task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;        
        
    var isAccept;

    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ECONOMICOU_167751') {
        if (typeof onCloseModalEventArgs.result === "boolean") {
            isAccept = onCloseModalEventArgs.result;
        }
        if (isAccept) {
            //Refrescar el grid 
            if (entities.Entity1.refreshGrid == null || entities.Entity1.refreshGrid == false) {
                entities.Entity1.refreshGrid = true;
            } else {
                entities.Entity1.refreshGrid = false;
            }
        }
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_ADDRESSITS_306302') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
            if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                    onCloseModalEventArgs.commons.api.grid.addRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.data);
                }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                    onCloseModalEventArgs.commons.api.grid.updateRow('PhysicalAddress', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
                }
            }
        }
        onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
            if(entities.PhysicalAddress.data().length > 0){
                onCloseModalEventArgs.commons.api.viewState.enable('VC_RIZJHPLTPZ_320966');
                var customerId = entities.CustomerTmp.code;
                if (customerId != undefined) {
                    var filtro ={
                        customerId:customerId,
                        processInstance:"0"
                    };
                    var filtro2 = {
                        origen: "P",
                        screeMode: screenMode
                    };
                    onCloseModalEventArgs.commons.api.vc.parentVc = {}
                    onCloseModalEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro2;

                    //Refresh de la grilla para llenar la entidad
                    onCloseModalEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
                }
            }
    }
if (onCloseModalEventArgs.closedViewContainerId == 'VC_BUSINESSPP_740722') {
    if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('Business', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('Business', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
      }
	  onCloseModalEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);//Para que recuper la info de la base a pesar de que dio error
    }
    if (onCloseModalEventArgs.closedViewContainerId == 'VC_REFERENCPP_688957') {
        if(onCloseModalEventArgs.result.resultArgs!=null){
        if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
            if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Insert) {
                
                onCloseModalEventArgs.commons.api.grid.addRow('References', onCloseModalEventArgs.result.resultArgs.data);

            }else if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                onCloseModalEventArgs.commons.api.grid.updateRow('References', onCloseModalEventArgs.result.resultArgs.index, onCloseModalEventArgs.result.resultArgs.data, true);
            }
        }
    }
    }
        if (onCloseModalEventArgs.closedViewContainerId == 'VC_REPLACEAII_570116') {
            if(onCloseModalEventArgs.result.resultArgs!=null){
                if (onCloseModalEventArgs.dialogCloseType !== onCloseModalEventArgs.commons.constants.dialogCloseType.NonInteractive) {
                    if (onCloseModalEventArgs.result.resultArgs.mode === onCloseModalEventArgs.commons.constants.mode.Update) {
                        entities.NaturalPerson.accountIndividual = onCloseModalEventArgs.result.resultArgs.accountIndividual; 
                    }
                }
            }
        }
    };