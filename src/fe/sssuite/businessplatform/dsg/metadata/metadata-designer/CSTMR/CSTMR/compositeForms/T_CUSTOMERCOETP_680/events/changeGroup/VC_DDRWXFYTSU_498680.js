//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
//ViewContainer: CustomerComposite
task.changeGroup.VC_DDRWXFYTSU_498680 = function (entities, changeGroupEventArgs) {
    changeGroupEventArgs.commons.execServer = false;    
    var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;

    var GET = location.search.substr(1).split("?");
    var get = {};
    for (var i = 0, l = GET.length; i < l; i++) {
        var tmp = GET[i].split('=');
        get[tmp[0]] = unescape(decodeURI(tmp[1]));
    }
    screenMode = get.modo;
   
    //INFORMACION GENERAL
    if (changeGroupEventArgs.commons.item.id == 'VC_KXWIBTYNCU_272226') {
        gnralInfoSelected++;
        changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMERIF_745226', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }

    }
    //DATOS DEMOGRAFICOS
    if (changeGroupEventArgs.commons.item.id == 'VC_FTDSYJBGDX_891186') {
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //DIRECCIONES
    if (changeGroupEventArgs.commons.item.id == 'VC_BZHSCWLUJU_302769') {        
        changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
    }
    //NEGOCIO DEL CLIENTE
    if (changeGroupEventArgs.commons.item.id == 'VC_RRLBYDXROB_523114') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    
    //Caso 155939
    //REFERENCIA DEL CLIENTE
    /*if (changeGroupEventArgs.commons.item.id == 'VC_OBFWMZSSQP_160647') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONOKQWNLY_810576','FindCustomer', undefined, true, false, 'VC_REFERENCSS_358647', false);
    }*/
    
    //RELACION ENTRE CLIENTES
    if (changeGroupEventArgs.commons.item.id == 'VC_QQHYLHYLXD_897494') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','FindCustomer', undefined, true, false, 'VC_RELATIONQE_861494', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //CONYUGE
    if (changeGroupEventArgs.commons.item.id == 'VC_GQKQIIYSWN_251604') {
       changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONSTVQSJN_350425','FindCustomer', undefined, true, false, 'VC_CUSTOMERUU_138604', false);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //CAPACIDAD DE PAGO
    if (changeGroupEventArgs.commons.item.id == 'VC_CFFKBKPJOS_961735') {
        balanceFlag = true;
        task.ableSaveButton(entities.EconomicInformation,changeGroupEventArgs);
        task.calculateAvailableBalance(entities.EconomicInformation,changeGroupEventArgs);

        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
    //VC_KXWIBTYNCU_272226 infor gene
    //VC_FTDSYJBGDX_891186 datos demo
    //VC_CFFKBKPJOS_961735 datos econo
    //VC_AWHUUJNANM_301855 activ econ
    //VC_BZHSCWLUJU_302769 direcciones
    //VC_RRLBYDXROB_523114 nego del client
    //VC_OBFWMZSSQP_160647 referen del client
    //VC_QQHYLHYLXD_897494 relacion entre clien
    
    //DOCUMENTOS DIGITALIZADOS
    //Llamada a executeQuery para llenar la grilla de documentos Digitalizados
    if (changeGroupEventArgs.commons.item.id == 'VC_HVDQINWTYF_467680') {
       var customerId = entities.Person.personSecuential;
        if (customerId != undefined) {
            var filtro ={
                customerId:customerId,
                processInstance:"0",
                sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
                        }
            //Refresh de la grilla para llenar la entidad
            changeGroupEventArgs.commons.api.vc.parentVc = {}
            changeGroupEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
                
            //Refresh de la grilla para llenar la entidad
            changeGroupEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
        }
    }
    //DATOS SOLICITUD COMPLEMENTARIA
    if (changeGroupEventArgs.commons.item.id == 'VC_XISAWPDNOD_912400') {
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            changeGroupEventArgs.commons.api.vc.executeCommand('VA_VABUTTONWVQOBVO_763566', 'FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        }
    }
};