//Start signature to Callback event to VA_VABUTTONXYNUHPG_895132
task.executeCommandCallback.VA_VABUTTONXYNUHPG_895132 = function (entities, executeCommandCallbackEventArgs) {
    if (executeCommandCallbackEventArgs.success) {
        var resultArgs = {
            index: executeCommandCallbackEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex
            , mode: executeCommandCallbackEventArgs.commons.api.vc.mode
            , data: entities.Member
            , addRow: 'S'
        }
        executeCommandCallbackEventArgs.commons.api.navigation.closeModal({
            response: resultArgs
        });
    }
};