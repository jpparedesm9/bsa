//Start signature to callBack event to VA_WRRNTSEACH8507_0000044
    task.executeCommandCallback.VA_WRRNTSEACH8507_0000044 = function(entities, executeCommandEventArgs) {
        entities.Guarantees.page(1);
	//Ajusta el tamaño de las cabeceras al campo de la grilla
 	 	var columns = ['GuaranteeCode','GuaranteeType','Description','CloseOpen','GuarantorId','CustomerId','GuarantorName','Custody',
     	            'Office','OfficeName','Currency','CurrentValue','InitialValue','ValueAvailable','AppraisedValueDate','ExpiredWarranty','Status','UserCreation'];
     	BUSIN.API.GRID.addColumnsStyle('QV_QURAR0892_86', 'Grid-Column-Header',executeCommandCallbackEventArgs.commons.api,columns);
    };