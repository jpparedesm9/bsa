//"TaskId": "T_CSTMRTCAJUPXM_188"
task.gridRowCommand.VA_CHECKBOXQELWHKO_910231 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.CustomerTransferRequest.data().length; i++) {
        if (i === index)
            entities.CustomerTransferRequest.data()[i].isChecked = !entities.CustomerTransferRequest.data()[i].isChecked;
    }
    task.changeImageChecker(entities, args);
};
task.checker = function (entities, gridExecuteCommandEventArgs) {
    var check = true;
    if(entities.CustomerTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.CustomerTransferRequest.data().length -1 ; i++ ){
            if((entities.CustomerTransferRequest.data()[i].isChecked === false)||(entities.CustomerTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if (entities.CustomerTransferRequest.data().length != 0) {
        for (var i = 0 ; i <= entities.CustomerTransferRequest.data().length - 1 ; i++) {
            gridExecuteCommandEventArgs.rowData = entities.CustomerTransferRequest.data()[i];
            if (check === true) {
                gridExecuteCommandEventArgs.rowData.isChecked = true;

            } else if (check === false) {
                gridExecuteCommandEventArgs.rowData.isChecked = false;

            }
        }
    }
    if (check === true) {
        $("input:checkbox").prop('checked', true)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_627');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_386');
    } else if (check === false) {
        $("input:checkbox").prop('checked', false)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_386');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9850_34524', 'CEQV_201QV_9850_34524_627');
    }
    
};
task.changeImageChecker = function (entities, args) {
    var check = true;
    if(entities.CustomerTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.CustomerTransferRequest.data().length -1 ; i++ ){
            if((entities.CustomerTransferRequest.data()[i].isChecked === false)||(entities.CustomerTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if(check === true){
        args.commons.api.grid.hideToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_386');
        args.commons.api.grid.showToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_627');
    } else if(check === false){
        args.commons.api.grid.hideToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_627');
        args.commons.api.grid.showToolBarButton('QV_9850_34524','CEQV_201QV_9850_34524_386');
    }
};