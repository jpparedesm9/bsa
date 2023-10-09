//gridRowDeleting QueryView: GrdWarrantyPolicies
    //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
    task.gridRowDeleting.QV_ERWRL4097_89 = function (entities, gridRowDeletingEventArgs) {
        var warrantyGeneral = gridRowDeletingEventArgs.commons.api.vc.model.WarrantyGeneral;
        var rowDeleted = gridRowDeletingEventArgs.rowData;       
        rowDeleted.branchOffice = warrantyGeneral.branchOffice;
        rowDeleted.custodyType = warrantyGeneral.warrantyType;
        rowDeleted.custody = warrantyGeneral.code;

        gridRowDeletingEventArgs.commons.execServer = true;
        // gridRowDeletingEventArgs.commons.serverParameters.WarrantyPoliciy = true;
        
    };