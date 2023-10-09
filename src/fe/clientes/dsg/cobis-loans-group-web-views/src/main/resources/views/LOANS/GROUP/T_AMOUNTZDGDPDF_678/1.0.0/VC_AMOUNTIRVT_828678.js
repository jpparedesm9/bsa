//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.amountform = designerEvents.api.amountform || designer.dsgEvents();

function VC_AMOUNTIRVT_828678(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_AMOUNTIRVT_828678_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_AMOUNTIRVT_828678_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_AMOUNTZDGDPDF_678",
            taskVersion: "1.0.0",
            viewContainerId: "VC_AMOUNTIRVT_828678",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_AMOUNTZDGDPDF_678",
        designerEvents.api.amountform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_AMOUNTIRVT_828678'
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
                    taskId: 'T_AMOUNTZDGDPDF_678',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Amount: "Amount",
                    Credit: "Credit"
                },
                entities: {
                    Amount: {
                        authorizedAmount: 'AT29_AUTHORZE937',
                        creditBureau: 'AT31_CREDITER937',
                        cycleParticipation: 'AT31_CYCLEPCN937',
                        voluntarySavings: 'AT36_VOLUNTNI937',
                        increment: 'AT41_INCREMTT937',
                        memberId: 'AT45_MEMBERID937',
                        amount: 'AT51_AMOUNTUQ937',
                        secuential: 'AT52_SECUENIA937',
                        memberName: 'AT62_MEMBERNN937',
                        riskLevel: 'AT66_RISKLEVV937',
                        checkRenapo: 'AT69_CHECKREP937',
                        groupId: 'AT70_GROUPIDD937',
                        safeReport: 'AT71_SAFERERR937',
                        credit: 'AT83_CREDITGM937',
                        safePackage: 'AT91_SAFEPACA937',
                        proposedMaximumSaving: 'AT92_PROPOSNG937',
                        _pks: [],
                        _entityId: 'EN_MONTOSVSY_937',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Credit: {
                        office: 'AT11_OFFICEGM386',
                        subtype: 'AT26_SUBTYPEE386',
                        linked: 'AT37_LINKEDMA386',
                        term: 'AT40_TERMUMMV386',
                        category: 'AT42_CATEGORY386',
                        businessSector: 'AT45_BUSINESC386',
                        officeName: 'AT45_OFFICEAN386',
                        operationNumber: 'AT48_OPERATNI386',
                        customerId: 'AT63_CUSTOMIR386',
                        applicationNumber: 'AT65_APPLICUR386',
                        approvedAmount: 'AT70_APPROVMO386',
                        nemonicCurrency: 'AT70_MNEMONER386',
                        nameActivity: 'AT71_NAMEACIY386',
                        percentageWarranty: 'AT71_PERCENWA386',
                        paymentFrecuencyName: 'AT75_PAYMENEE386',
                        creditCode: 'AT76_CREDITCC386',
                        productType: 'AT85_PRODUCTP386',
                        amountRequested: 'AT87_AMOUNTEE386',
                        warrantyAmount: 'AT90_WARRANUT386',
                        paymentFrecuency: 'AT94_PAYMENEE386',
                        _pks: [],
                        _entityId: 'EN_CREDITAUT_386',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_AMOUNTKL_6248 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_AMOUNTKL_6248 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_AMOUNTKL_6248_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_AMOUNTKL_6248_filters;
                    parametersAux = {
                        memberId: filters.memberId,
                        safeReport: filters.safeReport
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_MONTOSVSY_937',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_AMOUNTKL_6248',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['memberId'] = this.filters.memberId;
                            this.parameters['safeReport'] = this.filters.safeReport;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_AMOUNTKL_6248_filters = {};
            var defaultValues = {
                Amount: {},
                Credit: {}
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
                $scope.vc.execute("temporarySave", VC_AMOUNTIRVT_828678, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_AMOUNTIRVT_828678, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_AMOUNTIRVT_828678, data, function() {});
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
            $scope.vc.viewState.VC_AMOUNTIRVT_828678 = {
                style: []
            }
            //ViewState - Group: Group1285
            $scope.vc.createViewState({
                id: "G_AMOUNTGUDN_676190",
                hasId: true,
                componentStyle: [],
                label: 'Group1285',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Amount = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    secuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "secuential", 0)
                    },
                    memberName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "memberName", '')
                    },
                    cycleParticipation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "cycleParticipation", '')
                    },
                    amount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "amount", 0)
                    },
                    groupId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "groupId", 0)
                    },
                    credit: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "credit", 0)
                    },
                    authorizedAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "authorizedAmount", 0)
                    },
                    voluntarySavings: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "voluntarySavings", 0)
                    },
                    proposedMaximumSaving: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "proposedMaximumSaving", 0)
                    },
                    increment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "increment", 0)
                    },
                    creditBureau: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "creditBureau", '')
                    },
                    riskLevel: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "riskLevel", '')
                    },
                    checkRenapo: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "checkRenapo", '')
                    },
                    safePackage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "safePackage", '')
                    },
                    safeReport: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Amount", "safeReport", '')
                    },
                    memberId: {
                        type: "number",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Amount = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_AMOUNTKL_6248';
                            var queryRequest = $scope.vc.getRequestQuery_Q_AMOUNTKL_6248();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_6248_19660',
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
                    model: $scope.vc.types.Amount
                },
                aggregate: [{
                    field: "amount",
                    aggregate: "sum"
                }, {
                    field: "authorizedAmount",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6248_19660").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_AMOUNTKL_6248 = $scope.vc.model.Amount;
            $scope.vc.trackers.Amount = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Amount);
            $scope.vc.model.Amount.bind('change', function(e) {
                $scope.vc.trackers.Amount.track(e);
            });
            $scope.vc.grids.QV_6248_19660 = {};
            $scope.vc.grids.QV_6248_19660.queryId = 'Q_AMOUNTKL_6248';
            $scope.vc.viewState.QV_6248_19660 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6248_19660.column = {};
            $scope.vc.grids.QV_6248_19660.editable = false;
            $scope.vc.grids.QV_6248_19660.events = {
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
                    $scope.vc.trackers.Amount.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6248_19660.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6248_19660");
                    $scope.vc.hideShowColumns("QV_6248_19660", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6248_19660.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6248_19660.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6248_19660.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6248_19660 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6248_19660 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6248_19660.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6248_19660.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6248_19660.column.secuential = {
                title: 'LOANS.LBL_LOANS_SECUENCLL_73798',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEIC_598190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT52_SECUENIA937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.secuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEIC_598190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.secuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.secuential.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.secuential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.secuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.memberName = {
                title: 'LOANS.LBL_LOANS_CLIENTEMZ_77659',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSTP_229190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT62_MEMBERNN937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.memberName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSTP_229190",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.memberName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.memberName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.cycleParticipation = {
                title: 'LOANS.LBL_LOANS_PARTICIAA_71360',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVGT_319190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT31_CYCLEPCN937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.cycleParticipation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVGT_319190",
                        'designer-restrict-input': "lock",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.cycleParticipation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.cycleParticipation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.amount = {
                title: 'LOANS.LBL_LOANS_MONTOSOOI_45840',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSRP_129190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT51_AMOUNTUQ937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.amount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSRP_129190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.amount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.amount.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.amount.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXSRP_129190',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.amount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.groupId = {
                title: 'groupId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWOA_550190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT70_GROUPIDD937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.groupId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWOA_550190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.groupId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.groupId.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.groupId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.groupId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.credit = {
                title: 'credit',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYGF_110190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT83_CREDITGM937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.credit.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYGF_110190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.credit.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.credit.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.credit.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.credit.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.authorizedAmount = {
                title: 'LOANS.LBL_LOANS_MONTOAURO_71217',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLEH_921190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT29_AUTHORZE937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.authorizedAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLEH_921190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.authorizedAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.authorizedAmount.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.authorizedAmount.decimals",
                        'k-on-change': "vc.change(kendoEvent,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXLEH_921190',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.authorizedAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.voluntarySavings = {
                title: 'LOANS.LBL_LOANS_AHORROVOA_67689',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUPR_288190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT36_VOLUNTNI937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.voluntarySavings.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXUPR_288190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.voluntarySavings.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.voluntarySavings.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.voluntarySavings.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.voluntarySavings.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving = {
                title: 'LOANS.LBL_LOANS_MONTOMXOT_70313',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWXN_691190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT92_PROPOSNG937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.proposedMaximumSaving.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWXN_691190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.increment = {
                title: 'LOANS.LBL_LOANS_INCREMEOO_12075',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXAFW_332190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT41_INCREMTT937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.increment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAFW_332190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.increment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6248_19660.column.increment.format",
                        'k-decimals': "vc.viewState.QV_6248_19660.column.increment.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.increment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.creditBureau = {
                title: 'LOANS.LBL_LOANS_NIVELDERI_38662',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGCR_987190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT31_CREDITER937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.creditBureau.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGCR_987190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.creditBureau.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.creditBureau.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.riskLevel = {
                title: 'LOANS.LBL_LOANS_NIVELDERI_38662',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNPT_791190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT66_RISKLEVV937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.riskLevel.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNPT_791190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.riskLevel.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.riskLevel.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.checkRenapo = {
                title: 'checkRenapo',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBIK_156190',
                element: []
            };
            $scope.vc.grids.QV_6248_19660.AT69_CHECKREP937 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.checkRenapo.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBIK_156190",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.checkRenapo.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6248_19660.column.checkRenapo.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.safePackage = {
                title: 'LOANS.LBL_LOANS_PAQUETEGU_42007',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYVS_120190',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXYVS_120190 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog(
                            'VA_TEXTINPUTBOXYVS_120190', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXYVS_120190'];
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
            $scope.vc.grids.QV_6248_19660.AT91_SAFEPACA937 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.safePackage.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYVS_120190",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_6248_19660.column.safePackage.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXYVS_120190",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_6248_19660.column.safePackage.template",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.safePackage.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.safeReport = {
                title: 'safeReport',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHQM_979190',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXHQM_979190 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_6248_19660.AT71_SAFERERR937 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6248_19660.column.safeReport.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHQM_979190",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_6248_19660.column.safeReport.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXHQM_979190",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_6248_19660.column.safeReport.template",
                        'data-validation-code': "{{vc.viewState.QV_6248_19660.column.safeReport.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6248_19660.column.memberId = {
                title: 'memberId',
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
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'secuential',
                    title: '{{vc.viewState.QV_6248_19660.column.secuential.title|translate:vc.viewState.QV_6248_19660.column.secuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.secuential.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.secuential.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT52_SECUENIA937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.secuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.secuential, \"QV_6248_19660\", \"secuential\"):kendo.toString(#=secuential#, vc.viewState.QV_6248_19660.column.secuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.secuential.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.secuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.secuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'memberName',
                    title: '{{vc.viewState.QV_6248_19660.column.memberName.title|translate:vc.viewState.QV_6248_19660.column.memberName.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.memberName.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.memberName.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT62_MEMBERNN937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.memberName.style' ng-bind='vc.getStringColumnFormat(dataItem.memberName, \"QV_6248_19660\", \"memberName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.memberName.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.memberName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.memberName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'cycleParticipation',
                    title: '{{vc.viewState.QV_6248_19660.column.cycleParticipation.title|translate:vc.viewState.QV_6248_19660.column.cycleParticipation.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.cycleParticipation.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.cycleParticipation.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT31_CYCLEPCN937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.cycleParticipation.style' ng-bind='vc.getStringColumnFormat(dataItem.cycleParticipation, \"QV_6248_19660\", \"cycleParticipation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.cycleParticipation.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.cycleParticipation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.cycleParticipation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'amount',
                    title: '{{vc.viewState.QV_6248_19660.column.amount.title|translate:vc.viewState.QV_6248_19660.column.amount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.amount.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.amount.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'amount', $scope.vc.grids.QV_6248_19660.AT51_AMOUNTUQ937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'amount', "<span ng-class='vc.viewState.QV_6248_19660.column.amount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amount, \"QV_6248_19660\", \"amount\"):kendo.toString(#=amount#, vc.viewState.QV_6248_19660.column.amount.format)'></span>"),
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.amount.sum, $scope.vc.viewState.QV_6248_19660.column.amount.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.amount.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.amount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.amount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'groupId',
                    title: '{{vc.viewState.QV_6248_19660.column.groupId.title|translate:vc.viewState.QV_6248_19660.column.groupId.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.groupId.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.groupId.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT70_GROUPIDD937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.groupId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.groupId, \"QV_6248_19660\", \"groupId\"):kendo.toString(#=groupId#, vc.viewState.QV_6248_19660.column.groupId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.groupId.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.groupId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.groupId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'credit',
                    title: '{{vc.viewState.QV_6248_19660.column.credit.title|translate:vc.viewState.QV_6248_19660.column.credit.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.credit.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.credit.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT83_CREDITGM937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.credit.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.credit, \"QV_6248_19660\", \"credit\"):kendo.toString(#=credit#, vc.viewState.QV_6248_19660.column.credit.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6248_19660.column.credit.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.credit.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.credit.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'authorizedAmount',
                    title: '{{vc.viewState.QV_6248_19660.column.authorizedAmount.title|translate:vc.viewState.QV_6248_19660.column.authorizedAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'authorizedAmount', $scope.vc.grids.QV_6248_19660.AT29_AUTHORZE937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'authorizedAmount', "<span ng-class='vc.viewState.QV_6248_19660.column.authorizedAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.authorizedAmount, \"QV_6248_19660\", \"authorizedAmount\"):kendo.toString(#=authorizedAmount#, vc.viewState.QV_6248_19660.column.authorizedAmount.format)'></span>"),
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.authorizedAmount.sum, $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.format);
                        return "<div class='' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.authorizedAmount.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.authorizedAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.authorizedAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'voluntarySavings',
                    title: '{{vc.viewState.QV_6248_19660.column.voluntarySavings.title|translate:vc.viewState.QV_6248_19660.column.voluntarySavings.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.voluntarySavings.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.voluntarySavings.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'voluntarySavings', $scope.vc.grids.QV_6248_19660.AT36_VOLUNTNI937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'voluntarySavings', "<span ng-class='vc.viewState.QV_6248_19660.column.voluntarySavings.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.voluntarySavings, \"QV_6248_19660\", \"voluntarySavings\"):kendo.toString(#=voluntarySavings#, vc.viewState.QV_6248_19660.column.voluntarySavings.format)'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.voluntarySavings.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.voluntarySavings.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.voluntarySavings.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'proposedMaximumSaving',
                    title: '{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.title|translate:vc.viewState.QV_6248_19660.column.proposedMaximumSaving.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'proposedMaximumSaving', $scope.vc.grids.QV_6248_19660.AT92_PROPOSNG937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'proposedMaximumSaving', "<span ng-class='vc.viewState.QV_6248_19660.column.proposedMaximumSaving.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.proposedMaximumSaving, \"QV_6248_19660\", \"proposedMaximumSaving\"):kendo.toString(#=proposedMaximumSaving#, vc.viewState.QV_6248_19660.column.proposedMaximumSaving.format)'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.proposedMaximumSaving.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.proposedMaximumSaving.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.proposedMaximumSaving.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'increment',
                    title: '{{vc.viewState.QV_6248_19660.column.increment.title|translate:vc.viewState.QV_6248_19660.column.increment.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.increment.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.increment.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'increment', $scope.vc.grids.QV_6248_19660.AT41_INCREMTT937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'increment', "<span ng-class='vc.viewState.QV_6248_19660.column.increment.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.increment, \"QV_6248_19660\", \"increment\"):kendo.toString(#=increment#, vc.viewState.QV_6248_19660.column.increment.format)'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.increment.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.increment.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": ""
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.increment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'creditBureau',
                    title: '{{vc.viewState.QV_6248_19660.column.creditBureau.title|translate:vc.viewState.QV_6248_19660.column.creditBureau.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.creditBureau.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.creditBureau.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'creditBureau', $scope.vc.grids.QV_6248_19660.AT31_CREDITER937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'creditBureau', "<span ng-class='vc.viewState.QV_6248_19660.column.creditBureau.style' ng-bind='vc.getStringColumnFormat(dataItem.creditBureau, \"QV_6248_19660\", \"creditBureau\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.creditBureau.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.creditBureau.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.creditBureau.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'riskLevel',
                    title: '{{vc.viewState.QV_6248_19660.column.riskLevel.title|translate:vc.viewState.QV_6248_19660.column.riskLevel.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.riskLevel.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.riskLevel.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'riskLevel', $scope.vc.grids.QV_6248_19660.AT66_RISKLEVV937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'riskLevel', "<span ng-class='vc.viewState.QV_6248_19660.column.riskLevel.style' ng-bind='vc.getStringColumnFormat(dataItem.riskLevel, \"QV_6248_19660\", \"riskLevel\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.riskLevel.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.riskLevel.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.riskLevel.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'checkRenapo',
                    title: '{{vc.viewState.QV_6248_19660.column.checkRenapo.title|translate:vc.viewState.QV_6248_19660.column.checkRenapo.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.checkRenapo.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.checkRenapo.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT69_CHECKREP937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.checkRenapo.style' ng-bind='vc.getStringColumnFormat(dataItem.checkRenapo, \"QV_6248_19660\", \"checkRenapo\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.checkRenapo.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.checkRenapo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.checkRenapo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'safePackage',
                    title: '{{vc.viewState.QV_6248_19660.column.safePackage.title|translate:vc.viewState.QV_6248_19660.column.safePackage.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.safePackage.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.safePackage.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_6248_19660', 'safePackage', $scope.vc.grids.QV_6248_19660.AT91_SAFEPACA937.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_6248_19660', 'safePackage', "<span ng-class='vc.viewState.QV_6248_19660.column.safePackage.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXYVS_120190.get(dataItem.safePackage).value'> </span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.safePackage.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.safePackage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.safePackage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_6248_19660.columns.push({
                    field: 'safeReport',
                    title: '{{vc.viewState.QV_6248_19660.column.safeReport.title|translate:vc.viewState.QV_6248_19660.column.safeReport.titleArgs}}',
                    width: $scope.vc.viewState.QV_6248_19660.column.safeReport.width,
                    format: $scope.vc.viewState.QV_6248_19660.column.safeReport.format,
                    editor: $scope.vc.grids.QV_6248_19660.AT71_SAFERERR937.control,
                    template: "<span ng-class='vc.viewState.QV_6248_19660.column.safeReport.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXHQM_979190.get(dataItem.safeReport).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6248_19660.column.safeReport.style",
                        "title": "{{vc.viewState.QV_6248_19660.column.safeReport.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6248_19660.column.safeReport.hidden
                });
            }
            $scope.vc.viewState.QV_6248_19660.toolbar = {}
            $scope.vc.grids.QV_6248_19660.toolbar = [];
            $scope.vc.model.Credit = {
                office: $scope.vc.channelDefaultValues("Credit", "office"),
                subtype: $scope.vc.channelDefaultValues("Credit", "subtype"),
                linked: $scope.vc.channelDefaultValues("Credit", "linked"),
                term: $scope.vc.channelDefaultValues("Credit", "term"),
                category: $scope.vc.channelDefaultValues("Credit", "category"),
                businessSector: $scope.vc.channelDefaultValues("Credit", "businessSector"),
                officeName: $scope.vc.channelDefaultValues("Credit", "officeName"),
                operationNumber: $scope.vc.channelDefaultValues("Credit", "operationNumber"),
                customerId: $scope.vc.channelDefaultValues("Credit", "customerId"),
                applicationNumber: $scope.vc.channelDefaultValues("Credit", "applicationNumber"),
                approvedAmount: $scope.vc.channelDefaultValues("Credit", "approvedAmount"),
                nemonicCurrency: $scope.vc.channelDefaultValues("Credit", "nemonicCurrency"),
                nameActivity: $scope.vc.channelDefaultValues("Credit", "nameActivity"),
                percentageWarranty: $scope.vc.channelDefaultValues("Credit", "percentageWarranty"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("Credit", "paymentFrecuencyName"),
                creditCode: $scope.vc.channelDefaultValues("Credit", "creditCode"),
                productType: $scope.vc.channelDefaultValues("Credit", "productType"),
                amountRequested: $scope.vc.channelDefaultValues("Credit", "amountRequested"),
                warrantyAmount: $scope.vc.channelDefaultValues("Credit", "warrantyAmount"),
                paymentFrecuency: $scope.vc.channelDefaultValues("Credit", "paymentFrecuency")
            };
            //ViewState - Group: Group1180
            $scope.vc.createViewState({
                id: "G_AMOUNTIXUH_522190",
                hasId: true,
                componentStyle: [],
                label: 'Group1180',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Credit, Attribute: creditCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXZSH_356190",
                componentStyle: [],
                label: '',
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONNPVXIJW_123190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GUARDARLI_67841",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONAICSAKZ_975190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_RBUREOYXZ_41352",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Credit, Attribute: warrantyAmount
            $scope.vc.createViewState({
                id: "VA_WARRANTYAMOUNTN_792190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MONTOGATN_84974",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONGPPUIHN_830190",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SINCRONVZ_73628",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_AMOUNTZDGDPDF_678_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_AMOUNTZDGDPDF_678_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXYVS_120190.read();
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
                $scope.vc.render('VC_AMOUNTIRVT_828678');
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
    var cobisMainModule = cobis.createModule("VC_AMOUNTIRVT_828678", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_AMOUNTIRVT_828678", {
            templateUrl: "VC_AMOUNTIRVT_828678_FORM.html",
            controller: "VC_AMOUNTIRVT_828678_CTRL",
            label: "AmountForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_AMOUNTIRVT_828678?" + $.param(search);
            }
        });
        VC_AMOUNTIRVT_828678(cobisMainModule);
    }]);
} else {
    VC_AMOUNTIRVT_828678(cobisMainModule);
}