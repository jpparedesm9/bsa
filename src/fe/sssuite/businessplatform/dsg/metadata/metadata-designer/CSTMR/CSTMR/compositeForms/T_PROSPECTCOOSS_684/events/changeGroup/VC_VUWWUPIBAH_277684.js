//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: ProspectComposite
    task.changeGroup.VC_VUWWUPIBAH_277684 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;
        if (changeGroupEventArgs.commons.item.id == 'VC_RIZJHPLTPZ_320966') {
            var customerId = entities.CustomerTmp.code;
            if (customerId != undefined) {
                var filtro ={
                    customerId:customerId,
                    processInstance:"0"
                };
                //bioHasFingerprint>>N: Tiene Huella Dactilar, S: No tiene Huella Dactilar
                var filtro2 = {
                    origen: "P",
                    sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
                };
                changeGroupEventArgs.commons.api.vc.parentVc = {}
                changeGroupEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro2;
                
                //Refresh de la grilla para llenar la entidad
                changeGroupEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
            }
        }
    };