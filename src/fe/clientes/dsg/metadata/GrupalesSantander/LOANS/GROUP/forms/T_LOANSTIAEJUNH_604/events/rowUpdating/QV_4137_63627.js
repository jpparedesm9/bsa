//gridRowUpdating QueryView: QV_4137_63627
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_4137_63627 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            gridRowUpdatingEventArgs.rowData.extension = gridRowUpdatingEventArgs.rowData.file.substring((gridRowUpdatingEventArgs.rowData.file).lastIndexOf(".")+1);
			gridRowUpdatingEventArgs.rowData.file = "";
            //Descomentar esto cuando en el gridRowUpdatingEventArgs este llegando el uid
            /*if(gridRowUpdatingEventArgs.rowData.uploaded == 'S'){
				gridRowUpdatingEventArgs.commons.api.grid.removeCellStyle('QV_6397_58590',gridRowUpdatingEventArgs.rowData,'VA_GRIDROWCOMMMAAD_760904','disabled',true);
			}*/
        };