//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.extendsquotaformmain = designerEvents.api.extendsquotaformmain || designer.dsgEvents();

function VC_EXTENDSQMN_712926(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_EXTENDSQMN_712926_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_EXTENDSQMN_712926_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout, $translate) {
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
            taskId: "T_EXTENDSQUONTA_926",
            taskVersion: "1.0.0",
            viewContainerId: "VC_EXTENDSQMN_712926",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_EXTENDSQUONTA_926",
        designerEvents.api.extendsquotaformmain,
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
                vcName: 'VC_EXTENDSQMN_712926'
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
                    taskId: 'T_EXTENDSQUONTA_926',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    CurrentQuotas: "CurrentQuotas",
                    ExtendsQuota: "ExtendsQuota",
                    ExtendsQuotaExt: "ExtendsQuotaExt",
                    LoanInstancia: "LoanInstancia"
                },
                entities: {
                    Loan: {
                        numProcedure: 'AT10_NUMPROUE882',
                        quotaCredit: 'AT12_QUOTACEE882',
                        statusID: 'AT12_STATUSID882',
                        lastProcessDate: 'AT19_LASTPRED882',
                        balanceDue: 'AT21_BALANCDD882',
                        category: 'AT23_CATEGOYR882',
                        operationTypeID: 'AT23_OPERATDP882',
                        codCurrency: 'AT24_CODMONDD882',
                        newStatusID: 'AT25_NEWSTATT882',
                        isDisbursment: 'AT26_ISDISBTU882',
                        migratedOper: 'AT33_MIGRATEO882',
                        loanID: 'AT37_LOANIDFI882',
                        officeID: 'AT37_OFFICEID882',
                        currencyName: 'AT39_CURRENYY882',
                        startDate: 'AT39_STARTDEE882',
                        loanBankID: 'AT42_LOANBADK882',
                        idType: 'AT48_IDTYPEBH882',
                        endDate: 'AT50_ENDDATEE882',
                        identityCardNumber: 'AT56_IDCARDUU882',
                        desOperationType: 'AT57_DESOPETI882',
                        redesCont: 'AT58_REDESCTN882',
                        newStatus: 'AT59_NEWSTASS882',
                        group: 'AT62_GROUPTNG882',
                        previousOper: 'AT65_PREVIOPU882',
                        status: 'AT66_STATUSOB882',
                        clientID: 'AT68_CLIENTII882',
                        operationType: 'AT70_OPERATPP882',
                        clientName: 'AT71_CLIENTNA882',
                        disbursementDate: 'AT76_DISBURTS882',
                        expirationDate: 'AT76_EXPIRAEE882',
                        officer: 'AT77_OFFICERR882',
                        nextPayment: 'AT85_NEXTPAMT882',
                        effectiveAnualRate: 'AT90_EFFECTAU882',
                        amount: 'AT91_AMOUNTMO882',
                        adjustment: 'AT94_ADJUSTNT882',
                        officerID: 'AT95_OFFICEID882',
                        office: 'AT96_OFFICEPU882',
                        feeEndDate: 'AT99_FEEENDED882',
                        _pks: [],
                        _entityId: 'EN_LOANKYMRI_882',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CurrentQuotas: {
                        quota: 'AT76_QUOTAOPG270',
                        startDate: 'AT20_STARTDAE270',
                        endDate: 'AT65_ENDDATEE270',
                        capital: 'AT87_CAPITALL270',
                        interest: 'AT89_INTERETS270',
                        others: 'AT81_OTHERSPZ270',
                        total: 'AT58_TOTALCKB270',
                        state: 'AT46_STATETIH270',
                        _pks: [],
                        _entityId: 'EN_CURRENTQQ_270',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ExtendsQuota: {
                        extendsDate: 'AT66_DATEEXST567',
                        maximumDateExtended: 'AT65_MAXIMUTA567',
                        numberQuota: 'AT10_NUMBEROQ567',
                        expirationDate: 'AT92_EXPIRADE567',
                        processDate: 'AT95_PROCESDD567',
                        _pks: [],
                        _entityId: 'EN_EXTENDSUT_567',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ExtendsQuotaExt: {
                        quotaExt: 'AT98_QUOTAEXX507',
                        startDateExt: 'AT17_STARTDAE507',
                        endDateExt: 'AT96_ENDDATEE507',
                        capitalExt: 'AT14_CAPITALL507',
                        interestExt: 'AT23_INTERESX507',
                        others: 'AT65_OTHERSEU507',
                        total: 'AT96_TOTALVQB507',
                        state: 'AT37_STATENUW507',
                        _pks: [],
                        _entityId: 'EN_EXTENDSTU_507',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoanInstancia: {
                        idInstancia: 'AT74_IDINSTAA482',
                        idOptionMenu: 'AT59_IDOPTINM482',
                        errorValidation: 'AT62_ERRORVAA482',
                        _pks: [],
                        _entityId: 'EN_LOANINSTC_482',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CURRENAT_2921 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CURRENAT_2921 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CURRENAT_2921_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CURRENAT_2921_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CURRENTQQ_270',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CURRENAT_2921',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_CURRENAT_2921_filters = {};
            $scope.vc.queryProperties.Q_EXTENDEX_5312 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_EXTENDEX_5312 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_EXTENDEX_5312_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_EXTENDEX_5312_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_EXTENDSTU_507',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_EXTENDEX_5312',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_EXTENDEX_5312_filters = {};
            var defaultValues = {
                Loan: {},
                CurrentQuotas: {},
                ExtendsQuota: {},
                ExtendsQuotaExt: {},
                LoanInstancia: {}
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
                $scope.vc.execute("temporarySave", VC_EXTENDSQMN_712926, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_EXTENDSQMN_712926, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_EXTENDSQMN_712926, data, function() {});
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
            $scope.vc.viewState.VC_EXTENDSQMN_712926 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_EXTENDSQMN_712926",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_DFZRKBDHHZ_908926",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_JJPBBGOUBW_131316",
                hasId: true,
                componentStyle: [],
                label: 'LoanHeaderInfoForm',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.Loan = {
                numProcedure: $scope.vc.channelDefaultValues("Loan", "numProcedure"),
                quotaCredit: $scope.vc.channelDefaultValues("Loan", "quotaCredit"),
                statusID: $scope.vc.channelDefaultValues("Loan", "statusID"),
                lastProcessDate: $scope.vc.channelDefaultValues("Loan", "lastProcessDate"),
                balanceDue: $scope.vc.channelDefaultValues("Loan", "balanceDue"),
                category: $scope.vc.channelDefaultValues("Loan", "category"),
                operationTypeID: $scope.vc.channelDefaultValues("Loan", "operationTypeID"),
                codCurrency: $scope.vc.channelDefaultValues("Loan", "codCurrency"),
                newStatusID: $scope.vc.channelDefaultValues("Loan", "newStatusID"),
                isDisbursment: $scope.vc.channelDefaultValues("Loan", "isDisbursment"),
                migratedOper: $scope.vc.channelDefaultValues("Loan", "migratedOper"),
                loanID: $scope.vc.channelDefaultValues("Loan", "loanID"),
                officeID: $scope.vc.channelDefaultValues("Loan", "officeID"),
                currencyName: $scope.vc.channelDefaultValues("Loan", "currencyName"),
                startDate: $scope.vc.channelDefaultValues("Loan", "startDate"),
                loanBankID: $scope.vc.channelDefaultValues("Loan", "loanBankID"),
                idType: $scope.vc.channelDefaultValues("Loan", "idType"),
                endDate: $scope.vc.channelDefaultValues("Loan", "endDate"),
                identityCardNumber: $scope.vc.channelDefaultValues("Loan", "identityCardNumber"),
                desOperationType: $scope.vc.channelDefaultValues("Loan", "desOperationType"),
                redesCont: $scope.vc.channelDefaultValues("Loan", "redesCont"),
                newStatus: $scope.vc.channelDefaultValues("Loan", "newStatus"),
                group: $scope.vc.channelDefaultValues("Loan", "group"),
                previousOper: $scope.vc.channelDefaultValues("Loan", "previousOper"),
                status: $scope.vc.channelDefaultValues("Loan", "status"),
                clientID: $scope.vc.channelDefaultValues("Loan", "clientID"),
                operationType: $scope.vc.channelDefaultValues("Loan", "operationType"),
                clientName: $scope.vc.channelDefaultValues("Loan", "clientName"),
                disbursementDate: $scope.vc.channelDefaultValues("Loan", "disbursementDate"),
                expirationDate: $scope.vc.channelDefaultValues("Loan", "expirationDate"),
                officer: $scope.vc.channelDefaultValues("Loan", "officer"),
                nextPayment: $scope.vc.channelDefaultValues("Loan", "nextPayment"),
                effectiveAnualRate: $scope.vc.channelDefaultValues("Loan", "effectiveAnualRate"),
                amount: $scope.vc.channelDefaultValues("Loan", "amount"),
                adjustment: $scope.vc.channelDefaultValues("Loan", "adjustment"),
                officerID: $scope.vc.channelDefaultValues("Loan", "officerID"),
                office: $scope.vc.channelDefaultValues("Loan", "office"),
                feeEndDate: $scope.vc.channelDefaultValues("Loan", "feeEndDate")
            };
            //ViewState - Group: Group2443
            $scope.vc.createViewState({
                id: "G_LOANHEADOD_564612",
                hasId: true,
                componentStyle: [],
                label: 'Group2443',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_143612",
                componentStyle: [],
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
                componentStyle: [],
                label: 'Group1657',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: loanBankID
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_867612",
                componentStyle: [],
                labelImageId: "",
                label: "ASSTS.LBL_ASSTS_PRSTAMOFK_44930",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVITZRQ_108612",
                componentStyle: [],
                imageId: "glyphicon glyphicon-info-sign",
                label: "ASSTS.LBL_ASSTS_MASINACIN_18792",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONORYJAMS_468612",
                componentStyle: [],
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
                componentStyle: [],
                label: 'Group1848',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_5034UOFCASVGKTK_993612",
                componentStyle: [],
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
                componentStyle: [],
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
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Loan, Attribute: office
            $scope.vc.createViewState({
                id: "VA_7292SEAHPRAXOKC_868612",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_OFICINAHX_44623",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_RSXKZAWLKR_774926",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ExtendsQuotaForm
            $scope.vc.createViewState({
                id: "VC_CHUJBEQPMA_790575",
                hasId: true,
                componentStyle: [],
                label: 'ExtendsQuotaForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1938
            $scope.vc.createViewState({
                id: "G_EXTENDSAUT_547662",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CUOTASPRA_93874",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CurrentQuotas = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    quota: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "quota", 0)
                    },
                    startDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "startDate", '')
                    },
                    endDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "endDate", new Date())
                    },
                    capital: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "capital", 0)
                    },
                    interest: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "interest", 0)
                    },
                    others: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "others", 0)
                    },
                    total: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "total", 0)
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CurrentQuotas", "state", '')
                    }
                }
            });
            $scope.vc.model.CurrentQuotas = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CURRENAT_2921';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CURRENAT_2921();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_2921_98487',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                options.success(result);
                                            } else {
                                                options.success([]);
                                            }
                                        } else {
                                            options.error([]);
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': false,
                                            'pageSize': 0
                                        };

                                        function config(queryOptions, queryView) {
                                            var result = undefined;
                                            if (queryView.allowPaging === true) {
                                                result = {};
                                                if (angular.isDefined(queryOptions.appendRecords) && queryOptions.appendRecords === true) {
                                                    result.appendRecords = true;
                                                }
                                                result.pageSize = queryView.pageSize;
                                            }
                                            return result;
                                        }
                                        return config(queryOptions, queryView);
                                    }()));
                                }
                            }
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.CurrentQuotas
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2921_98487").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CURRENAT_2921 = $scope.vc.model.CurrentQuotas;
            $scope.vc.trackers.CurrentQuotas = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CurrentQuotas);
            $scope.vc.model.CurrentQuotas.bind('change', function(e) {
                $scope.vc.trackers.CurrentQuotas.track(e);
                $scope.vc.grids.QV_2921_98487.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_2921_98487 = {};
            $scope.vc.grids.QV_2921_98487.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_2921_98487) && expandedRowUidActual !== expandedRowUid_QV_2921_98487) {
                    var gridWidget = $('#QV_2921_98487').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_2921_98487 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_2921_98487 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_2921_98487 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_2921_98487);
                }
                expandedRowUid_QV_2921_98487 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_2921_98487', args);
                if (angular.isDefined($scope.vc.grids.QV_2921_98487.view)) {
                    $scope.vc.grids.QV_2921_98487.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_2921_98487.customView)) {
                    $scope.vc.grids.QV_2921_98487.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_2921_98487'/>"
            };
            $scope.vc.grids.QV_2921_98487.queryId = 'Q_CURRENAT_2921';
            $scope.vc.viewState.QV_2921_98487 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2921_98487.column = {};
            var expandedRowUid_QV_2921_98487;
            $scope.vc.grids.QV_2921_98487.editable = false;
            $scope.vc.grids.QV_2921_98487.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.CurrentQuotas.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2921_98487.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.grids.QV_2921_98487.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "CurrentQuotas",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_2921_98487", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_2921_98487", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_2921_98487");
                    $scope.vc.hideShowColumns("QV_2921_98487", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2921_98487.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2921_98487.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2921_98487.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2921_98487 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2921_98487 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_2921_98487.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_2921_98487.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_2921_98487.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_2921_98487.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "CurrentQuotas",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_2921_98487", args);
                        }
                        if (!$scope.$root) {
                            if (e.sender.$angular_scope.$$phase !== '$apply' && e.sender.$angular_scope.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        } else {
                            if ($scope.$root.$$phase !== '$apply' && $scope.$root.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_2921_98487 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2921_98487.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2921_98487.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2921_98487.column.quota = {
                title: 'ASSTS.LBL_ASSTS_CUOTAJJEW_83973',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKUL_165662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT76_QUOTAOPG270 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.quota.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKUL_165662",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.quota.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2921_98487.column.quota.format",
                        'k-decimals': "vc.viewState.QV_2921_98487.column.quota.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2921_98487.column.quota.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.startDate = {
                title: 'ASSTS.LBL_ASSTS_INICIALVX_61306',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDKHVZHE_598662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT20_STARTDAE270 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.startDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDKHVZHE_598662",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.startDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_2921_98487.column.startDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.endDate = {
                title: 'ASSTS.LBL_ASSTS_VENCECLRT_51039',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "dd/MM/yyyy",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDOSHXSD_216662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT65_ENDDATEE270 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.endDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDOSHXSD_216662",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.endDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_2921_98487.column.endDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.capital = {
                title: 'ASSTS.LBL_ASSTS_CAPITALBZ_88457',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEDY_233662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT87_CAPITALL270 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.capital.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEDY_233662",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.capital.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2921_98487.column.capital.format",
                        'k-decimals': "vc.viewState.QV_2921_98487.column.capital.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2921_98487.column.capital.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.interest = {
                title: 'ASSTS.LBL_ASSTS_INTERESWJ_80123',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJTQ_372662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT89_INTERETS270 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.interest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJTQ_372662",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.interest.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2921_98487.column.interest.format",
                        'k-decimals': "vc.viewState.QV_2921_98487.column.interest.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2921_98487.column.interest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.others = {
                title: 'ASSTS.LBL_ASSTS_OTROSRYRP_40547',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNSU_173662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT81_OTHERSPZ270 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.others.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNSU_173662",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.others.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2921_98487.column.others.format",
                        'k-decimals': "vc.viewState.QV_2921_98487.column.others.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2921_98487.column.others.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.total = {
                title: 'ASSTS.LBL_ASSTS_TOTALAOJT_55920',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSKI_427662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT58_TOTALCKB270 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.total.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSKI_427662",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.total.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2921_98487.column.total.format",
                        'k-decimals': "vc.viewState.QV_2921_98487.column.total.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2921_98487.column.total.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2921_98487.column.state = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHJL_257662',
                element: []
            };
            $scope.vc.grids.QV_2921_98487.AT46_STATETIH270 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2921_98487.column.state.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHJL_257662",
                        'data-validation-code': "{{vc.viewState.QV_2921_98487.column.state.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2921_98487.column.state.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'quota',
                    title: '{{vc.viewState.QV_2921_98487.column.quota.title|translate:vc.viewState.QV_2921_98487.column.quota.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.quota.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.quota.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT76_QUOTAOPG270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.quota.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quota, \"QV_2921_98487\", \"quota\"):kendo.toString(#=quota#, vc.viewState.QV_2921_98487.column.quota.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2921_98487.column.quota.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.quota.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.quota.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'startDate',
                    title: '{{vc.viewState.QV_2921_98487.column.startDate.title|translate:vc.viewState.QV_2921_98487.column.startDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.startDate.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.startDate.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT20_STARTDAE270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.startDate.style' ng-bind='vc.getStringColumnFormat(dataItem.startDate, \"QV_2921_98487\", \"startDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2921_98487.column.startDate.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.startDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.startDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'endDate',
                    title: '{{vc.viewState.QV_2921_98487.column.endDate.title|translate:vc.viewState.QV_2921_98487.column.endDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.endDate.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.endDate.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT65_ENDDATEE270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.endDate.style'>#=((endDate !== null) ? kendo.toString(endDate, 'dd/MM/yyyy') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2921_98487.column.endDate.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.endDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.endDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'capital',
                    title: '{{vc.viewState.QV_2921_98487.column.capital.title|translate:vc.viewState.QV_2921_98487.column.capital.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.capital.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.capital.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT87_CAPITALL270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.capital.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.capital, \"QV_2921_98487\", \"capital\"):kendo.toString(#=capital#, vc.viewState.QV_2921_98487.column.capital.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2921_98487.column.capital.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.capital.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.capital.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'interest',
                    title: '{{vc.viewState.QV_2921_98487.column.interest.title|translate:vc.viewState.QV_2921_98487.column.interest.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.interest.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.interest.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT89_INTERETS270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.interest.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interest, \"QV_2921_98487\", \"interest\"):kendo.toString(#=interest#, vc.viewState.QV_2921_98487.column.interest.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2921_98487.column.interest.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.interest.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.interest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'others',
                    title: '{{vc.viewState.QV_2921_98487.column.others.title|translate:vc.viewState.QV_2921_98487.column.others.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.others.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.others.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT81_OTHERSPZ270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.others.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.others, \"QV_2921_98487\", \"others\"):kendo.toString(#=others#, vc.viewState.QV_2921_98487.column.others.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2921_98487.column.others.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.others.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.others.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'total',
                    title: '{{vc.viewState.QV_2921_98487.column.total.title|translate:vc.viewState.QV_2921_98487.column.total.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.total.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.total.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT58_TOTALCKB270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.total.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.total, \"QV_2921_98487\", \"total\"):kendo.toString(#=total#, vc.viewState.QV_2921_98487.column.total.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2921_98487.column.total.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.total.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.total.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2921_98487.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_2921_98487.column.state.title|translate:vc.viewState.QV_2921_98487.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_2921_98487.column.state.width,
                    format: $scope.vc.viewState.QV_2921_98487.column.state.format,
                    editor: $scope.vc.grids.QV_2921_98487.AT46_STATETIH270.control,
                    template: "<span ng-class='vc.viewState.QV_2921_98487.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_2921_98487\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2921_98487.column.state.style",
                        "title": "{{vc.viewState.QV_2921_98487.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2921_98487.column.state.hidden
                });
            }
            $scope.vc.viewState.QV_2921_98487.toolbar = {}
            $scope.vc.grids.QV_2921_98487.toolbar = [];
            $scope.vc.model.ExtendsQuota = {
                extendsDate: $scope.vc.channelDefaultValues("ExtendsQuota", "extendsDate"),
                maximumDateExtended: $scope.vc.channelDefaultValues("ExtendsQuota", "maximumDateExtended"),
                numberQuota: $scope.vc.channelDefaultValues("ExtendsQuota", "numberQuota"),
                expirationDate: $scope.vc.channelDefaultValues("ExtendsQuota", "expirationDate"),
                processDate: $scope.vc.channelDefaultValues("ExtendsQuota", "processDate")
            };
            //ViewState - Group: Group2880
            $scope.vc.createViewState({
                id: "G_EXTENDSAUQ_349662",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRORROGAA_86150",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ExtendsQuota, Attribute: extendsDate
            $scope.vc.createViewState({
                id: "Spacer2497",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAPROO_65875",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExtendsQuota, Attribute: maximumDateExtended
            $scope.vc.createViewState({
                id: "Spacer2749",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAMXRR_98674",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1998
            $scope.vc.createViewState({
                id: "G_EXTENDSUUA_352662",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_VISTAPROA_84149",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.ExtendsQuotaExt = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    quotaExt: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "quotaExt", 0)
                    },
                    startDateExt: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "startDateExt", '')
                    },
                    endDateExt: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "endDateExt", '')
                    },
                    capitalExt: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "capitalExt", 0)
                    },
                    interestExt: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "interestExt", 0)
                    },
                    others: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "others", 0)
                    },
                    total: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "total", 0)
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExtendsQuotaExt", "state", '')
                    }
                }
            });
            $scope.vc.model.ExtendsQuotaExt = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_EXTENDEX_5312';
                            var queryRequest = $scope.vc.getRequestQuery_Q_EXTENDEX_5312();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5312_48027',
                                    queryRequest,
                                    queryRequest.mainEntityPk.entityId,
                                    true,

                                    function(response) {
                                        if (response.success) {
                                            var result = response.data['RESULT' + queryId];
                                            if (angular.isUndefined(result)) {
                                                result = [];
                                            }
                                            if (angular.isDefined(result) && angular.isArray(result)) {
                                                options.success(result);
                                            } else {
                                                options.success([]);
                                            }
                                        } else {
                                            options.error([]);
                                        }
                                    }, (function() {
                                        var queryOptions = options.data;
                                        var queryView = {
                                            'allowPaging': false,
                                            'pageSize': 0
                                        };

                                        function config(queryOptions, queryView) {
                                            var result = undefined;
                                            if (queryView.allowPaging === true) {
                                                result = {};
                                                if (angular.isDefined(queryOptions.appendRecords) && queryOptions.appendRecords === true) {
                                                    result.appendRecords = true;
                                                }
                                                result.pageSize = queryView.pageSize;
                                            }
                                            return result;
                                        }
                                        return config(queryOptions, queryView);
                                    }()));
                                }
                            }
                        }
                        if (promise === false) {
                            options.error({
                                xhr: {}
                            });
                        }
                    },
                    create: function(options) {
                        var model = options.data;
                        model.dsgnrId = designer.utils.uuid();
                        options.success(model);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.ExtendsQuotaExt
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5312_48027").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EXTENDEX_5312 = $scope.vc.model.ExtendsQuotaExt;
            $scope.vc.trackers.ExtendsQuotaExt = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ExtendsQuotaExt);
            $scope.vc.model.ExtendsQuotaExt.bind('change', function(e) {
                $scope.vc.trackers.ExtendsQuotaExt.track(e);
            });
            $scope.vc.grids.QV_5312_48027 = {};
            $scope.vc.grids.QV_5312_48027.queryId = 'Q_EXTENDEX_5312';
            $scope.vc.viewState.QV_5312_48027 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5312_48027.column = {};
            $scope.vc.grids.QV_5312_48027.editable = false;
            $scope.vc.grids.QV_5312_48027.events = {
                customRowClick: function(e, controlId, entity, idGrid, commandName) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false,
                        commandName: commandName
                    };
                    $scope.vc.executeGridRowCommand(controlId, args);
                    if (args.refreshData) {
                        grid.refresh();
                    }
                    if (args.stopPropagation) {
                        e.stopImmediatePropagation();
                        e.stopPropagation();
                    }
                },
                cancel: function(e) {
                    $scope.vc.trackers.ExtendsQuotaExt.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_5312_48027.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index === -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index === -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index === -1) {
                                commandCell = e.container.find("td:last");
                                index = commandCell.index();
                            } else {
                                commandCell = e.container.find("td > a.k-grid-update").parent();
                            }
                        } else {
                            commandCell = e.container.find("td > span.cb-commands").parent();
                        }
                    } else {
                        commandCell = e.container.find("td > a.k-grid-update").parent();
                    }
                    var titleUpdate = $filter('translate')('DSGNR.SYS_DSGNR_LBLACEPT0_00007');
                    var titleCancel = $filter('translate')('DSGNR.SYS_DSGNR_LBLCANCEL_00006');
                    commandCell.html("<a class='btn btn-default k-grid-update cb-row-image-button' title='" + titleUpdate + "' href='#'><span class='glyphicon glyphicon-ok-sign'></span></a><a class='btn btn-default k-grid-cancel cb-row-image-button' title='" + titleCancel + "' href='#'><span class='glyphicon glyphicon-remove-sign'></span></a>");
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_5312_48027");
                    $scope.vc.hideShowColumns("QV_5312_48027", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5312_48027.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5312_48027.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5312_48027.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5312_48027 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5312_48027 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5312_48027.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5312_48027.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5312_48027.column.quotaExt = {
                title: 'ASSTS.LBL_ASSTS_CUOTAJJEW_83973',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQAR_993662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT98_QUOTAEXX507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.quotaExt.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQAR_993662",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.quotaExt.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5312_48027.column.quotaExt.format",
                        'k-decimals': "vc.viewState.QV_5312_48027.column.quotaExt.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5312_48027.column.quotaExt.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.startDateExt = {
                title: 'ASSTS.LBL_ASSTS_INICIALVX_61306',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDENSHZO_505662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT17_STARTDAE507 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.startDateExt.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDENSHZO_505662",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.startDateExt.validationCode}}",
                        'ng-class': "vc.viewState.QV_5312_48027.column.startDateExt.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.endDateExt = {
                title: 'ASSTS.LBL_ASSTS_VENCECLRT_51039',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDXYSJRW_527662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT96_ENDDATEE507 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.endDateExt.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDXYSJRW_527662",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.endDateExt.validationCode}}",
                        'ng-class': "vc.viewState.QV_5312_48027.column.endDateExt.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.capitalExt = {
                title: 'ASSTS.LBL_ASSTS_CAPITALBZ_88457',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRQU_339662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT14_CAPITALL507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.capitalExt.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRQU_339662",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.capitalExt.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5312_48027.column.capitalExt.format",
                        'k-decimals': "vc.viewState.QV_5312_48027.column.capitalExt.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5312_48027.column.capitalExt.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.interestExt = {
                title: 'ASSTS.LBL_ASSTS_INTERESWJ_80123',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQSF_971662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT23_INTERESX507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.interestExt.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQSF_971662",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.interestExt.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5312_48027.column.interestExt.format",
                        'k-decimals': "vc.viewState.QV_5312_48027.column.interestExt.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5312_48027.column.interestExt.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.others = {
                title: 'ASSTS.LBL_ASSTS_OTROSRYRP_40547',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXENP_579662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT65_OTHERSEU507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.others.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXENP_579662",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.others.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5312_48027.column.others.format",
                        'k-decimals': "vc.viewState.QV_5312_48027.column.others.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5312_48027.column.others.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.total = {
                title: 'ASSTS.LBL_ASSTS_TOTALAOJT_55920',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVFS_528662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT96_TOTALVQB507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.total.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVFS_528662",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.total.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5312_48027.column.total.format",
                        'k-decimals': "vc.viewState.QV_5312_48027.column.total.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5312_48027.column.total.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5312_48027.column.state = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDCK_638662',
                element: []
            };
            $scope.vc.grids.QV_5312_48027.AT37_STATENUW507 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5312_48027.column.state.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDCK_638662",
                        'data-validation-code': "{{vc.viewState.QV_5312_48027.column.state.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5312_48027.column.state.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'quotaExt',
                    title: '{{vc.viewState.QV_5312_48027.column.quotaExt.title|translate:vc.viewState.QV_5312_48027.column.quotaExt.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.quotaExt.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.quotaExt.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT98_QUOTAEXX507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.quotaExt.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.quotaExt, \"QV_5312_48027\", \"quotaExt\"):kendo.toString(#=quotaExt#, vc.viewState.QV_5312_48027.column.quotaExt.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5312_48027.column.quotaExt.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.quotaExt.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.quotaExt.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'startDateExt',
                    title: '{{vc.viewState.QV_5312_48027.column.startDateExt.title|translate:vc.viewState.QV_5312_48027.column.startDateExt.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.startDateExt.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.startDateExt.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT17_STARTDAE507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.startDateExt.style' ng-bind='vc.getStringColumnFormat(dataItem.startDateExt, \"QV_5312_48027\", \"startDateExt\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5312_48027.column.startDateExt.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.startDateExt.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.startDateExt.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'endDateExt',
                    title: '{{vc.viewState.QV_5312_48027.column.endDateExt.title|translate:vc.viewState.QV_5312_48027.column.endDateExt.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.endDateExt.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.endDateExt.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT96_ENDDATEE507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.endDateExt.style' ng-bind='vc.getStringColumnFormat(dataItem.endDateExt, \"QV_5312_48027\", \"endDateExt\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5312_48027.column.endDateExt.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.endDateExt.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.endDateExt.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'capitalExt',
                    title: '{{vc.viewState.QV_5312_48027.column.capitalExt.title|translate:vc.viewState.QV_5312_48027.column.capitalExt.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.capitalExt.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.capitalExt.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT14_CAPITALL507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.capitalExt.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.capitalExt, \"QV_5312_48027\", \"capitalExt\"):kendo.toString(#=capitalExt#, vc.viewState.QV_5312_48027.column.capitalExt.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5312_48027.column.capitalExt.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.capitalExt.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.capitalExt.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'interestExt',
                    title: '{{vc.viewState.QV_5312_48027.column.interestExt.title|translate:vc.viewState.QV_5312_48027.column.interestExt.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.interestExt.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.interestExt.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT23_INTERESX507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.interestExt.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interestExt, \"QV_5312_48027\", \"interestExt\"):kendo.toString(#=interestExt#, vc.viewState.QV_5312_48027.column.interestExt.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5312_48027.column.interestExt.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.interestExt.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.interestExt.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'others',
                    title: '{{vc.viewState.QV_5312_48027.column.others.title|translate:vc.viewState.QV_5312_48027.column.others.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.others.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.others.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT65_OTHERSEU507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.others.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.others, \"QV_5312_48027\", \"others\"):kendo.toString(#=others#, vc.viewState.QV_5312_48027.column.others.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5312_48027.column.others.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.others.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.others.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'total',
                    title: '{{vc.viewState.QV_5312_48027.column.total.title|translate:vc.viewState.QV_5312_48027.column.total.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.total.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.total.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT96_TOTALVQB507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.total.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.total, \"QV_5312_48027\", \"total\"):kendo.toString(#=total#, vc.viewState.QV_5312_48027.column.total.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5312_48027.column.total.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.total.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.total.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5312_48027.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_5312_48027.column.state.title|translate:vc.viewState.QV_5312_48027.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_5312_48027.column.state.width,
                    format: $scope.vc.viewState.QV_5312_48027.column.state.format,
                    editor: $scope.vc.grids.QV_5312_48027.AT37_STATENUW507.control,
                    template: "<span ng-class='vc.viewState.QV_5312_48027.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_5312_48027\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5312_48027.column.state.style",
                        "title": "{{vc.viewState.QV_5312_48027.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5312_48027.column.state.hidden
                });
            }
            $scope.vc.viewState.QV_5312_48027.toolbar = {}
            $scope.vc.grids.QV_5312_48027.toolbar = [];
            //ViewState - Group: Group1667
            $scope.vc.createViewState({
                id: "G_EXTENDSATA_926662",
                hasId: true,
                componentStyle: [],
                label: 'Group1667',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: ExtendsQuota, Attribute: numberQuota
            $scope.vc.createViewState({
                id: "VA_NUMBERQUOTAHUXZ_811662",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExtendsQuota, Attribute: expirationDate
            $scope.vc.createViewState({
                id: "VA_EXPIRATIONDAETE_519662",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_EXTENDSQUONTA_926_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_EXTENDSQUONTA_926_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_EXTENDSQ_O3T",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRORROGRR_30298",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
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
                $scope.vc.render('VC_EXTENDSQMN_712926');
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
                    if (($scope.vc.hasOnCloseModalEvent && angular.isDefined($scope.vc.dialogParameters.autoSync) && $scope.vc.dialogParameters.autoSync === false) && ($scope.vc.dialogResponse || $scope.vc.customDialogResponse)) {
                        $scope.vc.onCloseModalEvent();
                    }
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
    var cobisMainModule = cobis.createModule("VC_EXTENDSQMN_712926", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_EXTENDSQMN_712926", {
            templateUrl: "VC_EXTENDSQMN_712926_FORM.html",
            controller: "VC_EXTENDSQMN_712926_CTRL",
            label: "ViewContainerBase",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_EXTENDSQMN_712926?" + $.param(search);
            }
        });
        VC_EXTENDSQMN_712926(cobisMainModule);
    }]);
} else {
    VC_EXTENDSQMN_712926(cobisMainModule);
}