//"TaskId": "T_BUSINESSFMWNQ_114"

var showHeader = true;
var section = null;
var taskHeader = {};
var ban =true;

task.closeModalEvent.findCustomer = function (args) {
    
    args.model.CustomerTmpBusiness.code = args.result.selectedData.code;
    args.model.CustomerTmpBusiness.businessName = args.result.selectedData.commercialName;
    args.model.CustomerTmpBusiness.name = args.result.selectedData.name;
    args.model.CustomerTmpBusiness.isGroup = args.result.selectedData.isGroup;
    args.model.CustomerTmpBusiness.customerType = args.result.selectedData.customerType;
    args.model.CustomerTmpBusiness.documentNumber = args.result.selectedData.documentId;
    args.model.CustomerTmpBusiness.documentType = args.result.selectedData.documentType;
    args.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304', 'FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);
    
};