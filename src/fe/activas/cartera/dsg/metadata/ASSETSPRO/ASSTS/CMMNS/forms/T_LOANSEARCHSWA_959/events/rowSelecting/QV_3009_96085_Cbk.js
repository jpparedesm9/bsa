//Start signature to callBack event to QV_3009_96085
    task.gridRowSelectingCallback.QV_3009_96085 = function(entities, gridRowSelectingEventArgs) {
        //here your code
        gridRowSelectingEventArgs.commons.execServer = true;
    var subModuleId = ""
        , taskId = ""
        , vcId = ""
        , label = ""
        , parameters = {
            loanInstancia: entities.LoanInstancia, 
            menu: queryString.menu, 
            type:queryString.type,
            groupSummary:entities.LoanSearchFilter.groupSummary,
            operationType:gridRowSelectingEventArgs.rowData.desOperationType,//GRUPAL, REVOLVENTE, INDIVIDUAL
            disbursementDate:gridRowSelectingEventArgs.rowData.disbursementDate
        };
    switch (queryString.menu) {
    case ASSETS.Constants.MENU_VALUE_DATE:
        subModuleId = "TRNSC";
        taskId = "T_VALUEDATEMINN_689";
        vcId = "VC_VALUEDATEN_586689";
        label = "Fecha Valor";
        break;
    case ASSETS.Constants.MENU_REVERSE:
        subModuleId = "TRNSC";
        taskId = "T_VALUEDATEMINN_689";
        vcId = "VC_VALUEDATEN_586689";
        label = "Reversas";
        break;
    case ASSETS.Constants.MENU_APPLY_CLAUSE:
        subModuleId = "TRNSC";
        taskId = "T_APPLYCLAUSEEE_533";
        vcId = "VC_APPLYCLASS_521533";
        label = "Cl\u00e1usula Aceleratoria";
        break;
    case ASSETS.Constants.MENU_QUERYSGENERAL:
        subModuleId = "QERYS";
        taskId = "T_GENERALINANNN_443";
        vcId = "VC_GENERALITN_743443";
        label = "Datos Generales";
        break;
    case ASSETS.Constants.MENU_READJUSTMENT:
        subModuleId = "MNTNN";
        taskId = "T_REAJUSTESRCSN_872";
        vcId = "VC_REAJUSTEKP_207872";
        label = "Reajustes del Pr\u00e9stamo";
        break;
    case ASSETS.Constants.MENU_LOANSTATCE:
        subModuleId = "CMMNS";
        taskId = "T_LOANSTATUSGNI_120";
        vcId = "VC_LOANSTATCE_588120";
        label = "Cambio de Estados";
        break;
    case ASSETS.Constants.MENU_PROYECTINST:
        subModuleId = "MNTNN";
        taskId = "T_PROJECTIONNQI_244";
        vcId = "VC_PROJECTIIU_405244";
        label = "Proyecci\u00f3n Cuota";
        break;
    case ASSETS.Constants.MENU_PAYMENTSMANI:
        subModuleId = "TRNSC";
        taskId = "T_PAYMENTSMANII_157";
        vcId = "VC_PAYMENTSAN_916157";
        label = "Pagos/Cancelaciones/Precancelaciones";
        break;
    case ASSETS.Constants.MENU_RENOVATION:
        subModuleId = "TRNSC";
        taskId = "T_LOANREFINANNG_618";
        vcId = "VC_LOANREFINN_713618";
        break;
    case ASSETS.Constants.MENU_INGOTROCARG:
        subModuleId = "MNTNN";
        taskId = "T_PROJECTINGSTR_344";
        vcId = "VC_PROJECTIAA_407344";
        label = "Ingresos Otros Cargos";
        break;
    case ASSETS.Constants.MENU_IMPRESIONDOC:
        subModuleId = "MNTNN";
        taskId = "T_DOCUMENTPRIAN_178";
        vcId = "VC_DOCUMENTIG_406178";
        label = "Impresi\u00f3n de Documentos";
        break;
    case ASSETS.Constants.MENU_PRORROGA:
        subModuleId = "MNTNN";
        taskId = "T_EXTENDSQUONTA_926";
        vcId = "VC_EXTENDSQMN_712926";
        label = "Pr\u00f3rroga";
        break;
    case ASSETS.Constants.MENU_DISBUSMNT:
        subModuleId = "TRNSC";
        taskId = "T_LOANDISBURSAA_275";
        vcId = "VC_LOANDISBMN_824275";
        label = "Desembolso";
        break;
    case ASSETS.Constants.MENU_BLOCK:
        subModuleId = "MNTNN";
        taskId = "T_ASSTSRBSDDMKT_144";
        vcId = "VC_CREDITBLOC_747144";
        label = "Bloqueo y Cancelaci\u00f3n Anticipada de LCR";
        break;
    case ASSETS.Constants.MENU_GROUP:
            subModuleId = "CMMNS";
            taskId = "T_LOANSEARCHSWA_959";
            vcId = "VC_LOANSEARHC_144959";
            label = "Busqueda Operaciones Grupales";
    break;
    }
    if (entities.LoanInstancia.errorValidation != true) {
        ASSETS.Navigation.taskRedirect(subModuleId, taskId, vcId, label, gridRowSelectingEventArgs, parameters);
    }
    //gridRowSelectingEventArgs.commons.serverParameters.Loan = true;
    };