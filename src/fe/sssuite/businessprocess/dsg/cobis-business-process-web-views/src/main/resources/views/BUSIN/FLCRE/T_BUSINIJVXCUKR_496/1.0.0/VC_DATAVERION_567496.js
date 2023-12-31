//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.dataverificationquestions = designerEvents.api.dataverificationquestions || designer.dsgEvents();

function VC_DATAVERION_567496(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DATAVERION_567496_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DATAVERION_567496_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_BUSINIJVXCUKR_496",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DATAVERION_567496",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_BUSINIJVXCUKR_496",
        designerEvents.api.dataverificationquestions,
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
                vcName: 'VC_DATAVERION_567496'
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
                    taskId: 'T_BUSINIJVXCUKR_496',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    QuestionsPartOne: "QuestionsPartOne",
                    QuestionsPartTwo: "QuestionsPartTwo",
                    QuestionsPartThree: "QuestionsPartThree",
                    Context: "Context"
                },
                entities: {
                    QuestionsPartOne: {
                        description: 'AT70_DESCRIOO589',
                        number: 'AT79_NUMBERUG589',
                        answer: 'AT91_ANSWERNG589',
                        _pks: [],
                        _entityId: 'EN_QUESTIOPN_589',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QuestionsPartTwo: {
                        number: 'AT25_NUMBERBO177',
                        description: 'AT40_DESCRIIT177',
                        answer: 'AT94_ANSWERJK177',
                        _pks: [],
                        _entityId: 'EN_QUESTIOAA_177',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QuestionsPartThree: {
                        cellType: 'AT12_CELLTYPP840',
                        frequencyUseEM: 'AT21_FREQUEYY840',
                        codeQuestion5: 'AT25_CODEQUT5840',
                        frequencyUseEMAnswer: 'AT34_FREQUEAE840',
                        haveEmailAnswer: 'AT34_HAVEEMRL840',
                        codeQuestion1: 'AT43_CODEQUNN840',
                        socialNetworks: 'AT44_SOCIALKN840',
                        result: 'AT55_RESULTLJ840',
                        codeQuestion2: 'AT67_CODEQUON840',
                        enableView: 'AT70_ENABLEIV840',
                        codeQuestion3: 'AT78_CODEQUST840',
                        paymentMethodPhone: 'AT79_PAYMENEO840',
                        cellTypeAnswer: 'AT81_CELLTYAW840',
                        paymentMethodPhoneAnswer: 'AT83_PAYMENMS840',
                        haveEmail: 'AT85_HAVEEMIL840',
                        codeQuestion4: 'AT87_CODEQUSN840',
                        socialNetworksAnswer: 'AT92_SOCIALNS840',
                        _pks: [],
                        _entityId: 'EN_QUESTIOSE_840',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        amountApproved: 'AT10_AMOUNTPP762',
                        amountRequested: 'AT37_AMOUNTUE762',
                        cycleNumber: 'AT60_CYCLENEM762',
                        synchronize: 'AT88_SYNCHRZZ762',
                        enable: 'AT91_ENABLEZV762',
                        ApplicationSubject: 'AT_CON762ACAO34',
                        Application: 'AT_CON762APCI65',
                        Bookmark: 'AT_CON762BKAK11',
                        CustomerId: 'AT_CON762CSTE68',
                        RequestId: 'AT_CON762EUTD32',
                        Flag1: 'AT_CON762FAG158',
                        Flag2: 'AT_CON762FLA211',
                        Type: 'AT_CON762FLAG45',
                        TaskCountLap: 'AT_CON762QSTA85',
                        RequestName: 'AT_CON762QUME09',
                        RequestType: 'AT_CON762QUTP71',
                        RequestStage: 'AT_CON762STAE19',
                        TaskSubject: 'AT_CON762TSUT41',
                        _pks: [],
                        _entityId: 'EN_CONTEXTTB762',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QUESTINO_5932 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_QUESTINO_5932 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUESTINO_5932_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUESTINO_5932_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_QUESTIOPN_589',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUESTINO_5932',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUESTINO_5932_filters = {};
            $scope.vc.queryProperties.Q_QUESTIRO_7780 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_QUESTIRO_7780 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QUESTIRO_7780_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QUESTIRO_7780_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_QUESTIOAA_177',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QUESTIRO_7780',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_QUESTIRO_7780_filters = {};
            var defaultValues = {
                QuestionsPartOne: {},
                QuestionsPartTwo: {},
                QuestionsPartThree: {},
                Context: {}
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
                $scope.vc.execute("temporarySave", VC_DATAVERION_567496, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DATAVERION_567496, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DATAVERION_567496, data, function() {});
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
            $scope.vc.viewState.VC_DATAVERION_567496 = {
                style: []
            }
            //ViewState - Group: Group1505
            $scope.vc.createViewState({
                id: "G_DATAVERNNO_570108",
                hasId: true,
                componentStyle: [],
                label: 'Group1505',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2448",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_193108",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CUESTIOAR_92189",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2449",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1550
            $scope.vc.createViewState({
                id: "G_DATAVERAAT_911108",
                hasId: true,
                componentStyle: [],
                label: 'Group1550',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_440108",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VERIFICLT_89510",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2700
            $scope.vc.createViewState({
                id: "G_DATAVERFQE_911108",
                hasId: true,
                componentStyle: [],
                label: 'Group2700',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QuestionsPartOne = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    number: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuestionsPartOne", "number", 0)
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuestionsPartOne", "description", '')
                    },
                    answer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuestionsPartOne", "answer", '')
                    }
                }
            });
            $scope.vc.model.QuestionsPartOne = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_QUESTINO_5932';
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUESTINO_5932();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_5932_10558',
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
                    model: $scope.vc.types.QuestionsPartOne
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_5932_10558").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUESTINO_5932 = $scope.vc.model.QuestionsPartOne;
            $scope.vc.trackers.QuestionsPartOne = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QuestionsPartOne);
            $scope.vc.model.QuestionsPartOne.bind('change', function(e) {
                $scope.vc.trackers.QuestionsPartOne.track(e);
            });
            $scope.vc.grids.QV_5932_10558 = {};
            $scope.vc.grids.QV_5932_10558.queryId = 'Q_QUESTINO_5932';
            $scope.vc.viewState.QV_5932_10558 = {
                style: undefined
            };
            $scope.vc.viewState.QV_5932_10558.column = {};
            $scope.vc.grids.QV_5932_10558.editable = {
                mode: 'incell',
            };
            $scope.vc.grids.QV_5932_10558.events = {
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
                    $scope.vc.trackers.QuestionsPartOne.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    var columnIndex = this.cellIndex(e.container);
                    var fieldName = this.thead.find("th").eq(columnIndex).data("field");
                    if (angular.isDefined($scope.vc.viewState.QV_5932_10558.column[fieldName]) && $scope.vc.viewState.QV_5932_10558.column[fieldName].enabled === false) {
                        this.closeCell();
                        return;
                    }
                    $scope.vc.grids.QV_5932_10558.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_5932_10558");
                    $scope.vc.hideShowColumns("QV_5932_10558", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_5932_10558.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_5932_10558.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_5932_10558.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_5932_10558 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_5932_10558 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                save: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                },
                remove: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_5932_10558.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_5932_10558.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_5932_10558.column.number = {
                title: 'BUSIN.LBL_BUSIN_NMEROTLNJ_91851',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSYL_143108',
                element: []
            };
            $scope.vc.grids.QV_5932_10558.AT79_NUMBERUG589 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5932_10558.column.number.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSYL_143108",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_5932_10558.column.number.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_5932_10558.column.number.format",
                        'k-decimals': "vc.viewState.QV_5932_10558.column.number.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5932_10558.column.number.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5932_10558.column.description = {
                title: 'BUSIN.LBL_BUSIN_PREGUNTAA_30366',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIKP_854108',
                element: []
            };
            $scope.vc.grids.QV_5932_10558.AT70_DESCRIOO589 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5932_10558.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIKP_854108",
                        'maxlength': 1000,
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_5932_10558.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_5932_10558.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_5932_10558.column.answer = {
                title: 'BUSIN.LBL_BUSIN_RESPUESAT_83571',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFFR_271108',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXFFR_271108 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXFFR_271108.data([{
                code: 'S',
                value: 'SI'
            }, {
                code: 'N',
                value: 'NO'
            }]);
            $scope.vc.grids.QV_5932_10558.AT91_ANSWERNG589 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_5932_10558.column.answer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFFR_271108",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_5932_10558.column.answer.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXFFR_271108",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_5932_10558.column.answer.template",
                        'data-validation-code': "{{vc.viewState.QV_5932_10558.column.answer.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5932_10558.columns.push({
                    field: 'number',
                    title: '{{vc.viewState.QV_5932_10558.column.number.title|translate:vc.viewState.QV_5932_10558.column.number.titleArgs}}',
                    width: $scope.vc.viewState.QV_5932_10558.column.number.width,
                    format: $scope.vc.viewState.QV_5932_10558.column.number.format,
                    editor: $scope.vc.grids.QV_5932_10558.AT79_NUMBERUG589.control,
                    template: "<span ng-class='vc.viewState.QV_5932_10558.column.number.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.number, \"QV_5932_10558\", \"number\"):kendo.toString(#=number#, vc.viewState.QV_5932_10558.column.number.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_5932_10558.column.number.style",
                        "title": "{{vc.viewState.QV_5932_10558.column.number.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5932_10558.column.number.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5932_10558.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_5932_10558.column.description.title|translate:vc.viewState.QV_5932_10558.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_5932_10558.column.description.width,
                    format: $scope.vc.viewState.QV_5932_10558.column.description.format,
                    editor: $scope.vc.grids.QV_5932_10558.AT70_DESCRIOO589.control,
                    template: "<span ng-class='vc.viewState.QV_5932_10558.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_5932_10558\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5932_10558.column.description.style",
                        "title": "{{vc.viewState.QV_5932_10558.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5932_10558.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_5932_10558.columns.push({
                    field: 'answer',
                    title: '{{vc.viewState.QV_5932_10558.column.answer.title|translate:vc.viewState.QV_5932_10558.column.answer.titleArgs}}',
                    width: $scope.vc.viewState.QV_5932_10558.column.answer.width,
                    format: $scope.vc.viewState.QV_5932_10558.column.answer.format,
                    editor: $scope.vc.grids.QV_5932_10558.AT91_ANSWERNG589.control,
                    template: "<span ng-class='vc.viewState.QV_5932_10558.column.answer.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXFFR_271108.get(dataItem.answer).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_5932_10558.column.answer.style",
                        "title": "{{vc.viewState.QV_5932_10558.column.answer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_5932_10558.column.answer.hidden
                });
            }
            $scope.vc.viewState.QV_5932_10558.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_5932_10558.toolbar = {}
            $scope.vc.grids.QV_5932_10558.toolbar = [];
            //ViewState - Group: Group2364
            $scope.vc.createViewState({
                id: "G_DATAVERITT_330108",
                hasId: true,
                componentStyle: [],
                label: 'Group2364',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_530108",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_LASSIGUTN_87175",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2206
            $scope.vc.createViewState({
                id: "G_DATAVERTOF_490108",
                hasId: true,
                componentStyle: [],
                label: 'Group2206',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.QuestionsPartTwo = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    number: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuestionsPartTwo", "number", 0)
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuestionsPartTwo", "description", '')
                    },
                    answer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("QuestionsPartTwo", "answer", '')
                    }
                }
            });
            $scope.vc.model.QuestionsPartTwo = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_QUESTIRO_7780';
                            var queryRequest = $scope.vc.getRequestQuery_Q_QUESTIRO_7780();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7780_54457',
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
                    model: $scope.vc.types.QuestionsPartTwo
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7780_54457").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QUESTIRO_7780 = $scope.vc.model.QuestionsPartTwo;
            $scope.vc.trackers.QuestionsPartTwo = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.QuestionsPartTwo);
            $scope.vc.model.QuestionsPartTwo.bind('change', function(e) {
                $scope.vc.trackers.QuestionsPartTwo.track(e);
            });
            $scope.vc.grids.QV_7780_54457 = {};
            $scope.vc.grids.QV_7780_54457.queryId = 'Q_QUESTIRO_7780';
            $scope.vc.viewState.QV_7780_54457 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7780_54457.column = {};
            $scope.vc.grids.QV_7780_54457.editable = {
                mode: 'incell',
            };
            $scope.vc.grids.QV_7780_54457.events = {
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
                    $scope.vc.trackers.QuestionsPartTwo.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    var columnIndex = this.cellIndex(e.container);
                    var fieldName = this.thead.find("th").eq(columnIndex).data("field");
                    if (angular.isDefined($scope.vc.viewState.QV_7780_54457.column[fieldName]) && $scope.vc.viewState.QV_7780_54457.column[fieldName].enabled === false) {
                        this.closeCell();
                        return;
                    }
                    $scope.vc.grids.QV_7780_54457.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7780_54457");
                    $scope.vc.hideShowColumns("QV_7780_54457", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7780_54457.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7780_54457.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7780_54457.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7780_54457 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7780_54457 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                save: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                },
                remove: function(e) {
                    setTimeout(function() {
                        e.sender.dataSource.sync();
                    })
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7780_54457.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7780_54457.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7780_54457.column.number = {
                title: 'BUSIN.LBL_BUSIN_NMEROSZIP_16667',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZGF_357108',
                element: []
            };
            $scope.vc.grids.QV_7780_54457.AT25_NUMBERBO177 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7780_54457.column.number.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZGF_357108",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_7780_54457.column.number.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7780_54457.column.number.format",
                        'k-decimals': "vc.viewState.QV_7780_54457.column.number.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7780_54457.column.number.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7780_54457.column.description = {
                title: 'BUSIN.LBL_BUSIN_PREGUNTAA_30366',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBBG_547108',
                element: []
            };
            $scope.vc.grids.QV_7780_54457.AT40_DESCRIIT177 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7780_54457.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBBG_547108",
                        'maxlength': 1000,
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_7780_54457.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7780_54457.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7780_54457.column.answer = {
                title: 'BUSIN.LBL_BUSIN_RESPUESAT_83571',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOGX_652108',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXOGX_652108 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXOGX_652108.data([{
                code: 'S',
                value: 'SI'
            }, {
                code: 'N',
                value: 'NO'
            }]);
            $scope.vc.grids.QV_7780_54457.AT94_ANSWERJK177 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7780_54457.column.answer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOGX_652108",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_7780_54457.column.answer.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXOGX_652108",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_7780_54457.column.answer.template",
                        'data-validation-code': "{{vc.viewState.QV_7780_54457.column.answer.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7780_54457.columns.push({
                    field: 'number',
                    title: '{{vc.viewState.QV_7780_54457.column.number.title|translate:vc.viewState.QV_7780_54457.column.number.titleArgs}}',
                    width: $scope.vc.viewState.QV_7780_54457.column.number.width,
                    format: $scope.vc.viewState.QV_7780_54457.column.number.format,
                    editor: $scope.vc.grids.QV_7780_54457.AT25_NUMBERBO177.control,
                    template: "<span ng-class='vc.viewState.QV_7780_54457.column.number.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.number, \"QV_7780_54457\", \"number\"):kendo.toString(#=number#, vc.viewState.QV_7780_54457.column.number.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7780_54457.column.number.style",
                        "title": "{{vc.viewState.QV_7780_54457.column.number.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7780_54457.column.number.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7780_54457.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7780_54457.column.description.title|translate:vc.viewState.QV_7780_54457.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7780_54457.column.description.width,
                    format: $scope.vc.viewState.QV_7780_54457.column.description.format,
                    editor: $scope.vc.grids.QV_7780_54457.AT40_DESCRIIT177.control,
                    template: "<span ng-class='vc.viewState.QV_7780_54457.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7780_54457\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7780_54457.column.description.style",
                        "title": "{{vc.viewState.QV_7780_54457.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7780_54457.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7780_54457.columns.push({
                    field: 'answer',
                    title: '{{vc.viewState.QV_7780_54457.column.answer.title|translate:vc.viewState.QV_7780_54457.column.answer.titleArgs}}',
                    width: $scope.vc.viewState.QV_7780_54457.column.answer.width,
                    format: $scope.vc.viewState.QV_7780_54457.column.answer.format,
                    editor: $scope.vc.grids.QV_7780_54457.AT94_ANSWERJK177.control,
                    template: "<span ng-class='vc.viewState.QV_7780_54457.column.answer.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXOGX_652108.get(dataItem.answer).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7780_54457.column.answer.style",
                        "title": "{{vc.viewState.QV_7780_54457.column.answer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7780_54457.column.answer.hidden
                });
            }
            $scope.vc.viewState.QV_7780_54457.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7780_54457.toolbar = {}
            $scope.vc.grids.QV_7780_54457.toolbar = [];
            //ViewState - Group: Group1833
            $scope.vc.createViewState({
                id: "G_DATAVERTNT_126108",
                hasId: true,
                componentStyle: [],
                label: 'Group1833',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASIMPLELABELLL_498108",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_LASSIGUTA_56882",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.QuestionsPartThree = {
                cellType: $scope.vc.channelDefaultValues("QuestionsPartThree", "cellType"),
                frequencyUseEM: $scope.vc.channelDefaultValues("QuestionsPartThree", "frequencyUseEM"),
                codeQuestion5: $scope.vc.channelDefaultValues("QuestionsPartThree", "codeQuestion5"),
                frequencyUseEMAnswer: $scope.vc.channelDefaultValues("QuestionsPartThree", "frequencyUseEMAnswer"),
                haveEmailAnswer: $scope.vc.channelDefaultValues("QuestionsPartThree", "haveEmailAnswer"),
                codeQuestion1: $scope.vc.channelDefaultValues("QuestionsPartThree", "codeQuestion1"),
                socialNetworks: $scope.vc.channelDefaultValues("QuestionsPartThree", "socialNetworks"),
                result: $scope.vc.channelDefaultValues("QuestionsPartThree", "result"),
                codeQuestion2: $scope.vc.channelDefaultValues("QuestionsPartThree", "codeQuestion2"),
                enableView: $scope.vc.channelDefaultValues("QuestionsPartThree", "enableView"),
                codeQuestion3: $scope.vc.channelDefaultValues("QuestionsPartThree", "codeQuestion3"),
                paymentMethodPhone: $scope.vc.channelDefaultValues("QuestionsPartThree", "paymentMethodPhone"),
                cellTypeAnswer: $scope.vc.channelDefaultValues("QuestionsPartThree", "cellTypeAnswer"),
                paymentMethodPhoneAnswer: $scope.vc.channelDefaultValues("QuestionsPartThree", "paymentMethodPhoneAnswer"),
                haveEmail: $scope.vc.channelDefaultValues("QuestionsPartThree", "haveEmail"),
                codeQuestion4: $scope.vc.channelDefaultValues("QuestionsPartThree", "codeQuestion4"),
                socialNetworksAnswer: $scope.vc.channelDefaultValues("QuestionsPartThree", "socialNetworksAnswer")
            };
            //ViewState - Group: Group2516
            $scope.vc.createViewState({
                id: "G_DATAVERICS_902108",
                hasId: true,
                componentStyle: [],
                label: 'Group2516',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: codeQuestion1
            $scope.vc.createViewState({
                id: "VA_CODEQUESTION111_114108",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: haveEmail
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTVM_263108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: haveEmailAnswer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXOIT_648108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXOIT_648108 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXOIT_648108");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: codeQuestion2
            $scope.vc.createViewState({
                id: "VA_CODEQUESTION222_146108",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: frequencyUseEM
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXJJ_459108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: frequencyUseEMAnswer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVMM_123108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXVMM_123108 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXVMM_123108', 'cr_frecuencia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXVMM_123108'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXVMM_123108");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: codeQuestion3
            $scope.vc.createViewState({
                id: "VA_CODEQUESTION333_974108",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: socialNetworks
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNFI_898108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: socialNetworksAnswer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPAA_394108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXPAA_394108 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXPAA_394108', 'cr_redes_sociales', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPAA_394108'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXPAA_394108");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: codeQuestion4
            $scope.vc.createViewState({
                id: "VA_CODEQUESTION444_953108",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: cellType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXFJJ_616108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: cellTypeAnswer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRUN_279108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXRUN_279108 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXRUN_279108', 'cr_tipo_telefono', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXRUN_279108'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXRUN_279108");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: codeQuestion5
            $scope.vc.createViewState({
                id: "VA_CODEQUESTION555_583108",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: paymentMethodPhone
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGSO_862108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: paymentMethodPhoneAnswer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPLN_348108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXPLN_348108 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXPLN_348108', 'cr_tipo_pago_telefono', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPLN_348108'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXPLN_348108");
                        }, null, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.createViewState({
                id: "Spacer2772",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2844",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2129",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2703",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWHZLTCH_588108",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CALCULARH_20617",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: result
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRZX_100108",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_RESULTADO_06672",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1117
            $scope.vc.createViewState({
                id: "G_DATAVERISO_664108",
                hasId: true,
                componentStyle: [],
                label: 'Group1117',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionsPartThree, Attribute: enableView
            $scope.vc.createViewState({
                id: "VA_ENABLEVIEWUEGPD_225108",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_BUSINIJVXCUKR_496_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_BUSINIJVXCUKR_496_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Context = {
                amountApproved: $scope.vc.channelDefaultValues("Context", "amountApproved"),
                amountRequested: $scope.vc.channelDefaultValues("Context", "amountRequested"),
                cycleNumber: $scope.vc.channelDefaultValues("Context", "cycleNumber"),
                synchronize: $scope.vc.channelDefaultValues("Context", "synchronize"),
                enable: $scope.vc.channelDefaultValues("Context", "enable"),
                ApplicationSubject: $scope.vc.channelDefaultValues("Context", "ApplicationSubject"),
                Application: $scope.vc.channelDefaultValues("Context", "Application"),
                Bookmark: $scope.vc.channelDefaultValues("Context", "Bookmark"),
                CustomerId: $scope.vc.channelDefaultValues("Context", "CustomerId"),
                RequestId: $scope.vc.channelDefaultValues("Context", "RequestId"),
                Flag1: $scope.vc.channelDefaultValues("Context", "Flag1"),
                Flag2: $scope.vc.channelDefaultValues("Context", "Flag2"),
                Type: $scope.vc.channelDefaultValues("Context", "Type"),
                TaskCountLap: $scope.vc.channelDefaultValues("Context", "TaskCountLap"),
                RequestName: $scope.vc.channelDefaultValues("Context", "RequestName"),
                RequestType: $scope.vc.channelDefaultValues("Context", "RequestType"),
                RequestStage: $scope.vc.channelDefaultValues("Context", "RequestStage"),
                TaskSubject: $scope.vc.channelDefaultValues("Context", "TaskSubject")
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
                $scope.vc.render('VC_DATAVERION_567496');
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
    var cobisMainModule = cobis.createModule("VC_DATAVERION_567496", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_DATAVERION_567496", {
            templateUrl: "VC_DATAVERION_567496_FORM.html",
            controller: "VC_DATAVERION_567496_CTRL",
            label: "DataVerificationQuestions",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DATAVERION_567496?" + $.param(search);
            }
        });
        VC_DATAVERION_567496(cobisMainModule);
    }]);
} else {
    VC_DATAVERION_567496(cobisMainModule);
}