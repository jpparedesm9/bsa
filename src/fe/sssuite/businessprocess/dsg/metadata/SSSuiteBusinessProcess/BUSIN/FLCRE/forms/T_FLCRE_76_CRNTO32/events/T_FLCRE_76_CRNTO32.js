//"TaskId": "T_FLCRE_76_CRNTO32"
    task.validateBeforeSave = function (entities, args){
        
        var savePolicy = true;
        var api = args.commons.api;
        var customParameters=api.parentVc.customDialogParameters;
        var customDialogParameters = api.parentVc.customDialogParameters.isNew == true?api.parentVc.parentVc.parentVc.customDialogParameters:api.parentVc.parentVc.customDialogParameters;
        var showMessageErrorPage = false;
        var processDate = api.parentVc.customDialogParameters.processDate;
        
        
        var numErrors = args.commons.api.errors.getErrorsGroup('GR_WARNTYPOIY77_04',false);
        if(numErrors > 0){
            args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ESICINSPG_05163', true);
            return false;
        }else{
            return true;
        }
        
    };