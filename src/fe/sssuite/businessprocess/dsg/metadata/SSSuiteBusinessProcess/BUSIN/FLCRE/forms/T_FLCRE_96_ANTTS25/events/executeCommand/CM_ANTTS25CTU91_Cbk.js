    //Start signature to callBack event to CM_ANTTS25CTU91
    task.executeCommandCallback.CM_ANTTS25CTU91 = function (entities, executeCommandEventArgs) {
        var parentParameters = executeCommandEventArgs.commons.api.parentVc.customDialogParameters;
        var inst_proc = parentParameters.Task.processInstanceIdentifier;

        for (var i = 0; i <= entities.DocumentProductTmp.length - 1; i++) {
            if (entities.DocumentProductTmp[i].YesNot === true) {

                var reportName = reportName = entities.DocumentProductTmp[i].Template;

                var nameManager = entities.ParameterPrint.nameManager;
                var city = entities.ParameterPrint.city ? entities.ParameterPrint.city : "Quito";
                var cRuc = entities.ParameterPrint.companyRuc ? entities.ParameterPrint.companyRuc:"";
                var cName = entities.ParameterPrint.companyName ? entities.ParameterPrint.companyName:"";
                var cMngr = entities.ParameterPrint.companyManager ? entities.ParameterPrint.companyManager:"";
                var cAddr = entities.ParameterPrint.companyAddress ? entities.ParameterPrint.companyAddress:"";


                if (FLCRE.CONSTANTS.Report.LoanApplication === entities.DocumentProductTmp[i].Template) {
                    var debtorP = null; // FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
                    var args = [['report.module', 'credito'], ['report.name', FLCRE.CONSTANTS.Report.LoanApplication], ['cstDebtor', 44], ['cstName', 'nombreDeudor'], ['cstId', '123456789'], ['cstTrId', entities.OriginalHeaderTmp.IDRequested], ['cstAplId', entities.OriginalHeaderTmp.ApplicationNumber], ['nameManager', nameManager], ['city', city]];
                    // var debtors = [];//entities.DebtorGeneral.data();
                    // var count = 0;
                    /*
                     * for (var j = 0; j < debtors.length; j++) {
                     * if(debtors[j].Role == 'C'){ count = count + 1;
                     * args.push(['cstCodeu'+count, debtors[j].CustomerCode]); } }
                     */
                } else if (FLCRE.CONSTANTS.Report.PunishmentList === entities.DocumentProductTmp[i].Template) {
                    var dueDate = parentParameters.Task.bussinessInformationStringTwo;
                    var args = [['report.module', 'credito'], ['report.name', reportName], ['type', 'PDF'], ['instProc', inst_proc], ['nameManager', nameManager], ['city', city]];
                } else {
                    var args = [['report.module', 'credito'], ['report.name', reportName], ['idCustomerTwo', '0'], ['idTramit', entities.OriginalHeaderTmp.IDRequested], ['idCity', city], ['reportGuarantor', ''], ['idProcess', entities.OriginalHeaderTmp.ApplicationNumber], ['nameManager', nameManager], ['city', city],['cRuc', cRuc],['cName', cName],['cMngr',cMngr],['cAddr',cAddr]];
                }
                if (reportName != '') {
                    BUSIN.REPORT.GenerarReporte(reportName, args);
                }
            }
        }

        var parentApi = executeCommandEventArgs.commons.api.parentApi();
        var nav = executeCommandEventArgs.commons.api.navigation;
        executeCommandEventArgs.commons.execServer = false;
        if (parentApi != undefined && executeCommandEventArgs.success) {
            var parentVc = parentApi.vc;
            nav.closeModal({
                entities: entities
            });
        } else {
            nav.closeModal({});
        }
        
    };
