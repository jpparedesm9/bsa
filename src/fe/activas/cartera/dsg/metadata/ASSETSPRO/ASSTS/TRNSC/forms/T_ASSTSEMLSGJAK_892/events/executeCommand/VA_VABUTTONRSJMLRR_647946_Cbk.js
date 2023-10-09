    //Start signature to Callback event to VA_VABUTTONRSJMLRR_647946
    task.executeCommandCallback.VA_VABUTTONRSJMLRR_647946 = function (entities, executeCommandCallbackEventArgs) {
        if (executeCommandCallbackEventArgs.success) {
            executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_9025_57410');
        }
    };