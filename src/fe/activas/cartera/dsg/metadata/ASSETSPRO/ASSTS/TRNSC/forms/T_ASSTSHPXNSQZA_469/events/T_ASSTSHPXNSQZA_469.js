//"TaskId": "T_ASSTSHPXNSQZA_469"
   
   task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            groupCode = args.commons.api.vc.dialogParameters.CodeReceive,
            groupName = args.commons.api.vc.dialogParameters.name,
            isGroup = 'S';
       
       if (args.model.Group.groupId != groupCode)
       {
           args.model.Group.groupId = groupCode;
            args.model.Group.groupName = groupName;
           
            args.model.Group.loanBalance = null;
            args.model.Group.collateralBalance = null;
            args.model.Group.groupStatus = null;
            args.model.Group.loanBalCurrencyNem = null;
            args.model.Group.colBalCurrencyNem = null;
       
       
            args.model.ProcessInstance.instanceId = null;
            args.model.ProcessInstance.activityId = null;
            args.model.ProcessInstance.company = null;
            args.model.ProcessInstance.transactionNumber = null;
            args.commons.api.viewState.disable("CM_TASSTSHP_4SA");
            args.commons.api.viewState.disable("CM_TASSTSHP_ZAX");
       
       }else{
            args.model.Group.groupName = groupName;
       }
    };
    