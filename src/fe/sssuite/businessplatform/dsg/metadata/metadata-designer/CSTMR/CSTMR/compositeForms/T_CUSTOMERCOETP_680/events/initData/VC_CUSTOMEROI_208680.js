//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: CustomerComposite
task.initData.VC_CUSTOMEROI_208680 = function(entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.hide('VA_HASPROBLEMSUGXJ_814213');
    initDataEventArgs.commons.api.viewState.disable('VA_AVAILABLEBALCNN_776168');
    initDataEventArgs.commons.api.viewState.disable('VA_DOCUMENTNUMBRRE_960213');
    initDataEventArgs.commons.api.viewState.disable('VA_IDENTIFICATICCC_741213');
    initDataEventArgs.commons.api.viewState.disable('VA_2792JAYJXHGFXEG_699213');
    initDataEventArgs.commons.api.viewState.disable('VA_BRANCHCODEYMGYZ_548213'); //Sucursal
    initDataEventArgs.commons.api.viewState.disable('VA_OFFICERCODEBNMM_892213'); //Oficial
    initDataEventArgs.commons.api.viewState.hide('VA_BUSINESSYEARSSS_759168');
    // initDataEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
    initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_2_9');
    initDataEventArgs.commons.api.viewState.disable('VA_PERSONPEPVOMMIN_199213'); //persona PEP
    initDataEventArgs.commons.api.viewState.disable('VA_CHARGEPUBGMPRKN_954213');
    initDataEventArgs.commons.api.viewState.disable('VA_AVAILABLETOTAAL_435168');
    initDataEventArgs.commons.api.viewState.disable('VA_AVAILABLEINCEEE_385168');
    initDataEventArgs.commons.api.viewState.hide('VA_EMAILPFXEWBQUQH_770213');
    /*Desactivar campos de RFC*/
    initDataEventArgs.commons.api.viewState.disable('VA_FIRSTNAMEFPYKAF_649213');
    initDataEventArgs.commons.api.viewState.disable('VA_SECONDNAMESJJYD_721213');
    initDataEventArgs.commons.api.viewState.disable('VA_SURNAMESONBWSJR_285213');
    initDataEventArgs.commons.api.viewState.disable('VA_SECONDSURNAMEEE_733213');
    initDataEventArgs.commons.api.viewState.disable('VA_BIRTHDATEEXJMQR_157213');
    initDataEventArgs.commons.api.viewState.disable('VA_COUNTYOFBIRTHHH_881213');
    initDataEventArgs.commons.api.viewState.disable('VA_GENDERCODEUTLBL_276213');
    initDataEventArgs.commons.api.viewState.hide('VA_LANDLINEONESMPZ_626642');
    //Se oculta por cambio bloqueado PLD
    initDataEventArgs.commons.api.viewState.hide('VA_BLOCKEDZUOBRBYZ_833213');
    initDataEventArgs.commons.api.viewState.hide('VA_STATUSCODEMPXFC_766213');
    //ComplementariaTelefonofijo
    //if (cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONRNZGSZY_345213');
    //}

    initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T26');
    var nav = initDataEventArgs.commons.api.navigation;
    var parentVc = initDataEventArgs.commons.api.vc.parentVc;
    var customDialogParameters = parentVc == undefined || parentVc == null ? null : parentVc.customDialogParameters;
    var parentParameters = parentVc == undefined || parentVc == null ? {} : parentVc.model;
    var GET = location.search.substr(1).split("?");
    var get = {};
    gnralInfoSelected = 0;
    if (parentVc == undefined) {
        initDataEventArgs.commons.api.viewState.hide('VC_GQKQIIYSWN_251604');
    }

    angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function(processDate) {
        today = processDate;
        today = new Date(today);
    });

    //Se oculta la columna Direccion
    initDataEventArgs.commons.api.grid.hideColumn('QV_4851_97960', 'addressDescription');

    for (var i = 0, l = GET.length; i < l; i++) {
        var tmp = GET[i].split('=');
        get[tmp[0]] = unescape(decodeURI(tmp[1]));
    }
    
    screenMode = get.modo;
 
    if ((screenMode != undefined && screenMode != null && screenMode == 'Q') || get[tmp[0]] == 'undefined' || (customDialogParameters != null && customDialogParameters.clientId != undefined)) {
        if (customDialogParameters == null && customDialogParameters == undefined && parentParameters.Task == undefined) {
            nav.label = 'B\u00FAsqueda de Clientes';
            nav.customAddress = {
                id: 'findCustomer',
                url: '/customer/templates/find-customers-tpl.html'
            };
            nav.scripts = [{
                module: cobis.modules.CUSTOMER,
                files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
            }];
            nav.customDialogParameters = {
                mode: "findCustomer"
            };
            nav.modalProperties = {
                size: 'lg'
            };
            nav.openCustomModalWindow('findCustomer');
        } else if (customDialogParameters != null && customDialogParameters != undefined && parentParameters.Task == undefined) {
            showHeader = false;
            entities.NaturalPerson.personSecuential = customDialogParameters.clientId;
            entities.NaturalPerson.typePerson = "P";
            section = customDialogParameters.section;
            initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
            if (parentVc.id == 'VC_GROUPCOMOS_387974') { //grupos aprobar prestamos
                initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T01'); //oculta guardar
                initDataEventArgs.commons.api.viewState.hide('CM_TCUSTOME_T6S'); //oculta buro
                initDataEventArgs.commons.api.viewState.disable('VC_CUSTOMEROI_208680'); //disable all
                initDataEventArgs.commons.api.viewState.disable('VC_GQKQIIYSWN_251604'); //disable spouse
            }

        } else if ((customDialogParameters != null || customDialogParameters != undefined) && parentParameters.Task != undefined) {
            showHeader = false;
            var task = parentParameters.Task;
            if (task != null) {
                entities.NaturalPerson.personSecuential = task.clientId;
                entities.NaturalPerson.typePerson = "P";
                initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
            }
        }
    } else {
        entities.NaturalPerson.personSecuential = get[tmp[0]];
        entities.NaturalPerson.typePerson = "P";
        //section = customDialogParameters.section;
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONQGYEKJY_245213', 'FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
        /*initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONYDIJDRL_132566','FindCustomer', undefined, true, false, 'VC_ADDRESSYWA_591769', false);
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONJPSJYQV_906304','FindCustomer', undefined, true, false, 'VC_BUSINESSPR_115114', false);
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONOKQWNLY_810576','FindCustomer', undefined, true, false, 'VC_REFERENCSS_358647', false);
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','FindCustomer', undefined, true, false, 'VC_RELATIONQE_861494', false);*/
    }
};