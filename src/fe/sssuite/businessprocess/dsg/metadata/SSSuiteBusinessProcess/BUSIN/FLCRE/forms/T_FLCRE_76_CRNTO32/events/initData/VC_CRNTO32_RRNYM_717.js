//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_CRNTO32_RRNYM_717 = function (entities, initDataEventArgs){
        var warrantyGeneral = initDataEventArgs.commons.api.vc.parentVc.model.WarrantyGeneral;

        entities.WarrantyPoliciy.branchOffice = warrantyGeneral.branchOffice;
        entities.WarrantyPoliciy.custodyType = warrantyGeneral.warrantyType;
        entities.WarrantyPoliciy.custody = warrantyGeneral.code;
        entities.WarrantyPoliciy.externalCode = warrantyGeneral.externalCode;

        entities.generalData = {}; // entidad temporal
        if (initDataEventArgs.commons.api.parentVc.customDialogParameters.currentRow !== null) {
            initDataEventArgs.commons.execServer = true;
            entities.generalData.isNew = false;
        } else {
            initDataEventArgs.commons.execServer = false;
            entities.generalData.isNew = true;
        }        
    };