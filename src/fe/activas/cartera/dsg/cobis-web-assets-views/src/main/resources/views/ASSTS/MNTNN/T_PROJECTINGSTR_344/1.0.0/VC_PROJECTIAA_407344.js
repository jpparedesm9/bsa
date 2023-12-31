//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.othercharges = designerEvents.api.othercharges || designer.dsgEvents();

function VC_PROJECTIAA_407344(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PROJECTIAA_407344_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PROJECTIAA_407344_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_PROJECTINGSTR_344",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PROJECTIAA_407344",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_PROJECTINGSTR_344",
        designerEvents.api.othercharges,
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
                vcName: 'VC_PROJECTIAA_407344'
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
                    taskId: 'T_PROJECTINGSTR_344',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Loan: "Loan",
                    OtherCharges: "OtherCharges",
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
                    OtherCharges: {
                        sequential: 'AT21_SECUENCL824',
                        iniDiv: 'AT93_DIVINIAI824',
                        divUp: 'AT46_DIVFINAA824',
                        date: 'AT48_FECHAXAR824',
                        concept: 'AT57_CONCEPTO824',
                        value: 'AT67_VALORAAB824',
                        commentary: 'AT94_REFEREAA824',
                        categoryType: 'AT72_CATEGORE824',
                        valueApply: 'AT24_VALUEALY824',
                        reference: 'AT93_REFERENE824',
                        valueMin: 'AT26_VALUEMIN824',
                        valueMax: 'AT58_VALUEMXX824',
                        baseCalculation: 'AT70_BASECATL824',
                        balanceOp: 'AT43_BALANCEP824',
                        balanceDesemp: 'AT46_BALANCSP824',
                        rate: 'AT65_RATEKOZZ824',
                        decTapl: 'AT71_DECTAPLL824',
                        range: 'AT32_RANGEVRU824',
                        _pks: [],
                        _entityId: 'EN_INGOTRCSA_824',
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
            $scope.vc.queryProperties.Q_INGOTRSR_8396 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_INGOTRSR_8396 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_INGOTRSR_8396_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_INGOTRSR_8396_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_INGOTRCSA_824',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_INGOTRSR_8396',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_INGOTRSR_8396_filters = {};
            var defaultValues = {
                Loan: {},
                OtherCharges: {},
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
                $scope.vc.execute("temporarySave", VC_PROJECTIAA_407344, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PROJECTIAA_407344, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PROJECTIAA_407344, data, function() {});
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
            $scope.vc.viewState.VC_PROJECTIAA_407344 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PROJECTIAA_407344",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_INGRESOOR_92676",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_UJNNOFLWUJ_608344",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LoanHeaderInfoForm
            $scope.vc.createViewState({
                id: "VC_OWPOFVEWRD_797316",
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
            //ViewState - Container: ProjectionIngresoOtrosCargosForm
            $scope.vc.createViewState({
                id: "VC_IHHMDIPYBG_286425",
                hasId: true,
                componentStyle: [],
                label: 'ProjectionIngresoOtrosCargosForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group2267
            $scope.vc.createViewState({
                id: "G_PROJECTOOG_992888",
                hasId: true,
                componentStyle: [],
                label: 'Group2267',
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.OtherCharges = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    sequential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "sequential", 0)
                    },
                    iniDiv: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "iniDiv", 0),
                        validation: {
                            iniDivRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    divUp: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "divUp", 0),
                        validation: {
                            divUpRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    date: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "date", new Date())
                    },
                    concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "concept", ''),
                        validation: {
                            conceptRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "value", 0),
                        validation: {
                            valueRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    commentary: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("OtherCharges", "commentary", ''),
                        validation: {
                            commentaryRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.OtherCharges = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_INGOTRSR_8396';
                            var queryRequest = $scope.vc.getRequestQuery_Q_INGOTRSR_8396();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_8396_63374',
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
                                            'allowPaging': true,
                                            'pageSize': 10
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
                    model: $scope.vc.types.OtherCharges
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_8396_63374").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_INGOTRSR_8396 = $scope.vc.model.OtherCharges;
            $scope.vc.trackers.OtherCharges = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.OtherCharges);
            $scope.vc.model.OtherCharges.bind('change', function(e) {
                $scope.vc.trackers.OtherCharges.track(e);
            });
            $scope.vc.grids.QV_8396_63374 = {};
            $scope.vc.grids.QV_8396_63374.queryId = 'Q_INGOTRSR_8396';
            $scope.vc.viewState.QV_8396_63374 = {
                style: undefined
            };
            $scope.vc.viewState.QV_8396_63374.column = {};
            $scope.vc.grids.QV_8396_63374.editable = {
                mode: 'inline',
            };
            $scope.vc.grids.QV_8396_63374.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.OtherCharges(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_TESTWKHELVLBD_756",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_TESTBKYOLO_973756',
                        title: ''
                    };
                    $scope.vc.beforeOpenGridDialog("QV_8396_63374", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "ASSTS",
                        subModuleId: "MNTNN",
                        taskId: "T_TESTWKHELVLBD_756",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_TESTBKYOLO_973756',
                        title: ''
                    };
                    $scope.vc.beforeOpenGridDialog("QV_8396_63374", dialogParameters);
                },
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_8396_63374");
                    $scope.vc.hideShowColumns("QV_8396_63374", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_8396_63374.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_8396_63374.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_8396_63374.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_8396_63374 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_8396_63374 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_8396_63374.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_8396_63374.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_8396_63374.column.sequential = {
                title: 'ASSTS.LBL_ASSTS_SECUENCAA_14570',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVRY_167888',
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.iniDiv = {
                title: 'ASSTS.LBL_ASSTS_DIVINICII_26095',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXFHW_169888',
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.divUp = {
                title: 'ASSTS.LBL_ASSTS_DIVHASTAA_21887',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXCDO_902888',
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.date = {
                title: 'ASSTS.LBL_ASSTS_FECHAQWBP_23514',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDZFVCGN_770888',
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.concept = {
                title: 'concepto',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXYVX_228888',
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.value = {
                title: 'valor',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXPSH_886888',
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.commentary = {
                title: 'referencia',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXRKL_324888',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'sequential',
                    title: '{{vc.viewState.QV_8396_63374.column.sequential.title|translate:vc.viewState.QV_8396_63374.column.sequential.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.sequential.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.sequential.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.sequential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sequential, \"QV_8396_63374\", \"sequential\"):kendo.toString(#=sequential#, vc.viewState.QV_8396_63374.column.sequential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8396_63374.column.sequential.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.sequential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.sequential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'iniDiv',
                    title: '{{vc.viewState.QV_8396_63374.column.iniDiv.title|translate:vc.viewState.QV_8396_63374.column.iniDiv.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.iniDiv.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.iniDiv.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.iniDiv.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.iniDiv, \"QV_8396_63374\", \"iniDiv\"):kendo.toString(#=iniDiv#, vc.viewState.QV_8396_63374.column.iniDiv.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8396_63374.column.iniDiv.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.iniDiv.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.iniDiv.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'divUp',
                    title: '{{vc.viewState.QV_8396_63374.column.divUp.title|translate:vc.viewState.QV_8396_63374.column.divUp.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.divUp.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.divUp.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.divUp.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.divUp, \"QV_8396_63374\", \"divUp\"):kendo.toString(#=divUp#, vc.viewState.QV_8396_63374.column.divUp.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8396_63374.column.divUp.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.divUp.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.divUp.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'date',
                    title: '{{vc.viewState.QV_8396_63374.column.date.title|translate:vc.viewState.QV_8396_63374.column.date.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.date.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.date.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.date.style'>#=((date !== null) ? kendo.toString(date, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8396_63374.column.date.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'concept',
                    title: '{{vc.viewState.QV_8396_63374.column.concept.title|translate:vc.viewState.QV_8396_63374.column.concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.concept.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.concept.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.concept.style' ng-bind='vc.getStringColumnFormat(dataItem.concept, \"QV_8396_63374\", \"concept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8396_63374.column.concept.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'value',
                    title: '{{vc.viewState.QV_8396_63374.column.value.title|translate:vc.viewState.QV_8396_63374.column.value.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.value.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.value.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.value.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.value, \"QV_8396_63374\", \"value\"):kendo.toString(#=value#, vc.viewState.QV_8396_63374.column.value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_8396_63374.column.value.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.value.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_8396_63374.columns.push({
                    field: 'commentary',
                    title: '{{vc.viewState.QV_8396_63374.column.commentary.title|translate:vc.viewState.QV_8396_63374.column.commentary.titleArgs}}',
                    width: $scope.vc.viewState.QV_8396_63374.column.commentary.width,
                    format: $scope.vc.viewState.QV_8396_63374.column.commentary.format,
                    template: "<span ng-class='vc.viewState.QV_8396_63374.column.commentary.style' ng-bind='vc.getStringColumnFormat(dataItem.commentary, \"QV_8396_63374\", \"commentary\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_8396_63374.column.commentary.style",
                        "title": "{{vc.viewState.QV_8396_63374.column.commentary.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_8396_63374.column.commentary.hidden
                });
            }
            $scope.vc.viewState.QV_8396_63374.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_8396_63374.column.cmdEdition = {};
            $scope.vc.viewState.QV_8396_63374.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_8396_63374.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "OtherCharges",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_8396_63374.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_8396_63374.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_PROJECTOOG_992888.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_8396_63374.events.customEdit($event, \"#:entity#\", grids.QV_8396_63374)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_8396_63374.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_8396_63374.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_8396_63374.toolbar = [{
                "name": "create",
                "entity": "OtherCharges",
                "text": "",
                "template": "<button id = 'QV_8396_63374_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_8396_63374.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_PROJECTOOG_992888.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_8396_63374.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            $scope.vc.model.LoanInstancia = {
                idInstancia: $scope.vc.channelDefaultValues("LoanInstancia", "idInstancia"),
                idOptionMenu: $scope.vc.channelDefaultValues("LoanInstancia", "idOptionMenu"),
                errorValidation: $scope.vc.channelDefaultValues("LoanInstancia", "errorValidation")
            };
            //ViewState - Group: Group1387
            $scope.vc.createViewState({
                id: "G_PROJECTGCI_425888",
                hasId: true,
                componentStyle: [],
                label: 'Group1387',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1989",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PROJECTINGSTR_344_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PROJECTINGSTR_344_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
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
                $scope.vc.render('VC_PROJECTIAA_407344');
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
    var cobisMainModule = cobis.createModule("VC_PROJECTIAA_407344", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_PROJECTIAA_407344", {
            templateUrl: "VC_PROJECTIAA_407344_FORM.html",
            controller: "VC_PROJECTIAA_407344_CTRL",
            labelId: "ASSTS.LBL_ASSTS_INGRESOOR_92676",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PROJECTIAA_407344?" + $.param(search);
            }
        });
        VC_PROJECTIAA_407344(cobisMainModule);
    }]);
} else {
    VC_PROJECTIAA_407344(cobisMainModule);
}