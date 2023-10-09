//gridRowSelecting QueryView: QV_2921_98487
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_2921_98487 = function (entities, gridRowSelectingEventArgs) {
        gridRowSelectingEventArgs.commons.execServer = false;
		gridRowSelectingEventArgs.commons.api.viewState.show('G_EXTENDSAUQ_349662');
      
       // var fecha = new Date(gridRowSelectingEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].endDate);
        entities.ExtendsQuota.extendsDate =  entities.ExtendsQuota.processDate;
        entities.ExtendsQuota.numberQuota =  gridRowSelectingEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].quota;
        entities.ExtendsQuota.expirationDate = gridRowSelectingEventArgs.commons.api.grid.getSelectedRows("QV_2921_98487")[0].endDate;  
        
    };