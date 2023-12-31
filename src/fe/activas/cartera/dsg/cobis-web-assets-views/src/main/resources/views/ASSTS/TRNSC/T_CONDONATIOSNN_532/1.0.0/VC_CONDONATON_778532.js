//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.condonationdetailform = designerEvents.api.condonationdetailform || designer.dsgEvents();

function VC_CONDONATON_778532(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CONDONATON_778532_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CONDONATON_778532_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "TRNSC",
            taskId: "T_CONDONATIOSNN_532",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CONDONATON_778532",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/TRNSC/T_CONDONATIOSNN_532",
        designerEvents.api.condonationdetailform,
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
                vcName: 'VC_CONDONATON_778532'
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
                    subModuleId: 'TRNSC',
                    taskId: 'T_CONDONATIOSNN_532',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ServerParameter: "ServerParameter",
                    CondonationDetail: "CondonationDetail"
                },
                entities: {
                    ServerParameter: {
                        loanBankID: 'AT83_LOANBADD884',
                        selectedRow: 'AT50_SELECTED884',
                        amount: 'AT64_AMOUNTCK884',
                        condonationPercentage: 'AT30_CONDONIE884',
                        flag: 'AT69_FLAGHWCK884',
                        refresGridFlag: 'AT58_REFRESRG884',
                        refresGrid2Flag: 'AT81_REFRESAD884',
                        _pks: [],
                        _entityId: 'EN_SERVERPRA_884',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CondonationDetail: {
                        concept: 'AT98_CONCEPTT795',
                        percentage: 'AT91_PERCENAT795',
                        observation: 'AT89_OBSERVNT795',
                        maximumPercentage: 'AT66_MAXIMUEG795',
                        totalValue: 'AT91_TOTALVAE795',
                        valueToCondone: 'AT14_VALUETOO795',
                        description: 'AT92_DESCRIPN795',
                        loanBankID: 'AT91_LOANBAKI795',
                        _pks: [],
                        _entityId: 'EN_CONDONAII_795',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CONDONDE_7324 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_CONDONDE_7324 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CONDONDE_7324_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CONDONDE_7324_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CONDONAII_795',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CONDONDE_7324',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_CONDONDE_7324_filters = {};
            var defaultValues = {
                ServerParameter: {},
                CondonationDetail: {}
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
                $scope.vc.execute("temporarySave", VC_CONDONATON_778532, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CONDONATON_778532, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CONDONATON_778532, data, function() {});
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
            $scope.vc.viewState.VC_CONDONATON_778532 = {
                style: []
            }
            $scope.vc.model.ServerParameter = {
                loanBankID: $scope.vc.channelDefaultValues("ServerParameter", "loanBankID"),
                selectedRow: $scope.vc.channelDefaultValues("ServerParameter", "selectedRow"),
                amount: $scope.vc.channelDefaultValues("ServerParameter", "amount"),
                condonationPercentage: $scope.vc.channelDefaultValues("ServerParameter", "condonationPercentage"),
                flag: $scope.vc.channelDefaultValues("ServerParameter", "flag"),
                refresGridFlag: $scope.vc.channelDefaultValues("ServerParameter", "refresGridFlag"),
                refresGrid2Flag: $scope.vc.channelDefaultValues("ServerParameter", "refresGrid2Flag")
            };
            //ViewState - Group: Group1526
            $scope.vc.createViewState({
                id: "G_CONDONAIOT_744764",
                hasId: true,
                componentStyle: [],
                label: 'Group1526',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ServerParameter, Attribute: condonationPercentage
            $scope.vc.createViewState({
                id: "VA_AMOUNTXJGMXOXXE_131764",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MAXIMOCTU_73308",
                format: "###",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2462
            $scope.vc.createViewState({
                id: "G_CONDONATTT_517764",
                hasId: true,
                componentStyle: [],
                label: 'Group2462',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CondonationDetail = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    concept: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "concept", ''),
                        validation: {
                            conceptRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "description", '')
                    },
                    observation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "observation", ''),
                        validation: {
                            observationRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    valueToCondone: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "valueToCondone", 0)
                    },
                    percentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "percentage", 0),
                        validation: {
                            percentageCompareInRange: function(input) {
                                return compareInRange(input);
                            }
                        }
                    },
                    maximumPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "maximumPercentage", 0)
                    },
                    totalValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CondonationDetail", "totalValue", 0)
                    }
                }
            });
            $scope.vc.model.CondonationDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_CONDONDE_7324();
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
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Insert,
                            nameEntityGrid: 'CondonationDetail'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_7324_98967', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        options.success(model);
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                            nameEntityGrid: 'CondonationDetail'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_7324_98967', argsAfterLeave);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.CondonationDetail
                },
                aggregate: [{
                    field: "valueToCondone",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7324_98967").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CONDONDE_7324 = $scope.vc.model.CondonationDetail;
            $scope.vc.trackers.CondonationDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CondonationDetail);
            $scope.vc.model.CondonationDetail.bind('change', function(e) {
                $scope.vc.trackers.CondonationDetail.track(e);
            });
            $scope.vc.grids.QV_7324_98967 = {};
            $scope.vc.grids.QV_7324_98967.queryId = 'Q_CONDONDE_7324';
            $scope.vc.viewState.QV_7324_98967 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7324_98967.column = {};
            $scope.vc.grids.QV_7324_98967.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_7324_98967.events = {
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
                    $scope.vc.trackers.CondonationDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7324_98967.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_7324_98967");
                    $scope.vc.hideShowColumns("QV_7324_98967", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7324_98967.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7324_98967.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7324_98967.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7324_98967 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7324_98967 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7324_98967.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7324_98967.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7324_98967.column.concept = {
                title: 'ASSTS.LBL_ASSTS_CONCEPTOO_16181',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVSD_563764',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXVSD_563764 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXVSD_563764', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXVSD_563764'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        },
                        options.data.filter, null, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_7324_98967.AT98_CONCEPTT795 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.concept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVSD_563764",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_7324_98967.column.concept.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXVSD_563764",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_7324_98967.column.concept.template",
                        'dsgrequired': '',
                        'data-dsgrequired-msg': $filter('translate')('ASSTS.MSG_ASSTS_ELCAMPOOC_91834'),
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.concept.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'dsgrequired': "",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXVSD_563764',this.dataItem,'" + options.field + "')",
                        'k-on-open': "vc.focus(kendoEvent,'VA_TEXTINPUTBOXVSD_563764',this.dataItem,'" + options.field + "')",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_98967.column.description = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPNI_65857',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJEE_667764',
                element: []
            };
            $scope.vc.grids.QV_7324_98967.AT92_DESCRIPN795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJEE_667764",
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_98967.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_98967.column.observation = {
                title: 'ASSTS.LBL_ASSTS_OBSERVANN_50010',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXEPR_994764',
                element: []
            };
            $scope.vc.grids.QV_7324_98967.AT89_OBSERVNT795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.observation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEPR_994764",
                        'dsgrequired': '',
                        'data-dsgrequired-msg': $filter('translate')('ASSTS.MSG_ASSTS_ELCAMPOON_25357'),
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.observation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox text-uppercase",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_98967.column.observation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_98967.column.valueToCondone = {
                title: 'ASSTS.LBL_ASSTS_VALORNPRH_26284',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "##,#.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXECH_722764',
                element: []
            };
            $scope.vc.grids.QV_7324_98967.AT14_VALUETOO795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.valueToCondone.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXECH_722764",
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.valueToCondone.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_98967.column.valueToCondone.format",
                        'k-decimals': "vc.viewState.QV_7324_98967.column.valueToCondone.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_98967.column.valueToCondone.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_98967.column.percentage = {
                title: 'ASSTS.LBL_ASSTS_PORCENTAE_66428',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 2,
                componentId: 'VA_TEXTINPUTBOXTBY_391764',
                element: []
            };
            $scope.vc.grids.QV_7324_98967.AT91_PERCENAT795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.percentage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTBY_391764",
                        'compare-in-range': "",
                        'data-compareInRange-msg': $filter('translate')('ASSTS.MSG_ASSTS_SEDEBERZE_11978'),
                        'compare-min': "1",
                        'compare-max': "100",
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.percentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_98967.column.percentage.format",
                        'k-decimals': "vc.viewState.QV_7324_98967.column.percentage.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXTBY_391764',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXTBY_391764',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_98967.column.percentage.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_98967.column.maximumPercentage = {
                title: 'maximumPercentage',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCMT_125764',
                element: []
            };
            $scope.vc.grids.QV_7324_98967.AT66_MAXIMUEG795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.maximumPercentage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCMT_125764",
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.maximumPercentage.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_98967.column.maximumPercentage.format",
                        'k-decimals': "vc.viewState.QV_7324_98967.column.maximumPercentage.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_98967.column.maximumPercentage.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7324_98967.column.totalValue = {
                title: 'ASSTS.LBL_ASSTS_TOTALCUTA_93906',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBOS_972764',
                element: []
            };
            $scope.vc.grids.QV_7324_98967.AT91_TOTALVAE795 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7324_98967.column.totalValue.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBOS_972764",
                        'data-validation-code': "{{vc.viewState.QV_7324_98967.column.totalValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7324_98967.column.totalValue.format",
                        'k-decimals': "vc.viewState.QV_7324_98967.column.totalValue.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7324_98967.column.totalValue.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'concept',
                    title: '{{vc.viewState.QV_7324_98967.column.concept.title|translate:vc.viewState.QV_7324_98967.column.concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.concept.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.concept.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT98_CONCEPTT795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.concept.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXVSD_563764.get(dataItem.concept).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7324_98967.column.concept.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7324_98967.column.description.title|translate:vc.viewState.QV_7324_98967.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.description.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.description.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT92_DESCRIPN795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7324_98967\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7324_98967.column.description.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'observation',
                    title: '{{vc.viewState.QV_7324_98967.column.observation.title|translate:vc.viewState.QV_7324_98967.column.observation.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.observation.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.observation.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT89_OBSERVNT795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.observation.style' ng-bind='vc.getStringColumnFormat(dataItem.observation, \"QV_7324_98967\", \"observation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7324_98967.column.observation.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.observation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.observation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'valueToCondone',
                    title: '{{vc.viewState.QV_7324_98967.column.valueToCondone.title|translate:vc.viewState.QV_7324_98967.column.valueToCondone.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.valueToCondone.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.valueToCondone.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT14_VALUETOO795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.valueToCondone.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueToCondone, \"QV_7324_98967\", \"valueToCondone\"):kendo.toString(#=valueToCondone#, vc.viewState.QV_7324_98967.column.valueToCondone.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.valueToCondone.sum, $scope.vc.viewState.QV_7324_98967.column.valueToCondone.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_98967.column.valueToCondone.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.valueToCondone.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.valueToCondone.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'percentage',
                    title: '{{vc.viewState.QV_7324_98967.column.percentage.title|translate:vc.viewState.QV_7324_98967.column.percentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.percentage.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.percentage.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT91_PERCENAT795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.percentage.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.percentage, \"QV_7324_98967\", \"percentage\"):kendo.toString(#=percentage#, vc.viewState.QV_7324_98967.column.percentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_98967.column.percentage.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.percentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.percentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'maximumPercentage',
                    title: '{{vc.viewState.QV_7324_98967.column.maximumPercentage.title|translate:vc.viewState.QV_7324_98967.column.maximumPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.maximumPercentage.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.maximumPercentage.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT66_MAXIMUEG795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.maximumPercentage.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.maximumPercentage, \"QV_7324_98967\", \"maximumPercentage\"):kendo.toString(#=maximumPercentage#, vc.viewState.QV_7324_98967.column.maximumPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_98967.column.maximumPercentage.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.maximumPercentage.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.maximumPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7324_98967.columns.push({
                    field: 'totalValue',
                    title: '{{vc.viewState.QV_7324_98967.column.totalValue.title|translate:vc.viewState.QV_7324_98967.column.totalValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_7324_98967.column.totalValue.width,
                    format: $scope.vc.viewState.QV_7324_98967.column.totalValue.format,
                    editor: $scope.vc.grids.QV_7324_98967.AT91_TOTALVAE795.control,
                    template: "<span ng-class='vc.viewState.QV_7324_98967.column.totalValue.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.totalValue, \"QV_7324_98967\", \"totalValue\"):kendo.toString(#=totalValue#, vc.viewState.QV_7324_98967.column.totalValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7324_98967.column.totalValue.style",
                        "title": "{{vc.viewState.QV_7324_98967.column.totalValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_7324_98967.column.totalValue.hidden
                });
            }
            $scope.vc.viewState.QV_7324_98967.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_7324_98967.column.cmdEdition = {};
            $scope.vc.viewState.QV_7324_98967.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7324_98967.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_7324_98967.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7324_98967.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_CONDONATTT_517764.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7324_98967.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_7324_98967.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_7324_98967.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_7324_98967.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_CONDONATTT_517764.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CONDONATIOSNN_532_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CONDONATIOSNN_532_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TCONDONA_SS3",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_GUARDARRI_81055",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TCONDONA_NAN",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CANCELARR_70217",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXVSD_563764.read();
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
                $scope.vc.render('VC_CONDONATON_778532');
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
    var cobisMainModule = cobis.createModule("VC_CONDONATON_778532", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_CONDONATON_778532", {
            templateUrl: "VC_CONDONATON_778532_FORM.html",
            controller: "VC_CONDONATON_778532_CTRL",
            label: "CondonationsForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CONDONATON_778532?" + $.param(search);
            }
        });
        VC_CONDONATON_778532(cobisMainModule);
    }]);
} else {
    VC_CONDONATON_778532(cobisMainModule);
}