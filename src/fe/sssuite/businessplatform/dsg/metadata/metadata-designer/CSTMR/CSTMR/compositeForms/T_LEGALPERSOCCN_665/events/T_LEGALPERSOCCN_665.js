//"TaskId": "T_LEGALPERSOCCN_665"
var showHeader = true;
var section = null;
task.closeModalEvent.findCustomer = function (args) {
    if (args.result.params.mode == "findCompany") {
        args.model.LegalPerson.personSecuential = args.result.selectedData.code;
        args.commons.api.vc.executeCommand('VA_VABUTTONECKBAAP_763218', 'FindCompany', undefined, true, false, 'VC_LEGALPERIP_319665', false);
    }
    else if (args.result.params.mode == "findRepresentative") {
        args.model.LegalRepresentative.legalRepresentativeCode = args.result.selectedData.code;
        args.model.LegalRepresentative.legalRepresentativeDescription = args.result.selectedData.name;
    }
};