//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.conciliationsearchform = designerEvents.api.conciliationsearchform || designer.dsgEvents();

function VC_CONCILIAHN_488136(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CONCILIAHN_488136_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CONCILIAHN_488136_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "CMMNS",
            taskId: "T_ASSTSCFJBIIFM_136",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CONCILIAHN_488136",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/CMMNS/T_ASSTSCFJBIIFM_136",
        designerEvents.api.conciliationsearchform,
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
                vcName: 'VC_CONCILIAHN_488136'
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
                    subModuleId: 'CMMNS',
                    taskId: 'T_ASSTSCFJBIIFM_136',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ConciliationSearchFilter: "ConciliationSearchFilter",
                    ConciliationSearch: "ConciliationSearch"
                },
                entities: {
                    ConciliationSearchFilter: {
                        conciliationStatus: 'AT26_CONCILUT277',
                        type: 'AT28_TYPEKUKE277',
                        customerCode: 'AT45_CUSTOMDD277',
                        dateUntil: 'AT57_DATEUNLI277',
                        notConciliationReason: 'AT59_NOTCONLA277',
                        amount: 'AT61_AMOUNTRY277',
                        dateFrom: 'AT85_DATEFROM277',
                        _pks: [],
                        _entityId: 'EN_CONCILIIC_277',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ConciliationSearch: {
                        customerCode: 'AT11_CUSTOMEO147',
                        reference: 'AT18_REFERECC147',
                        amount: 'AT25_AMOUNTZD147',
                        dateUntil: 'AT37_DATEUNLT147',
                        paymentState: 'AT40_ESTADOSM147',
                        type: 'AT45_TYPEKPEI147',
                        conciliate: 'AT47_CONCILAA147',
                        paymentReceiptDate: 'AT51_PAYMENCE147',
                        notConciliationReason: 'AT54_CONCILIA147',
                        conciliationDate: 'AT56_CONCILAT147',
                        paymentReceiptAmount: 'AT56_PAYMENAP147',
                        conciliationStatus: 'AT58_CONCILST147',
                        dateFrom: 'AT66_DATEFRMM147',
                        uploadConciliationFileDate: 'AT66_UPLOADTN147',
                        observation: 'AT74_OBSERVTI147',
                        conciliationUser: 'AT80_CONCILAE147',
                        operation: 'AT92_OPERATNN147',
                        amountReportedInFile: 'AT93_AMOUNTER147',
                        customerName: 'AT95_CUSTOMEE147',
                        _pks: [],
                        _entityId: 'EN_CONCILICC_147',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: [{
                    firstEntityId: 'EN_CONCILIIC_277',
                    firstEntityVersion: '1.0.0',
                    firstMultiplicity: '1',
                    secondEntityId: 'EN_CONCILICC_147',
                    secondEntityVersion: '1.0.0',
                    secondMultiplicity: '*',
                    relationType: 'R',
                    relationAttributes: [{
                        attributeIdPk: 'AT28_TYPEKUKE277',
                        attributeIdFk: 'AT45_TYPEKPEI147'
                    }, {
                        attributeIdPk: 'AT61_AMOUNTRY277',
                        attributeIdFk: 'AT25_AMOUNTZD147'
                    }, {
                        attributeIdPk: 'AT59_NOTCONLA277',
                        attributeIdFk: 'AT54_CONCILIA147'
                    }, {
                        attributeIdPk: 'AT26_CONCILUT277',
                        attributeIdFk: 'AT58_CONCILST147'
                    }, {
                        attributeIdPk: 'AT57_DATEUNLI277',
                        attributeIdFk: 'AT37_DATEUNLT147'
                    }, {
                        attributeIdPk: 'AT85_DATEFROM277',
                        attributeIdFk: 'AT66_DATEFRMM147'
                    }, {
                        attributeIdPk: 'AT45_CUSTOMDD277',
                        attributeIdFk: 'AT11_CUSTOMEO147'
                    }]
                }]
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CONCILOA_9564 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CONCILOA_9564 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CONCILOA_9564_filters)) {
                    parametersAux = {
                        type: $scope.vc.model.ConciliationSearchFilter.type,
                        notConciliationReason: $scope.vc.model.ConciliationSearchFilter.notConciliationReason
                    };
                } else {
                    var filters = $scope.vc.queries.Q_CONCILOA_9564_filters;
                    parametersAux = {
                        customerName: filters.customerName,
                        paymentReceiptDate: filters.paymentReceiptDate,
                        paymentReceiptAmount: filters.paymentReceiptAmount,
                        uploadConciliationFileDate: filters.uploadConciliationFileDate,
                        conciliate: filters.conciliate,
                        conciliationDate: filters.conciliationDate,
                        conciliationUser: filters.conciliationUser,
                        observation: filters.observation,
                        type: filters.type,
                        amountReportedInFile: filters.amountReportedInFile,
                        notConciliationReason: filters.notConciliationReason,
                        paymentState: filters.paymentState
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CONCILICC_147',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CONCILOA_9564',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            this.parameters['type'] = $scope.vc.model.ConciliationSearchFilter.type;
                            this.parameters['notConciliationReason'] = $scope.vc.model.ConciliationSearchFilter.notConciliationReason;
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['customerName'] = this.filters.customerName;
                            this.parameters['paymentReceiptDate'] = this.filters.paymentReceiptDate;
                            this.parameters['paymentReceiptAmount'] = this.filters.paymentReceiptAmount;
                            this.parameters['uploadConciliationFileDate'] = this.filters.uploadConciliationFileDate;
                            this.parameters['conciliate'] = this.filters.conciliate;
                            this.parameters['conciliationDate'] = this.filters.conciliationDate;
                            this.parameters['conciliationUser'] = this.filters.conciliationUser;
                            this.parameters['observation'] = this.filters.observation;
                            this.parameters['type'] = this.filters.type;
                            this.parameters['amountReportedInFile'] = this.filters.amountReportedInFile;
                            this.parameters['notConciliationReason'] = this.filters.notConciliationReason;
                            this.parameters['paymentState'] = this.filters.paymentState;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_CONCILOA_9564_filters = {};
            var defaultValues = {
                ConciliationSearchFilter: {},
                ConciliationSearch: {}
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
                $scope.vc.execute("temporarySave", VC_CONCILIAHN_488136, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CONCILIAHN_488136, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CONCILIAHN_488136, data, function() {});
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
            $scope.vc.viewState.VC_CONCILIAHN_488136 = {
                style: []
            }
            //ViewState - Group: GroupLayout1946
            $scope.vc.createViewState({
                id: "G_CONCILIEIS_831314",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1946',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ConciliationSearchFilter = {
                conciliationStatus: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "conciliationStatus"),
                type: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "type"),
                customerCode: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "customerCode"),
                dateUntil: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "dateUntil"),
                notConciliationReason: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "notConciliationReason"),
                amount: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "amount"),
                dateFrom: $scope.vc.channelDefaultValues("ConciliationSearchFilter", "dateFrom")
            };
            //ViewState - Group: Group1507
            $scope.vc.createViewState({
                id: "G_CONCILINOS_646314",
                hasId: true,
                componentStyle: [],
                label: 'Group1507',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearchFilter, Attribute: customerCode
            $scope.vc.createViewState({
                id: "VA_CUSTOMERCODEVGG_397314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CDIGOCLEN_99910",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearchFilter, Attribute: dateFrom
            $scope.vc.createViewState({
                id: "VA_DATEFROMSRSVMDL_381314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADESD_11676",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearchFilter, Attribute: dateUntil
            $scope.vc.createViewState({
                id: "VA_DATEUNTILRORUCP_833314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAHATS_18279",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearchFilter, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_AMOUNTLZJASLNAN_666314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONTOEMFX_52083",
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationSearchFilter, Attribute: type
            $scope.vc.createViewState({
                id: "VA_TYPEABMBHAOAJKU_389314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOLDSKB_46090",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEABMBHAOAJKU_389314 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPEABMBHAOAJKU_389314', 'ca_tipo_pago', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPEABMBHAOAJKU_389314'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TYPEABMBHAOAJKU_389314");
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
            //ViewState - Entity: ConciliationSearchFilter, Attribute: notConciliationReason
            $scope.vc.createViewState({
                id: "VA_NOTCONCILIATONN_740314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RAZNNOCCA_72804",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NOTCONCILIATONN_740314 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NOTCONCILIATONN_740314', 'ca_razon_no_conciliacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NOTCONCILIATONN_740314'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NOTCONCILIATONN_740314");
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
            //ViewState - Entity: ConciliationSearchFilter, Attribute: conciliationStatus
            $scope.vc.createViewState({
                id: "VA_CONCILIATIONSSS_486314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOCAC_27670",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_CONCILIATIONSSS_486314 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CONCILIATIONSSS_486314', 'ca_estado_conciliacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CONCILIATIONSSS_486314'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                        }, null, options.data.filter, 0);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_CONCILIATIONSSS_486314 !== "undefined") {}
            $scope.vc.createViewState({
                id: "VA_VABUTTONKHXTIGP_249314",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                queryId: 'Q_CONCILOA_9564',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2286
            $scope.vc.createViewState({
                id: "G_CONCILIOIO_622314",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2286',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1159
            $scope.vc.createViewState({
                id: "G_CONCILIEOO_903314",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RESULTAAO_74237",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ConciliationSearch = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "reference", '')
                    },
                    type: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.ConciliationSearchFilter.type
                        }
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "customerName", '')
                    },
                    paymentReceiptDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "paymentReceiptDate", new Date())
                    },
                    paymentReceiptAmount: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "paymentReceiptAmount", 0)
                    },
                    paymentState: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "paymentState", '')
                    },
                    uploadConciliationFileDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "uploadConciliationFileDate", new Date())
                    },
                    amountReportedInFile: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "amountReportedInFile", 0)
                    },
                    conciliate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliate", '')
                    },
                    conciliationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliationDate", new Date())
                    },
                    notConciliationReason: {
                        type: "string",
                        editable: true,
                        defaultValue: function fkValue() {
                            return $scope.vc.model.ConciliationSearchFilter.notConciliationReason
                        }
                    },
                    conciliationUser: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "conciliationUser", '')
                    },
                    observation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationSearch", "observation", ''),
                        validation: {
                            observationRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.ConciliationSearch = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CONCILOA_9564';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CONCILOA_9564();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9564_85454',
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
                    model: $scope.vc.types.ConciliationSearch
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9564_85454").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CONCILOA_9564 = $scope.vc.model.ConciliationSearch;
            $scope.vc.trackers.ConciliationSearch = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ConciliationSearch);
            $scope.vc.model.ConciliationSearch.bind('change', function(e) {
                $scope.vc.trackers.ConciliationSearch.track(e);
            });
            $scope.vc.grids.QV_9564_85454 = {};
            $scope.vc.grids.QV_9564_85454.queryId = 'Q_CONCILOA_9564';
            $scope.vc.viewState.QV_9564_85454 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9564_85454.column = {};
            $scope.vc.grids.QV_9564_85454.editable = false;
            $scope.vc.grids.QV_9564_85454.events = {
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
                    $scope.vc.trackers.ConciliationSearch.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9564_85454.selectedRow = e.model;
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
                    $scope.vc.exportGrid(e, 'QV_9564_85454', this.dataSource);
                },
                excel: {
                    fileName: 'QV_9564_85454.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_9564_85454.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9564_85454");
                    $scope.vc.hideShowColumns("QV_9564_85454", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9564_85454.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9564_85454.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9564_85454.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9564_85454 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9564_85454 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_9564_85454.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_9564_85454.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_9564_85454.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "ConciliationSearch",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        if (window.event.target.tagName !== "SPAN") {
                            $scope.vc.gridRowSelecting("QV_9564_85454", args);
                        }
                        if (!$scope.$root) {
                            if (e.sender.$angular_scope.$$phase !== '$apply' && e.sender.$angular_scope.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        } else {
                            if ($scope.$root.$$phase !== '$apply' && $scope.$root.$$phase !== '$digest') {
                                $scope.$apply();
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9564_85454.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9564_85454.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9564_85454.column.reference = {
                title: 'ASSTS.LBL_ASSTS_REFERENAI_72258',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOND_465314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT18_REFERECC147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.reference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOND_465314",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.reference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.reference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.type = {
                title: 'ASSTS.LBL_ASSTS_TIPOLDSKB_46090',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJRI_461314',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXJRI_461314 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXJRI_461314',
                            'ca_tipo_pago',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXJRI_461314'];
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
            $scope.vc.grids.QV_9564_85454.AT45_TYPEKPEI147 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.type.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJRI_461314",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9564_85454.column.type.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXJRI_461314",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9564_85454.column.type.template",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.type.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.customerName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREDLE_56666',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYC_402314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT95_CUSTOMEE147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQYC_402314",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.paymentReceiptDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAREEC_30465',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDRGUOCF_143314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT51_PAYMENCE147 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.paymentReceiptDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDRGUOCF_143314",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.paymentReceiptDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_9564_85454.column.paymentReceiptDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.paymentReceiptAmount = {
                title: 'ASSTS.LBL_ASSTS_VALORDELO_59378',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRCT_884314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT56_PAYMENAP147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.paymentReceiptAmount.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRCT_884314",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.paymentReceiptAmount.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9564_85454.column.paymentReceiptAmount.format",
                        'k-decimals': "vc.viewState.QV_9564_85454.column.paymentReceiptAmount.decimals",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.paymentReceiptAmount.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.paymentState = {
                title: 'ASSTS.LBL_ASSTS_ESTADOEAI_33340',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXHAC_736314',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXHAC_736314 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXHAC_736314',
                            'ca_estado_pago_corresponsal',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXHAC_736314'];
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
            $scope.vc.grids.QV_9564_85454.AT40_ESTADOSM147 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.paymentState.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXHAC_736314",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9564_85454.column.paymentState.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXHAC_736314",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9564_85454.column.paymentState.template",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.paymentState.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.uploadConciliationFileDate = {
                title: 'ASSTS.LBL_ASSTS_FECHACACA_71424',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDTNXYEQ_606314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT66_UPLOADTN147 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_DATEFIELDTNXYEQ_606314",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.amountReportedInFile = {
                title: 'ASSTS.LBL_ASSTS_VALORREDE_86179',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEXQ_984314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT93_AMOUNTER147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.amountReportedInFile.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEXQ_984314",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.amountReportedInFile.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9564_85454.column.amountReportedInFile.format",
                        'k-decimals': "vc.viewState.QV_9564_85454.column.amountReportedInFile.decimals",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.amountReportedInFile.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.conciliate = {
                title: 'ASSTS.LBL_ASSTS_CONCILIOA_81081',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNPG_341314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT47_CONCILAA147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.conciliate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNPG_341314",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.conciliate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.conciliate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.conciliationDate = {
                title: 'ASSTS.LBL_ASSTS_FECHACOLI_35633',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDJJBXGG_707314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT56_CONCILAT147 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.conciliationDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDJJBXGG_707314",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.conciliationDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_9564_85454.column.conciliationDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.notConciliationReason = {
                title: 'ASSTS.LBL_ASSTS_RAZNNOCLO_52799',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMXE_512314',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXMXE_512314 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXMXE_512314',
                            'ca_razon_no_conciliacion',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXMXE_512314'];
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
            $scope.vc.grids.QV_9564_85454.AT54_CONCILIA147 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.notConciliationReason.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMXE_512314",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9564_85454.column.notConciliationReason.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXMXE_512314",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9564_85454.column.notConciliationReason.template",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.notConciliationReason.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.conciliationUser = {
                title: 'ASSTS.LBL_ASSTS_USUARIOLN_96458',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXBO_142314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT80_CONCILAE147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.conciliationUser.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXXBO_142314",
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.conciliationUser.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.conciliationUser.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9564_85454.column.observation = {
                title: 'ASSTS.LBL_ASSTS_OBSERVACI_51532',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXMSA_103314',
                element: []
            };
            $scope.vc.grids.QV_9564_85454.AT74_OBSERVTI147 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9564_85454.column.observation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMSA_103314",
                        'required': '',
                        'data-required-msg': $filter('translate')('ASSTS.LBL_ASSTS_OBSERVACI_51532') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_9564_85454.column.observation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILIOIO_622314,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9564_85454.column.observation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'reference',
                    title: '{{vc.viewState.QV_9564_85454.column.reference.title|translate:vc.viewState.QV_9564_85454.column.reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.reference.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.reference.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT18_REFERECC147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.reference.style' ng-bind='vc.getStringColumnFormat(dataItem.reference, \"QV_9564_85454\", \"reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.reference.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.reference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'type',
                    title: '{{vc.viewState.QV_9564_85454.column.type.title|translate:vc.viewState.QV_9564_85454.column.type.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.type.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.type.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT45_TYPEKPEI147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.type.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXJRI_461314.get(dataItem.type).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.type.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_9564_85454.column.customerName.title|translate:vc.viewState.QV_9564_85454.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.customerName.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.customerName.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT95_CUSTOMEE147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_9564_85454\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.customerName.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'paymentReceiptDate',
                    title: '{{vc.viewState.QV_9564_85454.column.paymentReceiptDate.title|translate:vc.viewState.QV_9564_85454.column.paymentReceiptDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.paymentReceiptDate.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.paymentReceiptDate.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT51_PAYMENCE147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.paymentReceiptDate.style'>#=((paymentReceiptDate !== null) ? kendo.toString(paymentReceiptDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.paymentReceiptDate.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.paymentReceiptDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.paymentReceiptDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'paymentReceiptAmount',
                    title: '{{vc.viewState.QV_9564_85454.column.paymentReceiptAmount.title|translate:vc.viewState.QV_9564_85454.column.paymentReceiptAmount.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.paymentReceiptAmount.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.paymentReceiptAmount.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT56_PAYMENAP147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.paymentReceiptAmount.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.paymentReceiptAmount, \"QV_9564_85454\", \"paymentReceiptAmount\"):kendo.toString(#=paymentReceiptAmount#, vc.viewState.QV_9564_85454.column.paymentReceiptAmount.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9564_85454.column.paymentReceiptAmount.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.paymentReceiptAmount.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.paymentReceiptAmount.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'paymentState',
                    title: '{{vc.viewState.QV_9564_85454.column.paymentState.title|translate:vc.viewState.QV_9564_85454.column.paymentState.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.paymentState.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.paymentState.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT40_ESTADOSM147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.paymentState.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXHAC_736314.get(dataItem.paymentState).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.paymentState.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.paymentState.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.paymentState.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'uploadConciliationFileDate',
                    title: '{{vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.title|translate:vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT66_UPLOADTN147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.style'>#=((uploadConciliationFileDate !== null) ? kendo.toString(uploadConciliationFileDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.uploadConciliationFileDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'amountReportedInFile',
                    title: '{{vc.viewState.QV_9564_85454.column.amountReportedInFile.title|translate:vc.viewState.QV_9564_85454.column.amountReportedInFile.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.amountReportedInFile.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.amountReportedInFile.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT93_AMOUNTER147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.amountReportedInFile.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.amountReportedInFile, \"QV_9564_85454\", \"amountReportedInFile\"):kendo.toString(#=amountReportedInFile#, vc.viewState.QV_9564_85454.column.amountReportedInFile.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9564_85454.column.amountReportedInFile.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.amountReportedInFile.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.amountReportedInFile.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'conciliate',
                    title: '{{vc.viewState.QV_9564_85454.column.conciliate.title|translate:vc.viewState.QV_9564_85454.column.conciliate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.conciliate.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.conciliate.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT47_CONCILAA147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.conciliate.style' ng-bind='vc.getStringColumnFormat(dataItem.conciliate, \"QV_9564_85454\", \"conciliate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.conciliate.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.conciliate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.conciliate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'conciliationDate',
                    title: '{{vc.viewState.QV_9564_85454.column.conciliationDate.title|translate:vc.viewState.QV_9564_85454.column.conciliationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.conciliationDate.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.conciliationDate.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT56_CONCILAT147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.conciliationDate.style'>#=((conciliationDate !== null) ? kendo.toString(conciliationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.conciliationDate.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.conciliationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.conciliationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'notConciliationReason',
                    title: '{{vc.viewState.QV_9564_85454.column.notConciliationReason.title|translate:vc.viewState.QV_9564_85454.column.notConciliationReason.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.notConciliationReason.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.notConciliationReason.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT54_CONCILIA147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.notConciliationReason.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXMXE_512314.get(dataItem.notConciliationReason).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.notConciliationReason.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.notConciliationReason.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.notConciliationReason.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'conciliationUser',
                    title: '{{vc.viewState.QV_9564_85454.column.conciliationUser.title|translate:vc.viewState.QV_9564_85454.column.conciliationUser.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.conciliationUser.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.conciliationUser.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT80_CONCILAE147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.conciliationUser.style' ng-bind='vc.getStringColumnFormat(dataItem.conciliationUser, \"QV_9564_85454\", \"conciliationUser\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.conciliationUser.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.conciliationUser.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.conciliationUser.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9564_85454.columns.push({
                    field: 'observation',
                    title: '{{vc.viewState.QV_9564_85454.column.observation.title|translate:vc.viewState.QV_9564_85454.column.observation.titleArgs}}',
                    width: $scope.vc.viewState.QV_9564_85454.column.observation.width,
                    format: $scope.vc.viewState.QV_9564_85454.column.observation.format,
                    editor: $scope.vc.grids.QV_9564_85454.AT74_OBSERVTI147.control,
                    template: "<span ng-class='vc.viewState.QV_9564_85454.column.observation.style' ng-bind='vc.getStringColumnFormat(dataItem.observation, \"QV_9564_85454\", \"observation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9564_85454.column.observation.style",
                        "title": "{{vc.viewState.QV_9564_85454.column.observation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9564_85454.column.observation.hidden
                });
            }
            $scope.vc.viewState.QV_9564_85454.toolbar = {}
            $scope.vc.grids.QV_9564_85454.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_9564_85454.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSCFJBIIFM_136_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSCFJBIIFM_136_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: uploadFile
            $scope.vc.createViewState({
                id: "CM_TASSTSCF_6AJ",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CARGARAVI_75931",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_CONCILIATIONSSS_486314.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXJRI_461314.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXHAC_736314.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXMXE_512314.read();
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
                $scope.vc.render('VC_CONCILIAHN_488136');
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
    var cobisMainModule = cobis.createModule("VC_CONCILIAHN_488136", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_CONCILIAHN_488136", {
            templateUrl: "VC_CONCILIAHN_488136_FORM.html",
            controller: "VC_CONCILIAHN_488136_CTRL",
            labelId: "ASSTS.LBL_ASSTS_CONCILICI_92729",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CONCILIAHN_488136?" + $.param(search);
            }
        });
        VC_CONCILIAHN_488136(cobisMainModule);
    }]);
} else {
    VC_CONCILIAHN_488136(cobisMainModule);
}