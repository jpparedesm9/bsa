//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.reportgroupaccountstatement = designerEvents.api.reportgroupaccountstatement || designer.dsgEvents();

function VC_REPORTGRTT_453266(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_REPORTGRTT_453266_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_REPORTGRTT_453266_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_REPORTGROUMTA_266",
            taskVersion: "1.0.0",
            viewContainerId: "VC_REPORTGRTT_453266",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_REPORTGROUMTA_266",
        designerEvents.api.reportgroupaccountstatement,
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
                vcName: 'VC_REPORTGRTT_453266'
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
                    taskId: 'T_REPORTGROUMTA_266',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    InformationGroup: "InformationGroup",
                    CreditSummary: "CreditSummary",
                    PaymentPlan: "PaymentPlan",
                    CreditHeader: "CreditHeader"
                },
                entities: {
                    InformationGroup: {
                        deliverDate: 'AT17_DELIVEAE116',
                        groupMeeting: 'AT22_GROUPMIT116',
                        groupId: 'AT24_GROUPIDD116',
                        adviser: 'AT34_ADVISERR116',
                        amountBorrowed: 'AT41_AMOUNTEO116',
                        interestRate: 'AT57_INTERETA116',
                        cycle: 'AT61_CYCLEQNQ116',
                        destination: 'AT61_DESTINAO116',
                        branchOffice: 'AT68_BRANCHII116',
                        groupName: 'AT76_GROUPNMM116',
                        term: 'AT91_TERMFEEL116',
                        _pks: [],
                        _entityId: 'EN_INATIONPO_116',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CreditSummary: {
                        currencyBalance: 'AT21_CURRENAA284',
                        payment: 'AT22_PAYMENTT284',
                        concept: 'AT58_CONCEPTT284',
                        expired: 'AT62_EXPIREDD284',
                        beginningBalance: 'AT94_BEGINNLG284',
                        _pks: [],
                        _entityId: 'EN_CREDITSMM_284',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PaymentPlan: {
                        interest: 'AT22_INTERETT576',
                        numPayment: 'AT34_NUMPAYEE576',
                        capital: 'AT42_CAPITALL576',
                        voluntarySavings: 'AT43_VOLUNTVN576',
                        datePayment: 'AT47_DATEPAYY576',
                        balance: 'AT62_BALANCEE576',
                        others: 'AT77_OTHERSPZ576',
                        extraSavings: 'AT78_EXTRASSA576',
                        _pks: [],
                        _entityId: 'EN_PAYMENTLL_576',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    CreditHeader: {
                        creditCode: 'AT25_CREDITCD216',
                        _pks: [],
                        _entityId: 'EN_CREDITHAD_216',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CREDITYS_4263 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_CREDITYS_4263 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CREDITYS_4263_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CREDITYS_4263_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CREDITSMM_284',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CREDITYS_4263',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_CREDITYS_4263_filters = {};
            $scope.vc.queryProperties.Q_PAYMENLA_6897 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_PAYMENLA_6897 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PAYMENLA_6897_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PAYMENLA_6897_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PAYMENTLL_576',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PAYMENLA_6897',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {}
                }
            };
            $scope.vc.queries.Q_PAYMENLA_6897_filters = {};
            var defaultValues = {
                InformationGroup: {},
                CreditSummary: {},
                PaymentPlan: {},
                CreditHeader: {}
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
                $scope.vc.execute("temporarySave", VC_REPORTGRTT_453266, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_REPORTGRTT_453266, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_REPORTGRTT_453266, data, function() {});
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
            $scope.vc.viewState.VC_REPORTGRTT_453266 = {
                style: []
            }
            //ViewState - Group: GroupLayout1604
            $scope.vc.createViewState({
                id: "G_REPORTGNUE_515585",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1604',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.InformationGroup = {
                deliverDate: $scope.vc.channelDefaultValues("InformationGroup", "deliverDate"),
                groupMeeting: $scope.vc.channelDefaultValues("InformationGroup", "groupMeeting"),
                groupId: $scope.vc.channelDefaultValues("InformationGroup", "groupId"),
                adviser: $scope.vc.channelDefaultValues("InformationGroup", "adviser"),
                amountBorrowed: $scope.vc.channelDefaultValues("InformationGroup", "amountBorrowed"),
                interestRate: $scope.vc.channelDefaultValues("InformationGroup", "interestRate"),
                cycle: $scope.vc.channelDefaultValues("InformationGroup", "cycle"),
                destination: $scope.vc.channelDefaultValues("InformationGroup", "destination"),
                branchOffice: $scope.vc.channelDefaultValues("InformationGroup", "branchOffice"),
                groupName: $scope.vc.channelDefaultValues("InformationGroup", "groupName"),
                term: $scope.vc.channelDefaultValues("InformationGroup", "term")
            };
            //ViewState - Group: Group1507
            $scope.vc.createViewState({
                id: "G_REPORTGMOC_643585",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_INACINDEO_57026",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: groupName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXYP_515585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GRUPOKNQM_86359",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: cycle
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXIKC_800585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CICLOXUWG_33802",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: branchOffice
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKTD_961585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SUCURSALL_95443",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: amountBorrowed
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQMI_699585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MONTOPREO_58069",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: adviser
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVBK_220585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ASESORYRQ_40106",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: term
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXZYE_455585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_PLAZOUBSI_97565",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: destination
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDGB_604585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DESTINONO_76622",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: interestRate
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXWCA_479585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TASADEIES_94629",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: groupMeeting
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXCSK_712585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_REUNIONDU_31545",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: InformationGroup, Attribute: deliverDate
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVBZ_342585",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHADENG_61776",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2310
            $scope.vc.createViewState({
                id: "G_REPORTGTTU_983585",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_RESUMENDI_55498",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CreditSummary = kendo.data.Model.define({
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
                        defaultValue: $scope.vc.channelDefaultValues("CreditSummary", "concept", '')
                    },
                    beginningBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditSummary", "beginningBalance", 0)
                    },
                    payment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditSummary", "payment", 0)
                    },
                    currencyBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditSummary", "currencyBalance", 0)
                    },
                    expired: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CreditSummary", "expired", 0)
                    }
                }
            });
            $scope.vc.model.CreditSummary = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_CREDITYS_4263();
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
                    model: $scope.vc.types.CreditSummary
                },
                aggregate: [{
                    field: "beginningBalance",
                    aggregate: "sum"
                }, {
                    field: "payment",
                    aggregate: "sum"
                }, {
                    field: "currencyBalance",
                    aggregate: "sum"
                }, {
                    field: "expired",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_4263_54550").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CREDITYS_4263 = $scope.vc.model.CreditSummary;
            $scope.vc.trackers.CreditSummary = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CreditSummary);
            $scope.vc.model.CreditSummary.bind('change', function(e) {
                $scope.vc.trackers.CreditSummary.track(e);
            });
            $scope.vc.grids.QV_4263_54550 = {};
            $scope.vc.grids.QV_4263_54550.queryId = 'Q_CREDITYS_4263';
            $scope.vc.viewState.QV_4263_54550 = {
                style: undefined
            };
            $scope.vc.viewState.QV_4263_54550.column = {};
            $scope.vc.grids.QV_4263_54550.editable = false;
            $scope.vc.grids.QV_4263_54550.events = {
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
                    $scope.vc.trackers.CreditSummary.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_4263_54550.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_4263_54550");
                    $scope.vc.hideShowColumns("QV_4263_54550", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_4263_54550.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_4263_54550.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_4263_54550.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_4263_54550 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_4263_54550 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_4263_54550.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_4263_54550.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_4263_54550.column.concept = {
                title: 'LOANS.LBL_LOANS_CONCEPTOO_16117',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXABB_468585',
                element: []
            };
            $scope.vc.grids.QV_4263_54550.AT58_CONCEPTT284 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4263_54550.column.concept.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXABB_468585",
                        'maxlength': 40,
                        'data-validation-code': "{{vc.viewState.QV_4263_54550.column.concept.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4263_54550.column.concept.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4263_54550.column.beginningBalance = {
                title: 'LOANS.LBL_LOANS_SALDOINIA_75122',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJBX_629585',
                element: []
            };
            $scope.vc.grids.QV_4263_54550.AT94_BEGINNLG284 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4263_54550.column.beginningBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJBX_629585",
                        'data-validation-code': "{{vc.viewState.QV_4263_54550.column.beginningBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4263_54550.column.beginningBalance.format",
                        'k-decimals': "vc.viewState.QV_4263_54550.column.beginningBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4263_54550.column.beginningBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4263_54550.column.payment = {
                title: 'LOANS.LBL_LOANS_ABONOSBQW_44598',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCPJ_744585',
                element: []
            };
            $scope.vc.grids.QV_4263_54550.AT22_PAYMENTT284 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4263_54550.column.payment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCPJ_744585",
                        'data-validation-code': "{{vc.viewState.QV_4263_54550.column.payment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4263_54550.column.payment.format",
                        'k-decimals': "vc.viewState.QV_4263_54550.column.payment.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4263_54550.column.payment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4263_54550.column.currencyBalance = {
                title: 'LOANS.LBL_LOANS_SALDOACTU_64744',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKYA_879585',
                element: []
            };
            $scope.vc.grids.QV_4263_54550.AT21_CURRENAA284 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4263_54550.column.currencyBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKYA_879585",
                        'data-validation-code': "{{vc.viewState.QV_4263_54550.column.currencyBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4263_54550.column.currencyBalance.format",
                        'k-decimals': "vc.viewState.QV_4263_54550.column.currencyBalance.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4263_54550.column.currencyBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_4263_54550.column.expired = {
                title: 'LOANS.LBL_LOANS_VENCIDOYB_26859',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVPE_565585',
                element: []
            };
            $scope.vc.grids.QV_4263_54550.AT62_EXPIREDD284 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_4263_54550.column.expired.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVPE_565585",
                        'data-validation-code': "{{vc.viewState.QV_4263_54550.column.expired.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_4263_54550.column.expired.format",
                        'k-decimals': "vc.viewState.QV_4263_54550.column.expired.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_4263_54550.column.expired.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4263_54550.columns.push({
                    field: 'concept',
                    title: '{{vc.viewState.QV_4263_54550.column.concept.title|translate:vc.viewState.QV_4263_54550.column.concept.titleArgs}}',
                    width: $scope.vc.viewState.QV_4263_54550.column.concept.width,
                    format: $scope.vc.viewState.QV_4263_54550.column.concept.format,
                    editor: $scope.vc.grids.QV_4263_54550.AT58_CONCEPTT284.control,
                    template: "<span ng-class='vc.viewState.QV_4263_54550.column.concept.style' ng-bind='vc.getStringColumnFormat(dataItem.concept, \"QV_4263_54550\", \"concept\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4263_54550.column.concept.style",
                        "title": "{{vc.viewState.QV_4263_54550.column.concept.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4263_54550.column.concept.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4263_54550.columns.push({
                    field: 'beginningBalance',
                    title: '{{vc.viewState.QV_4263_54550.column.beginningBalance.title|translate:vc.viewState.QV_4263_54550.column.beginningBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_4263_54550.column.beginningBalance.width,
                    format: $scope.vc.viewState.QV_4263_54550.column.beginningBalance.format,
                    editor: $scope.vc.grids.QV_4263_54550.AT94_BEGINNLG284.control,
                    template: "<span ng-class='vc.viewState.QV_4263_54550.column.beginningBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.beginningBalance, \"QV_4263_54550\", \"beginningBalance\"):kendo.toString(#=beginningBalance#, vc.viewState.QV_4263_54550.column.beginningBalance.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.beginningBalance.sum, $scope.vc.viewState.QV_4263_54550.column.beginningBalance.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4263_54550.column.beginningBalance.style",
                        "title": "{{vc.viewState.QV_4263_54550.column.beginningBalance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4263_54550.column.beginningBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4263_54550.columns.push({
                    field: 'payment',
                    title: '{{vc.viewState.QV_4263_54550.column.payment.title|translate:vc.viewState.QV_4263_54550.column.payment.titleArgs}}',
                    width: $scope.vc.viewState.QV_4263_54550.column.payment.width,
                    format: $scope.vc.viewState.QV_4263_54550.column.payment.format,
                    editor: $scope.vc.grids.QV_4263_54550.AT22_PAYMENTT284.control,
                    template: "<span ng-class='vc.viewState.QV_4263_54550.column.payment.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.payment, \"QV_4263_54550\", \"payment\"):kendo.toString(#=payment#, vc.viewState.QV_4263_54550.column.payment.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.payment.sum, $scope.vc.viewState.QV_4263_54550.column.payment.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4263_54550.column.payment.style",
                        "title": "{{vc.viewState.QV_4263_54550.column.payment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4263_54550.column.payment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4263_54550.columns.push({
                    field: 'currencyBalance',
                    title: '{{vc.viewState.QV_4263_54550.column.currencyBalance.title|translate:vc.viewState.QV_4263_54550.column.currencyBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_4263_54550.column.currencyBalance.width,
                    format: $scope.vc.viewState.QV_4263_54550.column.currencyBalance.format,
                    editor: $scope.vc.grids.QV_4263_54550.AT21_CURRENAA284.control,
                    template: "<span ng-class='vc.viewState.QV_4263_54550.column.currencyBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.currencyBalance, \"QV_4263_54550\", \"currencyBalance\"):kendo.toString(#=currencyBalance#, vc.viewState.QV_4263_54550.column.currencyBalance.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.currencyBalance.sum, $scope.vc.viewState.QV_4263_54550.column.currencyBalance.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4263_54550.column.currencyBalance.style",
                        "title": "{{vc.viewState.QV_4263_54550.column.currencyBalance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4263_54550.column.currencyBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4263_54550.columns.push({
                    field: 'expired',
                    title: '{{vc.viewState.QV_4263_54550.column.expired.title|translate:vc.viewState.QV_4263_54550.column.expired.titleArgs}}',
                    width: $scope.vc.viewState.QV_4263_54550.column.expired.width,
                    format: $scope.vc.viewState.QV_4263_54550.column.expired.format,
                    editor: $scope.vc.grids.QV_4263_54550.AT62_EXPIREDD284.control,
                    template: "<span ng-class='vc.viewState.QV_4263_54550.column.expired.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.expired, \"QV_4263_54550\", \"expired\"):kendo.toString(#=expired#, vc.viewState.QV_4263_54550.column.expired.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.expired.sum, $scope.vc.viewState.QV_4263_54550.column.expired.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4263_54550.column.expired.style",
                        "title": "{{vc.viewState.QV_4263_54550.column.expired.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4263_54550.column.expired.hidden
                });
            }
            $scope.vc.viewState.QV_4263_54550.toolbar = {}
            $scope.vc.grids.QV_4263_54550.toolbar = [];
            //ViewState - Group: Group2247
            $scope.vc.createViewState({
                id: "G_REPORTGEOC_993585",
                hasId: true,
                componentStyle: [],
                label: "LOANS.LBL_LOANS_PLANDEPGG_49608",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PaymentPlan = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    numPayment: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "numPayment", 0)
                    },
                    datePayment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "datePayment", '')
                    },
                    capital: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "capital", 0)
                    },
                    interest: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "interest", 0)
                    },
                    others: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "others", 0)
                    },
                    balance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "balance", 0)
                    },
                    voluntarySavings: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "voluntarySavings", 0)
                    },
                    extraSavings: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PaymentPlan", "extraSavings", 0)
                    }
                }
            });
            $scope.vc.model.PaymentPlan = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_PAYMENLA_6897();
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
                    model: $scope.vc.types.PaymentPlan
                },
                aggregate: [{
                    field: "capital",
                    aggregate: "sum"
                }, {
                    field: "interest",
                    aggregate: "sum"
                }, {
                    field: "others",
                    aggregate: "sum"
                }, {
                    field: "balance",
                    aggregate: "sum"
                }, {
                    field: "voluntarySavings",
                    aggregate: "sum"
                }, {
                    field: "extraSavings",
                    aggregate: "sum"
                }],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_6897_70628").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PAYMENLA_6897 = $scope.vc.model.PaymentPlan;
            $scope.vc.trackers.PaymentPlan = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PaymentPlan);
            $scope.vc.model.PaymentPlan.bind('change', function(e) {
                $scope.vc.trackers.PaymentPlan.track(e);
            });
            $scope.vc.grids.QV_6897_70628 = {};
            $scope.vc.grids.QV_6897_70628.queryId = 'Q_PAYMENLA_6897';
            $scope.vc.viewState.QV_6897_70628 = {
                style: undefined
            };
            $scope.vc.viewState.QV_6897_70628.column = {};
            $scope.vc.grids.QV_6897_70628.editable = false;
            $scope.vc.grids.QV_6897_70628.events = {
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
                    $scope.vc.trackers.PaymentPlan.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_6897_70628.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_6897_70628");
                    $scope.vc.hideShowColumns("QV_6897_70628", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_6897_70628.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_6897_70628.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_6897_70628.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_6897_70628 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_6897_70628 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_6897_70628.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_6897_70628.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_6897_70628.column.numPayment = {
                title: 'LOANS.LBL_LOANS_PAGOOMOVN_95221',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDVZ_391585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT34_NUMPAYEE576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.numPayment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDVZ_391585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.numPayment.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.numPayment.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.numPayment.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.numPayment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.datePayment = {
                title: 'LOANS.LBL_LOANS_FECHADMDM_34540',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVWL_880585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT47_DATEPAYY576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.datePayment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXVWL_880585",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.datePayment.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.datePayment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.capital = {
                title: 'LOANS.LBL_LOANS_CAPITALPH_43211',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRBY_498585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT42_CAPITALL576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.capital.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRBY_498585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.capital.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.capital.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.capital.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.capital.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.interest = {
                title: 'LOANS.LBL_LOANS_INTERESEE_92151',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKTX_426585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT22_INTERETT576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.interest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKTX_426585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.interest.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.interest.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.interest.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.interest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.others = {
                title: 'LOANS.LBL_LOANS_OTROSWLGN_37870',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCTN_204585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT77_OTHERSPZ576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.others.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCTN_204585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.others.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.others.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.others.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.others.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.balance = {
                title: 'LOANS.LBL_LOANS_SALDOXRJO_86491',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMZX_432585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT62_BALANCEE576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.balance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMZX_432585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.balance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.balance.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.balance.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.balance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.voluntarySavings = {
                title: 'LOANS.LBL_LOANS_VOLUNTAOI_10790',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWYQ_165585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT43_VOLUNTVN576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.voluntarySavings.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWYQ_165585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.voluntarySavings.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.voluntarySavings.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.voluntarySavings.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.voluntarySavings.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_6897_70628.column.extraSavings = {
                title: 'LOANS.LBL_LOANS_EXTRASMQO_41120',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIYN_827585',
                element: []
            };
            $scope.vc.grids.QV_6897_70628.AT78_EXTRASSA576 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_6897_70628.column.extraSavings.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXIYN_827585",
                        'data-validation-code': "{{vc.viewState.QV_6897_70628.column.extraSavings.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_6897_70628.column.extraSavings.format",
                        'k-decimals': "vc.viewState.QV_6897_70628.column.extraSavings.decimals",
                        'data-cobis-group': "GroupLayout,G_REPORTGNUE_515585,2",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_6897_70628.column.extraSavings.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'numPayment',
                    title: '{{vc.viewState.QV_6897_70628.column.numPayment.title|translate:vc.viewState.QV_6897_70628.column.numPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.numPayment.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.numPayment.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT34_NUMPAYEE576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.numPayment.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numPayment, \"QV_6897_70628\", \"numPayment\"):kendo.toString(#=numPayment#, vc.viewState.QV_6897_70628.column.numPayment.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.numPayment.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.numPayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.numPayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'datePayment',
                    title: '{{vc.viewState.QV_6897_70628.column.datePayment.title|translate:vc.viewState.QV_6897_70628.column.datePayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.datePayment.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.datePayment.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT47_DATEPAYY576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.datePayment.style' ng-bind='vc.getStringColumnFormat(dataItem.datePayment, \"QV_6897_70628\", \"datePayment\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_6897_70628.column.datePayment.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.datePayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.datePayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'capital',
                    title: '{{vc.viewState.QV_6897_70628.column.capital.title|translate:vc.viewState.QV_6897_70628.column.capital.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.capital.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.capital.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT42_CAPITALL576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.capital.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.capital, \"QV_6897_70628\", \"capital\"):kendo.toString(#=capital#, vc.viewState.QV_6897_70628.column.capital.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.capital.sum, $scope.vc.viewState.QV_6897_70628.column.capital.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.capital.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.capital.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.capital.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'interest',
                    title: '{{vc.viewState.QV_6897_70628.column.interest.title|translate:vc.viewState.QV_6897_70628.column.interest.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.interest.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.interest.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT22_INTERETT576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.interest.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interest, \"QV_6897_70628\", \"interest\"):kendo.toString(#=interest#, vc.viewState.QV_6897_70628.column.interest.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.interest.sum, $scope.vc.viewState.QV_6897_70628.column.interest.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.interest.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.interest.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.interest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'others',
                    title: '{{vc.viewState.QV_6897_70628.column.others.title|translate:vc.viewState.QV_6897_70628.column.others.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.others.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.others.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT77_OTHERSPZ576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.others.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.others, \"QV_6897_70628\", \"others\"):kendo.toString(#=others#, vc.viewState.QV_6897_70628.column.others.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.others.sum, $scope.vc.viewState.QV_6897_70628.column.others.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.others.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.others.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.others.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'balance',
                    title: '{{vc.viewState.QV_6897_70628.column.balance.title|translate:vc.viewState.QV_6897_70628.column.balance.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.balance.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.balance.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT62_BALANCEE576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.balance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.balance, \"QV_6897_70628\", \"balance\"):kendo.toString(#=balance#, vc.viewState.QV_6897_70628.column.balance.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.balance.sum, $scope.vc.viewState.QV_6897_70628.column.balance.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.balance.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.balance.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.balance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'voluntarySavings',
                    title: '{{vc.viewState.QV_6897_70628.column.voluntarySavings.title|translate:vc.viewState.QV_6897_70628.column.voluntarySavings.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.voluntarySavings.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.voluntarySavings.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT43_VOLUNTVN576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.voluntarySavings.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.voluntarySavings, \"QV_6897_70628\", \"voluntarySavings\"):kendo.toString(#=voluntarySavings#, vc.viewState.QV_6897_70628.column.voluntarySavings.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.voluntarySavings.sum, $scope.vc.viewState.QV_6897_70628.column.voluntarySavings.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.voluntarySavings.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.voluntarySavings.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.voluntarySavings.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_6897_70628.columns.push({
                    field: 'extraSavings',
                    title: '{{vc.viewState.QV_6897_70628.column.extraSavings.title|translate:vc.viewState.QV_6897_70628.column.extraSavings.titleArgs}}',
                    width: $scope.vc.viewState.QV_6897_70628.column.extraSavings.width,
                    format: $scope.vc.viewState.QV_6897_70628.column.extraSavings.format,
                    editor: $scope.vc.grids.QV_6897_70628.AT78_EXTRASSA576.control,
                    template: "<span ng-class='vc.viewState.QV_6897_70628.column.extraSavings.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.extraSavings, \"QV_6897_70628\", \"extraSavings\"):kendo.toString(#=extraSavings#, vc.viewState.QV_6897_70628.column.extraSavings.format)'></span>",
                    footerTemplate: function(dataItem) {
                        var tooltip = $filter('translate')('DSGNR.SYS_DSGNR_AGSUM_00041'),
                            value = kendo.toString(dataItem.extraSavings.sum, $scope.vc.viewState.QV_6897_70628.column.extraSavings.format);
                        return "<div class='text-right' title='" + tooltip + "'>" + value + "</div>";
                    },
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_6897_70628.column.extraSavings.style",
                        "title": "{{vc.viewState.QV_6897_70628.column.extraSavings.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_6897_70628.column.extraSavings.hidden
                });
            }
            $scope.vc.viewState.QV_6897_70628.toolbar = {}
            $scope.vc.grids.QV_6897_70628.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_REPORTGROUMTA_266_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_REPORTGROUMTA_266_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CreditHeader = {
                creditCode: $scope.vc.channelDefaultValues("CreditHeader", "creditCode")
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
                $scope.vc.render('VC_REPORTGRTT_453266');
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
    var cobisMainModule = cobis.createModule("VC_REPORTGRTT_453266", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_REPORTGRTT_453266", {
            templateUrl: "VC_REPORTGRTT_453266_FORM.html",
            controller: "VC_REPORTGRTT_453266_CTRL",
            label: "ReportGroupAccountStatement",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_REPORTGRTT_453266?" + $.param(search);
            }
        });
        VC_REPORTGRTT_453266(cobisMainModule);
    }]);
} else {
    VC_REPORTGRTT_453266(cobisMainModule);
}