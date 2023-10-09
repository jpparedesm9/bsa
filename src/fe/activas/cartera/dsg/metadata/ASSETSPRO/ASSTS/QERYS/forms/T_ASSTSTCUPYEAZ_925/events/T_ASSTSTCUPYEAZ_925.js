//"TaskId": "T_ASSTSTCUPYEAZ_925"
task.gridRowCommand.VA_CHECKBOXXPZAELV_726782 = function (entities, args) {
    args.commons.execServer = false;
    var index = args.rowIndex;
    for (var i = 0; i <= entities.CreditCandidates.data().length; i++) {
        if (i === index)
            entities.CreditCandidates.data()[i].isChecked = !entities.CreditCandidates.data()[i].isChecked;
    }
    task.changeImageChecker(entities, args);
};
task.checker = function (entities, gridExecuteCommandEventArgs) {
    var check = true;
    if(entities.CreditCandidates.data().length != 0){
        for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
            if((entities.CreditCandidates.data()[i].isChecked === false)||(entities.CreditCandidates.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if (entities.CreditCandidates.data().length != 0) {
        for (var i = 0 ; i <= entities.CreditCandidates.data().length - 1 ; i++) {
            gridExecuteCommandEventArgs.rowData = entities.CreditCandidates.data()[i];
            if (check === true) {
                gridExecuteCommandEventArgs.rowData.isChecked = true;

            } else if (check === false) {
                gridExecuteCommandEventArgs.rowData.isChecked = false;

            }
        }
    }
    if (check === true) {
        $("input:checkbox").prop('checked', true)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_895');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_819');
    } else if (check === false) {
        $("input:checkbox").prop('checked', false)
        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_819');
        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_9492_89518', 'CEQV_201QV_9492_89518_895');
    }
    
};
task.changeImageChecker = function (entities, args) {
    var check = true;
    if(entities.CreditCandidates.data().length != 0){
        for(var i=0 ; i <= entities.CreditCandidates.data().length -1 ; i++ ){
            if((entities.CreditCandidates.data()[i].isChecked === false)||(entities.CreditCandidates.data()[i].isChecked === undefined)){
                check = true;
                break;
            } else {
                check = false;
            }
        }
    }
    if(check === true){
        args.commons.api.grid.hideToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_819');
        args.commons.api.grid.showToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_895');
    } else if(check === false){
        args.commons.api.grid.hideToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_895');
        args.commons.api.grid.showToolBarButton('QV_9492_89518','CEQV_201QV_9492_89518_819');
    }
};