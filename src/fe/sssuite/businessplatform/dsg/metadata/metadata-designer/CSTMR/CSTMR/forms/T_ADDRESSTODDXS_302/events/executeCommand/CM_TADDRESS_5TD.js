// (Button) 
    task.executeCommand.CM_TADDRESS_5TD = function(entities, executeCommandEventArgs) {

    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null : locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0) {
        parameters[params[0]] = params[1];
    }

    var scannedDocumentsDetailList = executeCommandEventArgs.commons.api.vc.parentVc.model.ScannedDocumentsDetail._data;
    var context = executeCommandEventArgs.commons.api.vc.parentVc.model.Context;

    if (parameters != null && parameters.modo != 'Q' && executeCommandEventArgs.commons.api.vc.parentVc.model.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && context.roleEnabledDataModRequest == 'S' && entities.PhysicalAddress.addressType == 'RE') {
        context.addressState = 'S';
        executeCommandEventArgs.commons.execServer = true;
    } else {
        executeCommandEventArgs.commons.execServer = false;
    }
        
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
  
        if(entities.Phone._data.length==0){
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SEDEBERIE_44979');
            return ;
        }
        
        if(entities.PhysicalAddress.addressId!=0){
           executeCommandEventArgs.commons.api.vc.closeModal({
          
            resultArgs: {
                index: executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandEventArgs.commons.api.vc.mode,
                data: entities.PhysicalAddress
            }
        });
        }else{
             executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_DEBECRERN_11199');
        }
    };