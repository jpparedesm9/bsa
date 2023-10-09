//"TaskId": "T_ASSTSOSPSJXWE_883"
task.gridRowCommand.VA_CHECKBOXIZTQJZZ_773759 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.DetailRejectedDispersions.data().length; i++) {
        if (i === index)
            entities.DetailRejectedDispersions.data()[i].selection = !entities.DetailRejectedDispersions.data()[i].selection;
    }
    ASSETS.API.changeImageChecker(entities, args);
};

