<!-- Designer Generator v 6.0.0 - release SPR 2016-16 19/08/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tpunishment = designerEvents.api.tpunishment || designer.dsgEvents();

function VC_TUIHT20_TIHNT_960(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_TUIHT20_TIHNT_960_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_TUIHT20_TIHNT_960_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_98_TUIHT20",
            taskVersion: "1.0.0",
            viewContainerId: "VC_TUIHT20_TIHNT_960",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_98_TUIHT20",
        designerEvents.api.tpunishment,
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
                vcName: 'VC_TUIHT20_TIHNT_960'
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
                    taskId: 'T_FLCRE_98_TUIHT20',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Punishment: "Punishment",
                    HeaderPunishment: "HeaderPunishment"
                },
                entities: {
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
            $scope.vc.queryProperties.Q_URPUHENT_4848 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_URPUHENT_4848 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_URPUHENT_4848_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_URPUHENT_4848_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PUNISMENT293',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_URPUHENT_4848',
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
            $scope.vc.queries.Q_URPUHENT_4848_filters = {};
            defaultValues = {
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
            $scope.vc.viewState.VC_TUIHT20_TIHNT_960 = {
                style: []
            }
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_VIWPUISHMN43_03",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
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
            //ViewState - Group: Panel Plegable para Punishment
            $scope.vc.createViewState({
                id: "GR_VIWPUISHMN43_04",
                hasId: true,
                componentStyle: "",
                label: 'Panel Plegable para Punishment',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: CourtDate
            $scope.vc.createViewState({
                id: "VA_VIWPUISHMN4304_ORTT692",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_ECHAECORE_43828",
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: OfficialGrant
            $scope.vc.createViewState({
                id: "VA_VIWPUISHMN4304_CIRA537",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_OFFICIALR_02742",
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Operaciones Candidatas
            $scope.vc.createViewState({
                id: "GR_VIWPUISHMN43_05",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_PRESNDIDA_36580",
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
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "Operation", 0)
                    },
                    Bank: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "Bank", '')
                    },
                    DescriptionClient: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "DescriptionClient", '')
                    },
                    OperationStatus: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "OperationStatus", '')
                    },
                    CapitalBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "CapitalBalance", 0)
                    },
                    InterestBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "InterestBalance", 0)
                    },
                    MoraBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "MoraBalance", 0)
                    },
                    OtherBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "OtherBalance", 0)
                    },
                    LastPaymentDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "LastPaymentDate", '')
                    },
                    MoraDay: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Punishment", "MoraDay", 0)
                    },
                    IdClient: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Punishment = new kendo.data.DataSource({
                pageSize: 8,
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_URPUHENT_4848();
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
                        $("#QV_URPUH4848_33").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_URPUHENT_4848 = $scope.vc.model.Punishment;
            $scope.vc.trackers.Punishment = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Punishment);
            $scope.vc.model.Punishment.bind('change', function(e) {
                $scope.vc.trackers.Punishment.track(e);
            });
            $scope.vc.grids.QV_URPUH4848_33 = {};
            $scope.vc.grids.QV_URPUH4848_33.queryId = 'Q_URPUHENT_4848';
            $scope.vc.viewState.QV_URPUH4848_33 = {
                style: undefined
            };
            $scope.vc.viewState.QV_URPUH4848_33.column = {};
            $scope.vc.grids.QV_URPUH4848_33.events = {
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
                },
                edit: function(e) {
                    $scope.vc.grids.QV_URPUH4848_33.selectedRow = e.model;
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
                    $scope.vc.exportGrid(e, 'QV_URPUH4848_33', this.dataSource);
                },
                excel: {
                    fileName: 'Operaciones Candidatas.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'Operaciones Candidatas.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_URPUH4848_33");
                    $scope.vc.hideShowColumns("QV_URPUH4848_33", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_URPUH4848_33.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_URPUH4848_33.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_URPUH4848_33.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_URPUH4848_33 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_URPUH4848_33 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_URPUH4848_33.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_URPUH4848_33.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_URPUH4848_33.column.Operation = {
                title: 'BUSIN.DLB_BUSIN_OPERATION_65031',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "####",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_ORAN627',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293ORAN64 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.Operation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_ORAN627",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.Operation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URPUH4848_33.column.Operation.format",
                        'k-decimals': "vc.viewState.QV_URPUH4848_33.column.Operation.decimals",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.Operation.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.Operation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.Bank = {
                title: 'BUSIN.DLB_BUSIN_PRTIONLBL_84607',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_BANK547',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293BANK04 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.Bank.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_BANK547",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.Bank.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.Bank.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.Bank.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.DescriptionClient = {
                title: 'BUSIN.DLB_BUSIN_CLIENTZXD_06072',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_SRIE174',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293SRIE62 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.DescriptionClient.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_SRIE174",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.DescriptionClient.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.DescriptionClient.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.DescriptionClient.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.OperationStatus = {
                title: 'BUSIN.DLB_BUSIN_OPERINSTU_68077',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_RANS214',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293RANS20 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.OperationStatus.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_RANS214",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.OperationStatus.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.OperationStatus.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.OperationStatus.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.CapitalBalance = {
                title: 'BUSIN.DLB_BUSIN_CPTALBLAE_05361',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_ATBC323',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293ATBC16 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.CapitalBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_ATBC323",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.CapitalBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URPUH4848_33.column.CapitalBalance.format",
                        'k-decimals': "vc.viewState.QV_URPUH4848_33.column.CapitalBalance.decimals",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.CapitalBalance.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.CapitalBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.InterestBalance = {
                title: 'BUSIN.DLB_BUSIN_IRSTBANCE_90059',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_RBAE366',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293RBAE33 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.InterestBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_RBAE366",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.InterestBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URPUH4848_33.column.InterestBalance.format",
                        'k-decimals': "vc.viewState.QV_URPUH4848_33.column.InterestBalance.decimals",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.InterestBalance.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.InterestBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.MoraBalance = {
                title: 'BUSIN.DLB_BUSIN_MBLANCOMA_42402',
                titleArgs: {},
                tooltip: '',
                width: 70,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_ORAA384',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293ORAA65 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.MoraBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_ORAA384",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.MoraBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URPUH4848_33.column.MoraBalance.format",
                        'k-decimals': "vc.viewState.QV_URPUH4848_33.column.MoraBalance.decimals",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.MoraBalance.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.MoraBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.OtherBalance = {
                title: 'BUSIN.DLB_BUSIN_TRAANYENL_49261',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_TBAC154',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293TBAC22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.OtherBalance.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_TBAC154",
                        'maxlength': 103,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.OtherBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URPUH4848_33.column.OtherBalance.format",
                        'k-decimals': "vc.viewState.QV_URPUH4848_33.column.OtherBalance.decimals",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.OtherBalance.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.OtherBalance.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.LastPaymentDate = {
                title: 'BUSIN.DLB_BUSIN_LATPANTDE_48999',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_SMNE622',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293SMNE22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_SMNE622",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.MoraDay = {
                title: 'BUSIN.DLB_BUSIN_MORADAYXD_68877',
                titleArgs: {},
                tooltip: '',
                width: 60,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_VIWPUISHMN4305_MADY798',
                element: []
            };
            $scope.vc.grids.QV_URPUH4848_33.AT_PUN293MADY02 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.MoraDay.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VIWPUISHMN4305_MADY798",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_URPUH4848_33.column.MoraDay.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_URPUH4848_33.column.MoraDay.format",
                        'k-decimals': "vc.viewState.QV_URPUH4848_33.column.MoraDay.decimals",
                        'data-cobis-group': "Group,GR_VIWPUISHMN43_03,1",
                        'ng-disabled': "!vc.viewState.QV_URPUH4848_33.column.MoraDay.enabled",
                        'ng-class': "vc.viewState.QV_URPUH4848_33.column.MoraDay.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_URPUH4848_33.column.IdClient = {
                title: 'IdClient',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'Operation',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.Operation.title|translate:vc.viewState.QV_URPUH4848_33.column.Operation.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.Operation.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.Operation.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293ORAN64.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.Operation.element[dataItem.uid].style' ng-bind='kendo.toString(#=Operation#, vc.viewState.QV_URPUH4848_33.column.Operation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.Operation.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.Operation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.Operation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'Bank',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.Bank.title|translate:vc.viewState.QV_URPUH4848_33.column.Bank.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.Bank.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.Bank.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293BANK04.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.Bank.element[dataItem.uid].style'>#if (Bank !== null) {# #=Bank# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.Bank.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.Bank.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.Bank.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'DescriptionClient',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.DescriptionClient.title|translate:vc.viewState.QV_URPUH4848_33.column.DescriptionClient.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.DescriptionClient.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.DescriptionClient.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293SRIE62.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.DescriptionClient.element[dataItem.uid].style'>#if (DescriptionClient !== null) {# #=DescriptionClient# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.DescriptionClient.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.DescriptionClient.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.DescriptionClient.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'OperationStatus',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.OperationStatus.title|translate:vc.viewState.QV_URPUH4848_33.column.OperationStatus.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.OperationStatus.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.OperationStatus.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293RANS20.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.OperationStatus.element[dataItem.uid].style'>#if (OperationStatus !== null) {# #=OperationStatus# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.OperationStatus.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.OperationStatus.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.OperationStatus.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'CapitalBalance',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.CapitalBalance.title|translate:vc.viewState.QV_URPUH4848_33.column.CapitalBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.CapitalBalance.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.CapitalBalance.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293ATBC16.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.CapitalBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=CapitalBalance#, vc.viewState.QV_URPUH4848_33.column.CapitalBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.CapitalBalance.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.CapitalBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.CapitalBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'InterestBalance',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.InterestBalance.title|translate:vc.viewState.QV_URPUH4848_33.column.InterestBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.InterestBalance.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.InterestBalance.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293RBAE33.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.InterestBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=InterestBalance#, vc.viewState.QV_URPUH4848_33.column.InterestBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.InterestBalance.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.InterestBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.InterestBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'MoraBalance',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.MoraBalance.title|translate:vc.viewState.QV_URPUH4848_33.column.MoraBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.MoraBalance.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.MoraBalance.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293ORAA65.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.MoraBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=MoraBalance#, vc.viewState.QV_URPUH4848_33.column.MoraBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.MoraBalance.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.MoraBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.MoraBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'OtherBalance',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.OtherBalance.title|translate:vc.viewState.QV_URPUH4848_33.column.OtherBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.OtherBalance.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.OtherBalance.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293TBAC22.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.OtherBalance.element[dataItem.uid].style' ng-bind='kendo.toString(#=OtherBalance#, vc.viewState.QV_URPUH4848_33.column.OtherBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.OtherBalance.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.OtherBalance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.OtherBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'LastPaymentDate',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.title|translate:vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293SMNE22.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.element[dataItem.uid].style'>#if (LastPaymentDate !== null) {# #=LastPaymentDate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.LastPaymentDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    field: 'MoraDay',
                    title: '{{vc.viewState.QV_URPUH4848_33.column.MoraDay.title|translate:vc.viewState.QV_URPUH4848_33.column.MoraDay.titleArgs}}',
                    width: $scope.vc.viewState.QV_URPUH4848_33.column.MoraDay.width,
                    format: $scope.vc.viewState.QV_URPUH4848_33.column.MoraDay.format,
                    editor: $scope.vc.grids.QV_URPUH4848_33.AT_PUN293MADY02.control,
                    template: "<span ng-class='vc.viewState.QV_URPUH4848_33.column.MoraDay.element[dataItem.uid].style' ng-bind='kendo.toString(#=MoraDay#, vc.viewState.QV_URPUH4848_33.column.MoraDay.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_URPUH4848_33.column.MoraDay.style",
                        "title": "{{vc.viewState.QV_URPUH4848_33.column.MoraDay.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_URPUH4848_33.column.MoraDay.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_URPUH4848_33.column.VA_VIWPUISHMN4305_CTDT569 = {
                    tooltip: 'BUSIN.DLB_BUSIN_NCIRESDSO_19572',
                    imageId: 'fa fa-cog',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                };
                $scope.vc.grids.QV_URPUH4848_33.columns.push({
                    command: {
                        name: "VA_VIWPUISHMN4305_CTDT569",
                        entity: "Punishment",
                        text: "{{'BUSIN.DLB_BUSIN_PROCESARL_81050'|translate}}",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'cb-btn-custom-procesar':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_VIWPUISHMN4305_CTDT569\", " + "vc.viewState.QV_URPUH4848_33.column.VA_VIWPUISHMN4305_CTDT569.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_URPUH4848_33.column.VA_VIWPUISHMN4305_CTDT569.enabled' " + "data-ng-click = 'vc.grids.QV_URPUH4848_33.events.customRowClick($event, \"VA_VIWPUISHMN4305_CTDT569\", \"#:entity#\", \"QV_URPUH4848_33\")' " + "title = \"{{vc.viewState.QV_URPUH4848_33.column.VA_VIWPUISHMN4305_CTDT569.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_URPUH4848_33.column.VA_VIWPUISHMN4305_CTDT569.imageId'></span>" + "</a>"
                    },
                    width: 60,
                    attributes: {
                        "class": "btn-toolbar"
                    }
                });
            }
            $scope.vc.viewState.QV_URPUH4848_33.toolbar = {}
            $scope.vc.grids.QV_URPUH4848_33.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_URPUH4848_33.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_98_TUIHT20_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_98_TUIHT20_CANCEL",
                componentStyle: "",
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
                $scope.vc.render('VC_TUIHT20_TIHNT_960');
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
    var cobisMainModule = cobis.createModule("VC_TUIHT20_TIHNT_960", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_TUIHT20_TIHNT_960", {
            templateUrl: "VC_TUIHT20_TIHNT_960_FORM.html",
            controller: "VC_TUIHT20_TIHNT_960_CTRL",
            labelId: "BUSIN.DLB_BUSIN_ISDOPENST_33659",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_TUIHT20_TIHNT_960?" + $.param(search);
            }
        });
        VC_TUIHT20_TIHNT_960(cobisMainModule);
    }]);
} else {
    VC_TUIHT20_TIHNT_960(cobisMainModule);
}