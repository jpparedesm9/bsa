//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: warrantiesCreation
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        if(onCloseModalEventArgs.result!=undefined && onCloseModalEventArgs.result.parameterGuarantee !=undefined){
			entities.WarrantyGeneral.externalCode = onCloseModalEventArgs.result.parameterGuarantee.GuaranteeCode;
			entities.WarrantyGeneral.warrantyType = onCloseModalEventArgs.result.parameterGuarantee.GuaranteeType;
			onCloseModalEventArgs.commons.execServer = true;
		}
    };