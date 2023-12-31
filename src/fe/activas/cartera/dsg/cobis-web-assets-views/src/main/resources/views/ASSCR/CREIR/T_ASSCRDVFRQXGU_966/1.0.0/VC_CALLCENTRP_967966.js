//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.callcenterpopupquestions = designerEvents.api.callcenterpopupquestions || designer.dsgEvents();

function VC_CALLCENTRP_967966(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CALLCENTRP_967966_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CALLCENTRP_967966_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "ASSCR",
            subModuleId: "CREIR",
            taskId: "T_ASSCRDVFRQXGU_966",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CALLCENTRP_967966",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSCR/CREIR/T_ASSCRDVFRQXGU_966",
        designerEvents.api.callcenterpopupquestions,
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
                vcName: 'VC_CALLCENTRP_967966'
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
                    moduleId: 'ASSCR',
                    subModuleId: 'CREIR',
                    taskId: 'T_ASSCRDVFRQXGU_966',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CallCenterQuestion: "CallCenterQuestion",
                    LoginCallCenter: "LoginCallCenter",
                    QuestionValidation: "QuestionValidation"
                },
                entities: {
                    CallCenterQuestion: {
                        clientCode: 'AT31_CLIENTDE616',
                        correctValidation: 'AT40_CORRECII616',
                        noTengo: 'AT62_NOTENGOO616',
                        answer: 'AT67_ANSWERKV616',
                        typeAnswer: 'AT68_TYPEANRE616',
                        idQuestion: 'AT81_IDQUESOT616',
                        question: 'AT88_QUESTIOO616',
                        booleanHas: 'AT90_BOOLEAAN616',
                        _pks: [],
                        _entityId: 'EN_CALLCENON_616',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LoginCallCenter: {
                        idCodRegister: 'AT39_IDCODRES641',
                        opration: 'AT58_OPRATINN641',
                        processInst: 'AT66_PROCESSN641',
                        idCliente: 'AT96_IDCLIEEE641',
                        _pks: [],
                        _entityId: 'EN_LOGINCATR_641',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    QuestionValidation: {
                        corretValidation: 'AT78_CORRETAA676',
                        msmValidation: 'AT90_MSMVALNI676',
                        _pks: [],
                        _entityId: 'EN_VALIDATCT_676',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CALLCEII_7316 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CALLCEII_7316 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CALLCEII_7316_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CALLCEII_7316_filters;
                    parametersAux = {
                        clientCode: filters.clientCode
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CALLCENON_616',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CALLCEII_7316',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['clientCode'] = this.filters.clientCode;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_CALLCEII_7316_filters = {};
            var defaultValues = {
                CallCenterQuestion: {},
                LoginCallCenter: {},
                QuestionValidation: {}
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
                $scope.vc.execute("temporarySave", VC_CALLCENTRP_967966, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CALLCENTRP_967966, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CALLCENTRP_967966, data, function() {});
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
            $scope.vc.viewState.VC_CALLCENTRP_967966 = {
                style: []
            }
            $scope.vc.model.LoginCallCenter = {
                idCodRegister: $scope.vc.channelDefaultValues("LoginCallCenter", "idCodRegister"),
                opration: $scope.vc.channelDefaultValues("LoginCallCenter", "opration"),
                processInst: $scope.vc.channelDefaultValues("LoginCallCenter", "processInst"),
                idCliente: $scope.vc.channelDefaultValues("LoginCallCenter", "idCliente")
            };
            //ViewState - Group: Group1770
            $scope.vc.createViewState({
                id: "G_CALLCENOQT_891912",
                hasId: true,
                componentStyle: [],
                label: 'Group1770',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoginCallCenter, Attribute: idCliente
            $scope.vc.createViewState({
                id: "VA_7904MAZZXVKTTBR_383912",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_BSQUEDAIE_90412",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONMLAQDME_803912",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_BUSCARLEP_50023",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2545
            $scope.vc.createViewState({
                id: "G_CALLCENNOS_634912",
                hasId: true,
                componentStyle: [],
                label: 'Group2545',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CallCenterQuestion = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    idQuestion: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CallCenterQuestion", "idQuestion", 0)
                    },
                    question: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CallCenterQuestion", "question", '')
                    },
                    answer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CallCenterQuestion", "answer", '')
                    },
                    booleanHas: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CallCenterQuestion", "booleanHas", false)
                    },
                    correctValidation: {
                        type: "string",
                        editable: true
                    },
                    clientCode: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.CallCenterQuestion = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CALLCEII_7316';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CALLCEII_7316();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7316_54056',
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
                    model: $scope.vc.types.CallCenterQuestion
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7316_54056").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CALLCEII_7316 = $scope.vc.model.CallCenterQuestion;
            $scope.vc.trackers.CallCenterQuestion = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CallCenterQuestion);
            $scope.vc.model.CallCenterQuestion.bind('change', function(e) {
                $scope.vc.trackers.CallCenterQuestion.track(e);
            });
            $scope.vc.grids.QV_7316_54056 = {};
            $scope.vc.grids.QV_7316_54056.queryId = 'Q_CALLCEII_7316';
            $scope.vc.viewState.QV_7316_54056 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7316_54056.column = {};
            $scope.vc.grids.QV_7316_54056.editable = false;
            $scope.vc.grids.QV_7316_54056.events = {
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
                    $scope.vc.trackers.CallCenterQuestion.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7316_54056.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'CallCenterQuestion',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_7316_54056", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7316_54056");
                    $scope.vc.hideShowColumns("QV_7316_54056", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7316_54056.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7316_54056.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7316_54056.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7316_54056 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7316_54056 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7316_54056.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7316_54056.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7316_54056.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7316_54056.column.idQuestion = {
                title: 'ASSCR.LBL_ASSCR_IDPREGUNA_16437',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDOL_835912',
                element: []
            };
            $scope.vc.grids.QV_7316_54056.AT81_IDQUESOT616 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_54056.column.idQuestion.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDOL_835912",
                        'data-validation-code': "{{vc.viewState.QV_7316_54056.column.idQuestion.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7316_54056.column.idQuestion.format",
                        'k-decimals': "vc.viewState.QV_7316_54056.column.idQuestion.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7316_54056.column.idQuestion.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_54056.column.question = {
                title: 'ASSCR.LBL_ASSCR_PREGUNTAA_65224',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXASB_489912',
                element: []
            };
            $scope.vc.grids.QV_7316_54056.AT88_QUESTIOO616 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_54056.column.question.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXASB_489912",
                        'data-validation-code': "{{vc.viewState.QV_7316_54056.column.question.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7316_54056.column.question.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_54056.column.answer = {
                title: 'ASSCR.LBL_ASSCR_RESPUESUN_64285',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJFI_818912',
                element: []
            };
            $scope.vc.grids.QV_7316_54056.AT67_ANSWERKV616 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_54056.column.answer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJFI_818912",
                        'data-validation-code': "{{vc.viewState.QV_7316_54056.column.answer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7316_54056.column.answer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_54056.column.booleanHas = {
                title: 'booleanHas',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXQTVZMVU_833912',
                element: []
            };
            $scope.vc.grids.QV_7316_54056.AT90_BOOLEAAN616 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_54056.column.booleanHas.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_CHECKBOXQTVZMVU_833912",
                        'ng-class': 'vc.viewState.QV_7316_54056.column.booleanHas.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_54056.column.correctValidation = {
                title: 'correctValidation',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_7316_54056.column.clientCode = {
                title: 'clientCode',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "n0",
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_54056.columns.push({
                    field: 'idQuestion',
                    title: '{{vc.viewState.QV_7316_54056.column.idQuestion.title|translate:vc.viewState.QV_7316_54056.column.idQuestion.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_54056.column.idQuestion.width,
                    format: $scope.vc.viewState.QV_7316_54056.column.idQuestion.format,
                    editor: $scope.vc.grids.QV_7316_54056.AT81_IDQUESOT616.control,
                    template: "<span ng-class='vc.viewState.QV_7316_54056.column.idQuestion.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.idQuestion, \"QV_7316_54056\", \"idQuestion\"):kendo.toString(#=idQuestion#, vc.viewState.QV_7316_54056.column.idQuestion.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7316_54056.column.idQuestion.style",
                        "title": "{{vc.viewState.QV_7316_54056.column.idQuestion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_54056.column.idQuestion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_54056.columns.push({
                    field: 'question',
                    title: '{{vc.viewState.QV_7316_54056.column.question.title|translate:vc.viewState.QV_7316_54056.column.question.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_54056.column.question.width,
                    format: $scope.vc.viewState.QV_7316_54056.column.question.format,
                    editor: $scope.vc.grids.QV_7316_54056.AT88_QUESTIOO616.control,
                    template: "<span ng-class='vc.viewState.QV_7316_54056.column.question.style' ng-bind='vc.getStringColumnFormat(dataItem.question, \"QV_7316_54056\", \"question\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7316_54056.column.question.style",
                        "title": "{{vc.viewState.QV_7316_54056.column.question.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_54056.column.question.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_54056.columns.push({
                    field: 'answer',
                    title: '{{vc.viewState.QV_7316_54056.column.answer.title|translate:vc.viewState.QV_7316_54056.column.answer.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_54056.column.answer.width,
                    format: $scope.vc.viewState.QV_7316_54056.column.answer.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7316_54056', 'answer', $scope.vc.grids.QV_7316_54056.AT67_ANSWERKV616.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7316_54056', 'answer', "<span ng-class='vc.viewState.QV_7316_54056.column.answer.style' ng-bind='vc.getStringColumnFormat(dataItem.answer, \"QV_7316_54056\", \"answer\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7316_54056.column.answer.style",
                        "title": "{{vc.viewState.QV_7316_54056.column.answer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_54056.column.answer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_54056.columns.push({
                    field: 'booleanHas',
                    title: '{{vc.viewState.QV_7316_54056.column.booleanHas.title|translate:vc.viewState.QV_7316_54056.column.booleanHas.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_54056.column.booleanHas.width,
                    format: $scope.vc.viewState.QV_7316_54056.column.booleanHas.format,
                    editor: $scope.vc.grids.QV_7316_54056.AT90_BOOLEAAN616.control,
                    template: "<input name='booleanHas' type='checkbox' value='#=booleanHas#' #=booleanHas?checked='checked':''# disabled='disabled' data-bind='value:booleanHas' ng-class='vc.viewState.QV_7316_54056.column.booleanHas.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7316_54056.column.booleanHas.style",
                        "title": "{{vc.viewState.QV_7316_54056.column.booleanHas.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_54056.column.booleanHas.hidden
                });
            }
            $scope.vc.viewState.QV_7316_54056.toolbar = {}
            $scope.vc.grids.QV_7316_54056.toolbar = [];
            $scope.vc.model.QuestionValidation = {
                corretValidation: $scope.vc.channelDefaultValues("QuestionValidation", "corretValidation"),
                msmValidation: $scope.vc.channelDefaultValues("QuestionValidation", "msmValidation")
            };
            //ViewState - Group: Group2701
            $scope.vc.createViewState({
                id: "G_CALLCENPPE_455912",
                hasId: true,
                componentStyle: [],
                label: 'Group2701',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionValidation, Attribute: corretValidation
            $scope.vc.createViewState({
                id: "VA_CORRETVALIDAIII_240912",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_CORRECTII_34747",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionValidation, Attribute: msmValidation
            $scope.vc.createViewState({
                id: "VA_MSMVALIDATIONNN_838912",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_MSMVALIAA_12544",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2394
            $scope.vc.createViewState({
                id: "G_CALLCENSSP_320912",
                hasId: true,
                componentStyle: [],
                label: 'Group2394',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONPDDCALJ_814912",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_VALIDARRU_71967",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSCRDVFRQXGU_966_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSCRDVFRQXGU_966_CANCEL",
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
                $scope.vc.render('VC_CALLCENTRP_967966');
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
    var cobisMainModule = cobis.createModule("VC_CALLCENTRP_967966", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSCR"]);
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
        $routeProvider.when("/VC_CALLCENTRP_967966", {
            templateUrl: "VC_CALLCENTRP_967966_FORM.html",
            controller: "VC_CALLCENTRP_967966_CTRL",
            label: "CallCenterPopupQuestions",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSCR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CALLCENTRP_967966?" + $.param(search);
            }
        });
        VC_CALLCENTRP_967966(cobisMainModule);
    }]);
} else {
    VC_CALLCENTRP_967966(cobisMainModule);
}