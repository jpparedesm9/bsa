//"TaskId": "T_CSTMRTVGMFYGK_259"
task.gridRowCommand.VA_CHECKBOXFCIBUWJ_653576 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.AuthorizationTransferRequest.data().length; i++) {
        if (i === index)
            entities.AuthorizationTransferRequest.data()[i].isChecked = !entities.AuthorizationTransferRequest.data()[i].isChecked;
    }
    task.changeImageChecker(entities, args);
};
task.checker = function (entities, gridExecuteCommandEventArgs) {
    var check = true;
    if(entities.AuthorizationTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.AuthorizationTransferRequest.data().length -1 ; i++ ){
            if((entities.AuthorizationTransferRequest.data()[i].isChecked === false)||(entities.AuthorizationTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if (entities.AuthorizationTransferRequest.data().length != 0) {
        for (var i = 0 ; i <= entities.AuthorizationTransferRequest.data().length - 1 ; i++) {
            gridExecuteCommandEventArgs.rowData = entities.AuthorizationTransferRequest.data()[i];
            if (check === true) {
                gridExecuteCommandEventArgs.rowData.isChecked = true;

            } else if (check === false) {
                gridExecuteCommandEventArgs.rowData.isChecked = false;

            }
        }
    }
    if (check === true) {
        $("input:checkbox").prop('checked', true)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_953');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_987');
    } else if (check === false) {
        $("input:checkbox").prop('checked', false)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_987');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_8174_44016', 'CEQV_201QV_8174_44016_953');
    }
    
    
};
task.changeImageChecker = function (entities, args) {
    var check = true;
    if(entities.AuthorizationTransferRequest.data().length != 0){
        for(var i=0 ; i <= entities.AuthorizationTransferRequest.data().length -1 ; i++ ){
            if((entities.AuthorizationTransferRequest.data()[i].isChecked === false)||(entities.AuthorizationTransferRequest.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if(check === true){
        args.commons.api.grid.hideToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_987');
        args.commons.api.grid.showToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_953');
    } else if(check === false){
        args.commons.api.grid.hideToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_953');
        args.commons.api.grid.showToolBarButton('QV_8174_44016','CEQV_201QV_8174_44016_987');
    }
};