//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.amortizationtable = designerEvents.api.amortizationtable || designer.dsgEvents();

function VC_AMORTIZAAT_297336(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AMORTIZAAT_297336_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AMORTIZAAT_297336_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANSKVAEOTPS_336",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AMORTIZAAT_297336",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_LOANSKVAEOTPS_336",
        designerEvents.api.amortizationtable,
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
                vcName: 'VC_AMORTIZAAT_297336'
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
                    taskId: 'T_LOANSKVAEOTPS_336',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    AmortizationTable: "AmortizationTable",
                    Amount: "Amount"
                },
                entities: {
                    AmortizationTable: {
                        item4: 'AT17_ITEM4FTA356',
                        operationNumber: 'AT18_OPERATMO356',
                        item8: 'AT19_ITEM8KTR356',
                        item10: 'AT31_ITEM10WE356',
                        item3: 'AT31_ITEM3AGC356',
                        item2: 'AT37_ITEM2GKC356',
                        item12: 'AT38_ITEM12RF356',
                        balance: 'AT42_BALANCEE356',
                        item11: 'AT42_ITEM11NG356',
                        dividend: 'AT43_DIVIDEDD356',
                        fee: 'AT45_FEEXPEKQ356',
                        expirationDate: 'AT46_EXPIRATD356',
                        item13: 'AT58_ITEM13GD356',
                        item7: 'AT62_ITEM7VEW356',
                        item1: 'AT72_ITEM1ZMF356',
                        item6: 'AT75_ITEM6OBT356',
                        item9: 'AT90_ITEM9HWY356',
                        item5: 'AT95_ITEM5VSP356',
                        _pks: [],
                        _entityId: 'EN_AMORTIZAB_356',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Amount: {
                        authorizedAmount: 'AT29_AUTHORZE937',
                        creditBureau: 'AT31_CREDITER937',
                        cycleParticipation: 'AT31_CYCLEPCN937',
                        voluntarySavings: 'AT36_VOLUNTNI937',
                        increment: 'AT41_INCREMTT937',
                        memberId: 'AT45_MEMBERID937',
                        amount: 'AT51_AMOUNTUQ937',
                        secuential: 'AT52_SECUENIA937',
                        resultAmount: 'AT58_RESULTNN937',
                        memberName: 'AT62_MEMBERNN937',
                        riskLevel: 'AT66_RISKLEVV937',
                        checkRenapo: 'AT69_CHECKREP937',
                        groupId: 'AT70_GROUPIDD937',
                        safeReport: 'AT71_SAFERERR937',
                        oldOperation: 'AT73_OLDOPENI937',
                        credit: 'AT83_CREDITGM937',
                        safePackage: 'AT91_SAFEPACA937',
                        proposedMaximumSaving: 'AT92_PROPOSNG937',
                        oldBalance: 'AT96_OLDBALCC937',
                        _pks: [],
                        _entityId: 'EN_MONTOSVSY_937',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_AMORTIOZ_6763 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_AMORTIOZ_6763 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMORTIOZ_6763_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMORTIOZ_6763_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_AMORTIZAB_356',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMORTIOZ_6763',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_AMORTIOZ_6763_filters = {};
            var defaultValues = {
                AmortizationTable: {},
                Amount: {}
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
                $scope.vc.execute("temporarySave", VC_AMORTIZAAT_297336, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_AMORTIZAAT_297336, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_AMORTIZAAT_297336, data, function() {});
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
            $scope.vc.viewState.VC_AMORTIZAAT_297336 = {
                style: []
            }
            //ViewState - Group: Group1463
            $scope.vc.createViewState({
                id: "G_AMORTIZTBA_414796",
                hasId: true,
                componentStyle: [],
                label: 'Group1463',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.AmortizationTable = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    dividend: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "dividend", 0)
                    },
                    expirationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "expirationDate", new Date())
                    },
                    balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "balance", 0)
                    },
                    item1: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item1", 0)
                    },
                    item2: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item2", 0)
                    },
                    item3: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item3", 0)
                    },
                    item4: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item4", 0)
                    },
                    item5: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item5", 0)
                    },
                    item6: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item6", 0)
                    },
                    item7: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item7", 0)
                    },
                    item8: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item8", 0)
                    },
                    item9: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item9", 0)
                    },
                    item10: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item10", 0)
                    },
                    item11: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item11", 0)
                    },
                    item12: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item12", 0)
                    },
                    item13: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "item13", 0)
                    },
                    fee: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "fee", 0)
                    },
                    operationNumber: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("AmortizationTable", "operationNumber", 0)
                    }
                }
            });
            $scope.vc.model.AmortizationTable = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_AMORTIOZ_6763';
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMORTIOZ_6763();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6763_19315',
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
                        options.success(model);
                    },
                    destroy: function(options) {
                        var model = options.data;
                        options.success(model);
                    }
                },
                schema: {
                    model: $scope.vc.types.AmortizationTable
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6763_19315").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMORTIOZ_6763 = $scope.vc.model.AmortizationTable;
            $scope.vc.trackers.AmortizationTable = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.AmortizationTable);
            $scope.vc.model.AmortizationTable.bind('change', function(e) {
                $scope.vc.trackers.AmortizationTable.track(e);
            });
            $scope.vc.grids.QV_6763_19315 = {};
            $scope.vc.grids.QV_6763_19315.queryId = 'Q_AMORTIOZ_6763';
            $scope.vc.viewState.QV_6763_19315 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6763_19315.column = {};
            $scope.vc.grids.QV_6763_19315.editable = false;
            $scope.vc.grids.QV_6763_19315.events = {
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
                    $scope.vc.trackers.AmortizationTable.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6763_19315.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6763_19315");
                    $scope.vc.hideShowColumns("QV_6763_19315", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6763_19315.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6763_19315.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6763_19315.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6763_19315 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6763_19315 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6763_19315.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6763_19315.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6763_19315.column.dividend = {
                title: 'LOANS.LBL_LOANS_CUOTAXZTE_88241',
                titleArgs: {},
                tooltip: '',
                width: 50,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOBH_936796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT43_DIVIDEDD356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.dividend.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOBH_936796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.dividend.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.dividend.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.dividend.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.dividend.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.expirationDate = {
                title: 'LOANS.LBL_LOANS_FECHADEGG_88362',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDHOOVUA_457796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT46_EXPIRATD356 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.expirationDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDHOOVUA_457796",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.expirationDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_6763_19315.column.expirationDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.balance = {
                title: 'LOANS.LBL_LOANS_SALDOCAAT_24029',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUZN_422796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT42_BALANCEE356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.balance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUZN_422796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.balance.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.balance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.balance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item1 = {
                title: 'item1',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWKM_119796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT72_ITEM1ZMF356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item1.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWKM_119796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item1.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item1.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item1.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item1.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item2 = {
                title: 'item2',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKZS_899796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT37_ITEM2GKC356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item2.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKZS_899796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item2.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item2.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item2.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item2.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item3 = {
                title: 'item3',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPGM_393796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT31_ITEM3AGC356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item3.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPGM_393796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item3.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item3.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item3.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item3.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item4 = {
                title: 'item4',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUCO_506796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT17_ITEM4FTA356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item4.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUCO_506796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item4.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item4.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item4.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item4.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item5 = {
                title: 'item5',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPDO_916796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT95_ITEM5VSP356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item5.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPDO_916796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item5.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item5.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item5.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item5.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item6 = {
                title: 'item6',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRCO_514796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT75_ITEM6OBT356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item6.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRCO_514796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item6.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item6.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item6.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item6.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item7 = {
                title: 'item7',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOET_679796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT62_ITEM7VEW356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item7.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOET_679796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item7.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item7.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item7.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item7.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item8 = {
                title: 'item8',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKCO_739796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT19_ITEM8KTR356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item8.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKCO_739796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item8.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item8.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item8.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item8.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item9 = {
                title: 'item9',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSPS_284796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT90_ITEM9HWY356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item9.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSPS_284796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item9.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item9.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item9.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item9.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item10 = {
                title: 'item10',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBOR_258796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT31_ITEM10WE356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item10.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBOR_258796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item10.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item10.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item10.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item10.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item11 = {
                title: 'item11',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYFC_967796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT42_ITEM11NG356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item11.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYFC_967796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item11.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item11.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item11.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item11.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item12 = {
                title: 'item12',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUVL_491796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT38_ITEM12RF356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item12.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUVL_491796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item12.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item12.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item12.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item12.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.item13 = {
                title: 'item13',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSFV_122796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT58_ITEM13GD356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.item13.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSFV_122796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.item13.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.item13.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.item13.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.item13.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.fee = {
                title: 'LOANS.LBL_LOANS_VALORCUTA_77017',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZIZ_245796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT45_FEEXPEKQ356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.fee.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZIZ_245796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.fee.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.fee.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.fee.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.fee.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6763_19315.column.operationNumber = {
                title: 'operationNumber',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEMC_879796',
                element: []
            };
            $scope.vc.grids.QV_6763_19315.AT18_OPERATMO356 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6763_19315.column.operationNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEMC_879796",
                        'data-validation-code': "{{vc.viewState.QV_6763_19315.column.operationNumber.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6763_19315.column.operationNumber.format",
                        'k-decimals': "vc.viewState.QV_6763_19315.column.operationNumber.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6763_19315.column.operationNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'dividend',
                    title: '{{vc.viewState.QV_6763_19315.column.dividend.title|translate:vc.viewState.QV_6763_19315.column.dividend.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.dividend.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.dividend.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT43_DIVIDEDD356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.dividend.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.dividend, \"QV_6763_19315\", \"dividend\"):kendo.toString(#=dividend#, vc.viewState.QV_6763_19315.column.dividend.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.dividend.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.dividend.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.dividend.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'expirationDate',
                    title: '{{vc.viewState.QV_6763_19315.column.expirationDate.title|translate:vc.viewState.QV_6763_19315.column.expirationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.expirationDate.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.expirationDate.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT46_EXPIRATD356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.expirationDate.style'>#=((expirationDate !== null) ? kendo.toString(expirationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6763_19315.column.expirationDate.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.expirationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.expirationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'balance',
                    title: '{{vc.viewState.QV_6763_19315.column.balance.title|translate:vc.viewState.QV_6763_19315.column.balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.balance.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.balance.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT42_BALANCEE356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.balance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.balance, \"QV_6763_19315\", \"balance\"):kendo.toString(#=balance#, vc.viewState.QV_6763_19315.column.balance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.balance.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item1',
                    title: '{{vc.viewState.QV_6763_19315.column.item1.title|translate:vc.viewState.QV_6763_19315.column.item1.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item1.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item1.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT72_ITEM1ZMF356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item1.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item1, \"QV_6763_19315\", \"item1\"):kendo.toString(#=item1#, vc.viewState.QV_6763_19315.column.item1.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item1.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item1.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item1.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item2',
                    title: '{{vc.viewState.QV_6763_19315.column.item2.title|translate:vc.viewState.QV_6763_19315.column.item2.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item2.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item2.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT37_ITEM2GKC356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item2.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item2, \"QV_6763_19315\", \"item2\"):kendo.toString(#=item2#, vc.viewState.QV_6763_19315.column.item2.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item2.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item2.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item2.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item3',
                    title: '{{vc.viewState.QV_6763_19315.column.item3.title|translate:vc.viewState.QV_6763_19315.column.item3.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item3.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item3.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT31_ITEM3AGC356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item3.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item3, \"QV_6763_19315\", \"item3\"):kendo.toString(#=item3#, vc.viewState.QV_6763_19315.column.item3.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item3.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item3.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item3.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item4',
                    title: '{{vc.viewState.QV_6763_19315.column.item4.title|translate:vc.viewState.QV_6763_19315.column.item4.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item4.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item4.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT17_ITEM4FTA356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item4.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item4, \"QV_6763_19315\", \"item4\"):kendo.toString(#=item4#, vc.viewState.QV_6763_19315.column.item4.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item4.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item4.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item4.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item5',
                    title: '{{vc.viewState.QV_6763_19315.column.item5.title|translate:vc.viewState.QV_6763_19315.column.item5.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item5.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item5.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT95_ITEM5VSP356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item5.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item5, \"QV_6763_19315\", \"item5\"):kendo.toString(#=item5#, vc.viewState.QV_6763_19315.column.item5.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item5.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item5.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item5.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item6',
                    title: '{{vc.viewState.QV_6763_19315.column.item6.title|translate:vc.viewState.QV_6763_19315.column.item6.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item6.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item6.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT75_ITEM6OBT356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item6.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item6, \"QV_6763_19315\", \"item6\"):kendo.toString(#=item6#, vc.viewState.QV_6763_19315.column.item6.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item6.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item6.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item6.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item7',
                    title: '{{vc.viewState.QV_6763_19315.column.item7.title|translate:vc.viewState.QV_6763_19315.column.item7.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item7.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item7.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT62_ITEM7VEW356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item7.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item7, \"QV_6763_19315\", \"item7\"):kendo.toString(#=item7#, vc.viewState.QV_6763_19315.column.item7.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item7.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item7.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item7.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item8',
                    title: '{{vc.viewState.QV_6763_19315.column.item8.title|translate:vc.viewState.QV_6763_19315.column.item8.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item8.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item8.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT19_ITEM8KTR356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item8.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item8, \"QV_6763_19315\", \"item8\"):kendo.toString(#=item8#, vc.viewState.QV_6763_19315.column.item8.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item8.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item8.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item8.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item9',
                    title: '{{vc.viewState.QV_6763_19315.column.item9.title|translate:vc.viewState.QV_6763_19315.column.item9.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item9.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item9.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT90_ITEM9HWY356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item9.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item9, \"QV_6763_19315\", \"item9\"):kendo.toString(#=item9#, vc.viewState.QV_6763_19315.column.item9.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item9.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item9.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item9.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item10',
                    title: '{{vc.viewState.QV_6763_19315.column.item10.title|translate:vc.viewState.QV_6763_19315.column.item10.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item10.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item10.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT31_ITEM10WE356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item10.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item10, \"QV_6763_19315\", \"item10\"):kendo.toString(#=item10#, vc.viewState.QV_6763_19315.column.item10.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item10.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item10.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item10.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item11',
                    title: '{{vc.viewState.QV_6763_19315.column.item11.title|translate:vc.viewState.QV_6763_19315.column.item11.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item11.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item11.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT42_ITEM11NG356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item11.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item11, \"QV_6763_19315\", \"item11\"):kendo.toString(#=item11#, vc.viewState.QV_6763_19315.column.item11.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item11.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item11.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item11.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item12',
                    title: '{{vc.viewState.QV_6763_19315.column.item12.title|translate:vc.viewState.QV_6763_19315.column.item12.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item12.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item12.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT38_ITEM12RF356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item12.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item12, \"QV_6763_19315\", \"item12\"):kendo.toString(#=item12#, vc.viewState.QV_6763_19315.column.item12.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item12.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item12.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item12.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'item13',
                    title: '{{vc.viewState.QV_6763_19315.column.item13.title|translate:vc.viewState.QV_6763_19315.column.item13.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.item13.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.item13.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT58_ITEM13GD356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.item13.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.item13, \"QV_6763_19315\", \"item13\"):kendo.toString(#=item13#, vc.viewState.QV_6763_19315.column.item13.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.item13.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.item13.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.item13.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'fee',
                    title: '{{vc.viewState.QV_6763_19315.column.fee.title|translate:vc.viewState.QV_6763_19315.column.fee.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.fee.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.fee.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT45_FEEXPEKQ356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.fee.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.fee, \"QV_6763_19315\", \"fee\"):kendo.toString(#=fee#, vc.viewState.QV_6763_19315.column.fee.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.fee.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.fee.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.fee.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6763_19315.columns.push({
                    field: 'operationNumber',
                    title: '{{vc.viewState.QV_6763_19315.column.operationNumber.title|translate:vc.viewState.QV_6763_19315.column.operationNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_6763_19315.column.operationNumber.width,
                    format: $scope.vc.viewState.QV_6763_19315.column.operationNumber.format,
                    editor: $scope.vc.grids.QV_6763_19315.AT18_OPERATMO356.control,
                    template: "<span ng-class='vc.viewState.QV_6763_19315.column.operationNumber.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.operationNumber, \"QV_6763_19315\", \"operationNumber\"):kendo.toString(#=operationNumber#, vc.viewState.QV_6763_19315.column.operationNumber.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6763_19315.column.operationNumber.style",
                        "title": "{{vc.viewState.QV_6763_19315.column.operationNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6763_19315.column.operationNumber.hidden
                });
            }
            $scope.vc.viewState.QV_6763_19315.toolbar = {}
            $scope.vc.grids.QV_6763_19315.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSKVAEOTPS_336_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSKVAEOTPS_336_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Amount = {
                authorizedAmount: $scope.vc.channelDefaultValues("Amount", "authorizedAmount"),
                creditBureau: $scope.vc.channelDefaultValues("Amount", "creditBureau"),
                cycleParticipation: $scope.vc.channelDefaultValues("Amount", "cycleParticipation"),
                voluntarySavings: $scope.vc.channelDefaultValues("Amount", "voluntarySavings"),
                increment: $scope.vc.channelDefaultValues("Amount", "increment"),
                memberId: $scope.vc.channelDefaultValues("Amount", "memberId"),
                amount: $scope.vc.channelDefaultValues("Amount", "amount"),
                secuential: $scope.vc.channelDefaultValues("Amount", "secuential"),
                resultAmount: $scope.vc.channelDefaultValues("Amount", "resultAmount"),
                memberName: $scope.vc.channelDefaultValues("Amount", "memberName"),
                riskLevel: $scope.vc.channelDefaultValues("Amount", "riskLevel"),
                checkRenapo: $scope.vc.channelDefaultValues("Amount", "checkRenapo"),
                groupId: $scope.vc.channelDefaultValues("Amount", "groupId"),
                safeReport: $scope.vc.channelDefaultValues("Amount", "safeReport"),
                oldOperation: $scope.vc.channelDefaultValues("Amount", "oldOperation"),
                credit: $scope.vc.channelDefaultValues("Amount", "credit"),
                safePackage: $scope.vc.channelDefaultValues("Amount", "safePackage"),
                proposedMaximumSaving: $scope.vc.channelDefaultValues("Amount", "proposedMaximumSaving"),
                oldBalance: $scope.vc.channelDefaultValues("Amount", "oldBalance")
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
                $scope.vc.render('VC_AMORTIZAAT_297336');
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
    var cobisMainModule = cobis.createModule("VC_AMORTIZAAT_297336", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_AMORTIZAAT_297336", {
            templateUrl: "VC_AMORTIZAAT_297336_FORM.html",
            controller: "VC_AMORTIZAAT_297336_CTRL",
            label: "AmortizationTable",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AMORTIZAAT_297336?" + $.param(search);
            }
        });
        VC_AMORTIZAAT_297336(cobisMainModule);
    }]);
} else {
    VC_AMORTIZAAT_297336(cobisMainModule);
}