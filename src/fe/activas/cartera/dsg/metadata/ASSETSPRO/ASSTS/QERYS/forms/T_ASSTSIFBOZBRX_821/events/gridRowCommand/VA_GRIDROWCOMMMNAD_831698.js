//Entity: ResultQueryByFilter
//ResultQueryByFilter. (Button) View: QueryDocumentsByFilter

task.gridRowCommand.VA_GRIDROWCOMMMNAD_831698 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;
    task.download(entities, gridRowCommandEventArgs);

};