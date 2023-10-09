//undefined Entity: 
    task.executeQuery.Q_COLLECRT_3718 = function(executeQueryEventArgs){
       /* executeQueryEventArgs.commons.execServer = false;
            if (executeQueryEventArgs.commons.api.vc.model.CollectiveAdvisor.data().length === 0) {
        executeQueryEventArgs.commons.api.vc.parentVc = {};
    }
    else */
            {
                executeQueryEventArgs.commons.execServer = true;
                executeQueryEventArgs.commons.api.grid.setAppendRecordsParams('QV_3718_27394', ['idSecuencial'], executeQueryEventArgs);
            }

        //executeQueryEventArgs.commons.serverParameters. = true;
    };