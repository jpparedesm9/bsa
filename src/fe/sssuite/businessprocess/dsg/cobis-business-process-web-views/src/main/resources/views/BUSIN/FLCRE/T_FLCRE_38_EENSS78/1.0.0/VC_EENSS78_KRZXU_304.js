<!-- Designer Generator v 5.1.0.1603 - release SPR 2016-03 19/02/2016 -->
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.taskexecutivebonusrisk = designerEvents.api.taskexecutivebonusrisk || designer.dsgEvents();

function VC_EENSS78_KRZXU_304(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_EENSS78_KRZXU_304_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_EENSS78_KRZXU_304_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_38_EENSS78",
            taskVersion: "1.0.0",
            viewContainerId: "VC_EENSS78_KRZXU_304",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_38_EENSS78",
        designerEvents.api.taskexecutivebonusrisk,
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
                vcName: 'VC_EENSS78_KRZXU_304'
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
                    taskId: 'T_FLCRE_38_EENSS78',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ExecutiveBonusDetailsRisk: "ExecutiveBonusDetailsRisk",
                    ExecutiveBonusHeaderRisk: "ExecutiveBonusHeaderRisk"
                },
                entities: {
                    ExecutiveBonusDetailsRisk: {
                        agencyId: 'AT_EEB653GNYD42',
                        agencyName: 'AT_EEB653NAME75',
                        AdditionalRiskPercentage: 'AT_EEB653DARR11',
                        GestionRiskPercentage: 'AT_EEB653RIPE66',
                        OfficerName: 'AT_EEB653FRNM28',
                        PositionDescription: 'AT_EEB653PION55',
                        OfficeId: 'AT_EEB653FFCD15',
                        RateDescription: 'AT_EEB653RATE35',
                        TotalAmount: 'AT_EEB653TOTL32',
                        TotalBonus: 'AT_EEB653BNVL34',
                        TotalBonusPrevious: 'AT_EEB653BSPV86',
                        OperationalRiskPercentage: 'AT_EEB653RAEN33',
                        Regional: 'AT_EEB653RONA83',
                        RegionalID: 'AT_EEB653RELI80',
                        _pks: [],
                        _entityId: 'EN_EEBONUETI653',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    ExecutiveBonusHeaderRisk: {
                        startDate: 'AT_HEA971TATA10',
                        endDate: 'AT_HEA971ENDT12',
                        login: 'AT_HEA971LOGN26',
                        registrationDate: 'AT_HEA971TRAN95',
                        riskId: 'AT_HEA971RSID11',
                        processDate: 'AT_HEA971RCES93',
                        _pks: [],
                        _entityId: 'EN_HEADERRSK971',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ECTIBOSD_5101 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_ECTIBOSD_5101 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ECTIBOSD_5101_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ECTIBOSD_5101_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_EEBONUETI653',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ECTIBOSD_5101',
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
            $scope.vc.queries.Q_ECTIBOSD_5101_filters = {};
            defaultValues = {
                ExecutiveBonusDetailsRisk: {},
                ExecutiveBonusHeaderRisk: {}
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
            $scope.vc.viewState.VC_EENSS78_KRZXU_304 = {
                style: []
            }
            //ViewState - Group: Contenedor Plegable
            $scope.vc.createViewState({
                id: "GR_IEWEUTEBSK00_04",
                hasId: true,
                componentStyle: "",
                label: 'Contenedor Plegable',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ExecutiveBonusHeaderRisk = {
                startDate: $scope.vc.channelDefaultValues("ExecutiveBonusHeaderRisk", "startDate"),
                endDate: $scope.vc.channelDefaultValues("ExecutiveBonusHeaderRisk", "endDate"),
                login: $scope.vc.channelDefaultValues("ExecutiveBonusHeaderRisk", "login"),
                registrationDate: $scope.vc.channelDefaultValues("ExecutiveBonusHeaderRisk", "registrationDate"),
                riskId: $scope.vc.channelDefaultValues("ExecutiveBonusHeaderRisk", "riskId"),
                processDate: $scope.vc.channelDefaultValues("ExecutiveBonusHeaderRisk", "processDate")
            };
            //ViewState - Group: Cabecera Riesgo Bono Ejecutivo
            $scope.vc.createViewState({
                id: "GR_IEWEUTEBSK00_05",
                hasId: true,
                componentStyle: "",
                label: 'Cabecera Riesgo Bono Ejecutivo',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExecutiveBonusHeaderRisk, Attribute: startDate
            $scope.vc.createViewState({
                id: "VA_IEWEUTEBSK0005_TATA551",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_STARTDATE_61282",
                label: "BUSIN.DLB_BUSIN_STARTDATE_61282",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExecutiveBonusHeaderRisk, Attribute: login
            $scope.vc.createViewState({
                id: "VA_IEWEUTEBSK0005_LOGN563",
                componentStyle: "",
                label: "DSGNR.SYS_DSGNR_LBLESTETQ_00024",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ExecutiveBonusHeaderRisk, Attribute: endDate
            $scope.vc.createViewState({
                id: "VA_IEWEUTEBSK0005_ENDT177",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_ENDDATENH_77479",
                label: "BUSIN.DLB_BUSIN_ENDDATENH_77479",
                haslabelArgs: true,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Detalle Riesgo Bono Ejecutivo
            $scope.vc.createViewState({
                id: "GR_IEWEUTEBSK00_06",
                hasId: true,
                componentStyle: "",
                label: 'Detalle Riesgo Bono Ejecutivo',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ExecutiveBonusDetailsRisk = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    Regional: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetailsRisk", "Regional", '')
                    },
                    agencyName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetailsRisk", "agencyName", '')
                    },
                    AdditionalRiskPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetailsRisk", "AdditionalRiskPercentage", 0),
                        validation: {
                            AdditionalRiskPercentageCompareInRange: function(input) {
                                return compareInRange(input);
                            }
                        }
                    },
                    GestionRiskPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetailsRisk", "GestionRiskPercentage", 0),
                        validation: {
                            GestionRiskPercentageCompareInRange: function(input) {
                                return compareInRange(input);
                            }
                        }
                    },
                    OperationalRiskPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ExecutiveBonusDetailsRisk", "OperationalRiskPercentage", 0),
                        validation: {
                            OperationalRiskPercentageCompareInRange: function(input) {
                                return compareInRange(input);
                            }
                        }
                    }
                }
            });;
            $scope.vc.model.ExecutiveBonusDetailsRisk = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_ECTIBOSD_5101();
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
                    model: $scope.vc.types.ExecutiveBonusDetailsRisk
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message == 'DeletingError') {
                        $("#QV_ECTIB5101_92").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ECTIBOSD_5101 = $scope.vc.model.ExecutiveBonusDetailsRisk;
            $scope.vc.trackers.ExecutiveBonusDetailsRisk = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ExecutiveBonusDetailsRisk);
            $scope.vc.model.ExecutiveBonusDetailsRisk.bind('change', function(e) {
                $scope.vc.trackers.ExecutiveBonusDetailsRisk.track(e);
            });
            $scope.vc.grids.QV_ECTIB5101_92 = {};
            $scope.vc.grids.QV_ECTIB5101_92.queryId = 'Q_ECTIBOSD_5101';
            $scope.vc.viewState.QV_ECTIB5101_92 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ECTIB5101_92.column = {};
            $scope.vc.grids.QV_ECTIB5101_92.events = {
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
                    $scope.vc.trackers.ExecutiveBonusDetailsRisk.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    var columnIndex = this.cellIndex(e.container);
                    var fieldName = this.thead.find("th").eq(columnIndex).data("field");
                    if (angular.isDefined($scope.vc.viewState.QV_ECTIB5101_92.column[fieldName]) && $scope.vc.viewState.QV_ECTIB5101_92.column[fieldName].enabled === false) {
                        this.closeCell();
                        return;
                    }
                    $scope.vc.grids.QV_ECTIB5101_92.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_ECTIB5101_92");
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_ECTIB5101_92.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_ECTIB5101_92.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_ECTIB5101_92.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_ECTIB5101_92 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_ECTIB5101_92 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                save: function(e) {
                    e.sender.dataSource.sync();
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_ECTIB5101_92.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ECTIB5101_92.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ECTIB5101_92.column.Regional = {
                title: 'BUSIN.DLB_BUSIN_REGIONALO_33554',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_REGIONALO_33554',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IEWEUTEBSK0006_RONA106',
                element: []
            };
            $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653RONA83 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.Regional.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_REGIONALO_33554'|translate}}",
                        'id': "VA_IEWEUTEBSK0006_RONA106",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_ECTIB5101_92.column.Regional.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_IEWEUTEBSK00_04,1",
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.Regional.enabled",
                        'ng-class': "vc.viewState.QV_ECTIB5101_92.column.Regional.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECTIB5101_92.column.agencyName = {
                title: 'BUSIN.DLB_BUSIN_AGENCYKWR_29533',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_AGENCYKWR_29533',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_IEWEUTEBSK0006_NAME648',
                element: []
            };
            $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653NAME75 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.agencyName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_AGENCYKWR_29533'|translate}}",
                        'id': "VA_IEWEUTEBSK0006_NAME648",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_ECTIB5101_92.column.agencyName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "Group,GR_IEWEUTEBSK00_04,1",
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.agencyName.enabled",
                        'ng-class': "vc.viewState.QV_ECTIB5101_92.column.agencyName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage = {
                title: 'BUSIN.DLB_BUSIN_DDTNAIPRA_78376',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_DDTNAIPRA_78376',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "##0.00",
                decimals: 2,
                suffix: "%",
                style: [],
                validationCode: 2,
                componentId: 'VA_IEWEUTEBSK0006_DARR243',
                element: []
            };
            $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653DARR11 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_DDTNAIPRA_78376'|translate}}",
                        'id': "VA_IEWEUTEBSK0006_DARR243",
                        'maxlength': 23,
                        'compare-in-range': "",
                        'data-compareInRange-msg': $filter('translate')('BUSIN.DLB_BUSIN_VOTOFRANG_36969'),
                        'compare-min': "0",
                        'compare-max': "100",
                        'data-validation-code': "{{vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.format",
                        'k-decimals': "vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.decimals",
                        'data-cobis-group': "Group,GR_IEWEUTEBSK00_04,1",
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.enabled",
                        'ng-class': "vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.element['" + options.model.uid + "'].style"
                    });
                    var inputGroup = $('<div/>', {
                        'class': 'input-group'
                    });
                    textInput.addClass('form-control');
                    textInput.appendTo(inputGroup);
                    var colSuffix = 'vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.suffix';
                    var cellSuffix = 'vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.element[\'' + options.model.uid + '\'].suffix';
                    var suffixExp = cellSuffix + '?' + cellSuffix + ':' + colSuffix;
                    var suffixAddon = $('<div/>', {
                        'class': 'input-group-addon',
                        'ng-bind': 'kendo.toString(' + suffixExp + ', \'\')'
                    });
                    suffixAddon.appendTo(inputGroup);
                    inputGroup.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage = {
                title: 'BUSIN.DLB_BUSIN_TIOPENTAJ_78148',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_TIOPENTAJ_78148',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "##0.00",
                decimals: 2,
                suffix: "%",
                style: [],
                validationCode: 2,
                componentId: 'VA_IEWEUTEBSK0006_RIPE512',
                element: []
            };
            $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653RIPE66 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_TIOPENTAJ_78148'|translate}}",
                        'id': "VA_IEWEUTEBSK0006_RIPE512",
                        'maxlength': 13,
                        'compare-in-range': "",
                        'data-compareInRange-msg': $filter('translate')('BUSIN.DLB_BUSIN_VOTOFRANG_36969'),
                        'compare-min': "0",
                        'compare-max': "100",
                        'data-validation-code': "{{vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.format",
                        'k-decimals': "vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.decimals",
                        'data-cobis-group': "Group,GR_IEWEUTEBSK00_04,1",
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.enabled",
                        'ng-class': "vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.element['" + options.model.uid + "'].style"
                    });
                    var inputGroup = $('<div/>', {
                        'class': 'input-group'
                    });
                    textInput.addClass('form-control');
                    textInput.appendTo(inputGroup);
                    var colSuffix = 'vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.suffix';
                    var cellSuffix = 'vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.element[\'' + options.model.uid + '\'].suffix';
                    var suffixExp = cellSuffix + '?' + cellSuffix + ':' + colSuffix;
                    var suffixAddon = $('<div/>', {
                        'class': 'input-group-addon',
                        'ng-bind': 'kendo.toString(' + suffixExp + ', \'\')'
                    });
                    suffixAddon.appendTo(inputGroup);
                    inputGroup.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage = {
                title: 'BUSIN.DLB_BUSIN_PRCTAEERN_99525',
                titleArgs: {},
                tooltip: 'BUSIN.DLB_BUSIN_PRCTAEERN_99525',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "##0.00",
                decimals: 2,
                suffix: "%",
                style: [],
                validationCode: 2,
                componentId: 'VA_IEWEUTEBSK0006_RAEN731',
                element: []
            };
            $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653RAEN33 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'title': "{{'BUSIN.DLB_BUSIN_PRCTAEERN_99525'|translate}}",
                        'id': "VA_IEWEUTEBSK0006_RAEN731",
                        'maxlength': 23,
                        'compare-in-range': "",
                        'data-compareInRange-msg': $filter('translate')('BUSIN.DLB_BUSIN_VOTOFRANG_36969'),
                        'compare-min': "0",
                        'compare-max': "100",
                        'data-validation-code': "{{vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.format",
                        'k-decimals': "vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.decimals",
                        'data-cobis-group': "Group,GR_IEWEUTEBSK00_04,1",
                        'ng-disabled': "!vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.enabled",
                        'ng-class': "vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.element['" + options.model.uid + "'].style"
                    });
                    var inputGroup = $('<div/>', {
                        'class': 'input-group'
                    });
                    textInput.addClass('form-control');
                    textInput.appendTo(inputGroup);
                    var colSuffix = 'vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.suffix';
                    var cellSuffix = 'vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.element[\'' + options.model.uid + '\'].suffix';
                    var suffixExp = cellSuffix + '?' + cellSuffix + ':' + colSuffix;
                    var suffixAddon = $('<div/>', {
                        'class': 'input-group-addon',
                        'ng-bind': 'kendo.toString(' + suffixExp + ', \'\')'
                    });
                    suffixAddon.appendTo(inputGroup);
                    inputGroup.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECTIB5101_92.columns.push({
                    field: 'Regional',
                    title: '{{vc.viewState.QV_ECTIB5101_92.column.Regional.title|translate:vc.viewState.QV_ECTIB5101_92.column.Regional.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECTIB5101_92.column.Regional.width,
                    format: $scope.vc.viewState.QV_ECTIB5101_92.column.Regional.format,
                    editor: $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653RONA83.control,
                    template: "<span ng-class='vc.viewState.QV_ECTIB5101_92.column.Regional.element[dataItem.uid].style'>#if (Regional !== null) {# #=Regional# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECTIB5101_92.column.Regional.style",
                        "title": "{{vc.viewState.QV_ECTIB5101_92.column.Regional.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECTIB5101_92.column.Regional.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECTIB5101_92.columns.push({
                    field: 'agencyName',
                    title: '{{vc.viewState.QV_ECTIB5101_92.column.agencyName.title|translate:vc.viewState.QV_ECTIB5101_92.column.agencyName.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECTIB5101_92.column.agencyName.width,
                    format: $scope.vc.viewState.QV_ECTIB5101_92.column.agencyName.format,
                    editor: $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653NAME75.control,
                    template: "<span ng-class='vc.viewState.QV_ECTIB5101_92.column.agencyName.element[dataItem.uid].style'>#if (agencyName !== null) {# #=agencyName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ECTIB5101_92.column.agencyName.style",
                        "title": "{{vc.viewState.QV_ECTIB5101_92.column.agencyName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECTIB5101_92.column.agencyName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECTIB5101_92.columns.push({
                    field: 'AdditionalRiskPercentage',
                    title: '{{vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.title|translate:vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.width,
                    format: $scope.vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.format,
                    editor: $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653DARR11.control,
                    template: "<span ng-class='vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=AdditionalRiskPercentage#, vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.style",
                        "title": "{{vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECTIB5101_92.column.AdditionalRiskPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECTIB5101_92.columns.push({
                    field: 'GestionRiskPercentage',
                    title: '{{vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.title|translate:vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.width,
                    format: $scope.vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.format,
                    editor: $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653RIPE66.control,
                    template: "<span ng-class='vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=GestionRiskPercentage#, vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.style",
                        "title": "{{vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECTIB5101_92.column.GestionRiskPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ECTIB5101_92.columns.push({
                    field: 'OperationalRiskPercentage',
                    title: '{{vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.title|translate:vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.width,
                    format: $scope.vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.format,
                    editor: $scope.vc.grids.QV_ECTIB5101_92.AT_EEB653RAEN33.control,
                    template: "<span ng-class='vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.element[dataItem.uid].style' ng-bind='kendo.toString(#=OperationalRiskPercentage#, vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.style",
                        "title": "{{vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ECTIB5101_92.column.OperationalRiskPercentage.hidden
                });
            }
            $scope.vc.viewState.QV_ECTIB5101_92.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_ECTIB5101_92.toolbar = {}
            $scope.vc.grids.QV_ECTIB5101_92.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_38_EENSS78_ACCEPT",
                componentStyle: "",
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_38_EENSS78_CANCEL",
                componentStyle: "",
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Save
            $scope.vc.createViewState({
                id: "CM_EENSS78SVE49",
                componentStyle: "",
                tooltip: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                haslabelArgs: true,
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
                $scope.vc.render('VC_EENSS78_KRZXU_304');
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
    var cobisMainModule = cobis.createModule("VC_EENSS78_KRZXU_304", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_EENSS78_KRZXU_304", {
            templateUrl: "VC_EENSS78_KRZXU_304_FORM.html",
            controller: "VC_EENSS78_KRZXU_304_CTRL",
            labelId: "BUSIN.DLB_BUSIN_KPARETNNS_31731",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_EENSS78_KRZXU_304?" + $.param(search);
            }
        });
        VC_EENSS78_KRZXU_304(cobisMainModule);
    }]);
} else {
    VC_EENSS78_KRZXU_304(cobisMainModule);
}