//Entity: ResultQueryByFilter
//ResultQueryByFilter. (Button) View: QueryDocumentsByFilter

task.gridRowCommand.VA_GRIDROWCOMMMNNA_455698 = function (entities, gridRowCommandEventArgs) {
    gridRowCommandEventArgs.commons.execServer = false;
    var entity = {};
    entity.processInstance = gridRowCommandEventArgs.rowData.processId == null ? 0 : gridRowCommandEventArgs.rowData.processId;
    entity.customerId = gridRowCommandEventArgs.rowData.clientId == null ? 0 : gridRowCommandEventArgs.rowData.clientId;
    entity.groupId = gridRowCommandEventArgs.rowData.groupId == null ? 0 : gridRowCommandEventArgs.rowData.groupId;
    entity.description = gridRowCommandEventArgs.rowData.documentType == null ? "" : gridRowCommandEventArgs.rowData.documentType.trim();
    entity.documentId = gridRowCommandEventArgs.rowData.codDocumentType == null ? "" : gridRowCommandEventArgs.rowData.codDocumentType.trim();
    entity.extension = (gridRowCommandEventArgs.rowData.documentName == null ? "" : gridRowCommandEventArgs.rowData.documentName.trim()) + "." + (gridRowCommandEventArgs.rowData.extension == null ? "" : gridRowCommandEventArgs.rowData.extension.trim());
    entity.folder = gridRowCommandEventArgs.rowData.folder;
    ASSETS.Navigation.openHistorical(entity, gridRowCommandEventArgs, 'VA_GRIDROWCOMMMNNA_455698');

};