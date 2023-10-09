//Entity: Document
//Document. (Button) View: DocumentGrid

task.gridRowCommand.VA_GRIDROWCOMMMNAN_389731 = function (entities, gridRowCommandEventArgs) {
    gridRowCommandEventArgs.commons.execServer = false;
    task.download(entities, gridRowCommandEventArgs);
};