<!-- Designer Generator v 6.1.0 - release SPR 2016-21 20/10/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.projectionquotaformmain = designerEvents.api.projectionquotaformmain || designer.dsgEvents();

function VC_PROJECTIIU_405244(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PROJECTIIU_405244_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PROJECTIIU_405244_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL);
        }
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT)) {
            $scope.dateFormat = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT);
        } else {
            $scope.dateFormat = 'yyyy/MM/dd';
        }
        if (preferencesService.getGlobalization(cobis.constant.DATE_FORMAT_PLACEHOLDER)) {
            $scope.dateFormatPlaceholder = preferencesService.getGlobalization(cobis.constant.DATE_FORMAT_PLACEHOLDER);
        } else {
            $scope.dateFormatPlaceholder = $scope.dateFormat;
        }
        $scope.designer = designer;
        $scope.validatorOptions = validatorOptions;
        $scope.vc = designer.initViewContainer({
            moduleId: "ASSTS",
            subModuleId: "MNTNN",
            taskId: "T_PROJECTIONNQI_244",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PROJECTIIU_405244",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_PROJECTIONNQI_244",
        designerEvents.api.projectionquotaformmain,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
                hasChangeInitDataSupport: false,
                hasSearchRenderEvent: true,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: false,
                vcName: 'VC_PROJECTIIU_405244'
            };
            if (($scope.vc.isModal($scope) || $scope.isDesignerInclude || $scope.isDesignerDetail) && angular.isDefined($scope.queryParameters)) {
                $scope.vc.pk = $scope.queryParameters.pk;
                $scope.vc.mode = parseInt($scope.queryParameters.mode || designer.constants.mode.Insert);
            } else {
                $scope.vc.pk = $location.search().pk;
                $scope.vc.mode = parseInt($location.search().mode || designer.constants.mode.Insert);
            }
            $scope.vc.args.pk = $scope.vc.pk;
            $scope.vc.args.mode = $scope.vc.mode;
            if (cobis.userContext.getValue(cobis.constant.USER_NAME)) {
                $scope.vc.args.user = cobis.userContext.getValue(cobis.constant.USER_NAME);
            } else {
                $scope.vc.args.user = "UserOutContainer";
            }
            $scope.vc.customDialogParameters = $scope.customDialogParameters;
            $scope.vc.args.channel = $location.search().channel;
            $scope.vc.metadata = {
                taskPk: {
                    moduleId: 'ASSTS',
                    subModuleId: 'MNTNN',
                    taskId: 'T_PROJECTIONNQI_244',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    ProjectionQuota: "ProjectionQuota"
                },
                entities: {
                    Loan: {
                        loanID: 'AT37_LOANIDFI882',
                        loanBankID: 'AT42_LOANBADK882',
                        operationTypeID: 'AT23_OPERATDP882',
                        operationType: 'AT70_OPERATPP882',
                        officeID: 'AT37_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        currencyName: 'AT39_CURRENYY882',
                        officer: 'AT77_OFFICERR882',
                        amount: 'AT91_AMOUNTMO882',
                        clientID: 'AT68_CLIENTII882',
                        clientName: 'AT71_CLIENTNA882',
                        idType: 'AT48_IDTYPEBH882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        statusID: 'AT12_STATUSID882',
                        status: 'AT66_STATUSOB882',
                        newStatusID: 'AT25_NEWSTATT882',
                        startDate: 'AT39_STARTDEE882',
                        endDate: 'AT50_ENDDATEE882',
                        feeEndDate: 'AT99_FEEENDED882',
                        newStatus: 'AT59_NEWSTASS882',
                        balanceDue: 'AT21_BALANCDD882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        codCurrency: 'AT24_CODMONDD882',
                        numProcedure: 'AT10_NUMPROUE882',
                        migratedOper: 'AT33_MIGRATEO882',
                        disbursementDate: 'AT76_DISBURTS882',
                        desOperationType: 'AT57_DESOPETI882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        previousOper: 'AT65_PREVIOPU882',
                        adjustment: 'AT94_ADJUSTNT882',
                        redesCont: 'AT58_REDESCTN882',
                        idInstancia: 'AT33_IDINSTII882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ProjectionQuota: {
                        projectionDate: 'AT26_FECHAPRO953',
                        projectionDays: 'AT40_DIASPRCO953',
                        currentAmountDue: 'AT78_MONTOVVD953',
                        amountOverdue: 'AT11_MONTOVIC953',
                        prepaymentAmount: 'AT20_MONTOPNE953',
                        typeCalculation: 'AT75_TIPOCACU953',
                        expirationDays: 'AT83_EXPIRAAN953',
                        dateProcess: 'AT98_DATEPRSE953',
                        _pks: [],
                        _entityId: 'EN_PROJECTTI_953',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Loan: {},
                ProjectionQuota: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (var en in defaultValues) {
                    if (defaultValues.hasOwnProperty(en) && en === entityName) {
                        for (var att in defaultValues[en]) {
                            if (defaultValues[en].hasOwnProperty(att) && att === attributeName) {
                                for (var ch in defaultValues[en][att]) {
                                    if (defaultValues[en][att].hasOwnProperty(ch) && ch === channel) {
                                        return defaultValues[en][att][ch];
                                    }
                                }
                            }
                        }
                    }
                }
                if (typeof valueIfNotExist !== "undefined") {
                    return valueIfNotExist;
                } else {
                    return null;
                }
            };
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                };
                $scope.vc.execute("temporarySave", null, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", null, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", null, data, function() {});
                            $scope.vc.crud.addTrackers($scope.vc.model);
                        }
                        page.hasTemporaryData = result;
                        page.ejecTemporaryData = response.success;
                        return page;
                    });
                } else {
                    page.ejecTemporaryData = false;
                    page.hasTemporaryData = false;
                    return page;
                }
            };
            $scope.vc.viewState.keyDown = function(e) {
                dsgnrUtils.container.validateOnEnter(e, $scope.vc);
            }
            $scope.vc.viewState.VC_PROJECTIIU_405244 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PROJECTIIU_405244",
                hasId: true,
                componentStyle: "",
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_SQRMWXXWBH_255244",
                hasId: true,
                componentStyle: "",
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_WMVURFPSBR_236316",
                hasId: true,
                componentStyle: "",
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Loan = {
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                idInstancia: $scope.vc.channelDefaultValues("Loan", "idInstancia")
            };
            //ViewState - Group: Group2443
            $scope.vc.createViewState({
                id: "G_LOANHEADOD_564612",
                hasId: true,
                componentStyle: "",
                label: 'Group2443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: clientName
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_143612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1657
            $scope.vc.createViewState({
                id: "G_LOANHEADRO_349612",
                hasId: true,
                componentStyle: "",
                label: 'Group1657',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_867612",
                componentStyle: "",
                labelImageId: "",
                label: "ASSTS.LBL_ASSTS_PRSTAMOFK_44930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVITZRQ_108612",
                componentStyle: "",
                imageId: "glyphicon glyphicon-info-sign",
                label: "ASSTS.LBL_ASSTS_MASINACIN_18792",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONORYJAMS_468612",
                componentStyle: "",
                imageId: "glyphicon glyphicon-search",
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1848
            $scope.vc.createViewState({
                id: "G_LOANHEAINF_340612",
                hasId: true,
                componentStyle: "",
                label: 'Group1848',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_5034UOFCASVGKTK_993612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_TIPOCRDOO_69382",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: balanceDue
            $scope.vc.createViewState({
                id: "VA_2463BHBNLZPKLMU_865612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_SALDOEXBB_70535",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: status
            $scope.vc.createViewState({
                id: "VA_3853RRTWBIRUGHQ_533612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: office
            $scope.vc.createViewState({
                id: "VA_7292SEAHPRAXOKC_868612",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_SQUIFEROTT_498244",
                hasId: true,
                componentStyle: "",
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ProjectionQuotaForm
            $scope.vc.createViewState({
                id: "VC_JBFPPOJDKE_802621",
                hasId: true,
                componentStyle: "",
                label: 'ProjectionQuotaForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1435
            $scope.vc.createViewState({
                id: "G_PROJECTOTQ_450517",
                hasId: true,
                componentStyle: "",
                label: 'GroupLayout1435',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ProjectionQuota = {
                projectionDate: $scope.vc.channelDefaultValues("ProjectionQuota", "projectionDate"),
                projectionDays: $scope.vc.channelDefaultValues("ProjectionQuota", "projectionDays"),
                currentAmountDue: $scope.vc.channelDefaultValues("ProjectionQuota", "currentAmountDue"),
                amountOverdue: $scope.vc.channelDefaultValues("ProjectionQuota", "amountOverdue"),
                prepaymentAmount: $scope.vc.channelDefaultValues("ProjectionQuota", "prepaymentAmount"),
                typeCalculation: $scope.vc.channelDefaultValues("ProjectionQuota", "typeCalculation"),
                expirationDays: $scope.vc.channelDefaultValues("ProjectionQuota", "expirationDays"),
                dateProcess: $scope.vc.channelDefaultValues("ProjectionQuota", "dateProcess")
            };
            //ViewState - Group: Group1567
            $scope.vc.createViewState({
                id: "G_PROJECTIUQ_171517",
                hasId: true,
                componentStyle: "",
                label: 'Group1567',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_915517",
                componentStyle: "control_titulo",
                label: "ASSTS.LBL_ASSTS_FECHAPRON_57586",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2108",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ProjectionQuota, Attribute: projectionDate
            $scope.vc.createViewState({
                id: "VA_FECHAPROYECCOIN_790517",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_FECHAPRON_57586",
                validationCode: 96,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "Spacer2857",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ProjectionQuota, Attribute: projectionDays
            $scope.vc.createViewState({
                id: "VA_DIASPROYECCIONO_148517",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_DIASPROCA_33799",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2838",
                componentStyle: "",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ProjectionQuota, Attribute: typeCalculation
            $scope.vc.createViewState({
                id: "VA_TIPOUWNWJMGVYCI_648517",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_MODALIDOC_51998",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_TIPOUWNWJMGVYCI_648517 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Paga intereses Proyectados'
                        }, {
                            code: 'N',
                            value: 'Paga Intereses Acumulados'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_TIPOUWNWJMGVYCI_648517 !== "undefined") {}
            //ViewState - Entity: ProjectionQuota, Attribute: dateProcess
            $scope.vc.createViewState({
                id: "VA_DATEPROCESSGJPH_342517",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_FECHAPRSC_69139",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group2298
            $scope.vc.createViewState({
                id: "G_PROJECTINO_339517",
                hasId: true,
                componentStyle: "",
                label: 'Group2298',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_283517",
                componentStyle: "control_titulo",
                label: "ASSTS.LBL_ASSTS_PROYECCTI_84293",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ProjectionQuota, Attribute: currentAmountDue
            $scope.vc.createViewState({
                id: "VA_MONTOVIGENTEENO_276517",
                componentStyle: "control_monto_vencido",
                label: "ASSTS.LBL_ASSTS_MONTOVIEE_67403",
                format: "#,##0.00\ USD.",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ProjectionQuota, Attribute: amountOverdue
            $scope.vc.createViewState({
                id: "VA_MONTOVENCIDOXAY_846517",
                componentStyle: "control_monto_vencido",
                label: "ASSTS.LBL_ASSTS_MONTOVEDC_35140",
                format: "#,##0.00\ USD.",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ProjectionQuota, Attribute: prepaymentAmount
            $scope.vc.createViewState({
                id: "VA_MONTOPRECANCALO_956517",
                componentStyle: "control_monto_vencido",
                label: "ASSTS.LBL_ASSTS_MONTOPRCE_54604",
                format: "#,##0.00\ USD.",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PROJECTIONNQI_244_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PROJECTIONNQI_244_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TPROJECT_N0M",
                componentStyle: "",
                label: "ASSTS.LBL_ASSTS_CALCULARR_78724",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TIPOUWNWJMGVYCI_648517.read();
                }
            });
        }
        $scope.isInvalid = function(form, field) {
            if (!field) {
                return false;
            }
            var submitted = $scope.vc.submitted[form.$name];
            return ((submitted || field.$dirty) && field.$invalid);
        };
        $scope._initPage_CRUDExecuteQueryEntities = function(page) {
            if (!designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                if (page.hasTemporaryDataSupport && page.ejecTemporaryData && !page.hasTemporaryData) {
                    return $scope.vc.CRUDExecuteQueryEntities(page);
                } else if (page.hasCRUDSupport) {
                    return $scope.vc.CRUDExecuteQueryEntities(page);
                } else {
                    return page;
                }
            } else {
                return page;
            }
        };
        $scope._initPage_InitializeTrackers = function(page) {
            $scope.vc.addChangeEvents($scope);
            $scope.vc.crud.addTrackers($scope.vc.model);
            return page;
        };
        $scope._initPage_ChangeInitData = function(page) {
            return $scope.vc.changeInitData(page, $scope.vc);
        };
        $scope._initPage_ProcessRender = function(page) {
            if (page.hasSearchRenderEvent) {
                $scope.vc.render('VC_PROJECTIIU_405244');
            }
            return page;
        };
        if ($scope.vc.isModal($scope) || $scope.vc.isDetailGrid($scope) || $scope.isDesignerInclude) {
            //para ventanas modales se usa ng-include con onload
            $scope.runLifeCycle = function() {
                var threadLifeCycle = $scope.vc.lifeCycle.prepareThread(page);
                if (threadLifeCycle) {
                    if (!$scope.isDesignerInclude) {
                        cobis.showMessageWindow.loading(true, "none");
                    }
                    $scope.vc.lifeCycle.run(page, threadLifeCycle, $scope);
                    cobis.showMessageWindow.loading(false);
                }
            };
        } else {
            //con ngView no funciona el $document.ready se cambia por $viewContentLoaded
            $scope.$on('$viewContentLoaded', function() {
                if ($scope.vc.loaded) {
                    //Si se esta regresando de otra pantalla
                    $scope.vc.addChangeEvents($scope);
                    if ($scope.vc.dialogResponse || $scope.vc.customDialogResponse) {
                        $scope.vc.afterCloseGridDialog();
                    }
                    cobis.showMessageWindow.loading(false);
                } else {
                    //Si es la primera vez que se ejecuta la pantalla
                    var threadLifeCycle = $scope.vc.lifeCycle.prepareThread(page);
                    if (threadLifeCycle) {
                        $scope.vc.lifeCycle.run(page, threadLifeCycle, $scope);
                        cobis.showMessageWindow.loading(false);
                    }
                }
            });
        }
    }]);
}
if (typeof cobisMainModule === "undefined") {
    var cobisMainModule = cobis.createModule("VC_PROJECTIIU_405244", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
    cobisMainModule.config(["$controllerProvider", "$compileProvider", "$filterProvider", "$locationProvider", "$routeProvider", "$provide", "$translateProvider", "$translatePartialLoaderProvider", "$ocLazyLoadProvider",

    function($controllerProvider, $compileProvider, $filterProvider, $locationProvider, $routeProvider, $provide, $translateProvider, $translatePartialLoaderProvider, $ocLazyLoadProvider) {
        $ocLazyLoadProvider.config({
            asyncLoader: $script
        });
        $locationProvider.html5Mode(true);
        cobisMainModule.controllerProvider = $controllerProvider;
        cobisMainModule.compileProvider = $compileProvider;
        cobisMainModule.routeProvider = $routeProvider;
        cobisMainModule.filterProvider = $filterProvider;
        cobisMainModule.provide = $provide;
        var culture = cobis.userContext.getValue(cobis.constant.CULTURE);
        $routeProvider.when("/VC_PROJECTIIU_405244", {
            templateUrl: "VC_PROJECTIIU_405244_FORM.html",
            controller: "VC_PROJECTIIU_405244_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PROJECTIIU_405244?" + $.param(search);
            }
        });
        VC_PROJECTIIU_405244(cobisMainModule);
    }]);
} else {
    VC_PROJECTIIU_405244(cobisMainModule);
}