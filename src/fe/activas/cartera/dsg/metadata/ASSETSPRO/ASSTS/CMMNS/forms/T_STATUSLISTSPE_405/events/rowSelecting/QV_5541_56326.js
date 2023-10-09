//gridRowSelecting QueryView: QV_5541_56326
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_5541_56326 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = true;
        var parentModel=gridRowSelectingEventArgs.commons.api.parentVc.model;
        var Status=gridRowSelectingEventArgs.rowData;        
        parentModel.Loan.newStatus=Status.newStatus;            
        
        gridRowSelectingEventArgs.commons.api.vc.closeModal(Status);
        //gridRowSelectingEventArgs.commons.serverParameters.LoanStatusChange = true;
    };