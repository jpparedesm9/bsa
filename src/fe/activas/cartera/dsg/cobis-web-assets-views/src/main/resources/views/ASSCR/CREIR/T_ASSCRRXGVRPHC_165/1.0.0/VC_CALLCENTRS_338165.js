//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.callcenterquestions = designerEvents.api.callcenterquestions || designer.dsgEvents();

function VC_CALLCENTRS_338165(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CALLCENTRS_338165_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CALLCENTRS_338165_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSCRRXGVRPHC_165",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CALLCENTRS_338165",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSCR/CREIR/T_ASSCRRXGVRPHC_165",
        designerEvents.api.callcenterquestions,
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
                vcName: 'VC_CALLCENTRS_338165'
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
                    taskId: 'T_ASSCRRXGVRPHC_165',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Amount: "Amount",
                    QuestionValidation: "QuestionValidation",
                    CallCenterQuestion: "CallCenterQuestion",
                    LoginCallCenter: "LoginCallCenter"
                },
                entities: {
                    Amount: {
                        idCliente: 'AT59_IDCLIETN769',
                        amountApproved: 'AT72_AMOUNTPO769',
                        operation: 'AT82_OPERATOI769',
                        processInts: 'AT82_PROCESSN769',
                        msmDesembolsar: 'AT95_MSMZNGXW769',
                        _pks: [],
                        _entityId: 'EN_AMOUNTWNM_769',
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
                    },
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
                Amount: {},
                QuestionValidation: {},
                CallCenterQuestion: {},
                LoginCallCenter: {}
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
                $scope.vc.execute("temporarySave", VC_CALLCENTRS_338165, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CALLCENTRS_338165, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CALLCENTRS_338165, data, function() {});
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
            $scope.vc.viewState.VC_CALLCENTRS_338165 = {
                style: []
            }
            $scope.vc.model.LoginCallCenter = {
                idCodRegister: $scope.vc.channelDefaultValues("LoginCallCenter", "idCodRegister"),
                opration: $scope.vc.channelDefaultValues("LoginCallCenter", "opration"),
                processInst: $scope.vc.channelDefaultValues("LoginCallCenter", "processInst"),
                idCliente: $scope.vc.channelDefaultValues("LoginCallCenter", "idCliente")
            };
            //ViewState - Group: Group1716
            $scope.vc.createViewState({
                id: "G_CALLCENTOT_504769",
                hasId: true,
                componentStyle: [],
                label: 'Group1716',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoginCallCenter, Attribute: idCliente
            $scope.vc.createViewState({
                id: "VA_1194BQLISALGYQY_683769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_BSQUEDAIE_90412",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LoginCallCenter, Attribute: idCodRegister
            $scope.vc.createViewState({
                id: "VA_1QSHTYXNJBZHEWZ_632769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_INGRESETA_99762",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONEAKDTLW_523769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_BUSCARLEP_50023",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1172
            $scope.vc.createViewState({
                id: "G_CALLCENOEI_535769",
                hasId: true,
                componentStyle: [],
                label: 'Group1172',
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
                    booleanHas: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CallCenterQuestion", "booleanHas", false)
                    },
                    answer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CallCenterQuestion", "answer", ''),
                        validation: {
                            answerRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
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
                pageSize: 10,
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
                                        'QV_7316_82692',
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'CallCenterQuestion',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7316_82692', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
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
                        $("#QV_7316_82692").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CALLCEII_7316 = $scope.vc.model.CallCenterQuestion;
            $scope.vc.trackers.CallCenterQuestion = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CallCenterQuestion);
            $scope.vc.model.CallCenterQuestion.bind('change', function(e) {
                $scope.vc.trackers.CallCenterQuestion.track(e);
            });
            $scope.vc.grids.QV_7316_82692 = {};
            $scope.vc.grids.QV_7316_82692.queryId = 'Q_CALLCEII_7316';
            $scope.vc.viewState.QV_7316_82692 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7316_82692.column = {};
            $scope.vc.grids.QV_7316_82692.editable = false;
            $scope.vc.grids.QV_7316_82692.events = {
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
                    $scope.vc.grids.QV_7316_82692.selectedRow = e.model;
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
                    $scope.vc.gridRowRendering("QV_7316_82692", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7316_82692");
                    $scope.vc.hideShowColumns("QV_7316_82692", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7316_82692.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7316_82692.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7316_82692.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7316_82692 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7316_82692 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7316_82692.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7316_82692.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7316_82692.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7316_82692.column.idQuestion = {
                title: 'ASSCR.LBL_ASSCR_IDPREGUNA_16437',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSWT_980769',
                element: []
            };
            $scope.vc.grids.QV_7316_82692.AT81_IDQUESOT616 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_82692.column.idQuestion.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSWT_980769",
                        'data-validation-code': "{{vc.viewState.QV_7316_82692.column.idQuestion.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7316_82692.column.idQuestion.format",
                        'k-decimals': "vc.viewState.QV_7316_82692.column.idQuestion.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7316_82692.column.idQuestion.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_82692.column.question = {
                title: 'ASSCR.LBL_ASSCR_PREGUNTAA_65224',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWJC_351769',
                element: []
            };
            $scope.vc.grids.QV_7316_82692.AT88_QUESTIOO616 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_82692.column.question.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWJC_351769",
                        'data-validation-code': "{{vc.viewState.QV_7316_82692.column.question.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7316_82692.column.question.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_82692.column.booleanHas = {
                title: 'booleanHas',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXZLBCKNG_801769',
                element: []
            };
            $scope.vc.grids.QV_7316_82692.AT90_BOOLEAAN616 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_82692.column.booleanHas.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_CHECKBOXZLBCKNG_801769",
                        'ng-class': 'vc.viewState.QV_7316_82692.column.booleanHas.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_82692.column.answer = {
                title: 'ASSCR.LBL_ASSCR_RESPUESEC_66790',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXNKM_555769',
                element: []
            };
            $scope.vc.grids.QV_7316_82692.AT67_ANSWERKV616 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7316_82692.column.answer.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNKM_555769",
                        'dsgrequired': '',
                        'data-dsgrequired-msg': $filter('translate')('ASSCR.MSG_ASSCR_LARESPUAA_62535'),
                        'data-validation-code': "{{vc.viewState.QV_7316_82692.column.answer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7316_82692.column.answer.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7316_82692.column.correctValidation = {
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
            $scope.vc.viewState.QV_7316_82692.column.clientCode = {
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
                $scope.vc.grids.QV_7316_82692.columns.push({
                    field: 'idQuestion',
                    title: '{{vc.viewState.QV_7316_82692.column.idQuestion.title|translate:vc.viewState.QV_7316_82692.column.idQuestion.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_82692.column.idQuestion.width,
                    format: $scope.vc.viewState.QV_7316_82692.column.idQuestion.format,
                    editor: $scope.vc.grids.QV_7316_82692.AT81_IDQUESOT616.control,
                    template: "<span ng-class='vc.viewState.QV_7316_82692.column.idQuestion.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.idQuestion, \"QV_7316_82692\", \"idQuestion\"):kendo.toString(#=idQuestion#, vc.viewState.QV_7316_82692.column.idQuestion.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7316_82692.column.idQuestion.style",
                        "title": "{{vc.viewState.QV_7316_82692.column.idQuestion.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_82692.column.idQuestion.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_82692.columns.push({
                    field: 'question',
                    title: '{{vc.viewState.QV_7316_82692.column.question.title|translate:vc.viewState.QV_7316_82692.column.question.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_82692.column.question.width,
                    format: $scope.vc.viewState.QV_7316_82692.column.question.format,
                    editor: $scope.vc.grids.QV_7316_82692.AT88_QUESTIOO616.control,
                    template: "<span ng-class='vc.viewState.QV_7316_82692.column.question.style' ng-bind='vc.getStringColumnFormat(dataItem.question, \"QV_7316_82692\", \"question\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7316_82692.column.question.style",
                        "title": "{{vc.viewState.QV_7316_82692.column.question.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_82692.column.question.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_82692.columns.push({
                    field: 'booleanHas',
                    title: '{{vc.viewState.QV_7316_82692.column.booleanHas.title|translate:vc.viewState.QV_7316_82692.column.booleanHas.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_82692.column.booleanHas.width,
                    format: $scope.vc.viewState.QV_7316_82692.column.booleanHas.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7316_82692', 'booleanHas', $scope.vc.grids.QV_7316_82692.AT90_BOOLEAAN616.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7316_82692', 'booleanHas', "<input name='booleanHas' type='checkbox' value='#=booleanHas#' #=booleanHas?checked='checked':''# disabled='disabled' data-bind='value:booleanHas' ng-class='vc.viewState.QV_7316_82692.column.booleanHas.style' />"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7316_82692.column.booleanHas.style",
                        "title": "{{vc.viewState.QV_7316_82692.column.booleanHas.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_82692.column.booleanHas.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7316_82692.columns.push({
                    field: 'answer',
                    title: '{{vc.viewState.QV_7316_82692.column.answer.title|translate:vc.viewState.QV_7316_82692.column.answer.titleArgs}}',
                    width: $scope.vc.viewState.QV_7316_82692.column.answer.width,
                    format: $scope.vc.viewState.QV_7316_82692.column.answer.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7316_82692', 'answer', $scope.vc.grids.QV_7316_82692.AT67_ANSWERKV616.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7316_82692', 'answer', "<span ng-class='vc.viewState.QV_7316_82692.column.answer.style' ng-bind='vc.getStringColumnFormat(dataItem.answer, \"QV_7316_82692\", \"answer\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7316_82692.column.answer.style",
                        "title": "{{vc.viewState.QV_7316_82692.column.answer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7316_82692.column.answer.hidden
                });
            }
            $scope.vc.viewState.QV_7316_82692.toolbar = {}
            $scope.vc.grids.QV_7316_82692.toolbar = [];
            $scope.vc.model.Amount = {
                idCliente: $scope.vc.channelDefaultValues("Amount", "idCliente"),
                amountApproved: $scope.vc.channelDefaultValues("Amount", "amountApproved"),
                operation: $scope.vc.channelDefaultValues("Amount", "operation"),
                processInts: $scope.vc.channelDefaultValues("Amount", "processInts"),
                msmDesembolsar: $scope.vc.channelDefaultValues("Amount", "msmDesembolsar")
            };
            //ViewState - Group: Group1956
            $scope.vc.createViewState({
                id: "G_CALLCENERT_656769",
                hasId: true,
                componentStyle: [],
                label: 'Group1956',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Amount, Attribute: amountApproved
            $scope.vc.createViewState({
                id: "VA_9614ZTSONZLMVRK_410769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_MONTOAAOR_24791",
                format: "#,##0.00",
                decimals: 2,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2658",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.QuestionValidation = {
                corretValidation: $scope.vc.channelDefaultValues("QuestionValidation", "corretValidation"),
                msmValidation: $scope.vc.channelDefaultValues("QuestionValidation", "msmValidation")
            };
            //ViewState - Group: Group1377
            $scope.vc.createViewState({
                id: "G_CALLCENETE_857769",
                hasId: true,
                componentStyle: [],
                label: 'Group1377',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionValidation, Attribute: corretValidation
            $scope.vc.createViewState({
                id: "VA_1OCJFHZIFBDTGEC_461769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_CORRECTII_34747",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: QuestionValidation, Attribute: msmValidation
            $scope.vc.createViewState({
                id: "VA_5925IGVYVNMPHPD_149769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_MSMVALIAA_12544",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2696
            $scope.vc.createViewState({
                id: "G_CALLCENENE_411769",
                hasId: true,
                componentStyle: [],
                label: 'Group2696',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONTOSIJNF_422769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_VALIDARRU_71967",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONUWUXNHE_853769",
                componentStyle: [],
                label: "ASSCR.LBL_ASSCR_AUTORIZPP_93494",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSCRRXGVRPHC_165_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSCRRXGVRPHC_165_CANCEL",
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
                $scope.vc.render('VC_CALLCENTRS_338165');
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
    var cobisMainModule = cobis.createModule("VC_CALLCENTRS_338165", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSCR"]);
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
        $routeProvider.when("/VC_CALLCENTRS_338165", {
            templateUrl: "VC_CALLCENTRS_338165_FORM.html",
            controller: "VC_CALLCENTRS_338165_CTRL",
            labelId: "ASSCR.LBL_ASSCR_UTILIZARD_48773",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSCR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CALLCENTRS_338165?" + $.param(search);
            }
        });
        VC_CALLCENTRS_338165(cobisMainModule);
    }]);
} else {
    VC_CALLCENTRS_338165(cobisMainModule);
}