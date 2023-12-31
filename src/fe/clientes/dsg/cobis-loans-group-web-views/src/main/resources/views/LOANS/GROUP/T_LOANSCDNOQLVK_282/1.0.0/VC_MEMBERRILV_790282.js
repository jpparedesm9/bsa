//Designer Generator v 6.4.0.2 - SPR 2018-13 26/06/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.memberrisklevelform = designerEvents.api.memberrisklevelform || designer.dsgEvents();

function VC_MEMBERRILV_790282(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MEMBERRILV_790282_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MEMBERRILV_790282_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "LOANS",
            subModuleId: "GROUP",
            taskId: "T_LOANSCDNOQLVK_282",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MEMBERRILV_790282",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_LOANSCDNOQLVK_282",
        designerEvents.api.memberrisklevelform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: true,
                hasChangeInitDataSupport: false,
                hasSearchRenderEvent: false,
                ejecTemporaryData: false,
                ejecInitData: false,
                ejecChangeInitData: false,
                ejecSearchRenderEvent: false,
                hasTemporaryData: false,
                hasInitData: false,
                hasChangeInitData: false,
                hasCRUDSupport: false,
                vcName: 'VC_MEMBERRILV_790282'
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
                    moduleId: 'LOANS',
                    subModuleId: 'GROUP',
                    taskId: 'T_LOANSCDNOQLVK_282',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    RiskLevel: "RiskLevel",
                    QualificationRange: "QualificationRange",
                    QualificationResult: "QualificationResult",
                    Member: "Member"
                },
                entities: {
                    RiskLevel: {
                        points: 'AT27_POINTSGP994',
                        variableName: 'AT63_VARIABEE994',
                        level: 'AT84_LEVELTXC994',
                        _pks: [],
                        _entityId: 'EN_RISKLEVEE_994',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QualificationRange: {
                        maxValue: 'AT32_MAXVALEU678',
                        minValue: 'AT57_MINVALUU678',
                        description: 'AT79_DESCRIPO678',
                        _pks: [],
                        _entityId: 'EN_QUALIFICA_678',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QualificationResult: {
                        level: 'AT10_LEVELWRH379',
                        points: 'AT89_POINTSRC379',
                        _pks: [],
                        _entityId: 'EN_QUALIFICL_379',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Member: {
                        customerId: 'AT13_CUSTOMDE444',
                        qualification: 'AT16_QUALIFCA444',
                        hasIndividualAccountAux: 'AT17_HASINDUC444',
                        membershipDate: 'AT17_MEMBERIT444',
                        points: 'AT19_POINTSIA444',
                        savingVoluntary: 'AT20_SAVINGTY444',
                        groupId: 'AT27_GROUPIDD444',
                        state: 'AT29_STATEVDB444',
                        creditCode: 'AT40_CREDITCE444',
                        role: 'AT43_ROLEQVSE444',
                        riskLevel: 'AT45_RISKLEVE444',
                        qualificationId: 'AT49_QUALIFIN444',
                        secuential: 'AT51_SECUENIT444',
                        roleId: 'AT64_ROLEDPKV444',
                        level: 'AT65_LEVELGWK444',
                        disconnectionDate: 'AT74_DISCONOI444',
                        ctaIndividual: 'AT77_CTAINDAA444',
                        numberCyclePersonGroup: 'AT85_NUMBERSO444',
                        stateId: 'AT91_STATEIDD444',
                        operation: 'AT92_OPERATIO444',
                        meetingPlace: 'AT94_MEETINAA444',
                        customer: 'AT96_CUSTOMER444',
                        _pks: [],
                        _entityId: 'EN_MEMBERWLM_444',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QUALIFEL_7416 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_QUALIFEL_7416 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUALIFEL_7416_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUALIFEL_7416_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_QUALIFICL_379',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUALIFEL_7416',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUALIFEL_7416_filters = {};
            $scope.vc.queryProperties.Q_QUALIFTC_2992 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_QUALIFTC_2992 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUALIFTC_2992_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUALIFTC_2992_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_QUALIFICA_678',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUALIFTC_2992',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUALIFTC_2992_filters = {};
            $scope.vc.queryProperties.Q_RISKLELL_4750 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_RISKLELL_4750 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_RISKLELL_4750_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_RISKLELL_4750_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_RISKLEVEE_994',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_RISKLELL_4750',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_RISKLELL_4750_filters = {};
            var defaultValues = {
                RiskLevel: {},
                QualificationRange: {},
                QualificationResult: {},
                Member: {}
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
                $scope.vc.execute("temporarySave", VC_MEMBERRILV_790282, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MEMBERRILV_790282, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MEMBERRILV_790282, data, function() {});
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
            $scope.vc.viewState.VC_MEMBERRILV_790282 = {
                style: []
            }
            //ViewState - Group: Group1423
            $scope.vc.createViewState({
                id: "G_MEMBERRLIL_519911",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1423',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_MEMBERRLIL_519911-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1709
            $scope.vc.createViewState({
                id: "G_MEMBERRIES_616911",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1709',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1193
            $scope.vc.createViewState({
                id: "G_MEMBERRVKL_122911",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MATRIZRGO_80297",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.RiskLevel = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    variableName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RiskLevel", "variableName", '')
                    },
                    level: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RiskLevel", "level", '')
                    },
                    points: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("RiskLevel", "points", 0)
                    }
                }
            });
            $scope.vc.model.RiskLevel = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_RISKLELL_4750';
                            var queryRequest = $scope.vc.getRequestQuery_Q_RISKLELL_4750();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_4750_20700',
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
                    model: $scope.vc.types.RiskLevel
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_4750_20700").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_RISKLELL_4750 = $scope.vc.model.RiskLevel;
            $scope.vc.trackers.RiskLevel = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.RiskLevel);
            $scope.vc.model.RiskLevel.bind('change', function(e) {
                $scope.vc.trackers.RiskLevel.track(e);
            });
            $scope.vc.grids.QV_4750_20700 = {};
            $scope.vc.grids.QV_4750_20700.queryId = 'Q_RISKLELL_4750';
            $scope.vc.viewState.QV_4750_20700 = {
                style: undefined
            };
            $scope.vc.viewState.QV_4750_20700.column = {};
            $scope.vc.grids.QV_4750_20700.editable = false;
            $scope.vc.grids.QV_4750_20700.events = {
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
                    $scope.vc.trackers.RiskLevel.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_4750_20700.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_4750_20700");
                    $scope.vc.hideShowColumns("QV_4750_20700", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_4750_20700.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_4750_20700.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_4750_20700.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_4750_20700 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_4750_20700 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_4750_20700.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_4750_20700.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_4750_20700.column.variableName = {
                title: 'LOANS.LBL_LOANS_VARIABLSS_54528',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMRU_451911',
                element: []
            };
            $scope.vc.grids.QV_4750_20700.AT63_VARIABEE994 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4750_20700.column.variableName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMRU_451911",
                        'data-validation-code': "{{vc.viewState.QV_4750_20700.column.variableName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4750_20700.column.variableName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4750_20700.column.level = {
                title: 'LOANS.LBL_LOANS_NIVELHJQC_23857',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVCP_281911',
                element: []
            };
            $scope.vc.grids.QV_4750_20700.AT84_LEVELTXC994 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4750_20700.column.level.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVCP_281911",
                        'data-validation-code': "{{vc.viewState.QV_4750_20700.column.level.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4750_20700.column.level.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4750_20700.column.points = {
                title: 'LOANS.LBL_LOANS_PUNTOSJEK_22270',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSYH_252911',
                element: []
            };
            $scope.vc.grids.QV_4750_20700.AT27_POINTSGP994 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4750_20700.column.points.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSYH_252911",
                        'data-validation-code': "{{vc.viewState.QV_4750_20700.column.points.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4750_20700.column.points.format",
                        'k-decimals': "vc.viewState.QV_4750_20700.column.points.decimals",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4750_20700.column.points.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4750_20700.columns.push({
                    field: 'variableName',
                    title: '{{vc.viewState.QV_4750_20700.column.variableName.title|translate:vc.viewState.QV_4750_20700.column.variableName.titleArgs}}',
                    width: $scope.vc.viewState.QV_4750_20700.column.variableName.width,
                    format: $scope.vc.viewState.QV_4750_20700.column.variableName.format,
                    editor: $scope.vc.grids.QV_4750_20700.AT63_VARIABEE994.control,
                    template: "<span ng-class='vc.viewState.QV_4750_20700.column.variableName.style' ng-bind='vc.getStringColumnFormat(dataItem.variableName, \"QV_4750_20700\", \"variableName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4750_20700.column.variableName.style",
                        "title": "{{vc.viewState.QV_4750_20700.column.variableName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4750_20700.column.variableName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4750_20700.columns.push({
                    field: 'level',
                    title: '{{vc.viewState.QV_4750_20700.column.level.title|translate:vc.viewState.QV_4750_20700.column.level.titleArgs}}',
                    width: $scope.vc.viewState.QV_4750_20700.column.level.width,
                    format: $scope.vc.viewState.QV_4750_20700.column.level.format,
                    editor: $scope.vc.grids.QV_4750_20700.AT84_LEVELTXC994.control,
                    template: "<span ng-class='vc.viewState.QV_4750_20700.column.level.style' ng-bind='vc.getStringColumnFormat(dataItem.level, \"QV_4750_20700\", \"level\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4750_20700.column.level.style",
                        "title": "{{vc.viewState.QV_4750_20700.column.level.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4750_20700.column.level.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4750_20700.columns.push({
                    field: 'points',
                    title: '{{vc.viewState.QV_4750_20700.column.points.title|translate:vc.viewState.QV_4750_20700.column.points.titleArgs}}',
                    width: $scope.vc.viewState.QV_4750_20700.column.points.width,
                    format: $scope.vc.viewState.QV_4750_20700.column.points.format,
                    editor: $scope.vc.grids.QV_4750_20700.AT27_POINTSGP994.control,
                    template: "<span ng-class='vc.viewState.QV_4750_20700.column.points.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.points, \"QV_4750_20700\", \"points\"):kendo.toString(#=points#, vc.viewState.QV_4750_20700.column.points.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4750_20700.column.points.style",
                        "title": "{{vc.viewState.QV_4750_20700.column.points.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4750_20700.column.points.hidden
                });
            }
            $scope.vc.viewState.QV_4750_20700.toolbar = {}
            $scope.vc.grids.QV_4750_20700.toolbar = [];
            //ViewState - Group: Group2603
            $scope.vc.createViewState({
                id: "G_MEMBERRIEE_535911",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_RANGOCALC_14283",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QualificationRange = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QualificationRange", "description", '')
                    },
                    minValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QualificationRange", "minValue", 0)
                    },
                    maxValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QualificationRange", "maxValue", 0)
                    }
                }
            });
            $scope.vc.model.QualificationRange = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_QUALIFTC_2992';
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUALIFTC_2992();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_2992_92227',
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
                    model: $scope.vc.types.QualificationRange
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2992_92227").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUALIFTC_2992 = $scope.vc.model.QualificationRange;
            $scope.vc.trackers.QualificationRange = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QualificationRange);
            $scope.vc.model.QualificationRange.bind('change', function(e) {
                $scope.vc.trackers.QualificationRange.track(e);
            });
            $scope.vc.grids.QV_2992_92227 = {};
            $scope.vc.grids.QV_2992_92227.queryId = 'Q_QUALIFTC_2992';
            $scope.vc.viewState.QV_2992_92227 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2992_92227.column = {};
            $scope.vc.grids.QV_2992_92227.editable = false;
            $scope.vc.grids.QV_2992_92227.events = {
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
                    $scope.vc.trackers.QualificationRange.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2992_92227.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_2992_92227");
                    $scope.vc.hideShowColumns("QV_2992_92227", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2992_92227.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2992_92227.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2992_92227.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2992_92227 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2992_92227 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2992_92227.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2992_92227.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2992_92227.column.description = {
                title: 'LOANS.LBL_LOANS_CALIFICCI_26963',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWMW_921911',
                element: []
            };
            $scope.vc.grids.QV_2992_92227.AT79_DESCRIPO678 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2992_92227.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWMW_921911",
                        'data-validation-code': "{{vc.viewState.QV_2992_92227.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2992_92227.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2992_92227.column.minValue = {
                title: 'LOANS.LBL_LOANS_VALORMNIO_48387',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYEX_549911',
                element: []
            };
            $scope.vc.grids.QV_2992_92227.AT57_MINVALUU678 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2992_92227.column.minValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYEX_549911",
                        'data-validation-code': "{{vc.viewState.QV_2992_92227.column.minValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2992_92227.column.minValue.format",
                        'k-decimals': "vc.viewState.QV_2992_92227.column.minValue.decimals",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2992_92227.column.minValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2992_92227.column.maxValue = {
                title: 'LOANS.LBL_LOANS_VALORMXIM_74827',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGLO_900911',
                element: []
            };
            $scope.vc.grids.QV_2992_92227.AT32_MAXVALEU678 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2992_92227.column.maxValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGLO_900911",
                        'data-validation-code': "{{vc.viewState.QV_2992_92227.column.maxValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2992_92227.column.maxValue.format",
                        'k-decimals': "vc.viewState.QV_2992_92227.column.maxValue.decimals",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2992_92227.column.maxValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2992_92227.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_2992_92227.column.description.title|translate:vc.viewState.QV_2992_92227.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_2992_92227.column.description.width,
                    format: $scope.vc.viewState.QV_2992_92227.column.description.format,
                    editor: $scope.vc.grids.QV_2992_92227.AT79_DESCRIPO678.control,
                    template: "<span ng-class='vc.viewState.QV_2992_92227.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_2992_92227\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2992_92227.column.description.style",
                        "title": "{{vc.viewState.QV_2992_92227.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2992_92227.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2992_92227.columns.push({
                    field: 'minValue',
                    title: '{{vc.viewState.QV_2992_92227.column.minValue.title|translate:vc.viewState.QV_2992_92227.column.minValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_2992_92227.column.minValue.width,
                    format: $scope.vc.viewState.QV_2992_92227.column.minValue.format,
                    editor: $scope.vc.grids.QV_2992_92227.AT57_MINVALUU678.control,
                    template: "<span ng-class='vc.viewState.QV_2992_92227.column.minValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.minValue, \"QV_2992_92227\", \"minValue\"):kendo.toString(#=minValue#, vc.viewState.QV_2992_92227.column.minValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2992_92227.column.minValue.style",
                        "title": "{{vc.viewState.QV_2992_92227.column.minValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2992_92227.column.minValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2992_92227.columns.push({
                    field: 'maxValue',
                    title: '{{vc.viewState.QV_2992_92227.column.maxValue.title|translate:vc.viewState.QV_2992_92227.column.maxValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_2992_92227.column.maxValue.width,
                    format: $scope.vc.viewState.QV_2992_92227.column.maxValue.format,
                    editor: $scope.vc.grids.QV_2992_92227.AT32_MAXVALEU678.control,
                    template: "<span ng-class='vc.viewState.QV_2992_92227.column.maxValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.maxValue, \"QV_2992_92227\", \"maxValue\"):kendo.toString(#=maxValue#, vc.viewState.QV_2992_92227.column.maxValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2992_92227.column.maxValue.style",
                        "title": "{{vc.viewState.QV_2992_92227.column.maxValue.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2992_92227.column.maxValue.hidden
                });
            }
            $scope.vc.viewState.QV_2992_92227.toolbar = {}
            $scope.vc.grids.QV_2992_92227.toolbar = [];
            //ViewState - Group: Group1659
            $scope.vc.createViewState({
                id: "G_MEMBERRKKL_767911",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_RESULTADD_17133",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QualificationResult = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    level: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QualificationResult", "level", '')
                    },
                    points: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QualificationResult", "points", 0)
                    }
                }
            });
            $scope.vc.model.QualificationResult = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_QUALIFEL_7416';
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUALIFEL_7416();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7416_36634',
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
                    model: $scope.vc.types.QualificationResult
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7416_36634").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUALIFEL_7416 = $scope.vc.model.QualificationResult;
            $scope.vc.trackers.QualificationResult = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QualificationResult);
            $scope.vc.model.QualificationResult.bind('change', function(e) {
                $scope.vc.trackers.QualificationResult.track(e);
            });
            $scope.vc.grids.QV_7416_36634 = {};
            $scope.vc.grids.QV_7416_36634.queryId = 'Q_QUALIFEL_7416';
            $scope.vc.viewState.QV_7416_36634 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7416_36634.column = {};
            $scope.vc.grids.QV_7416_36634.editable = false;
            $scope.vc.grids.QV_7416_36634.events = {
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
                    $scope.vc.trackers.QualificationResult.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7416_36634.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7416_36634");
                    $scope.vc.hideShowColumns("QV_7416_36634", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7416_36634.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7416_36634.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7416_36634.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7416_36634 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7416_36634 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7416_36634.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7416_36634.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7416_36634.column.level = {
                title: 'LOANS.LBL_LOANS_CALIFICCC_80806',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTIE_204911',
                element: []
            };
            $scope.vc.grids.QV_7416_36634.AT10_LEVELWRH379 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7416_36634.column.level.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTIE_204911",
                        'data-validation-code': "{{vc.viewState.QV_7416_36634.column.level.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7416_36634.column.level.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7416_36634.column.points = {
                title: 'LOANS.LBL_LOANS_PUNTOSJEK_22270',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNPD_356911',
                element: []
            };
            $scope.vc.grids.QV_7416_36634.AT89_POINTSRC379 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7416_36634.column.points.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNPD_356911",
                        'data-validation-code': "{{vc.viewState.QV_7416_36634.column.points.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7416_36634.column.points.format",
                        'k-decimals': "vc.viewState.QV_7416_36634.column.points.decimals",
                        'data-cobis-group': "GroupLayout,G_MEMBERRIES_616911,3",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7416_36634.column.points.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7416_36634.columns.push({
                    field: 'level',
                    title: '{{vc.viewState.QV_7416_36634.column.level.title|translate:vc.viewState.QV_7416_36634.column.level.titleArgs}}',
                    width: $scope.vc.viewState.QV_7416_36634.column.level.width,
                    format: $scope.vc.viewState.QV_7416_36634.column.level.format,
                    editor: $scope.vc.grids.QV_7416_36634.AT10_LEVELWRH379.control,
                    template: "<span ng-class='vc.viewState.QV_7416_36634.column.level.style' ng-bind='vc.getStringColumnFormat(dataItem.level, \"QV_7416_36634\", \"level\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7416_36634.column.level.style",
                        "title": "{{vc.viewState.QV_7416_36634.column.level.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7416_36634.column.level.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7416_36634.columns.push({
                    field: 'points',
                    title: '{{vc.viewState.QV_7416_36634.column.points.title|translate:vc.viewState.QV_7416_36634.column.points.titleArgs}}',
                    width: $scope.vc.viewState.QV_7416_36634.column.points.width,
                    format: $scope.vc.viewState.QV_7416_36634.column.points.format,
                    editor: $scope.vc.grids.QV_7416_36634.AT89_POINTSRC379.control,
                    template: "<span ng-class='vc.viewState.QV_7416_36634.column.points.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.points, \"QV_7416_36634\", \"points\"):kendo.toString(#=points#, vc.viewState.QV_7416_36634.column.points.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7416_36634.column.points.style",
                        "title": "{{vc.viewState.QV_7416_36634.column.points.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7416_36634.column.points.hidden
                });
            }
            $scope.vc.viewState.QV_7416_36634.toolbar = {}
            $scope.vc.grids.QV_7416_36634.toolbar = [];
            $scope.vc.model.Member = {
                customerId: $scope.vc.channelDefaultValues("Member", "customerId"),
                qualification: $scope.vc.channelDefaultValues("Member", "qualification"),
                hasIndividualAccountAux: $scope.vc.channelDefaultValues("Member", "hasIndividualAccountAux"),
                membershipDate: $scope.vc.channelDefaultValues("Member", "membershipDate"),
                points: $scope.vc.channelDefaultValues("Member", "points"),
                savingVoluntary: $scope.vc.channelDefaultValues("Member", "savingVoluntary"),
                groupId: $scope.vc.channelDefaultValues("Member", "groupId"),
                state: $scope.vc.channelDefaultValues("Member", "state"),
                creditCode: $scope.vc.channelDefaultValues("Member", "creditCode"),
                role: $scope.vc.channelDefaultValues("Member", "role"),
                riskLevel: $scope.vc.channelDefaultValues("Member", "riskLevel"),
                qualificationId: $scope.vc.channelDefaultValues("Member", "qualificationId"),
                secuential: $scope.vc.channelDefaultValues("Member", "secuential"),
                roleId: $scope.vc.channelDefaultValues("Member", "roleId"),
                level: $scope.vc.channelDefaultValues("Member", "level"),
                disconnectionDate: $scope.vc.channelDefaultValues("Member", "disconnectionDate"),
                ctaIndividual: $scope.vc.channelDefaultValues("Member", "ctaIndividual"),
                numberCyclePersonGroup: $scope.vc.channelDefaultValues("Member", "numberCyclePersonGroup"),
                stateId: $scope.vc.channelDefaultValues("Member", "stateId"),
                operation: $scope.vc.channelDefaultValues("Member", "operation"),
                meetingPlace: $scope.vc.channelDefaultValues("Member", "meetingPlace"),
                customer: $scope.vc.channelDefaultValues("Member", "customer")
            };
            //ViewState - Group: Group1442
            $scope.vc.createViewState({
                id: "G_MEMBERRIKV_129911",
                hasId: true,
                componentStyle: [],
                label: 'Group1442',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1562",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSCDNOQLVK_282_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSCDNOQLVK_282_CANCEL",
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
                $scope.vc.render('VC_MEMBERRILV_790282');
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
    var cobisMainModule = cobis.createModule("VC_MEMBERRILV_790282", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_MEMBERRILV_790282", {
            templateUrl: "VC_MEMBERRILV_790282_FORM.html",
            controller: "VC_MEMBERRILV_790282_CTRL",
            labelId: "LOANS.LBL_LOANS_MATRIZRGO_54581",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MEMBERRILV_790282?" + $.param(search);
            }
        });
        VC_MEMBERRILV_790282(cobisMainModule);
    }]);
} else {
    VC_MEMBERRILV_790282(cobisMainModule);
}