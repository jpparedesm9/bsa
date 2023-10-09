// (Button) 
task.executeCommand.CM_TPROSPEC_MT4 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    var confirmMsg = '';
    var ejecuta = 0;
    var aux = 0;
    var collectives = executeCommandEventArgs.commons.api.vc.catalogs.VA_7690NBEFQLFYVXT_868739.data();

    for (let i = 0; i < collectives.length; i++) {
        if (collectives[i].code === entities.NaturalPerson.colectivo) {
            confirmMsg = 'Tipo de Mercado ' + collectives[i].value + ', \u00bfest\u00e1 seguro de su selecci\u00f3n?';
            break;
        }
    }

    //Validacion de personas naturales
    if (entities.NaturalPerson.surname == null || entities.NaturalPerson.genderCode == null || entities.NaturalPerson.firstName == null) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_DEBECOMSL_54956', true);
    } else {
        if (task.FechaNacimiento(entities.NaturalPerson.birthDate, edadMin, edadMax) == false) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_LAPERSONS_59446', true);
            aux = 1;
        }
        if (entities.NaturalPerson.expirationDate != null && task.ValidaVencimiento(entities.NaturalPerson.expirationDate) == false) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELDOCUMTO_49378', true);
            aux = 1;
        }

    }

    /*if ("INE" == entities.NaturalPerson.bioIdentificationType) {
        if (null == entities.NaturalPerson.bioCIC || "" == entities.NaturalPerson.bioCIC.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_CICESOBIT_15951', true);
            aux = 1;
        }
    } else if ("IFE" == entities.NaturalPerson.bioIdentificationType) {
        if (null == entities.NaturalPerson.bioReaderKey || "" == entities.NaturalPerson.bioReaderKey.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_CLAVEDERR_16854', true);
            aux = 1;
        }
        if (null == entities.NaturalPerson.bioOCR || "" == entities.NaturalPerson.bioOCR.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_OCRESOBIT_95215', true);
            aux = 1;
        }
        if (null == entities.NaturalPerson.bioEmissionNumber || "" == entities.NaturalPerson.bioEmissionNumber.trim()) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_NUMERODGS_28759', true);
            aux = 1;
        }

    }*/

    if (null == entities.NaturalPerson.colectivo || "" == entities.NaturalPerson.colectivo.trim()) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.LBL_CSTMR_TIPODEMOT_65400', true);
        aux = 1;
    }
    if (aux == 0) {
        ejecuta = 1;
        entities.NaturalPerson.numCycles;
        entities.NaturalPerson.countyOfBirth;
    }

    if (entities.NaturalPerson.bioIdentificationType == 'INE') {
        entities.NaturalPerson.bioEmissionNumber = null;
        entities.NaturalPerson.bioOCR = null;
        entities.NaturalPerson.bioReaderKey = null;
    } else {
        entities.NaturalPerson.bioCIC = null;
    }
    //Ejecutar el boton
    if (ejecuta == 1) {
        var nav = executeCommandEventArgs.commons.api.navigation;
        nav.label = 'Advertencia';
        nav.address = {
            moduleId: 'CSTMR',
            subModuleId: 'CSTMR',
            taskId: 'T_CSTMRRJEZNQUS_394',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CONFIRMMGG_786394'
        };
        nav.queryParameters = {
            mode: 2
        };
        nav.modalProperties = {
            size: "sm"
        };
        nav.customDialogParameters = {
            mMessage: confirmMsg
        }
        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
    }


};