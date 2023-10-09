//gridRowUpdating QueryView: QV_7463_28553
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_7463_28553 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.rowData.extension = gridRowUpdatingEventArgs.rowData.file.substring((gridRowUpdatingEventArgs.rowData.file).lastIndexOf(".")+1);
			gridRowUpdatingEventArgs.rowData.file = "";
            //Descomentar esto cuando en el gridRowUpdatingEventArgs este llegando el uid
            /*if(gridRowUpdatingEventArgs.rowData.uploaded == 'S'){
				gridRowUpdatingEventArgs.commons.api.grid.removeCellStyle('QV_7463_28553',gridRowUpdatingEventArgs.rowData,'VA_GRIDROWCOMMMNDD_972611','disabled',true);
			}*/
            var action = true;
            if(entities.ScannedDocumentsDetail.data().length != 0){
                for(var i = 0; i <= entities.ScannedDocumentsDetail.data().length - 1; i++){
                    if(entities.ScannedDocumentsDetail.data()[i].uploaded === 'N'){
                        action = false;
                    }
                }
            }
            if (action === true){
                gridRowUpdatingEventArgs.commons.api.viewState.show('CM_TPROSPEC_STR');
                gridRowUpdatingEventArgs.commons.api.viewState.enable('CM_TPROSPEC_STR');
            }
        };