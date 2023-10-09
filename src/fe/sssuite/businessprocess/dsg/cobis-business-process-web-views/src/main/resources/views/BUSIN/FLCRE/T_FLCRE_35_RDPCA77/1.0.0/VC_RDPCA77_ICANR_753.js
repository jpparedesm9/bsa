<!-- Designer Generator v 5.1.0.1608 - release SPR 2016-08 29/04/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.approvedapplication = designerEvents.api.approvedapplication || designer.dsgEvents();

function VC_RDPCA77_ICANR_753(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RDPCA77_ICANR_753_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RDPCA77_ICANR_753_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
        $scope.kendo = kendo;
        //Lectura de Preferencias Visuales del Usuario, si no existen se aplican unas por default
        $scope.currencySymbol = kendo.cultures.current.numberFormat.currency.symbol;
        if (preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)) {
            $scope.currencySymbol = preferencesService.getGlobalization(cobis.constant.CURRENCY_SYMBOL)
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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_35_RDPCA77",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RDPCA77_ICANR_753",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_35_RDPCA77",
        designerEvents.api.approvedapplication,
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
                vcName: 'VC_RDPCA77_ICANR_753'
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
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_35_RDPCA77',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    VariablePolicy: "VariablePolicy",
                    Exceptions: "Exceptions",
                    Context: "Context",
                    OriginalHeader: "OriginalHeader",
                    Policy: "Policy",
                    VariableExceptions: "VariableExceptions"
                },
                entities: {
                    VariablePolicy: {
                        VariableName: 'AT_VAR396ILEA09',
                        VariableValue: 'AT_VAR396VILV60',
                        VariableRule: 'AT_VAR396ALRL41',
                        VariableDescription: 'AT_VAR396BSCT95',
                        _pks: [],
                        _entityId: 'EN_VARBLEPCY396',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Exceptions: {
                        mnemonic: 'AT_EXC513NONI25',
                        description: 'AT_EXC513RTIO01',
                        Aproved: 'AT_EXC513EULT52',
                        Authorized: 'AT_EXC513UOIZ62',
                        detail: 'AT_EXC513DETA22',
                        Type: 'AT_EXC513TYPE30',
                        Observations: 'AT_EXC513SETO85',
                        Official: 'AT_EXC513OCIA20',
                        Activity: 'AT_EXC513AVIT49',
                        EndDate: 'AT_EXC513ENTE92',
                        _pks: [],
                        _entityId: 'EN_EXCEPTINS513',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        Application: 'AT_CON762APCI65',
                        ApplicationSubject: 'AT_CON762ACAO34',
                        RequestId: 'AT_CON762EUTD32',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        CustomerId: 'AT_CON762CSTE68',
                        Bookmark: 'AT_CON762BKAK11',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        TaskSubject: 'AT_CON762TSUT41',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OriginalHeader: {
                        IDRequested: 'AT_RIG477RQSD66',
                        Office: 'AT_RIG477FICE32',
                        CityCode: 'AT_RIG477ITCE46',
                        AmountRequested: 'AT_RIG477OQUE10',
                        CurrencyRequested: 'AT_RIG477URQT91',
                        Quota: 'AT_RIG477QUOA32',
                        PaymentFrequency: 'AT_RIG477NQUE49',
                        CreditTarget: 'AT_RIG477CRET05',
                        InitialDate: 'AT_RIG477IALT55',
                        ApplicationNumber: 'AT_RIG477IOUR00',
                        UserL: 'AT_RIG477USRL75',
                        Country: 'AT_RIG477COTR74',
                        Province: 'AT_RIG477OINC84',
                        Term: 'AT_RIG477TERM59',
                        TypeRequest: 'AT_RIG477YPRU27',
                        OfficerName: 'AT_RIG477FNME01',
                        NumberLine: 'AT_RIG477NMLN54',
                        AmountApproved: 'AT_RIG477AUPR26',
                        OpNumberBank: 'AT_RIG477NRAK86',
                        StatusRequested: 'AT_RIG477SAUT78',
                        Expromission: 'AT_RIG477XSIN84',
                        ReasonRefinancing: 'AT_RIG477AONN01',
                        CityCredit: 'AT_RIG477CIDI98',
                        CreditSector: 'AT_RIG477EDCT30',
                        ClientSector: 'AT_RIG477LIEN42',
                        OfficerId: 'AT_RIG477OERD27',
                        AmountRequestedML: 'AT_RIG477ONTD67',
                        stageflux: 'AT_RIG477AGFX85',
                        ProductType: 'AT_RIG477PEOE42',
                        Type: 'AT_RIG477TYPE69',
                        CreditLineValid: 'AT_RIG477EVAL88',
                        Agreement: 'AT_RIG477REEM93',
                        CodeAgreement: 'AT_RIG477REET12',
                        RejectionReason: 'AT_RIG477EIEA32',
                        RequestLine: 'AT_RIG477UTIN05',
                        ProductFIE: 'AT_RIG477RUCE24',
                        HousingCount: 'AT_RIG477GCUN35',
                        ScoreType: 'AT_RIG477SOET77',
                        Score: 'AT_RIG477SCOR35',
                        IsWarrantyDestination: 'AT_RIG477DSIN93',
                        IsDebtorOwner: 'AT_RIG477IBTO19',
                        AmountAprobed: 'AT_RIG477MICI25',
                        TermLimit: 'AT_RIG477TEIM91',
                        ActivityNumber: 'AT_RIG477IIMB92',
                        _pks: [],
                        _entityId: 'EN_RIGNLEADE477',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    Policy: {
                        mnemonic: 'AT_POL965NMNI98',
                        description: 'AT_POL965DRTO65',
                        result: 'AT_POL965RELT93',
                        detail: 'AT_POL965DETA90',
                        _pks: [],
                        _entityId: 'EN_POLICYKGO965',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    VariableExceptions: {
                        VariableName: 'AT_ABL836RABM62',
                        VariableValue: 'AT_ABL836VBLE29',
                        VariableRule: 'AT_ABL836LELE47',
                        VariableDescription: 'AT_ABL836RSCP88',
                        _pks: [],
                        _entityId: 'EN_ABLEECPTO836',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_UERXCPTS_4756 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UERXCPTS_4756 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UERXCPTS_4756_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UERXCPTS_4756_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_EXCEPTINS513',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UERXCPTS_4756',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_UERXCPTS_4756_filters = {};
            $scope.vc.queryProperties.Q_UEVRBPOC_5831 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UEVRBPOC_5831 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UEVRBPOC_5831_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UEVRBPOC_5831_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_VARBLEPCY396',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UEVRBPOC_5831',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_UEVRBPOC_5831_filters = {};
            $scope.vc.queryProperties.Q_EAIBLEEP_2309 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_EAIBLEEP_2309 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_EAIBLEEP_2309_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_EAIBLEEP_2309_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_ABLEECPTO836',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_EAIBLEEP_2309',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_EAIBLEEP_2309_filters = {};
            $scope.vc.queryProperties.Q_QUEROLCY_4480 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_QUEROLCY_4480 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUEROLCY_4480_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUEROLCY_4480_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_POLICYKGO965',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUEROLCY_4480',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters = {};
                        }
                    }
                }
            };
            $scope.vc.queries.Q_QUEROLCY_4480_filters = {};
            defaultValues = {
                VariablePolicy: {},
                Exceptions: {},
                Context: {},
                OriginalHeader: {},
                Policy: {},
                VariableExceptions: {}
            };
            $scope.vc.channelDefaultValues = function(entityName, attributeName, valueIfNotExist) {
                var channel = $scope.vc.args.channel;
                for (en in defaultValues) {
                    if (en == entityName) {
                        for (att in defaultValues[en]) {
                            if (att == attributeName) {
                                for (ch in defaultValues[en][att]) {
                                    if (ch == channel) {
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
            }
            $scope.vc.temporarySave = function() {
                console.log("temporarySave");
                var modelo = $scope.vc.cleanData($scope.vc.model);
                var data = {
                    model: modelo,
                    trackers: $scope.vc.trackers,
                    temporaryStorePK: $scope.vc.metadata.taskPk
                }
                $scope.vc.execute("temporarySave", null, data, function(response) {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    console.log("readTemporaryData");
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    }
                    return $scope.vc.executeService("readTemporaryData", null, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", null, data, function(response) {});
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
            $scope.vc.viewState.VC_RDPCA77_ICANR_753 = {
                style: []
            }
            //ViewState - Container: PoliciesAndExceptionsForm
            $scope.vc.createViewState({
                id: "VC_RDPCA77_ICANR_753",
                hasId: true,
                componentStyle: "",
                label: 'PoliciesAndExceptionsForm',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: headerTskGrp
            $scope.vc.createViewState({
                id: "VC_RDPCA77_HEAES_140",
                hasId: true,
                componentStyle: "cabecera",
                label: 'headerTskGrp',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.OriginalHeader = {
                IDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "IDRequested"),
                Office: $scope.vc.channelDefaultValues("OriginalHeader", "Office"),
                CityCode: $scope.vc.channelDefaultValues("OriginalHeader", "CityCode"),
                AmountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequested"),
                CurrencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "CurrencyRequested"),
                Quota: $scope.vc.channelDefaultValues("OriginalHeader", "Quota"),
                PaymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "PaymentFrequency"),
                CreditTarget: $scope.vc.channelDefaultValues("OriginalHeader", "CreditTarget"),
                InitialDate: $scope.vc.channelDefaultValues("OriginalHeader", "InitialDate"),
                ApplicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ApplicationNumber"),
                UserL: $scope.vc.channelDefaultValues("OriginalHeader", "UserL"),
                Country: $scope.vc.channelDefaultValues("OriginalHeader", "Country"),
                Province: $scope.vc.channelDefaultValues("OriginalHeader", "Province"),
                Term: $scope.vc.channelDefaultValues("OriginalHeader", "Term"),
                TypeRequest: $scope.vc.channelDefaultValues("OriginalHeader", "TypeRequest"),
                OfficerName: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerName"),
                NumberLine: $scope.vc.channelDefaultValues("OriginalHeader", "NumberLine"),
                AmountApproved: $scope.vc.channelDefaultValues("OriginalHeader", "AmountApproved"),
                OpNumberBank: $scope.vc.channelDefaultValues("OriginalHeader", "OpNumberBank"),
                StatusRequested: $scope.vc.channelDefaultValues("OriginalHeader", "StatusRequested"),
                Expromission: $scope.vc.channelDefaultValues("OriginalHeader", "Expromission"),
                ReasonRefinancing: $scope.vc.channelDefaultValues("OriginalHeader", "ReasonRefinancing"),
                CityCredit: $scope.vc.channelDefaultValues("OriginalHeader", "CityCredit"),
                CreditSector: $scope.vc.channelDefaultValues("OriginalHeader", "CreditSector"),
                ClientSector: $scope.vc.channelDefaultValues("OriginalHeader", "ClientSector"),
                OfficerId: $scope.vc.channelDefaultValues("OriginalHeader", "OfficerId"),
                AmountRequestedML: $scope.vc.channelDefaultValues("OriginalHeader", "AmountRequestedML"),
                stageflux: $scope.vc.channelDefaultValues("OriginalHeader", "stageflux"),
                ProductType: $scope.vc.channelDefaultValues("OriginalHeader", "ProductType"),
                Type: $scope.vc.channelDefaultValues("OriginalHeader", "Type"),
                CreditLineValid: $scope.vc.channelDefaultValues("OriginalHeader", "CreditLineValid"),
                Agreement: $scope.vc.channelDefaultValues("OriginalHeader", "Agreement"),
                CodeAgreement: $scope.vc.channelDefaultValues("OriginalHeader", "CodeAgreement"),
                RejectionReason: $scope.vc.channelDefaultValues("OriginalHeader", "RejectionReason"),
                RequestLine: $scope.vc.channelDefaultValues("OriginalHeader", "RequestLine"),
                ProductFIE: $scope.vc.channelDefaultValues("OriginalHeader", "ProductFIE"),
                HousingCount: $scope.vc.channelDefaultValues("OriginalHeader", "HousingCount"),
                ScoreType: $scope.vc.channelDefaultValues("OriginalHeader", "ScoreType"),
                Score: $scope.vc.channelDefaultValues("OriginalHeader", "Score"),
                IsWarrantyDestination: $scope.vc.channelDefaultValues("OriginalHeader", "IsWarrantyDestination"),
                IsDebtorOwner: $scope.vc.channelDefaultValues("OriginalHeader", "IsDebtorOwner"),
                AmountAprobed: $scope.vc.channelDefaultValues("OriginalHeader", "AmountAprobed"),
                TermLimit: $scope.vc.channelDefaultValues("OriginalHeader", "TermLimit"),
                ActivityNumber: $scope.vc.channelDefaultValues("OriginalHeader", "ActivityNumber")
            };
            //ViewState - Group: GrpTittleManual
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_02",
                hasId: true,
                componentStyle: "",
                htmlSection: true,
                label: 'GrpTittleManual',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2")
            };
            //ViewState - Group: GrpContextHide
            $scope.vc.createViewState({
                id: "GR_WTTTEPRCES08_03",
                hasId: true,
                componentStyle: "",
                label: 'GrpContextHide',
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: VerticalGrp
            $scope.vc.createViewState({
                id: "VC_RDPCA77_VERCR_078",
                hasId: true,
                componentStyle: "",
                label: 'VerticalGrp',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GrpPolicy
            $scope.vc.createViewState({
                id: "VC_RDPCA77_RPICY_718",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_POLICYTTL_56403",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GrpGeneral
            $scope.vc.createViewState({
                id: "GR_POLCIESVEW32_02",
                hasId: true,
                componentStyle: "",
                label: 'GrpGeneral',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpPolicyGrid
            $scope.vc.createViewState({
                id: "GR_POLCIESVEW32_03",
                hasId: true,
                componentStyle: "",
                label: 'GrpPolicyGrid',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Policy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    mnemonic: {
                        type: "string",
                        editable: true
                    },
                    description: {
                        type: "string",
                        editable: true
                    },
                    result: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Policy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUEROLCY_4480();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
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
                    model: $scope.vc.types.Policy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_QUERO4480_42").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUEROLCY_4480 = $scope.vc.model.Policy;
            $scope.vc.trackers.Policy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Policy);
            $scope.vc.model.Policy.bind('change', function(e) {
                $scope.vc.trackers.Policy.track(e);
            });
            $scope.vc.grids.QV_QUERO4480_42 = {};
            $scope.vc.grids.QV_QUERO4480_42.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_QUERO4480_42) && expandedRowUidActual !== expandedRowUid_QV_QUERO4480_42) {
                    var gridWidget = $('#QV_QUERO4480_42').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_QUERO4480_42 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_QUERO4480_42 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_QUERO4480_42 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_QUERO4480_42);
                }
                expandedRowUid_QV_QUERO4480_42 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_QUERO4480_42', args);
                if (angular.isDefined($scope.vc.grids.QV_QUERO4480_42.view)) {
                    $scope.vc.grids.QV_QUERO4480_42.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_QUERO4480_42.customView)) {
                    $scope.vc.grids.QV_QUERO4480_42.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_QUERO4480_42'/>"
            };
            $scope.vc.grids.QV_QUERO4480_42.queryId = 'Q_QUEROLCY_4480';
            $scope.vc.viewState.QV_QUERO4480_42 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QUERO4480_42.column = {};
            var expandedRowUid_QV_QUERO4480_42;
            $scope.vc.grids.QV_QUERO4480_42.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.Policy.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QUERO4480_42.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.gridDataBound("QV_QUERO4480_42");
                    $scope.vc.hideShowColumns("QV_QUERO4480_42", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QUERO4480_42.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QUERO4480_42.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QUERO4480_42.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QUERO4480_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QUERO4480_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_QUERO4480_42 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_QUERO4480_42.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QUERO4480_42.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic = {
                title: 'BUSIN.DLB_BUSIN_NEMNICOZH_18160',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUERO4480_42.AT_POL965NMNI98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 10,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUERO4480_42.column.mnemonic.enabled",
                        'ng-class': "vc.viewState.QV_QUERO4480_42.column.mnemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERO4480_42.column.description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUERO4480_42.AT_POL965DRTO65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUERO4480_42.column.description.enabled",
                        'ng-class': "vc.viewState.QV_QUERO4480_42.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QUERO4480_42.column.result = {
                title: 'BUSIN.DLB_BUSIN_RESULTADO_06672',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_QUERO4480_42.AT_POL965RELT93 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 25,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_QUERO4480_42.column.result.enabled",
                        'ng-class': "vc.viewState.QV_QUERO4480_42.column.result.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERO4480_42.columns.push({
                    field: 'mnemonic',
                    title: '{{vc.viewState.QV_QUERO4480_42.column.mnemonic.title|translate:vc.viewState.QV_QUERO4480_42.column.mnemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic.width,
                    format: $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic.format,
                    editor: $scope.vc.grids.QV_QUERO4480_42.AT_POL965NMNI98.control,
                    template: "<span ng-class='vc.viewState.QV_QUERO4480_42.column.mnemonic.element[dataItem.uid].style'>#if (mnemonic !== null) {# #=mnemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERO4480_42.column.mnemonic.style",
                        "title": "{{vc.viewState.QV_QUERO4480_42.column.mnemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERO4480_42.column.mnemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERO4480_42.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_QUERO4480_42.column.description.title|translate:vc.viewState.QV_QUERO4480_42.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERO4480_42.column.description.width,
                    format: $scope.vc.viewState.QV_QUERO4480_42.column.description.format,
                    editor: $scope.vc.grids.QV_QUERO4480_42.AT_POL965DRTO65.control,
                    template: "<span ng-class='vc.viewState.QV_QUERO4480_42.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERO4480_42.column.description.style",
                        "title": "{{vc.viewState.QV_QUERO4480_42.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERO4480_42.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QUERO4480_42.columns.push({
                    field: 'result',
                    title: '{{vc.viewState.QV_QUERO4480_42.column.result.title|translate:vc.viewState.QV_QUERO4480_42.column.result.titleArgs}}',
                    width: $scope.vc.viewState.QV_QUERO4480_42.column.result.width,
                    format: $scope.vc.viewState.QV_QUERO4480_42.column.result.format,
                    editor: $scope.vc.grids.QV_QUERO4480_42.AT_POL965RELT93.control,
                    template: "<span ng-class='vc.viewState.QV_QUERO4480_42.column.result.element[dataItem.uid].style'>#if (result !== null) {# #=result# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QUERO4480_42.column.result.style",
                        "title": "{{vc.viewState.QV_QUERO4480_42.column.result.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QUERO4480_42.column.result.hidden
                });
            }
            $scope.vc.viewState.QV_QUERO4480_42.toolbar = {}
            $scope.vc.grids.QV_QUERO4480_42.toolbar = [];
            //ViewState - Group: GrpVariablePolicy
            $scope.vc.createViewState({
                id: "GR_POLCIESVEW32_04",
                hasId: true,
                componentStyle: "",
                label: 'GrpVariablePolicy',
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.VariablePolicy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    },
                    VariableDescription: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.VariablePolicy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UEVRBPOC_5831();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
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
                    model: $scope.vc.types.VariablePolicy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UEVRB5831_12").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UEVRBPOC_5831 = $scope.vc.model.VariablePolicy;
            $scope.vc.trackers.VariablePolicy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariablePolicy);
            $scope.vc.model.VariablePolicy.bind('change', function(e) {
                $scope.vc.trackers.VariablePolicy.track(e);
            });
            $scope.vc.grids.QV_UEVRB5831_12 = {};
            $scope.vc.grids.QV_UEVRB5831_12.queryId = 'Q_UEVRBPOC_5831';
            $scope.vc.viewState.QV_UEVRB5831_12 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column = {};
            $scope.vc.grids.QV_UEVRB5831_12.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.VariablePolicy.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UEVRB5831_12.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.gridDataBound("QV_UEVRB5831_12");
                    $scope.vc.hideShowColumns("QV_UEVRB5831_12", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UEVRB5831_12.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UEVRB5831_12.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UEVRB5831_12.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UEVRB5831_12 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UEVRB5831_12 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UEVRB5831_12.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UEVRB5831_12.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396ILEA09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396VILV60 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396BSCT95 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 100,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_UEVRB5831_12.column.VariableDescription.enabled",
                        'ng-class': "vc.viewState.QV_UEVRB5831_12.column.VariableDescription.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableName.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396ILEA09.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableName.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableValue.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396VILV60.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UEVRB5831_12.columns.push({
                    field: 'VariableDescription',
                    title: '{{vc.viewState.QV_UEVRB5831_12.column.VariableDescription.title|translate:vc.viewState.QV_UEVRB5831_12.column.VariableDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.width,
                    format: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.format,
                    editor: $scope.vc.grids.QV_UEVRB5831_12.AT_VAR396BSCT95.control,
                    template: "<span ng-class='vc.viewState.QV_UEVRB5831_12.column.VariableDescription.element[dataItem.uid].style'>#if (VariableDescription !== null) {# #=VariableDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UEVRB5831_12.column.VariableDescription.style",
                        "title": "{{vc.viewState.QV_UEVRB5831_12.column.VariableDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UEVRB5831_12.column.VariableDescription.hidden
                });
            }
            $scope.vc.viewState.QV_UEVRB5831_12.toolbar = {}
            $scope.vc.grids.QV_UEVRB5831_12.toolbar = []; //ViewState - Container: GrpException
            $scope.vc.createViewState({
                id: "VC_RDPCA77_REXTO_015",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_EXCEPCONS_52292",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GrpGeneral
            $scope.vc.createViewState({
                id: "GR_EEPTIONVIW22_02",
                hasId: true,
                componentStyle: "",
                label: 'GrpGeneral',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GrpExceptionGrid
            $scope.vc.createViewState({
                id: "GR_EEPTIONVIW22_03",
                hasId: true,
                componentStyle: "",
                label: 'GrpExceptionGrid',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Exceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Type", ''),
                        validation: {
                            TypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    mnemonic: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "mnemonic", ''),
                        validation: {
                            mnemonicRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "description", ''),
                        validation: {
                            descriptionRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    detail: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "detail", '')
                    },
                    EndDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "EndDate", new Date())
                    },
                    Official: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Official", '')
                    },
                    Observations: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Observations", '')
                    },
                    Aproved: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Aproved", false),
                        validation: {
                            AprovedRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.Exceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UERXCPTS_4756();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
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
                    model: $scope.vc.types.Exceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UERXC4756_18").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UERXCPTS_4756 = $scope.vc.model.Exceptions;
            $scope.vc.trackers.Exceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Exceptions);
            $scope.vc.model.Exceptions.bind('change', function(e) {
                $scope.vc.trackers.Exceptions.track(e);
                $scope.vc.grids.QV_UERXC4756_18.events.evalVisibilityOfGridRowDetailIcon(e.sender);
            });
            $scope.vc.grids.QV_UERXC4756_18 = {};
            $scope.vc.grids.QV_UERXC4756_18.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_UERXC4756_18) && expandedRowUidActual !== expandedRowUid_QV_UERXC4756_18) {
                    var gridWidget = $('#QV_UERXC4756_18').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_UERXC4756_18 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_UERXC4756_18);
                }
                expandedRowUid_QV_UERXC4756_18 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_UERXC4756_18', args);
                if (angular.isDefined($scope.vc.grids.QV_UERXC4756_18.view)) {
                    $scope.vc.grids.QV_UERXC4756_18.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_UERXC4756_18.customView)) {
                    $scope.vc.grids.QV_UERXC4756_18.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_UERXC4756_18'/>"
            };
            $scope.vc.grids.QV_UERXC4756_18.queryId = 'Q_UERXCPTS_4756';
            $scope.vc.viewState.QV_UERXC4756_18 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UERXC4756_18.column = {};
            var expandedRowUid_QV_UERXC4756_18;
            $scope.vc.grids.QV_UERXC4756_18.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.Exceptions.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UERXC4756_18.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.grids.QV_UERXC4756_18.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    $scope.vc.validateForm();
                },
                evalVisibilityOfGridRowDetailIcon: function(dataSource) {
                    var dataView = dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        var args = {
                            nameEntityGrid: "Exceptions",
                            rowData: dataView[i],
                            rowIndex: dataSource.indexOf(dataView[i])
                        }
                        var showDetailIcon = $scope.vc.showGridRowDetailIcon("QV_UERXC4756_18", args);
                        $scope.vc.setVisibilityOfGridRowDetailIcon("QV_UERXC4756_18", dataView[i].uid, showDetailIcon);
                    }
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_UERXC4756_18");
                    $scope.vc.hideShowColumns("QV_UERXC4756_18", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UERXC4756_18.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UERXC4756_18 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UERXC4756_18 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    $scope.vc.grids.QV_UERXC4756_18.events.evalVisibilityOfGridRowDetailIcon(this.dataSource);
                    if (this.options.selectable && angular.isDefined($scope.vc.grids.QV_UERXC4756_18.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_UERXC4756_18.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_UERXC4756_18.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Exceptions",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem),
                        };
                        $scope.vc.gridRowSelecting("QV_UERXC4756_18", args);
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
                    var scope = angular.element($('#QV_UERXC4756_18 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UERXC4756_18.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UERXC4756_18.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UERXC4756_18.column.Type = {
                title: 'BUSIN.DLB_BUSIN_TIPOLRXRX_31531',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_EEPTIONVIW2203_TYPE521',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513TYPE30 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Type.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_TYPE521",
                        'maxlength': 5,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_TIPOLRXRX_31531') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.Type.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Type.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.Type.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic = {
                title: 'BUSIN.DLB_BUSIN_IDMNUIEUV_49873',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_EEPTIONVIW2203_NONI575',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513NONI25 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.mnemonic.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_NONI575",
                        'maxlength': 10,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_IDMNUIEUV_49873') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.mnemonic.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.mnemonic.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.mnemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCI_06123',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_EEPTIONVIW2203_RTIO567',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513RTIO01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_RTIO567",
                        'maxlength': 50,
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.DLB_BUSIN_DESCRIPCI_06123') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.description.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.detail = {
                title: 'BUSIN.DLB_BUSIN_ETAPALBLO_86425',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EEPTIONVIW2203_DETA578',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513DETA22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.detail.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_DETA578",
                        'maxlength': 500,
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.detail.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.detail.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.detail.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.EndDate = {
                title: 'BUSIN.DLB_BUSIN_ENDDATENH_77479',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EEPTIONVIW2203_ENTE040',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513ENTE92 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.EndDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_ENTE040",
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.EndDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.EndDate.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.EndDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.Official = {
                title: 'BUSIN.DLB_BUSIN_OFFICIALR_02742',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EEPTIONVIW2203_OCIA285',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513OCIA20 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Official.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_OCIA285",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.Official.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Official.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.Official.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.Observations = {
                title: 'BUSIN.DLB_BUSIN_SERVACINS_39064',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_EEPTIONVIW2203_SETO198',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513SETO85 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Observations.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_SETO198",
                        'maxlength': 500,
                        'data-validation-code': "{{vc.viewState.QV_UERXC4756_18.column.Observations.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_EEPTIONVIW22_02,0",
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Observations.enabled",
                        'ng-class': "vc.viewState.QV_UERXC4756_18.column.Observations.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UERXC4756_18.column.Aproved = {
                title: 'BUSIN.DLB_BUSIN_AUTORIZAR_89338',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_EEPTIONVIW2203_EULT694',
                element: []
            };
            $scope.vc.grids.QV_UERXC4756_18.AT_EXC513EULT52 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UERXC4756_18.column.Aproved.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_EEPTIONVIW2203_EULT694",
                        'ng-class': 'vc.viewState.QV_UERXC4756_18.column.Aproved.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'Type',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.Type.title|translate:vc.viewState.QV_UERXC4756_18.column.Type.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.Type.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.Type.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513TYPE30.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.Type.element[dataItem.uid].style'>#if (Type !== null) {# #=Type# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.Type.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.Type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.Type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'mnemonic',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.mnemonic.title|translate:vc.viewState.QV_UERXC4756_18.column.mnemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513NONI25.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.mnemonic.element[dataItem.uid].style'>#if (mnemonic !== null) {# #=mnemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.mnemonic.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.mnemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.mnemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.description.title|translate:vc.viewState.QV_UERXC4756_18.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.description.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.description.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513RTIO01.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.description.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'detail',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.detail.title|translate:vc.viewState.QV_UERXC4756_18.column.detail.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.detail.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.detail.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513DETA22.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.detail.element[dataItem.uid].style'>#if (detail !== null) {# #=detail# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.detail.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.detail.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.detail.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'EndDate',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.EndDate.title|translate:vc.viewState.QV_UERXC4756_18.column.EndDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.EndDate.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.EndDate.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513ENTE92.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.EndDate.element[dataItem.uid].style'>#=((EndDate !== null) ? kendo.toString(EndDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.EndDate.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.EndDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.EndDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'Official',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.Official.title|translate:vc.viewState.QV_UERXC4756_18.column.Official.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.Official.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.Official.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513OCIA20.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.Official.element[dataItem.uid].style'>#if (Official !== null) {# #=Official# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.Official.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.Official.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.Official.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'Observations',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.Observations.title|translate:vc.viewState.QV_UERXC4756_18.column.Observations.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.Observations.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.Observations.format,
                    editor: $scope.vc.grids.QV_UERXC4756_18.AT_EXC513SETO85.control,
                    template: "<span ng-class='vc.viewState.QV_UERXC4756_18.column.Observations.element[dataItem.uid].style'>#if (Observations !== null) {# #=Observations# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.Observations.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.Observations.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.Observations.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UERXC4756_18.columns.push({
                    field: 'Aproved',
                    title: '{{vc.viewState.QV_UERXC4756_18.column.Aproved.title|translate:vc.viewState.QV_UERXC4756_18.column.Aproved.titleArgs}}',
                    width: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.width,
                    format: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_UERXC4756_18', 'Aproved', $scope.vc.grids.QV_UERXC4756_18.AT_EXC513EULT52.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_UERXC4756_18', 'Aproved'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UERXC4756_18.column.Aproved.style",
                        "title": "{{vc.viewState.QV_UERXC4756_18.column.Aproved.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UERXC4756_18.column.Aproved.hidden
                });
            }
            $scope.vc.viewState.QV_UERXC4756_18.toolbar = {}
            $scope.vc.grids.QV_UERXC4756_18.toolbar = [];
            //ViewState - Group: GrpVariableException
            $scope.vc.createViewState({
                id: "GR_EEPTIONVIW22_05",
                hasId: true,
                componentStyle: "",
                label: 'GrpVariableException',
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.VariableExceptions = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    VariableName: {
                        type: "string",
                        editable: true
                    },
                    VariableValue: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.VariableExceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_EAIBLEEP_2309();
                            $scope.vc.CRUDExecuteQuery(queryRequest, function(data) {
                                if (angular.isDefined(data) && angular.isArray(data)) {
                                    options.success(data);
                                } else {
                                    options.success([]);
                                }
                            });
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
                    model: $scope.vc.types.VariableExceptions
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_EAIBL2309_87").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EAIBLEEP_2309 = $scope.vc.model.VariableExceptions;
            $scope.vc.trackers.VariableExceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VariableExceptions);
            $scope.vc.model.VariableExceptions.bind('change', function(e) {
                $scope.vc.trackers.VariableExceptions.track(e);
            });
            $scope.vc.grids.QV_EAIBL2309_87 = {};
            $scope.vc.grids.QV_EAIBL2309_87.queryId = 'Q_EAIBLEEP_2309';
            $scope.vc.viewState.QV_EAIBL2309_87 = {
                style: undefined
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column = {};
            $scope.vc.grids.QV_EAIBL2309_87.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.VariableExceptions.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_EAIBL2309_87.selectedRow = e.model;
                    var commandCell;
                    var index = e.container.find("td > a.k-grid-update").index();
                    if (index == -1) {
                        index = e.container.find("td > span.cb-commands").index();
                        if (index == -1) {
                            index = e.container.find("th.k-header[data-role='droptarget']").index();
                            if (index == -1) {
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
                    $scope.vc.gridDataBound("QV_EAIBL2309_87");
                    $scope.vc.hideShowColumns("QV_EAIBL2309_87", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_EAIBL2309_87.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_EAIBL2309_87.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_EAIBL2309_87.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_EAIBL2309_87 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_EAIBL2309_87 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_EAIBL2309_87.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName = {
                title: 'BUSIN.DLB_BUSIN_VARIABLEV_12696',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 45,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableName.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue = {
                title: 'BUSIN.DLB_BUSIN_VALORDWSB_39301',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EAIBL2309_87.column.VariableValue.enabled",
                        'ng-class': "vc.viewState.QV_EAIBL2309_87.column.VariableValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableName',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableName.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836RABM62.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableName.element[dataItem.uid].style'>#if (VariableName !== null) {# #=VariableName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableName.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EAIBL2309_87.columns.push({
                    field: 'VariableValue',
                    title: '{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.title|translate:vc.viewState.QV_EAIBL2309_87.column.VariableValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.width,
                    format: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.format,
                    editor: $scope.vc.grids.QV_EAIBL2309_87.AT_ABL836VBLE29.control,
                    template: "<span ng-class='vc.viewState.QV_EAIBL2309_87.column.VariableValue.element[dataItem.uid].style'>#if (VariableValue !== null) {# #=VariableValue# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EAIBL2309_87.column.VariableValue.style",
                        "title": "{{vc.viewState.QV_EAIBL2309_87.column.VariableValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EAIBL2309_87.column.VariableValue.hidden
                });
            }
            $scope.vc.viewState.QV_EAIBL2309_87.toolbar = {}
            $scope.vc.grids.QV_EAIBL2309_87.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_35_RDPCA77_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_35_RDPCA77_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Autorizar
            $scope.vc.createViewState({
                id: "CM_RDPCA77SAE65",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_AUTORIZAR_89338",
                label: "BUSIN.DLB_BUSIN_AUTORIZAR_89338",
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
                $scope.vc.render('VC_RDPCA77_ICANR_753');
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
    var cobisMainModule = cobis.createModule("VC_RDPCA77_ICANR_753", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_RDPCA77_ICANR_753", {
            templateUrl: "VC_RDPCA77_ICANR_753_FORM.html",
            controller: "VC_RDPCA77_ICANR_753_CTRL",
            label: "PoliciesAndExceptionsForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RDPCA77_ICANR_753?" + $.param(search);
            }
        });
        VC_RDPCA77_ICANR_753(cobisMainModule);
    }]);
} else {
    VC_RDPCA77_ICANR_753(cobisMainModule);
}