//gridRowSelecting QueryView: GridApplicationsPrint
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
task.gridRowSelecting.QV_ERPLI1480_97 = function (entities, gridRowSelectingEventArgs) {
    selectedApplication = gridRowSelectingEventArgs.commons.api.grid.getSelectedRows('QV_ERPLI1480_97');
    entities.SearchCriteriaPrintingDocuments.codeProcess=selectedApplication[0].CreditCode;
    entities.SearchCriteriaPrintingDocuments.typeProcess=selectedApplication[0].FlowType;
     gridRowSelectingEventArgs.commons.execServer = true;

};