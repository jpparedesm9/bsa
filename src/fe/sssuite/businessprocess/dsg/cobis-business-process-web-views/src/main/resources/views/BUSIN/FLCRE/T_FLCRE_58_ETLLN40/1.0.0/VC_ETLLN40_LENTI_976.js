<!-- Designer Generator v 6.0.0 - release SPR 2016-13 08/07/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.tdetailpenalization = designerEvents.api.tdetailpenalization || designer.dsgEvents();

function VC_ETLLN40_LENTI_976(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ETLLN40_LENTI_976_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ETLLN40_LENTI_976_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_58_ETLLN40",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ETLLN40_LENTI_976",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_58_ETLLN40",
        designerEvents.api.tdetailpenalization,
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
                vcName: 'VC_ETLLN40_LENTI_976'
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
                    taskId: 'T_FLCRE_58_ETLLN40',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Exceptions: "Exceptions",
                    HeaderPunishment: "HeaderPunishment"
                },
                entities: {
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
            $scope.vc.queryProperties.Q_EQUETATO_4811 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_EQUETATO_4811 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_EQUETATO_4811_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_EQUETATO_4811_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_EXCEPTINS513',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_EQUETATO_4811',
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
            $scope.vc.queries.Q_EQUETATO_4811_filters = {};
            defaultValues = {
                Exceptions: {},
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
            $scope.vc.viewState.VC_ETLLN40_LENTI_976 = {
                style: []
            }
            //ViewState - Group: Contenedor
            $scope.vc.createViewState({
                id: "GR_VDAILNAIIN43_55",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor',
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
            //ViewState - Group: Panel para HeaderPunishment
            $scope.vc.createViewState({
                id: "GR_VDAILNAIIN43_46",
                hasId: true,
                componentStyle: "",
                label: 'Panel para HeaderPunishment',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: ImpossibilityDescription
            $scope.vc.createViewState({
                id: "VA_VDAILNAIIN4346_EPTI967",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_DEIMIIAPO_40326",
                validationCode: 32,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: DescripNotRecoverGaranties
            $scope.vc.createViewState({
                id: "VA_VDAILNAIIN4346_PNUR684",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_LGACIOLBL_62562",
                validationCode: 32,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: ConsistencyApplication
            $scope.vc.createViewState({
                id: "VA_VDAILNAIIN4346_DTIN019",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_CRCISOLIU_00263",
                validationCode: 32,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: HeaderPunishment, Attribute: Observation
            $scope.vc.createViewState({
                id: "VA_VDAILNAIIN4346_AANS111",
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_COENTARIO_11656",
                validationCode: 32,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_VDAILNAIIN43_57",
                hasId: true,
                componentStyle: "",
                label: "BUSIN.DLB_BUSIN_RQISITOBL_42571",
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
                    Aproved: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Exceptions", "Aproved", false),
                        validation: {
                            AprovedRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    mnemonic: {
                        type: "string",
                        editable: true
                    },
                    description: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Exceptions = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_EQUETATO_4811();
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
                        $("#QV_EQUET4811_32").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_EQUETATO_4811 = $scope.vc.model.Exceptions;
            $scope.vc.trackers.Exceptions = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Exceptions);
            $scope.vc.model.Exceptions.bind('change', function(e) {
                $scope.vc.trackers.Exceptions.track(e);
            });
            $scope.vc.grids.QV_EQUET4811_32 = {};
            $scope.vc.grids.QV_EQUET4811_32.queryId = 'Q_EQUETATO_4811';
            $scope.vc.viewState.QV_EQUET4811_32 = {
                style: undefined
            };
            $scope.vc.viewState.QV_EQUET4811_32.column = {};
            $scope.vc.grids.QV_EQUET4811_32.events = {
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
                },
                edit: function(e) {
                    $scope.vc.grids.QV_EQUET4811_32.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_EQUET4811_32");
                    $scope.vc.hideShowColumns("QV_EQUET4811_32", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_EQUET4811_32.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_EQUET4811_32.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_EQUET4811_32.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_EQUET4811_32 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_EQUET4811_32 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_EQUET4811_32.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_EQUET4811_32.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_EQUET4811_32.column.Aproved = {
                title: 'BUSIN.DLB_BUSIN_ATENDIDOL_17162',
                titleArgs: {},
                tooltip: '',
                width: 50,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_VDAILNAIIN4357_EULT620',
                element: []
            };
            $scope.vc.grids.QV_EQUET4811_32.AT_EXC513EULT52 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_EQUET4811_32.column.Aproved.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_VDAILNAIIN4357_EULT620",
                        'ng-class': 'vc.viewState.QV_EQUET4811_32.column.Aproved.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EQUET4811_32.column.mnemonic = {
                title: 'BUSIN.DLB_BUSIN_NAMEFDOFF_74379',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EQUET4811_32.AT_EXC513NONI25 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 10,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EQUET4811_32.column.mnemonic.enabled",
                        'ng-class': "vc.viewState.QV_EQUET4811_32.column.mnemonic.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_EQUET4811_32.column.description = {
                title: 'BUSIN.DLB_BUSIN_OBSERVACI_93291',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.grids.QV_EQUET4811_32.AT_EXC513RTIO01 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'k-spinners': "false",
                        'maxlength': 50,
                        'type': "text",
                        'class': "k-textbox",
                        'ng-disabled': "!vc.viewState.QV_EQUET4811_32.column.description.enabled",
                        'ng-class': "vc.viewState.QV_EQUET4811_32.column.description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EQUET4811_32.columns.push({
                    field: 'Aproved',
                    title: '{{vc.viewState.QV_EQUET4811_32.column.Aproved.title|translate:vc.viewState.QV_EQUET4811_32.column.Aproved.titleArgs}}',
                    width: $scope.vc.viewState.QV_EQUET4811_32.column.Aproved.width,
                    format: $scope.vc.viewState.QV_EQUET4811_32.column.Aproved.format,
                    editor: $scope.vc.grids.QV_EQUET4811_32.AT_EXC513EULT52.control,
                    template: "<input name='Aproved' type='checkbox' value='#=Aproved#' #=Aproved?checked='checked':''# disabled='disabled' data-bind='value:Aproved' ng-class='vc.viewState.QV_EQUET4811_32.column.Aproved.element[dataItem.uid].style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EQUET4811_32.column.Aproved.style",
                        "title": "{{vc.viewState.QV_EQUET4811_32.column.Aproved.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EQUET4811_32.column.Aproved.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EQUET4811_32.columns.push({
                    field: 'mnemonic',
                    title: '{{vc.viewState.QV_EQUET4811_32.column.mnemonic.title|translate:vc.viewState.QV_EQUET4811_32.column.mnemonic.titleArgs}}',
                    width: $scope.vc.viewState.QV_EQUET4811_32.column.mnemonic.width,
                    format: $scope.vc.viewState.QV_EQUET4811_32.column.mnemonic.format,
                    editor: $scope.vc.grids.QV_EQUET4811_32.AT_EXC513NONI25.control,
                    template: "<span ng-class='vc.viewState.QV_EQUET4811_32.column.mnemonic.element[dataItem.uid].style'>#if (mnemonic !== null) {# #=mnemonic# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EQUET4811_32.column.mnemonic.style",
                        "title": "{{vc.viewState.QV_EQUET4811_32.column.mnemonic.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EQUET4811_32.column.mnemonic.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_EQUET4811_32.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_EQUET4811_32.column.description.title|translate:vc.viewState.QV_EQUET4811_32.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_EQUET4811_32.column.description.width,
                    format: $scope.vc.viewState.QV_EQUET4811_32.column.description.format,
                    editor: $scope.vc.grids.QV_EQUET4811_32.AT_EXC513RTIO01.control,
                    template: "<span ng-class='vc.viewState.QV_EQUET4811_32.column.description.element[dataItem.uid].style'>#if (description !== null) {# #=description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_EQUET4811_32.column.description.style",
                        "title": "{{vc.viewState.QV_EQUET4811_32.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_EQUET4811_32.column.description.hidden
                });
            }
            $scope.vc.viewState.QV_EQUET4811_32.toolbar = {}
            $scope.vc.grids.QV_EQUET4811_32.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_58_ETLLN40_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_58_ETLLN40_CANCEL",
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
                $scope.vc.render('VC_ETLLN40_LENTI_976');
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
    var cobisMainModule = cobis.createModule("VC_ETLLN40_LENTI_976", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_ETLLN40_LENTI_976", {
            templateUrl: "VC_ETLLN40_LENTI_976_FORM.html",
            controller: "VC_ETLLN40_LENTI_976_CTRL",
            label: "TDetailPenalization",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ETLLN40_LENTI_976?" + $.param(search);
            }
        });
        VC_ETLLN40_LENTI_976(cobisMainModule);
    }]);
} else {
    VC_ETLLN40_LENTI_976(cobisMainModule);
}