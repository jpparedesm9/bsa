//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.debitorderprocessinglog = designerEvents.api.debitorderprocessinglog || designer.dsgEvents();

function VC_DEBITORDOC_486608(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_DEBITORDOC_486608_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_DEBITORDOC_486608_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "QERYS",
            taskId: "T_ASSTSKUSBXHZA_608",
            taskVersion: "1.0.0",
            viewContainerId: "VC_DEBITORDOC_486608",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/QERYS/T_ASSTSKUSBXHZA_608",
        designerEvents.api.debitorderprocessinglog,
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
                vcName: 'VC_DEBITORDOC_486608'
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
                    subModuleId: 'QERYS',
                    taskId: 'T_ASSTSKUSBXHZA_608',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    DebitOrderProcessingLogFilter: "DebitOrderProcessingLogFilter",
                    DebitOrderProcessingLog: "DebitOrderProcessingLog"
                },
                entities: {
                    DebitOrderProcessingLogFilter: {
                        fromDate: 'AT15_FROMDATE194',
                        processDate: 'AT17_PROCESEE194',
                        clientId: 'AT31_CLIENTID194',
                        accountNumberSantander: 'AT32_ACCOUNUN194',
                        filename: 'AT54_FILENAMM194',
                        untilDate: 'AT57_UNTILDTA194',
                        loanNumber: 'AT62_NUMBERAO194',
                        reference: 'AT76_REFERENE194',
                        typeError: 'AT99_ERRORTYP194',
                        _pks: [],
                        _entityId: 'EN_DEBITORDG_194',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DebitOrderProcessingLog: {
                        nameClient: 'AT18_NAMECLNT499',
                        loanNumber: 'AT22_LOANNUBR499',
                        untilDate: 'AT37_UNTILDTT499',
                        paymentAmount: 'AT40_AMOUNTAY499',
                        orderGenerationDate: 'AT42_ORDERGRN499',
                        errorDescription: 'AT47_DESCRIOC499',
                        clientId: 'AT58_CLIENTII499',
                        fromDate: 'AT69_FROMDAET499',
                        reference: 'AT71_REFEREEE499',
                        accountNumberSantander: 'AT77_ACCOUNBB499',
                        errorType: 'AT87_TYPEEROR499',
                        filename: 'AT96_FILENAMM499',
                        state: 'AT97_STATECSS499',
                        _pks: [],
                        _entityId: 'EN_DEBITORGE_499',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_DEBITORDG_194',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_DEBITORGE_499',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT76_REFERENE194',
                        attributeIdFk: 'AT71_REFEREEE499'
                    }, {
                        attributeIdPk: 'AT54_FILENAMM194',
                        attributeIdFk: 'AT96_FILENAMM499'
                    }, {
                        attributeIdPk: 'AT31_CLIENTID194',
                        attributeIdFk: 'AT58_CLIENTII499'
                    }, {
                        attributeIdPk: 'AT32_ACCOUNUN194',
                        attributeIdFk: 'AT77_ACCOUNBB499'
                    }, {
                        attributeIdPk: 'AT99_ERRORTYP194',
                        attributeIdFk: 'AT87_TYPEEROR499'
                    }, {
                        attributeIdPk: 'AT62_NUMBERAO194',
                        attributeIdFk: 'AT22_LOANNUBR499'
                    }, {
                        attributeIdPk: 'AT57_UNTILDTA194',
                        attributeIdFk: 'AT37_UNTILDTT499'
                    }, {
                        attributeIdPk: 'AT15_FROMDATE194',
                        attributeIdFk: 'AT69_FROMDAET499'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_DEBITOOI_1156 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_DEBITOOI_1156 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_DEBITOOI_1156_filters)) {
                    parametersAux = {
                        loanNumber: $scope.vc.model.DebitOrderProcessingLogFilter.loanNumber,
                        accountNumber: $scope.vc.model.DebitOrderProcessingLogFilter.accountNumberSantander,
                        fromDate: $scope.vc.model.DebitOrderProcessingLogFilter.fromDate,
                        untilDate: $scope.vc.model.DebitOrderProcessingLogFilter.untilDate,
                        typeError: $scope.vc.model.DebitOrderProcessingLogFilter.typeError,
                        clientId: $scope.vc.model.DebitOrderProcessingLogFilter.clientId
                    };
                } else {
                    var filters = $scope.vc.queries.Q_DEBITOOI_1156_filters;
                    parametersAux = {
                        loanNumber: filters.loanNumber,
                        accountNumber: filters.accountNumber,
                        fromDate: filters.fromDate,
                        untilDate: filters.untilDate,
                        typeError: filters.typeError,
                        clientId: filters.clientId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_DEBITORGE_499',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_DEBITOOI_1156',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['loanNumber'] = $scope.vc.model.DebitOrderProcessingLogFilter.loanNumber;
                            this.parameters['accountNumber'] = $scope.vc.model.DebitOrderProcessingLogFilter.accountNumberSantander;
                            this.parameters['fromDate'] = $scope.vc.model.DebitOrderProcessingLogFilter.fromDate;
                            this.parameters['untilDate'] = $scope.vc.model.DebitOrderProcessingLogFilter.untilDate;
                            this.parameters['typeError'] = $scope.vc.model.DebitOrderProcessingLogFilter.typeError;
                            this.parameters['clientId'] = $scope.vc.model.DebitOrderProcessingLogFilter.clientId;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['loanNumber'] = this.filters.loanNumber;
                            this.parameters['accountNumber'] = this.filters.accountNumber;
                            this.parameters['fromDate'] = this.filters.fromDate;
                            this.parameters['untilDate'] = this.filters.untilDate;
                            this.parameters['typeError'] = this.filters.typeError;
                            this.parameters['clientId'] = this.filters.clientId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_DEBITOOI_1156_filters = {};
            var defaultValues = {
                DebitOrderProcessingLogFilter: {},
                DebitOrderProcessingLog: {}
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
                $scope.vc.execute("temporarySave", VC_DEBITORDOC_486608, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_DEBITORDOC_486608, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_DEBITORDOC_486608, data, function() {});
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
            $scope.vc.viewState.VC_DEBITORDOC_486608 = {
                style: []
            }
            //ViewState - Group: s1974
            $scope.vc.createViewState({
                id: "G_DEBITORSIS_408643",
                hasId: true,
                componentStyle: [],
                label: 's1974',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.DebitOrderProcessingLogFilter = {
                fromDate: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "fromDate"),
                processDate: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "processDate"),
                clientId: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "clientId"),
                accountNumberSantander: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "accountNumberSantander"),
                filename: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "filename"),
                untilDate: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "untilDate"),
                loanNumber: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "loanNumber"),
                reference: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "reference"),
                typeError: $scope.vc.channelDefaultValues("DebitOrderProcessingLogFilter", "typeError")
            };
            //ViewState - Group: u1602
            $scope.vc.createViewState({
                id: "G_DEBITORNOG_439643",
                hasId: true,
                componentStyle: [],
                label: 'u1602',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: typeError
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXYNP_541643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOERROR_36798",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXYNP_541643 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXYNP_541643', 'ca_tipo_error', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXYNP_541643'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXYNP_541643");
                            $scope.vc.setReadOnlyInputCombobox("VA_TEXTINPUTBOXYNP_541643");
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
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: fromDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDDOSHLK_541643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADESD_11676",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: untilDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDMYOWUX_624643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAHATS_18279",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: loanNumber
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRBR_513643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NMEROPRAT_45183",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: accountNumberSantander
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXMRW_242643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_NMEROCUAA_69356",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: filename
            $scope.vc.createViewState({
                id: "VA_FILENAMEPPTUVRV_958643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ARCHIVOGS_24517",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: reference
            $scope.vc.createViewState({
                id: "VA_REFERENCEWNSUIW_805643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REFERENAI_72258",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: DebitOrderProcessingLogFilter, Attribute: clientId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNGO_790643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CDIGOCLEN_93241",
                validationCode: 3,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONCIHBTPR_835643",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_DEBITOOI_1156',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: u2933
            $scope.vc.createViewState({
                id: "G_DEBITORGSE_151643",
                hasId: true,
                componentStyle: [],
                label: 'u2933',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.DebitOrderProcessingLog = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    loanNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.loanNumber
                        }
                    },
                    accountNumberSantander: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.accountNumberSantander
                        }
                    },
                    reference: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.reference
                        }
                    },
                    filename: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.filename
                        }
                    },
                    paymentAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebitOrderProcessingLog", "paymentAmount", 0)
                    },
                    state: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebitOrderProcessingLog", "state", '')
                    },
                    errorType: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.typeError
                        }
                    },
                    errorDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebitOrderProcessingLog", "errorDescription", '')
                    },
                    clientId: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.clientId
                        }
                    },
                    nameClient: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebitOrderProcessingLog", "nameClient", '')
                    },
                    orderGenerationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("DebitOrderProcessingLog", "orderGenerationDate", new Date())
                    },
                    fromDate: {
                        type: "date",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.fromDate
                        }
                    },
                    untilDate: {
                        type: "date",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.DebitOrderProcessingLogFilter.untilDate
                        }
                    }
                }
            });
            $scope.vc.model.DebitOrderProcessingLog = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_DEBITOOI_1156';
                            var queryRequest = $scope.vc.getRequestQuery_Q_DEBITOOI_1156();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_1156_57465',
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
                    model: $scope.vc.types.DebitOrderProcessingLog
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_1156_57465").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_DEBITOOI_1156 = $scope.vc.model.DebitOrderProcessingLog;
            $scope.vc.trackers.DebitOrderProcessingLog = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.DebitOrderProcessingLog);
            $scope.vc.model.DebitOrderProcessingLog.bind('change', function(e) {
                $scope.vc.trackers.DebitOrderProcessingLog.track(e);
            });
            $scope.vc.grids.QV_1156_57465 = {};
            $scope.vc.grids.QV_1156_57465.queryId = 'Q_DEBITOOI_1156';
            $scope.vc.viewState.QV_1156_57465 = {
                style: undefined
            };
            $scope.vc.viewState.QV_1156_57465.column = {};
            $scope.vc.grids.QV_1156_57465.editable = false;
            $scope.vc.grids.QV_1156_57465.events = {
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
                    $scope.vc.trackers.DebitOrderProcessingLog.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_1156_57465.selectedRow = e.model;
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
                excelExport: function(e) {
                    $scope.vc.exportGrid(e, 'QV_1156_57465', this.dataSource);
                },
                excel: {
                    fileName: 'QV_1156_57465.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_1156_57465.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_1156_57465");
                    $scope.vc.hideShowColumns("QV_1156_57465", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_1156_57465.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_1156_57465.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_1156_57465.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_1156_57465 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_1156_57465 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_1156_57465.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_1156_57465.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_1156_57465.column.loanNumber = {
                title: 'ASSTS.LBL_ASSTS_NUMPRSTOO_83774',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQVW_891643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT22_LOANNUBR499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.loanNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQVW_891643",
                        'maxlength': 24,
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.loanNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.loanNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.accountNumberSantander = {
                title: 'ASSTS.LBL_ASSTS_NMEROCUAA_69356',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXULU_210643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT77_ACCOUNBB499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.accountNumberSantander.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXULU_210643",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.accountNumberSantander.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.accountNumberSantander.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.reference = {
                title: 'ASSTS.LBL_ASSTS_REFERENAI_72258',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXARI_121643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT71_REFEREEE499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.reference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXARI_121643",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.reference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.reference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.filename = {
                title: 'ASSTS.LBL_ASSTS_ARCHIVOGS_24517',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXZG_431643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT96_FILENAMM499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.filename.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXZG_431643",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.filename.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.filename.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.paymentAmount = {
                title: 'ASSTS.LBL_ASSTS_MONTODEGG_79201',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTZZ_678643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT40_AMOUNTAY499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.paymentAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXTZZ_678643",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.paymentAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_1156_57465.column.paymentAmount.format",
                        'k-decimals': "vc.viewState.QV_1156_57465.column.paymentAmount.decimals",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.paymentAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.state = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPER_629643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT97_STATECSS499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.state.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPER_629643",
                        'maxlength': 10,
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.state.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.state.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.errorType = {
                title: 'ASSTS.LBL_ASSTS_TIPOERROR_36798',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMUK_368643',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXMUK_368643 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXMUK_368643',
                            'ca_tipo_error',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXMUK_368643'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error();
                            }
                        }, options.data.filter, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.grids.QV_1156_57465.AT87_TYPEEROR499 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.errorType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMUK_368643",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_1156_57465.column.errorType.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXMUK_368643",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_1156_57465.column.errorType.template",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.errorType.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.errorDescription = {
                title: 'ASSTS.LBL_ASSTS_DESCRIPIO_25154',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPBC_266643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT47_DESCRIOC499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.errorDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPBC_266643",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.errorDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.errorDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.clientId = {
                title: 'ASSTS.LBL_ASSTS_IDCLIENTT_49211',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFUX_836643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT58_CLIENTII499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.clientId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFUX_836643",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.clientId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.clientId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.nameClient = {
                title: 'ASSTS.LBL_ASSTS_CLIENTEWV_22561',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHUS_291643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT18_NAMECLNT499 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.nameClient.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHUS_291643",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.nameClient.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_DEBITORSIS_408643,1",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_1156_57465.column.nameClient.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.orderGenerationDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAGEIR_41980',
                titleArgs: {},
                tooltip: '',
                width: 90,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDCXZPAV_458643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT42_ORDERGRN499 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.orderGenerationDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDCXZPAV_458643",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.orderGenerationDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_1156_57465.column.orderGenerationDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.fromDate = {
                title: 'fromDate',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDZFBNAG_231643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT69_FROMDAET499 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.fromDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_DATEFIELDZFBNAG_231643",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.fromDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_1156_57465.column.fromDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_1156_57465.column.untilDate = {
                title: 'untilDate',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDNEFSQR_671643',
                element: []
            };
            $scope.vc.grids.QV_1156_57465.AT37_UNTILDTT499 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_1156_57465.column.untilDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_DATEFIELDNEFSQR_671643",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_1156_57465.column.untilDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_1156_57465.column.untilDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'loanNumber',
                    title: '{{vc.viewState.QV_1156_57465.column.loanNumber.title|translate:vc.viewState.QV_1156_57465.column.loanNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.loanNumber.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.loanNumber.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT22_LOANNUBR499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.loanNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.loanNumber, \"QV_1156_57465\", \"loanNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.loanNumber.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.loanNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.loanNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'accountNumberSantander',
                    title: '{{vc.viewState.QV_1156_57465.column.accountNumberSantander.title|translate:vc.viewState.QV_1156_57465.column.accountNumberSantander.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.accountNumberSantander.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.accountNumberSantander.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT77_ACCOUNBB499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.accountNumberSantander.style' ng-bind='vc.getStringColumnFormat(dataItem.accountNumberSantander, \"QV_1156_57465\", \"accountNumberSantander\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.accountNumberSantander.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.accountNumberSantander.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.accountNumberSantander.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'reference',
                    title: '{{vc.viewState.QV_1156_57465.column.reference.title|translate:vc.viewState.QV_1156_57465.column.reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.reference.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.reference.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT71_REFEREEE499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.reference.style' ng-bind='vc.getStringColumnFormat(dataItem.reference, \"QV_1156_57465\", \"reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.reference.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'filename',
                    title: '{{vc.viewState.QV_1156_57465.column.filename.title|translate:vc.viewState.QV_1156_57465.column.filename.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.filename.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.filename.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT96_FILENAMM499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.filename.style' ng-bind='vc.getStringColumnFormat(dataItem.filename, \"QV_1156_57465\", \"filename\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.filename.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.filename.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.filename.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'paymentAmount',
                    title: '{{vc.viewState.QV_1156_57465.column.paymentAmount.title|translate:vc.viewState.QV_1156_57465.column.paymentAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.paymentAmount.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.paymentAmount.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT40_AMOUNTAY499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.paymentAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.paymentAmount, \"QV_1156_57465\", \"paymentAmount\"):kendo.toString(#=paymentAmount#, vc.viewState.QV_1156_57465.column.paymentAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_1156_57465.column.paymentAmount.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.paymentAmount.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.paymentAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'state',
                    title: '{{vc.viewState.QV_1156_57465.column.state.title|translate:vc.viewState.QV_1156_57465.column.state.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.state.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.state.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT97_STATECSS499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.state.style' ng-bind='vc.getStringColumnFormat(dataItem.state, \"QV_1156_57465\", \"state\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.state.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.state.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.state.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'errorType',
                    title: '{{vc.viewState.QV_1156_57465.column.errorType.title|translate:vc.viewState.QV_1156_57465.column.errorType.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.errorType.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.errorType.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT87_TYPEEROR499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.errorType.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXMUK_368643.get(dataItem.errorType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.errorType.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.errorType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.errorType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'errorDescription',
                    title: '{{vc.viewState.QV_1156_57465.column.errorDescription.title|translate:vc.viewState.QV_1156_57465.column.errorDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.errorDescription.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.errorDescription.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT47_DESCRIOC499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.errorDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.errorDescription, \"QV_1156_57465\", \"errorDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.errorDescription.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.errorDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.errorDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'clientId',
                    title: '{{vc.viewState.QV_1156_57465.column.clientId.title|translate:vc.viewState.QV_1156_57465.column.clientId.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.clientId.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.clientId.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT58_CLIENTII499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.clientId.style' ng-bind='vc.getStringColumnFormat(dataItem.clientId, \"QV_1156_57465\", \"clientId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.clientId.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.clientId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.clientId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'nameClient',
                    title: '{{vc.viewState.QV_1156_57465.column.nameClient.title|translate:vc.viewState.QV_1156_57465.column.nameClient.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.nameClient.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.nameClient.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT18_NAMECLNT499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.nameClient.style' ng-bind='vc.getStringColumnFormat(dataItem.nameClient, \"QV_1156_57465\", \"nameClient\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.nameClient.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.nameClient.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.nameClient.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'orderGenerationDate',
                    title: '{{vc.viewState.QV_1156_57465.column.orderGenerationDate.title|translate:vc.viewState.QV_1156_57465.column.orderGenerationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.orderGenerationDate.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.orderGenerationDate.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT42_ORDERGRN499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.orderGenerationDate.style'>#=((orderGenerationDate !== null) ? kendo.toString(orderGenerationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.orderGenerationDate.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.orderGenerationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.orderGenerationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'fromDate',
                    title: '{{vc.viewState.QV_1156_57465.column.fromDate.title|translate:vc.viewState.QV_1156_57465.column.fromDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.fromDate.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.fromDate.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT69_FROMDAET499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.fromDate.style'>#=((fromDate !== null) ? kendo.toString(fromDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.fromDate.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.fromDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.fromDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_1156_57465.columns.push({
                    field: 'untilDate',
                    title: '{{vc.viewState.QV_1156_57465.column.untilDate.title|translate:vc.viewState.QV_1156_57465.column.untilDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_1156_57465.column.untilDate.width,
                    format: $scope.vc.viewState.QV_1156_57465.column.untilDate.format,
                    editor: $scope.vc.grids.QV_1156_57465.AT37_UNTILDTT499.control,
                    template: "<span ng-class='vc.viewState.QV_1156_57465.column.untilDate.style'>#=((untilDate !== null) ? kendo.toString(untilDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_1156_57465.column.untilDate.style",
                        "title": "{{vc.viewState.QV_1156_57465.column.untilDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_1156_57465.column.untilDate.hidden
                });
            }
            $scope.vc.viewState.QV_1156_57465.toolbar = {}
            $scope.vc.grids.QV_1156_57465.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_1156_57465.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSKUSBXHZA_608_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSKUSBXHZA_608_CANCEL",
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
                    $scope.vc.catalogs.VA_TEXTINPUTBOXMUK_368643.read();
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
                $scope.vc.render('VC_DEBITORDOC_486608');
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
    var cobisMainModule = cobis.createModule("VC_DEBITORDOC_486608", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_DEBITORDOC_486608", {
            templateUrl: "VC_DEBITORDOC_486608_FORM.html",
            controller: "VC_DEBITORDOC_486608_CTRL",
            labelId: "ASSTS.LBL_ASSTS_LOGPROCNT_12701",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_DEBITORDOC_486608?" + $.param(search);
            }
        });
        VC_DEBITORDOC_486608(cobisMainModule);
    }]);
} else {
    VC_DEBITORDOC_486608(cobisMainModule);
}