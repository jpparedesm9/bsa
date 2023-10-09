//"TaskId": "T_FLCRE_13_RPUME79"
var selectedApplication;

task.closeModalEvent.findCustomer = function (args) {
         var resp = args.commons.api.vc.dialogParameters;
		 //args.model.SearchCriteriaPrintingDocuments.CustomerId =   resp.CodeReceive ;
         args.model.SearchCriteriaPrintingDocuments.CustomerId =   resp.CodeReceive +"-"+resp.name;
         args.model.SearchCriteriaPrintingDocuments.group =   resp.isGroup;
    };

task.gridRowCommand.VA_DOCUNODCVW7303_YSNO533 = function (entities, args) {		
        args.commons.execServer = false;		
        var index = args.rowIndex;								
		for (var i = 0; i<=entities.DocumentProduct.data().length; i++)
		{			
			if (i === index)
				entities.DocumentProduct.data()[i].YesNot = !entities.DocumentProduct.data()[i].YesNot;
		}
};