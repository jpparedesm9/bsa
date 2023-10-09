//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.simulationcreditrenovations = designerEvents.api.simulationcreditrenovations || designer.dsgEvents();

function VC_SIMULATIEE_163810(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_SIMULATIEE_163810_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_SIMULATIEE_163810_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LOANSYBASRMCC_810",
            taskVersion: "1.0.0",
            viewContainerId: "VC_SIMULATIEE_163810",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_LOANSYBASRMCC_810",
        designerEvents.api.simulationcreditrenovations,
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
                vcName: 'VC_SIMULATIEE_163810'
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
                    taskId: 'T_LOANSYBASRMCC_810',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    FilterSimulation: "FilterSimulation",
                    InformationSimulation: "InformationSimulation"
                },
                entities: {
                    FilterSimulation: {
                        nameClient: 'AT38_NAMECLNI640',
                        amountRequest: 'AT69_AMOUNTQU640',
                        term: 'AT71_TERMDMPX640',
                        _pks: [],
                        _entityId: 'EN_FILTERSIA_640',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    InformationSimulation: {
                        term: 'AT16_TERMPJJD415',
                        nameClient: 'AT17_NAMECLTN415',
                        numQuota: 'AT17_NUMQUOAT415',
                        paymentDate: 'AT26_PAYMENDD415',
                        interest: 'AT35_INTERETT415',
                        totalQuota: 'AT40_TOTALQUO415',
                        capitalBalance: 'AT59_CAPITACA415',
                        amountRequest: 'AT80_AMOUNTSU415',
                        _pks: [],
                        _entityId: 'EN_INATIONAL_415',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_FILTERSIA_640',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_INATIONAL_415',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '1',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT71_TERMDMPX640',
                        attributeIdFk: 'AT16_TERMPJJD415'
                    }, {
                        attributeIdPk: 'AT69_AMOUNTQU640',
                        attributeIdFk: 'AT80_AMOUNTSU415'
                    }, {
                        attributeIdPk: 'AT38_NAMECLNI640',
                        attributeIdFk: 'AT17_NAMECLTN415'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_INATIOOM_2798 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_INATIOOM_2798 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_INATIOOM_2798_filters)) {
                    parametersAux = {
                        nameClient: $scope.vc.model.FilterSimulation.nameClient,
                        amountRequest: $scope.vc.model.FilterSimulation.amountRequest,
                        term: $scope.vc.model.FilterSimulation.term
                    };
                } else {
                    var filters = $scope.vc.queries.Q_INATIOOM_2798_filters;
                    parametersAux = {
                        nameClient: filters.nameClient,
                        amountRequest: filters.amountRequest,
                        term: filters.term
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_INATIONAL_415',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_INATIOOM_2798',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['nameClient'] = $scope.vc.model.FilterSimulation.nameClient;
                            this.parameters['amountRequest'] = $scope.vc.model.FilterSimulation.amountRequest;
                            this.parameters['term'] = $scope.vc.model.FilterSimulation.term;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['nameClient'] = this.filters.nameClient;
                            this.parameters['amountRequest'] = this.filters.amountRequest;
                            this.parameters['term'] = this.filters.term;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_INATIOOM_2798_filters = {};
            var defaultValues = {
                FilterSimulation: {},
                InformationSimulation: {}
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
                $scope.vc.execute("temporarySave", VC_SIMULATIEE_163810, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_SIMULATIEE_163810, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_SIMULATIEE_163810, data, function() {});
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
            $scope.vc.viewState.VC_SIMULATIEE_163810 = {
                style: []
            }
            $scope.vc.model.FilterSimulation = {
                nameClient: $scope.vc.channelDefaultValues("FilterSimulation", "nameClient"),
                amountRequest: $scope.vc.channelDefaultValues("FilterSimulation", "amountRequest"),
                term: $scope.vc.channelDefaultValues("FilterSimulation", "term")
            };
            //ViewState - Group: Group1802
            $scope.vc.createViewState({
                id: "G_SIMULATERR_144753",
                hasId: true,
                componentStyle: [],
                label: 'Group1802',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FilterSimulation, Attribute: nameClient
            $scope.vc.createViewState({
                id: "VA_NAMECLIENTMUUTS_510753",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NOMBREDTL_54923",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2983",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FilterSimulation, Attribute: amountRequest
            $scope.vc.createViewState({
                id: "VA_AMOUNTREQUESTTT_231753",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_MONTOSOOI_45840",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: FilterSimulation, Attribute: term
            $scope.vc.createViewState({
                id: "VA_TERMFQAXXSBCLOQ_177753",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_PLAZOFQPV_77159",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TERMFQAXXSBCLOQ_177753 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TERMFQAXXSBCLOQ_177753', 'cr_plazo_grp', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TERMFQAXXSBCLOQ_177753'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TERMFQAXXSBCLOQ_177753");
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
                id: "VA_VABUTTONKGIOGCD_493753",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_GENERARRK_53097",
                queryId: 'Q_INATIOOM_2798',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2892
            $scope.vc.createViewState({
                id: "G_SIMULATTSO_346753",
                hasId: true,
                componentStyle: [],
                label: 'Group2892',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORASJX_676753",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2284
            $scope.vc.createViewState({
                id: "G_SIMULATOIN_358753",
                hasId: true,
                componentStyle: [],
                label: 'Group2284',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.InformationSimulation = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    paymentDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InformationSimulation", "paymentDate", new Date())
                    },
                    numQuota: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InformationSimulation", "numQuota", 0)
                    },
                    capitalBalance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InformationSimulation", "capitalBalance", 0)
                    },
                    interest: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InformationSimulation", "interest", 0)
                    },
                    totalQuota: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("InformationSimulation", "totalQuota", 0)
                    },
                    nameClient: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.FilterSimulation.nameClient
                        }
                    },
                    amountRequest: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.FilterSimulation.amountRequest
                        }
                    },
                    term: {
                        type: "number",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.FilterSimulation.term
                        }
                    }
                }
            });
            $scope.vc.model.InformationSimulation = new kendo.data.DataSource({
                pageSize: 20,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_INATIOOM_2798';
                            var queryRequest = $scope.vc.getRequestQuery_Q_INATIOOM_2798();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_2798_99321',
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
                                            'pageSize': 20
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
                    model: $scope.vc.types.InformationSimulation
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2798_99321").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_INATIOOM_2798 = $scope.vc.model.InformationSimulation;
            $scope.vc.trackers.InformationSimulation = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.InformationSimulation);
            $scope.vc.model.InformationSimulation.bind('change', function(e) {
                $scope.vc.trackers.InformationSimulation.track(e);
            });
            $scope.vc.grids.QV_2798_99321 = {};
            $scope.vc.grids.QV_2798_99321.queryId = 'Q_INATIOOM_2798';
            $scope.vc.viewState.QV_2798_99321 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2798_99321.column = {};
            $scope.vc.grids.QV_2798_99321.editable = false;
            $scope.vc.grids.QV_2798_99321.events = {
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
                    $scope.vc.trackers.InformationSimulation.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_2798_99321.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_2798_99321");
                    $scope.vc.hideShowColumns("QV_2798_99321", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2798_99321.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2798_99321.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_2798_99321.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2798_99321 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2798_99321 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2798_99321.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2798_99321.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2798_99321.column.paymentDate = {
                title: 'LOANS.LBL_LOANS_FECHAPAOO_61568',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDDZQUFK_823753',
                element: []
            };
            $scope.vc.grids.QV_2798_99321.AT26_PAYMENDD415 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2798_99321.column.paymentDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDDZQUFK_823753",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_2798_99321.column.paymentDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_2798_99321.column.paymentDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2798_99321.column.numQuota = {
                title: 'LOANS.LBL_LOANS_NROCUOTAA_18677',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFLD_944753',
                element: []
            };
            $scope.vc.grids.QV_2798_99321.AT17_NUMQUOAT415 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2798_99321.column.numQuota.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFLD_944753",
                        'data-validation-code': "{{vc.viewState.QV_2798_99321.column.numQuota.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2798_99321.column.numQuota.format",
                        'k-decimals': "vc.viewState.QV_2798_99321.column.numQuota.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2798_99321.column.numQuota.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2798_99321.column.capitalBalance = {
                title: 'LOANS.LBL_LOANS_SALDOCAAT_24029',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXREJ_437753',
                element: []
            };
            $scope.vc.grids.QV_2798_99321.AT59_CAPITACA415 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2798_99321.column.capitalBalance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXREJ_437753",
                        'data-validation-code': "{{vc.viewState.QV_2798_99321.column.capitalBalance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2798_99321.column.capitalBalance.format",
                        'k-decimals': "vc.viewState.QV_2798_99321.column.capitalBalance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2798_99321.column.capitalBalance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2798_99321.column.interest = {
                title: 'LOANS.LBL_LOANS_INTERESED_16318',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOMQ_891753',
                element: []
            };
            $scope.vc.grids.QV_2798_99321.AT35_INTERETT415 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2798_99321.column.interest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOMQ_891753",
                        'data-validation-code': "{{vc.viewState.QV_2798_99321.column.interest.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2798_99321.column.interest.format",
                        'k-decimals': "vc.viewState.QV_2798_99321.column.interest.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2798_99321.column.interest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2798_99321.column.totalQuota = {
                title: 'LOANS.LBL_LOANS_TOTALCUAT_23247',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYB_697753',
                element: []
            };
            $scope.vc.grids.QV_2798_99321.AT40_TOTALQUO415 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_2798_99321.column.totalQuota.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQYB_697753",
                        'data-validation-code': "{{vc.viewState.QV_2798_99321.column.totalQuota.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_2798_99321.column.totalQuota.format",
                        'k-decimals': "vc.viewState.QV_2798_99321.column.totalQuota.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_2798_99321.column.totalQuota.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_2798_99321.column.nameClient = {
                title: 'nameClient',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                decimals: 0,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_2798_99321.column.amountRequest = {
                title: 'amountRequest',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                readOnly: false,
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                element: []
            };
            $scope.vc.viewState.QV_2798_99321.column.term = {
                title: 'term',
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
                $scope.vc.grids.QV_2798_99321.columns.push({
                    field: 'paymentDate',
                    title: '{{vc.viewState.QV_2798_99321.column.paymentDate.title|translate:vc.viewState.QV_2798_99321.column.paymentDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_2798_99321.column.paymentDate.width,
                    format: $scope.vc.viewState.QV_2798_99321.column.paymentDate.format,
                    editor: $scope.vc.grids.QV_2798_99321.AT26_PAYMENDD415.control,
                    template: "<span ng-class='vc.viewState.QV_2798_99321.column.paymentDate.style'>#=((paymentDate !== null) ? kendo.toString(paymentDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2798_99321.column.paymentDate.style",
                        "title": "{{vc.viewState.QV_2798_99321.column.paymentDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2798_99321.column.paymentDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2798_99321.columns.push({
                    field: 'numQuota',
                    title: '{{vc.viewState.QV_2798_99321.column.numQuota.title|translate:vc.viewState.QV_2798_99321.column.numQuota.titleArgs}}',
                    width: $scope.vc.viewState.QV_2798_99321.column.numQuota.width,
                    format: $scope.vc.viewState.QV_2798_99321.column.numQuota.format,
                    editor: $scope.vc.grids.QV_2798_99321.AT17_NUMQUOAT415.control,
                    template: "<span ng-class='vc.viewState.QV_2798_99321.column.numQuota.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numQuota, \"QV_2798_99321\", \"numQuota\"):kendo.toString(#=numQuota#, vc.viewState.QV_2798_99321.column.numQuota.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2798_99321.column.numQuota.style",
                        "title": "{{vc.viewState.QV_2798_99321.column.numQuota.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2798_99321.column.numQuota.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2798_99321.columns.push({
                    field: 'capitalBalance',
                    title: '{{vc.viewState.QV_2798_99321.column.capitalBalance.title|translate:vc.viewState.QV_2798_99321.column.capitalBalance.titleArgs}}',
                    width: $scope.vc.viewState.QV_2798_99321.column.capitalBalance.width,
                    format: $scope.vc.viewState.QV_2798_99321.column.capitalBalance.format,
                    editor: $scope.vc.grids.QV_2798_99321.AT59_CAPITACA415.control,
                    template: "<span ng-class='vc.viewState.QV_2798_99321.column.capitalBalance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.capitalBalance, \"QV_2798_99321\", \"capitalBalance\"):kendo.toString(#=capitalBalance#, vc.viewState.QV_2798_99321.column.capitalBalance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2798_99321.column.capitalBalance.style",
                        "title": "{{vc.viewState.QV_2798_99321.column.capitalBalance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2798_99321.column.capitalBalance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2798_99321.columns.push({
                    field: 'interest',
                    title: '{{vc.viewState.QV_2798_99321.column.interest.title|translate:vc.viewState.QV_2798_99321.column.interest.titleArgs}}',
                    width: $scope.vc.viewState.QV_2798_99321.column.interest.width,
                    format: $scope.vc.viewState.QV_2798_99321.column.interest.format,
                    editor: $scope.vc.grids.QV_2798_99321.AT35_INTERETT415.control,
                    template: "<span ng-class='vc.viewState.QV_2798_99321.column.interest.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.interest, \"QV_2798_99321\", \"interest\"):kendo.toString(#=interest#, vc.viewState.QV_2798_99321.column.interest.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2798_99321.column.interest.style",
                        "title": "{{vc.viewState.QV_2798_99321.column.interest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2798_99321.column.interest.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2798_99321.columns.push({
                    field: 'totalQuota',
                    title: '{{vc.viewState.QV_2798_99321.column.totalQuota.title|translate:vc.viewState.QV_2798_99321.column.totalQuota.titleArgs}}',
                    width: $scope.vc.viewState.QV_2798_99321.column.totalQuota.width,
                    format: $scope.vc.viewState.QV_2798_99321.column.totalQuota.format,
                    editor: $scope.vc.grids.QV_2798_99321.AT40_TOTALQUO415.control,
                    template: "<span ng-class='vc.viewState.QV_2798_99321.column.totalQuota.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.totalQuota, \"QV_2798_99321\", \"totalQuota\"):kendo.toString(#=totalQuota#, vc.viewState.QV_2798_99321.column.totalQuota.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2798_99321.column.totalQuota.style",
                        "title": "{{vc.viewState.QV_2798_99321.column.totalQuota.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2798_99321.column.totalQuota.hidden
                });
            }
            $scope.vc.viewState.QV_2798_99321.toolbar = {}
            $scope.vc.grids.QV_2798_99321.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LOANSYBASRMCC_810_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LOANSYBASRMCC_810_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TLOANSYB_04A",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_IMPRIMIRR_29938",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TLOANSYB_148",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_LIMPIARIQ_52693",
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
                $scope.vc.render('VC_SIMULATIEE_163810');
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
    var cobisMainModule = cobis.createModule("VC_SIMULATIEE_163810", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_SIMULATIEE_163810", {
            templateUrl: "VC_SIMULATIEE_163810_FORM.html",
            controller: "VC_SIMULATIEE_163810_CTRL",
            labelId: "LOANS.LBL_LOANS_SIMULACIV_16855",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_SIMULATIEE_163810?" + $.param(search);
            }
        });
        VC_SIMULATIEE_163810(cobisMainModule);
    }]);
} else {
    VC_SIMULATIEE_163810(cobisMainModule);
}