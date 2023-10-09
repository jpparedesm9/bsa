// (Button) 
    task.executeCommand.CM_TADDRESS_DDD = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var catalogs=executeCommandEventArgs.commons.api.vc.catalogs;
		entities.PhysicalAddress.countryDescription=task.findValueInCatalog(entities.PhysicalAddress.countryCode,
                            catalogs.VA_TEXTINPUTBOXOJR_474436.data());
        entities.PhysicalAddress.provinceDescription=task.findValueInCatalog(entities.PhysicalAddress.provinceCode,
                            catalogs.VA_TEXTINPUTBOXTCU_205436.data());
        entities.PhysicalAddress.cityDescription=task.findValueInCatalog(entities.PhysicalAddress.cityCode,
                            catalogs.VA_TEXTINPUTBOXQVZ_987436.data());
        entities.PhysicalAddress.parishDescription=task.findValueInCatalog(entities.PhysicalAddress.parishCode,
                            catalogs.VA_TEXTINPUTBOXPPK_701436.data());
        entities.PhysicalAddress.addressTypeDescription=task.findValueInCatalog(entities.PhysicalAddress.addressType,
                            catalogs.VA_TEXTINPUTBOXHGW_672436.data());
		 if(entities.PhysicalAddress.addressId!=0){   
           executeCommandEventArgs.commons.api.vc.closeModal({
          
            resultArgs: {
                index: executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandEventArgs.commons.api.vc.mode,
                data: entities.PhysicalAddress
            }});
        }
		else{
		executeCommandEventArgs.commons.api.vc.closeModal({});
		}
    };