//Start signature to callBack event to QV_9303_67123
    task.gridRowInsertingCallback.QV_9303_67123 = function(entities, gridRowInsertingEventArgs) {
        if(gridRowInsertingEventArgs.success){
          if (section != null){
                var response = { 
                    operation: "U",
                    section: section,
                    clientId: gridRowInsertingEventArgs.rowData.personSecuential
                }; 
        }

        }else{
            cobis.showMessageWindow.loading(false);
        }
    };