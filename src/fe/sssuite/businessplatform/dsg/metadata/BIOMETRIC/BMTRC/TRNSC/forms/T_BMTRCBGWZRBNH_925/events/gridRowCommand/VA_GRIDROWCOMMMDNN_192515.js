//Entity: Customer
//Customer. (Button) View: BiometricValidation
task.gridRowCommand.VA_GRIDROWCOMMMDNN_192515 = function(entities, gridRowCommandEventArgs) {
    gridRowCommandEventArgs.commons.execServer = false;
	var rowData = gridRowCommandEventArgs.rowData
	var api = gridRowCommandEventArgs.commons.api;
    var dataSend = {};
    // BMTRC.SERVICES.BIOCHECK.validateBiocheck(gridRowCommandEventArgs,entities.AdditionalInformation.environment, localIp);

    if (rowData.withoutFingerprintValue !== 'S') {
        //Open Modal
        var nav = gridRowCommandEventArgs.commons.api.navigation;
        nav.label = "Captura de Huellas Dactilares";
        nav.address = {
            moduleId: "BMTRC",
            subModuleId: "TRNSC",
            taskId: "T_BMTRCZDWNNFMY_409",
            taskVersion: "1.0.0",
            viewContainerId: "VC_BIOMETRINP_845409",
        };
        nav.queryParameters = {
            mode: 1,
        };
        nav.modalProperties = {
            size: "lg",
            height: 650,
            callFromGrid: false,
        };

        nav.customDialogParameters = {
            grid: gridRowCommandEventArgs,
            entities: entities,
        };

        //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
        nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, null);
        //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
        //nav.openModalWindow(id, gridRowCommandEventArgs.modelRow);

    } else {
        dataSend.response = null;
        dataSend.signature = null;
        dataSend.amount = rowData.amount;
        dataSend.sequential = null;        
        dataSend.instanceProcess = api.parentVc.model.Task.processInstanceIdentifier;

        if (rowData.withoutFingerprint) {
            dataSend.validateFingerPrint = 'S';
        }

        //servicio guardado
        BMTRC.SERVICES.BIOCHECK.saveBiometricInfo(dataSend, rowData, gridRowCommandEventArgs);
    }

};