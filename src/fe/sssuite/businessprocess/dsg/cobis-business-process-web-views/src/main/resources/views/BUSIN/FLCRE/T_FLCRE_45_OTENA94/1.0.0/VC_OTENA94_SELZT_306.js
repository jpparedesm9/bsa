<!-- Designer Generator v 6.0.0 - release SPR 2016-16 19/08/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tconsolidatepenalization = designerEvents.api.tconsolidatepenalization || designer.dsgEvents();

function VC_OTENA94_SELZT_306(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_OTENA94_SELZT_306_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_OTENA94_SELZT_306_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_45_OTENA94",
            taskVersion: "1.0.0",
            viewContainerId: "VC_OTENA94_SELZT_306",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_45_OTENA94",
        designerEvents.api.tconsolidatepenalization,
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
                vcName: 'VC_OTENA94_SELZT_306'
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
                    taskId: 'T_FLCRE_45_OTENA94',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    SummaryAmount: "SummaryAmount",
                    Punishment: "Punishment",
                    HeaderPunishment: "HeaderPunishment"
                },
                entities: {
                    SummaryAmount: {
                        Office: 'AT_SMA669FFIE22',
                        Currency: 'AT_SMA669CURN65',
                        CapitalBalance: 'AT_SMA669PALN98',
                        CapitalBalanceToDate: 'AT_SMA669IALE09',
                        _pks: [],
                        _entityId: 'EN_SMARYAOUT669',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Punishment: {
                        CourtDate: 'AT_PUN293CTDT26',
                        Operation: 'AT_PUN293ORAN64',
                        Bank: 'AT_PUN293BANK04',
                        OperationStatus: 'AT_PUN293RANS20',
                        CapitalBalance: 'AT_PUN293ATBC16',
                        InterestBalance: 'AT_PUN293RBAE33',
                        MoraBalance: 'AT_PUN293ORAA65',
                        OtherBalance: 'AT_PUN293TBAC22',
                        MoraDay: 'AT_PUN293MADY02',
                        Oficial: 'AT_PUN293FIAL42',
                        DescriptionOficial: 'AT_PUN293CTON16',
                        IdClient: 'AT_PUN293ILNT35',
                        DescriptionClient: 'AT_PUN293SRIE62',
                        LastPaymentDate: 'AT_PUN293SMNE22',
                        Currency: 'AT_PUN293CUEY89',
                        Observation: 'AT_PUN293OBSE04',
                        Recommended: 'AT_PUN293REOE42',
                        CapitalBalanceToDate: 'AT_PUN293INDE62',
                        InterestBalanceToDate: 'AT_PUN293EBAO37',
                        Office: 'AT_PUN293OFIC00',
                        Amount: 'AT_PUN293AMNT05',
                        Status: 'AT_PUN293STAS42',
                        _pks: [],
                        _entityId: 'EN_PUNISMENT293',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    HeaderPunishment: {
                        SpecificForecast: 'AT_EDR212AANS58',
                        PercentageRecovered: 'AT_EDR212AGRD14',
                        CourtDate: 'AT_EDR212ORTT66',
                        DisbursementDate: 'AT_EDR212SBME09',
                        CreditStatus: 'AT_EDR212DTTA08',
                        CustomerOriginalActivity: 'AT_EDR212SMIA17',
                        NumberCreditsEarned: 'AT_EDR212BEDS90',
                        CourtDaysLate: 'AT_EDR212OURS34',
                        ApplicationDaysLate: 'AT_EDR212APCA64',
                        OfficialGrant: 'AT_EDR212CIRA07',
                        ResponsibleCurrent: 'AT_EDR212RENN73',
                        ActualUseLoan: 'AT_EDR212AUOA04',
                        Trouble: 'AT_EDR212TOBL12',
                        ImpossibilityDescription: 'AT_EDR212EPTI39',
                        DescripNotRecoverGaranties: 'AT_EDR212PNUR98',
                        DisbursedAmount: 'AT_EDR212IBRS42',
                        ApplicationNumber: 'AT_EDR212LINU69',
                        IDRequested: 'AT_EDR212EUED07',
                        Agency: 'AT_EDR212AGCY42',
                        CityCode: 'AT_EDR212CTYE71',
                        CurrencyRequest: 'AT_EDR212CQUE29',
                        CreditTarget: 'AT_EDR212RDRE99',
                        NumberOperation: 'AT_EDR212PRAI16',
                        ConsistencyApplication: 'AT_EDR212DTIN81',
                        Observation: 'AT_EDR212BRTO11',
                        Province: 'AT_EDR212RINE98',
                        UserL: 'AT_EDR212UELI22',
                        CustomerId: 'AT_EDR212UTMD63',
                        Type: 'AT_EDR212TYPE26',
                        Status: 'AT_EDR212STAU79',
                        ParentGroupID: 'AT_EDR212ARNI56',
                        GroupID: 'AT_EDR212GPID89',
                        Sindico1: 'AT_EDR212NICO38',
                        Sindico2: 'AT_EDR212SII259',
                        Step: 'AT_EDR212STEP97',
                        _pks: [],
                        _entityId: 'EN_EDRPNSMET212',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DTPEAZAT_0472 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_DTPEAZAT_0472 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DTPEAZAT_0472_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_DTPEAZAT_0472_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PUNISMENT293',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DTPEAZAT_0472',
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
            $scope.vc.queries.Q_DTPEAZAT_0472_filters = {};
            $scope.vc.queryProperties.Q_UMMAYOUT_4215 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_UMMAYOUT_4215 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_UMMAYOUT_4215_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_UMMAYOUT_4215_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SMARYAOUT669',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_UMMAYOUT_4215',
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
            $scope.vc.queries.Q_UMMAYOUT_4215_filters = {};
            defaultValues = {
                SummaryAmount: {},
                Punishment: {},
                HeaderPunishment: {}
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
            };
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
            $scope.vc.viewState.VC_OTENA94_SELZT_306 = {
                style: []
            }
            //ViewState - Container: FConsolidatePenalization
            $scope.vc.createViewState({
                id: "VC_OTENA94_SELZT_306",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_NLIOLIDEA_04630",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: [HeaderPenalization]
            $scope.vc.createViewState({
                id: "VC_OTENA94_HRIZT_422",
                hasId: true,
                componentStyle: "",
                label: '[HeaderPenalization]',
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.HeaderPunishment = {
                SpecificForecast: $scope.vc.channelDefaultValues("HeaderPunishment", "SpecificForecast"),
                PercentageRecovered: $scope.vc.channelDefaultValues("HeaderPunishment", "PercentageRecovered"),
                CourtDate: $scope.vc.channelDefaultValues("HeaderPunishment", "CourtDate"),
                DisbursementDate: $scope.vc.channelDefaultValues("HeaderPunishment", "DisbursementDate"),
                CreditStatus: $scope.vc.channelDefaultValues("HeaderPunishment", "CreditStatus"),
                CustomerOriginalActivity: $scope.vc.channelDefaultValues("HeaderPunishment", "CustomerOriginalActivity"),
                NumberCreditsEarned: $scope.vc.channelDefaultValues("HeaderPunishment", "NumberCreditsEarned"),
                CourtDaysLate: $scope.vc.channelDefaultValues("HeaderPunishment", "CourtDaysLate"),
                ApplicationDaysLate: $scope.vc.channelDefaultValues("HeaderPunishment", "ApplicationDaysLate"),
                OfficialGrant: $scope.vc.channelDefaultValues("HeaderPunishment", "OfficialGrant"),
                ResponsibleCurrent: $scope.vc.channelDefaultValues("HeaderPunishment", "ResponsibleCurrent"),
                ActualUseLoan: $scope.vc.channelDefaultValues("HeaderPunishment", "ActualUseLoan"),
                Trouble: $scope.vc.channelDefaultValues("HeaderPunishment", "Trouble"),
                ImpossibilityDescription: $scope.vc.channelDefaultValues("HeaderPunishment", "ImpossibilityDescription"),
                DescripNotRecoverGaranties: $scope.vc.channelDefaultValues("HeaderPunishment", "DescripNotRecoverGaranties"),
                DisbursedAmount: $scope.vc.channelDefaultValues("HeaderPunishment", "DisbursedAmount"),
                ApplicationNumber: $scope.vc.channelDefaultValues("HeaderPunishment", "ApplicationNumber"),
                IDRequested: $scope.vc.channelDefaultValues("HeaderPunishment", "IDRequested"),
                Agency: $scope.vc.channelDefaultValues("HeaderPunishment", "Agency"),
                CityCode: $scope.vc.channelDefaultValues("HeaderPunishment", "CityCode"),
                CurrencyRequest: $scope.vc.channelDefaultValues("HeaderPunishment", "CurrencyRequest"),
                CreditTarget: $scope.vc.channelDefaultValues("HeaderPunishment", "CreditTarget"),
                NumberOperation: $scope.vc.channelDefaultValues("HeaderPunishment", "NumberOperation"),
                ConsistencyApplication: $scope.vc.channelDefaultValues("HeaderPunishment", "ConsistencyApplication"),
                Observation: $scope.vc.channelDefaultValues("HeaderPunishment", "Observation"),
                Province: $scope.vc.channelDefaultValues("HeaderPunishment", "Province"),
                UserL: $scope.vc.channelDefaultValues("HeaderPunishment", "UserL"),
                CustomerId: $scope.vc.channelDefaultValues("HeaderPunishment", "CustomerId"),
                Type: $scope.vc.channelDefaultValues("HeaderPunishment", "Type"),
                Status: $scope.vc.channelDefaultValues("HeaderPunishment", "Status"),
                ParentGroupID: $scope.vc.channelDefaultValues("HeaderPunishment", "ParentGroupID"),
                GroupID: $scope.vc.channelDefaultValues("HeaderPunishment", "GroupID"),
                Sindico1: $scope.vc.channelDefaultValues("HeaderPunishment", "Sindico1"),
                Sindico2: $scope.vc.channelDefaultValues("HeaderPunishment", "Sindico2"),
                Step: $scope.vc.channelDefaultValues("HeaderPunishment", "Step")
            };
            //ViewState - Group: [HeadePunishment]
            $scope.vc.createViewState({
                id: "GR_HEAPNAIION05_58",
                hasId: true,
                componentStyle: "",
                label: '[HeadePunishment]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CourtDate
            $scope.vc.createViewState({
                id: "VA_HEAPNAIION0558_ORTT848",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ECHAECORE_43828",
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: [VConsolidatePenalization]
            $scope.vc.createViewState({
                id: "VC_OTENA94_LDAAI_739",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_SLIUSCAGO_38766",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor VConsolidatePenalization
            $scope.vc.createViewState({
                id: "GR_VOSOLDTENI35_11",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor VConsolidatePenalization',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [GConsolidatePenalization]
            $scope.vc.createViewState({
                id: "GR_VOSOLDTENI35_04",
                hasId: true,
                componentStyle: "",
                label: '[GConsolidatePenalization]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Punishment = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Operation: {
                        type: "number",
                        editable: true
                    },
                    Office: {
                        type: "number",
                        editable: true
                    },
                    Bank: {
                        type: "string",
                        editable: true
                    },
                    DescriptionClient: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "DescriptionClient", '')
                    },
                    Observation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "Observation", '')
                    },
                    OperationStatus: {
                        type: "string",
                        editable: true
                    },
                    Amount: {
                        type: "number",
                        editable: true
                    },
                    CapitalBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "CapitalBalance", 0)
                    },
                    CapitalBalanceToDate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "CapitalBalanceToDate", 0)
                    },
                    InterestBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "InterestBalance", 0)
                    },
                    InterestBalanceToDate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "InterestBalanceToDate", 0)
                    },
                    OtherBalance: {
                        type: "number",
                        editable: true
                    },
                    Currency: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "Currency", 0)
                    },
                    Recommended: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "Recommended", false)
                    },
                    Status: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Punishment = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_DTPEAZAT_0472();
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
                    model: $scope.vc.types.Punishment
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_DTPEA0472_42").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DTPEAZAT_0472 = $scope.vc.model.Punishment;
            $scope.vc.trackers.Punishment = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Punishment);
            $scope.vc.model.Punishment.bind('change', function(e) {
                $scope.vc.trackers.Punishment.track(e);
            });
            $scope.vc.grids.QV_DTPEA0472_42 = {};
            $scope.vc.grids.QV_DTPEA0472_42.detailTemplate = function(dataItem) {
                var expandedRowUidActual = dataItem.uid;
                if (angular.isDefined(expandedRowUid_QV_DTPEA0472_42) && expandedRowUidActual !== expandedRowUid_QV_DTPEA0472_42) {
                    var gridWidget = $('#QV_DTPEA0472_42').data('kendoGrid');
                    gridWidget.collapseRow($('tr[data-uid=' + expandedRowUid_QV_DTPEA0472_42 + ']'));
                    var scope = angular.element($('tr[data-uid=' + expandedRowUid_QV_DTPEA0472_42 + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                    $('tr[data-uid=' + expandedRowUid_QV_DTPEA0472_42 + '] + tr.k-detail-row').remove();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                    $scope.vc.removeChildVc(expandedRowUid_QV_DTPEA0472_42);
                }
                expandedRowUid_QV_DTPEA0472_42 = expandedRowUidActual;
                var args = {
                    modelRow: dataItem
                };
                $scope.vc.gridInitDetailTemplate('QV_DTPEA0472_42', args);
                if (angular.isDefined($scope.vc.grids.QV_DTPEA0472_42.view)) {
                    $scope.vc.grids.QV_DTPEA0472_42.view.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                if (angular.isDefined($scope.vc.grids.QV_DTPEA0472_42.customView)) {
                    $scope.vc.grids.QV_DTPEA0472_42.customView.rowData = dataItem;
                    $scope.vc.addChildVc(dataItem.uid);
                }
                return "<div designer-form-load form='vc.grids.QV_DTPEA0472_42'/>"
            };
            $scope.vc.grids.QV_DTPEA0472_42.queryId = 'Q_DTPEAZAT_0472';
            $scope.vc.viewState.QV_DTPEA0472_42 = {
                style: undefined
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column = {};
            var expandedRowUid_QV_DTPEA0472_42;
            $scope.vc.grids.QV_DTPEA0472_42.events = {
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
                    $scope.vc.trackers.Punishment.cancelTrackedChanges(e.model);
                    //TODO: Verificar que no afecte el track
                    e.sender.cancelRow();
                    e.sender.refresh();
                },
                edit: function(e) {
                    $scope.vc.grids.QV_DTPEA0472_42.selectedRow = e.model;
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_DTPEA0472_42', this.dataSource);
                },
                excel: {
                    fileName: 'Solicitudes de Castigo.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'Solicitudes de Castigo.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_DTPEA0472_42");
                    $scope.vc.hideShowColumns("QV_DTPEA0472_42", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_DTPEA0472_42.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_DTPEA0472_42.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_DTPEA0472_42.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_DTPEA0472_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_DTPEA0472_42 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var scope = angular.element($('#QV_DTPEA0472_42 tr.k-detail-row td.k-detail-cell > div')).scope();
                    if (angular.isDefined(scope)) {
                        scope.$destroy();
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_DTPEA0472_42.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_DTPEA0472_42.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_DTPEA0472_42.column.Operation = {
                title: 'Code',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Office = {
                title: 'Office',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293OFIC00 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 1,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'n0'",
                        'k-decimals': "0",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.Office.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.Office.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Bank = {
                title: 'Bank',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293BANK04 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 24,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.Bank.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.Bank.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.DescriptionClient = {
                title: 'BUSIN.DLB_BUSIN_CLIENTZXD_06072',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_SRIE628',
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293SRIE62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_SRIE628",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VOSOLDTENI35_11,0",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Observation = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_OBSE727',
                element: []
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.OperationStatus = {
                title: 'OperationStatus',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293RANS20 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 10,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.OperationStatus.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.OperationStatus.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Amount = {
                title: 'Amount',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293AMNT05 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 18,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.Amount.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.Amount.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalance = {
                title: 'BUSIN.DLB_BUSIN_LDOECITAL_77904',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_ATBC205',
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293ATBC16 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_ATBC205",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.format",
                        'k-decimals': "vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.decimals",
                        'data-cobis-group': "Group,GR_VOSOLDTENI35_11,0",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate = {
                title: 'BUSIN.DLB_BUSIN_LCPIFEHLL_29397',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_INDE704',
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293INDE62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_INDE704",
                        'maxlength': 18,
                        'data-validation-code': "{{vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.format",
                        'k-decimals': "vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.decimals",
                        'data-cobis-group': "Group,GR_VOSOLDTENI35_11,0",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalance = {
                title: 'BUSIN.DLB_BUSIN_ALOITRSLB_89518',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_RBAE806',
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293RBAE33 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.InterestBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_RBAE806",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_DTPEA0472_42.column.InterestBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_DTPEA0472_42.column.InterestBalance.format",
                        'k-decimals': "vc.viewState.QV_DTPEA0472_42.column.InterestBalance.decimals",
                        'data-cobis-group': "Group,GR_VOSOLDTENI35_11,0",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.InterestBalance.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.InterestBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate = {
                title: 'BUSIN.DLB_BUSIN_SAITERLCH_81619',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_EBAO727',
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293EBAO37 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_EBAO727",
                        'maxlength': 18,
                        'data-validation-code': "{{vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.format",
                        'k-decimals': "vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.decimals",
                        'data-cobis-group': "Group,GR_VOSOLDTENI35_11,0",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.OtherBalance = {
                title: 'OtherBalance',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293TBAC22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 103,
                        'type': "number",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-step': "0",
                        'k-format': "'c'",
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.OtherBalance.enabled",
                        'ng-class': "vc.viewState.QV_DTPEA0472_42.column.OtherBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAQAQ_04700',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_CUEY703',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_VOSOLDTENI3504_CUEY703 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_VOSOLDTENI3504_CUEY703_values)) {
                            $scope.vc.catalogs.VA_VOSOLDTENI3504_CUEY703_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_VOSOLDTENI3504_CUEY703',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_VOSOLDTENI3504_CUEY703'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_VOSOLDTENI3504_CUEY703_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_DTPEA0472_42", "VA_VOSOLDTENI3504_CUEY703");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_VOSOLDTENI3504_CUEY703_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_DTPEA0472_42", "VA_VOSOLDTENI3504_CUEY703");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293CUEY89 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_CUEY703",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_DTPEA0472_42.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_VOSOLDTENI3504_CUEY703",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_DTPEA0472_42.column.Currency.template",
                        'data-validation-code': "{{vc.viewState.QV_DTPEA0472_42.column.Currency.validationCode}}",
                        'data-cobis-group': "Group,GR_VOSOLDTENI35_11,0",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Recommended = {
                title: 'BUSIN.DLB_BUSIN_RCOMENDAR_52395',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VOSOLDTENI3504_REOE379',
                element: []
            };
            $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293REOE42 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_DTPEA0472_42.column.Recommended.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VOSOLDTENI3504_REOE379",
                        'ng-class': 'vc.viewState.QV_DTPEA0472_42.column.Recommended.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_DTPEA0472_42.column.Status = {
                title: 'Status',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'Office',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.Office.title|translate:vc.viewState.QV_DTPEA0472_42.column.Office.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.Office.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.Office.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293OFIC00.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.Office.element[dataItem.uid].style' ng-bind='kendo.toString(#=Office#, vc.viewState.QV_DTPEA0472_42.column.Office.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.Office.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.Office.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.Office.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'Bank',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.Bank.title|translate:vc.viewState.QV_DTPEA0472_42.column.Bank.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.Bank.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.Bank.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293BANK04.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.Bank.element[dataItem.uid].style'>#if (Bank !== null) {# #=Bank# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.Bank.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.Bank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.Bank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'DescriptionClient',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.title|translate:vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_DTPEA0472_42', 'DescriptionClient', $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293SRIE62.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_DTPEA0472_42', 'DescriptionClient'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.DescriptionClient.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'OperationStatus',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.OperationStatus.title|translate:vc.viewState.QV_DTPEA0472_42.column.OperationStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.OperationStatus.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.OperationStatus.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293RANS20.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.OperationStatus.element[dataItem.uid].style'>#if (OperationStatus !== null) {# #=OperationStatus# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.OperationStatus.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.OperationStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.OperationStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'Amount',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.Amount.title|translate:vc.viewState.QV_DTPEA0472_42.column.Amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.Amount.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.Amount.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293AMNT05.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.Amount.element[dataItem.uid].style' ng-bind='kendo.toString(#=Amount#, vc.viewState.QV_DTPEA0472_42.column.Amount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.Amount.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.Amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.Amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'CapitalBalance',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.title|translate:vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293ATBC16.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=CapitalBalance#, vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'CapitalBalanceToDate',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.title|translate:vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293INDE62.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.element[dataItem.uid].style' ng-bind='kendo.toString(#=CapitalBalanceToDate#, vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.CapitalBalanceToDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'InterestBalance',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.InterestBalance.title|translate:vc.viewState.QV_DTPEA0472_42.column.InterestBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalance.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalance.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293RBAE33.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.InterestBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=InterestBalance#, vc.viewState.QV_DTPEA0472_42.column.InterestBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.InterestBalance.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.InterestBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'InterestBalanceToDate',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.title|translate:vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293EBAO37.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.element[dataItem.uid].style' ng-bind='kendo.toString(#=InterestBalanceToDate#, vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.InterestBalanceToDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'OtherBalance',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.OtherBalance.title|translate:vc.viewState.QV_DTPEA0472_42.column.OtherBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.OtherBalance.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.OtherBalance.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293TBAC22.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.OtherBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=OtherBalance#, vc.viewState.QV_DTPEA0472_42.column.OtherBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.OtherBalance.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.OtherBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.OtherBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.Currency.title|translate:vc.viewState.QV_DTPEA0472_42.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.Currency.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.Currency.format,
                    editor: $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293CUEY89.control,
                    template: "<span ng-class='vc.viewState.QV_DTPEA0472_42.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_VOSOLDTENI3504_CUEY703.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.Currency.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_DTPEA0472_42.columns.push({
                    field: 'Recommended',
                    title: '{{vc.viewState.QV_DTPEA0472_42.column.Recommended.title|translate:vc.viewState.QV_DTPEA0472_42.column.Recommended.titleArgs}}',
                    width: $scope.vc.viewState.QV_DTPEA0472_42.column.Recommended.width,
                    format: $scope.vc.viewState.QV_DTPEA0472_42.column.Recommended.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_DTPEA0472_42', 'Recommended', $scope.vc.grids.QV_DTPEA0472_42.AT_PUN293REOE42.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_DTPEA0472_42', 'Recommended'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_DTPEA0472_42.column.Recommended.style",
                        "title": "{{vc.viewState.QV_DTPEA0472_42.column.Recommended.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_DTPEA0472_42.column.Recommended.hidden
                });
            }
            $scope.vc.viewState.QV_DTPEA0472_42.toolbar = {}
            $scope.vc.grids.QV_DTPEA0472_42.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_DTPEA0472_42.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }]; //ViewState - Container: [SummaryAmount]
            $scope.vc.createViewState({
                id: "VC_OTENA94_UMOUN_680",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_TOLAGEABL_28318",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Contenedor Principal
            $scope.vc.createViewState({
                id: "GR_SUMARYAMNT49_32",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Principal',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel para Grid SummaryAmount
            $scope.vc.createViewState({
                id: "GR_SUMARYAMNT49_36",
                hasId: true,
                componentStyle: "",
                label: 'Panel para Grid SummaryAmount',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.SummaryAmount = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Office: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryAmount", "Office", 0)
                    },
                    Currency: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryAmount", "Currency", 0)
                    },
                    CapitalBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryAmount", "CapitalBalance", 0)
                    },
                    CapitalBalanceToDate: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SummaryAmount", "CapitalBalanceToDate", 0)
                    }
                }
            });
            $scope.vc.model.SummaryAmount = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_UMMAYOUT_4215();
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
                    model: $scope.vc.types.SummaryAmount
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_UMMAY4215_41").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_UMMAYOUT_4215 = $scope.vc.model.SummaryAmount;
            $scope.vc.trackers.SummaryAmount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.SummaryAmount);
            $scope.vc.model.SummaryAmount.bind('change', function(e) {
                $scope.vc.trackers.SummaryAmount.track(e);
            });
            $scope.vc.grids.QV_UMMAY4215_41 = {};
            $scope.vc.grids.QV_UMMAY4215_41.queryId = 'Q_UMMAYOUT_4215';
            $scope.vc.viewState.QV_UMMAY4215_41 = {
                style: undefined
            };
            $scope.vc.viewState.QV_UMMAY4215_41.column = {};
            $scope.vc.grids.QV_UMMAY4215_41.events = {
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
                    $scope.vc.trackers.SummaryAmount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_UMMAY4215_41.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_UMMAY4215_41");
                    $scope.vc.hideShowColumns("QV_UMMAY4215_41", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_UMMAY4215_41.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_UMMAY4215_41.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_UMMAY4215_41.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_UMMAY4215_41 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_UMMAY4215_41 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_UMMAY4215_41.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_UMMAY4215_41.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_UMMAY4215_41.column.Office = {
                title: 'BUSIN.DLB_BUSIN_AGENCYKWR_29533',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SUMARYAMNT4936_FFIE542',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_SUMARYAMNT4936_FFIE542 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_SUMARYAMNT4936_FFIE542_values)) {
                            $scope.vc.catalogs.VA_SUMARYAMNT4936_FFIE542_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_SUMARYAMNT4936_FFIE542',
                                'cl_oficina',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_SUMARYAMNT4936_FFIE542'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_SUMARYAMNT4936_FFIE542_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_UMMAY4215_41", "VA_SUMARYAMNT4936_FFIE542");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_SUMARYAMNT4936_FFIE542_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_UMMAY4215_41", "VA_SUMARYAMNT4936_FFIE542");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669FFIE22 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UMMAY4215_41.column.Office.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SUMARYAMNT4936_FFIE542",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_UMMAY4215_41.column.Office.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_SUMARYAMNT4936_FFIE542",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_UMMAY4215_41.column.Office.template",
                        'data-validation-code': "{{vc.viewState.QV_UMMAY4215_41.column.Office.validationCode}}",
                        'data-cobis-group': "Group,GR_SUMARYAMNT49_32,0",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UMMAY4215_41.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAWDW_15876',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_SUMARYAMNT4936_CURN691',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_SUMARYAMNT4936_CURN691 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        if (!angular.isDefined($scope.vc.catalogs.VA_SUMARYAMNT4936_CURN691_values)) {
                            $scope.vc.catalogs.VA_SUMARYAMNT4936_CURN691_values = [];
                            $scope.vc.loadCatalogCobis(
                                'VA_SUMARYAMNT4936_CURN691',
                                'cl_moneda',

                            function(response) {
                                if (response.success) {
                                    var catalogResponse = response.data['RESULTVA_SUMARYAMNT4936_CURN691'];
                                    if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                        $scope.vc.catalogs.VA_SUMARYAMNT4936_CURN691_values = catalogResponse;
                                        options.success(catalogResponse);
                                    } else {
                                        options.success([]);
                                    }
                                } else {
                                    options.error();
                                }
                                $scope.vc.setGridComboBoxDefaultValue("QV_UMMAY4215_41", "VA_SUMARYAMNT4936_CURN691");
                            }, options.data.filter, 0);
                        } else {
                            options.success($scope.vc.catalogs.VA_SUMARYAMNT4936_CURN691_values);
                            $scope.vc.setGridComboBoxDefaultValue("QV_UMMAY4215_41", "VA_SUMARYAMNT4936_CURN691");
                        }
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669CURN65 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UMMAY4215_41.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SUMARYAMNT4936_CURN691",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_UMMAY4215_41.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_SUMARYAMNT4936_CURN691",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_UMMAY4215_41.column.Currency.template",
                        'data-validation-code': "{{vc.viewState.QV_UMMAY4215_41.column.Currency.validationCode}}",
                        'data-cobis-group': "Group,GR_SUMARYAMNT49_32,0",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalance = {
                title: 'BUSIN.DLB_BUSIN_LDOECITAL_77904',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_SUMARYAMNT4936_PALN404',
                element: []
            };
            $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669PALN98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SUMARYAMNT4936_PALN404",
                        'data-validation-code': "{{vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.format",
                        'k-decimals': "vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.decimals",
                        'data-cobis-group': "Group,GR_SUMARYAMNT49_32,0",
                        'ng-disabled': "!vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.enabled",
                        'ng-class': "vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate = {
                title: 'BUSIN.DLB_BUSIN_LCPIFEHLL_29397',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_SUMARYAMNT4936_IALE492',
                element: []
            };
            $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669IALE09 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_SUMARYAMNT4936_IALE492",
                        'data-validation-code': "{{vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.format",
                        'k-decimals': "vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.decimals",
                        'data-cobis-group': "Group,GR_SUMARYAMNT49_32,0",
                        'ng-disabled': "!vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.enabled",
                        'ng-class': "vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UMMAY4215_41.columns.push({
                    field: 'Office',
                    title: '{{vc.viewState.QV_UMMAY4215_41.column.Office.title|translate:vc.viewState.QV_UMMAY4215_41.column.Office.titleArgs}}',
                    width: $scope.vc.viewState.QV_UMMAY4215_41.column.Office.width,
                    format: $scope.vc.viewState.QV_UMMAY4215_41.column.Office.format,
                    editor: $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669FFIE22.control,
                    template: "<span ng-class='vc.viewState.QV_UMMAY4215_41.column.Office.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_SUMARYAMNT4936_FFIE542.get(dataItem.Office).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UMMAY4215_41.column.Office.style",
                        "title": "{{vc.viewState.QV_UMMAY4215_41.column.Office.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UMMAY4215_41.column.Office.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UMMAY4215_41.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_UMMAY4215_41.column.Currency.title|translate:vc.viewState.QV_UMMAY4215_41.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_UMMAY4215_41.column.Currency.width,
                    format: $scope.vc.viewState.QV_UMMAY4215_41.column.Currency.format,
                    editor: $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669CURN65.control,
                    template: "<span ng-class='vc.viewState.QV_UMMAY4215_41.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_SUMARYAMNT4936_CURN691.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_UMMAY4215_41.column.Currency.style",
                        "title": "{{vc.viewState.QV_UMMAY4215_41.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_UMMAY4215_41.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UMMAY4215_41.columns.push({
                    field: 'CapitalBalance',
                    title: '{{vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.title|translate:vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.width,
                    format: $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.format,
                    editor: $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669PALN98.control,
                    template: "<span ng-class='vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=CapitalBalance#, vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.style",
                        "title": "{{vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_UMMAY4215_41.columns.push({
                    field: 'CapitalBalanceToDate',
                    title: '{{vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.title|translate:vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.width,
                    format: $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.format,
                    editor: $scope.vc.grids.QV_UMMAY4215_41.AT_SMA669IALE09.control,
                    template: "<span ng-class='vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.element[dataItem.uid].style' ng-bind='kendo.toString(#=CapitalBalanceToDate#, vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.style",
                        "title": "{{vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_UMMAY4215_41.column.CapitalBalanceToDate.hidden
                });
            }
            $scope.vc.viewState.QV_UMMAY4215_41.toolbar = {}
            $scope.vc.grids.QV_UMMAY4215_41.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_45_OTENA94_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_45_OTENA94_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Guardar
            $scope.vc.createViewState({
                id: "CM_OTENA94GAD25",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Recomendacion
            $scope.vc.createViewState({
                id: "CM_OTENA94COM63",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_RECENDAON_73799",
                label: "BUSIN.DLB_BUSIN_RECENDAON_73799",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Affidavit
            $scope.vc.createViewState({
                id: "CM_OTENA94AAI98",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ELACJUMNA_93943",
                label: "BUSIN.DLB_BUSIN_ELACJUMNA_93943",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Hide
            $scope.vc.createViewState({
                id: "CM_OTENA94IDE41",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DELETEVPS_36022",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_VOSOLDTENI3504_CUEY703.read();
                    $scope.vc.catalogs.VA_SUMARYAMNT4936_FFIE542.read();
                    $scope.vc.catalogs.VA_SUMARYAMNT4936_CURN691.read();
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
                $scope.vc.render('VC_OTENA94_SELZT_306');
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
    var cobisMainModule = cobis.createModule("VC_OTENA94_SELZT_306", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_OTENA94_SELZT_306", {
            templateUrl: "VC_OTENA94_SELZT_306_FORM.html",
            controller: "VC_OTENA94_SELZT_306_CTRL",
            labelId: "BUSIN.DLB_BUSIN_NLIOLIDEA_04630",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_OTENA94_SELZT_306?" + $.param(search);
            }
        });
        VC_OTENA94_SELZT_306(cobisMainModule);
    }]);
} else {
    VC_OTENA94_SELZT_306(cobisMainModule);
}