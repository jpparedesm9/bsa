//"TaskId": "T_ADDRESSKSQYAJ_769"

var showHeader = true;
var section = null;
var taskHeader = {};
var ban=true;

task.closeModalEvent.findCustomer = function (args) {
    
    args.model.CustomerTmp.code = args.result.selectedData.code;
    args.model.CustomerTmp.businessName = args.result.selectedData.commercialName;
    args.model.CustomerTmp.name = args.result.selectedData.name;
    args.model.CustomerTmp.isGroup = args.result.selectedData.isGroup;
    args.model.CustomerTmp.customerType = args.result.selectedData.customerType;
    args.model.CustomerTmp.documentNumber = args.result.selectedData.documentId;
    args.model.CustomerTmp.documentType = args.result.selectedData.documentType;
    args.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    
};