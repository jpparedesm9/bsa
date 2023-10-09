//"TaskId": "T_VW_SHCTRATNIW77"

task.closeModalEvent.findCustomer = function (args) {
         var resp = args.commons.api.vc.dialogParameters;
		 //args.model.SearchCriteriaPrintingDocuments.CustomerId =   resp.CodeReceive ;
         args.model.SearchCriteriaPrintingDocuments.CustomerId =   resp.CodeReceive +"-"+resp.name;		 
         args.model.SearchCriteriaPrintingDocuments.group =   resp.isGroup;
    };