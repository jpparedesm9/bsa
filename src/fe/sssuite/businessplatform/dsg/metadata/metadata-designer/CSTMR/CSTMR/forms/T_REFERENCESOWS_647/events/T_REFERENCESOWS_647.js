//"TaskId": "T_REFERENCESOWS_647"

var showHeader = true;
var section = null;
var taskHeader = {};
var ban =true;

task.closeModalEvent.findCustomer = function (args) {
    args.model.CustomerTmpReferences.code = args.result.selectedData.code;
    //args.model.CustomerTmp.code = args.result.selectedData.code;
    args.model.CustomerTmpReferences.businessName = args.result.selectedData.commercialName;
    args.model.CustomerTmpReferences.name = args.result.selectedData.name;
    args.model.CustomerTmpReferences.isGroup = args.result.selectedData.isGroup;
    args.model.CustomerTmpReferences.customerType = args.result.selectedData.customerType;
    args.model.CustomerTmpReferences.documentNumber = args.result.selectedData.documentId;
    args.model.CustomerTmpReferences.documentType = args.result.selectedData.documentType;
    args.commons.api.vc.executeCommand('VA_VABUTTONOKQWNLY_810576', 'FindCustomer', undefined, true, false, 'VC_REFERENCSS_358647', false);
    
};