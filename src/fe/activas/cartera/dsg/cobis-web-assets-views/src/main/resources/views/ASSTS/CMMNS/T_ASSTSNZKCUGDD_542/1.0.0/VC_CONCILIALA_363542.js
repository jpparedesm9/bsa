//Designer Generator v 6.3.6 - release SPR 2018-04 28/02/2018
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.conciliationmanualsearchform = designerEvents.api.conciliationmanualsearchform || designer.dsgEvents();

function VC_CONCILIALA_363542(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CONCILIALA_363542_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CONCILIALA_363542_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ASSTSNZKCUGDD_542",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CONCILIALA_363542",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/CMMNS/T_ASSTSNZKCUGDD_542",
        designerEvents.api.conciliationmanualsearchform,
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
                vcName: 'VC_CONCILIALA_363542'
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
                    taskId: 'T_ASSTSNZKCUGDD_542',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    ConciliationManualSearchFilter: "ConciliationManualSearchFilter",
                    ConciliationManualSearch: "ConciliationManualSearch"
                },
                entities: {
                    ConciliationManualSearchFilter: {
                        conciliate: 'AT10_CONCILTA649',
                        notConciliationReason: 'AT10_NOTCONNE649',
                        conciliationType: 'AT23_CONCILIP649',
                        customType: 'AT34_CUSTOMTT649',
                        observation: 'AT56_OBSERVAI649',
                        paymentState: 'AT63_PAYMENTS649',
                        customCode: 'AT79_CUSTOMCD649',
                        dateUntil: 'AT86_DATEUNLT649',
                        dateFrom: 'AT89_DATEFROO649',
                        correspTransactionCode: 'AT96_CORRESIT649',
                        correspondent: 'AT96_CORRESTO649',
                        type: 'AT97_TYPEDIXC649',
                        _pks: [],
                        _entityId: 'EN_CONCILIAH_649',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    ConciliationManualSearch: {
                        conciliate: 'AT14_CONCILEE936',
                        codeCo: 'AT16_CUSTOMOE936',
                        valueDate: 'AT23_VALUEDEA936',
                        conciliationUser: 'AT24_CONCILSI936',
                        correspTransactionCode: 'AT24_CORRESAE936',
                        isReverse: 'AT27_ISREVESR936',
                        observation: 'AT29_OBSERVTI936',
                        conciliationDate: 'AT37_CONCILAA936',
                        userPayment: 'AT39_USERPATT936',
                        recordsDate: 'AT41_RECORDAA936',
                        clientName: 'AT42_CLIENTAE936',
                        paymentReference: 'AT51_PAYMENNR936',
                        correspondent: 'AT52_CORRESNN936',
                        customCode: 'AT64_CLIENTOO936',
                        type: 'AT69_TYPELRSC936',
                        paymentState: 'AT76_PAYMENTE936',
                        sequentialCode: 'AT87_SEQUENOE936',
                        notConciliationReason: 'AT88_NOTCONOR936',
                        isSelected: 'AT89_ISSELEDT936',
                        operation: 'AT90_OPERATON936',
                        codeRelation: 'AT91_CODEREOA936',
                        _pks: [],
                        _entityId: 'EN_CONCILISL_936',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_CONCILNH_9498 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_CONCILNH_9498 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_CONCILNH_9498_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_CONCILNH_9498_filters;
                    parametersAux = {
                        correspondent: filters.correspondent,
                        correspTransactionCode: filters.correspTransactionCode,
                        type: filters.type,
                        customCode: filters.customCode,
                        recordsDate: filters.recordsDate,
                        paymentState: filters.paymentState,
                        conciliate: filters.conciliate,
                        notConciliationReason: filters.notConciliationReason
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CONCILISL_936',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_CONCILNH_9498',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['correspondent'] = this.filters.correspondent;
                            this.parameters['correspTransactionCode'] = this.filters.correspTransactionCode;
                            this.parameters['type'] = this.filters.type;
                            this.parameters['customCode'] = this.filters.customCode;
                            this.parameters['recordsDate'] = this.filters.recordsDate;
                            this.parameters['paymentState'] = this.filters.paymentState;
                            this.parameters['conciliate'] = this.filters.conciliate;
                            this.parameters['notConciliationReason'] = this.filters.notConciliationReason;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_CONCILNH_9498_filters = {};
            var defaultValues = {
                ConciliationManualSearchFilter: {},
                ConciliationManualSearch: {}
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
                $scope.vc.execute("temporarySave", VC_CONCILIALA_363542, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CONCILIALA_363542, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CONCILIALA_363542, data, function() {});
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
            $scope.vc.viewState.VC_CONCILIALA_363542 = {
                style: []
            }
            //ViewState - Group: GroupLayout1699
            $scope.vc.createViewState({
                id: "G_CONCILINSM_801547",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1699',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.ConciliationManualSearchFilter = {
                conciliate: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "conciliate"),
                notConciliationReason: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "notConciliationReason"),
                conciliationType: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "conciliationType"),
                customType: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "customType"),
                observation: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "observation"),
                paymentState: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "paymentState"),
                customCode: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "customCode"),
                dateUntil: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "dateUntil"),
                dateFrom: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "dateFrom"),
                correspTransactionCode: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "correspTransactionCode"),
                correspondent: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "correspondent"),
                type: $scope.vc.channelDefaultValues("ConciliationManualSearchFilter", "type")
            };
            //ViewState - Group: Group1159
            $scope.vc.createViewState({
                id: "G_CONCILIUNA_884547",
                hasId: true,
                componentStyle: [],
                label: 'Group1159',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: customCode
            $scope.vc.createViewState({
                id: "VA_CUSTOMCODEETRCB_211547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CLIENTEWV_22561",
                format: "n0",
                decimals: 0,
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: correspTransactionCode
            $scope.vc.createViewState({
                id: "VA_CORRESPTRANSTEO_698547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CDIGOTRSR_11649",
                format: "#",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: dateFrom
            $scope.vc.createViewState({
                id: "VA_DATEFROMJLXDFUC_868547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHADESD_11676",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: dateUntil
            $scope.vc.createViewState({
                id: "VA_DATEUNTILVGLSWC_330547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_FECHAHATS_18279",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: correspondent
            $scope.vc.createViewState({
                id: "VA_CORRESPONDENTTT_336547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CORRESPAS_68079",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CORRESPONDENTTT_336547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CORRESPONDENTTT_336547', 'ca_corresponsal', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CORRESPONDENTTT_336547'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CORRESPONDENTTT_336547");
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
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: type
            $scope.vc.createViewState({
                id: "VA_TYPEETPPCTHMLIW_604547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOPAGOO_46459",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEETPPCTHMLIW_604547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPEETPPCTHMLIW_604547', 'ca_tipo_pago_corresponsal', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPEETPPCTHMLIW_604547'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TYPEETPPCTHMLIW_604547");
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
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: notConciliationReason
            $scope.vc.createViewState({
                id: "VA_NOTCONCILIATRNE_811547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RAZNNOCCO_11400",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NOTCONCILIATRNE_811547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NOTCONCILIATRNE_811547', 'ca_no_concilia_corresponsal', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NOTCONCILIATRNE_811547'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NOTCONCILIATRNE_811547");
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
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: conciliate
            $scope.vc.createViewState({
                id: "VA_CONCILIATETZPLE_801547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOCII_38627",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CONCILIATETZPLE_801547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CONCILIATETZPLE_801547', 'ca_estado_conciliacion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CONCILIATETZPLE_801547'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CONCILIATETZPLE_801547");
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
            //ViewState - Entity: ConciliationManualSearchFilter, Attribute: paymentState
            $scope.vc.createViewState({
                id: "VA_PAYMENTSTATERUB_284547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOPAG_29749",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PAYMENTSTATERUB_284547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_PAYMENTSTATERUB_284547', 'ca_estado_pago_corresponsal', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_PAYMENTSTATERUB_284547'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_PAYMENTSTATERUB_284547");
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
                id: "VA_VABUTTONXDZJZKT_299547",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_BUSCARYEV_82731",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2603
            $scope.vc.createViewState({
                id: "G_CONCILISSR_584547",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RESULTADA_33493",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2289
            $scope.vc.createViewState({
                id: "G_CONCILICOA_717547",
                hasId: true,
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_RESULTALU_74264",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ConciliationManualSearch = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    isSelected: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "isSelected", false)
                    },
                    correspondent: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "correspondent", '')
                    },
                    paymentReference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "paymentReference", '')
                    },
                    correspTransactionCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "correspTransactionCode", 0)
                    },
                    type: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "type", '')
                    },
                    customCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "customCode", 0)
                    },
                    clientName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "clientName", '')
                    },
                    isReverse: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "isReverse", '')
                    },
                    recordsDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "recordsDate", '')
                    },
                    valueDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "valueDate", new Date())
                    },
                    userPayment: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "userPayment", '')
                    },
                    paymentState: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "paymentState", '')
                    },
                    conciliate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "conciliate", '')
                    },
                    notConciliationReason: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "notConciliationReason", '')
                    },
                    conciliationUser: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "conciliationUser", '')
                    },
                    conciliationDate: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "conciliationDate", new Date())
                    },
                    operation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "operation", '')
                    },
                    observation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "observation", '')
                    },
                    codeCo: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "codeCo", 0)
                    },
                    codeRelation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ConciliationManualSearch", "codeRelation", 0)
                    }
                }
            });
            $scope.vc.model.ConciliationManualSearch = new kendo.data.DataSource({
                pageSize: 30,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_CONCILNH_9498';
                            var queryRequest = $scope.vc.getRequestQuery_Q_CONCILNH_9498();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9498_38003',
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
                                            'pageSize': 30
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
                    model: $scope.vc.types.ConciliationManualSearch
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9498_38003").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_CONCILNH_9498 = $scope.vc.model.ConciliationManualSearch;
            $scope.vc.trackers.ConciliationManualSearch = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ConciliationManualSearch);
            $scope.vc.model.ConciliationManualSearch.bind('change', function(e) {
                $scope.vc.trackers.ConciliationManualSearch.track(e);
            });
            $scope.vc.grids.QV_9498_38003 = {};
            $scope.vc.grids.QV_9498_38003.queryId = 'Q_CONCILNH_9498';
            $scope.vc.viewState.QV_9498_38003 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9498_38003.column = {};
            $scope.vc.grids.QV_9498_38003.editable = false;
            $scope.vc.grids.QV_9498_38003.events = {
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
                    $scope.vc.trackers.ConciliationManualSearch.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9498_38003.selectedRow = e.model;
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
                    $scope.vc.exportGrid(e, 'QV_9498_38003', this.dataSource);
                },
                excel: {
                    fileName: 'QV_9498_38003.xlsx',
                    filterable: true,
                    allPages: true
                },
                pdf: {
                    allPages: true,
                    fileName: 'QV_9498_38003.pdf'
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9498_38003");
                    $scope.vc.hideShowColumns("QV_9498_38003", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9498_38003.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9498_38003.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9498_38003.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9498_38003 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9498_38003 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9498_38003.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9498_38003.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9498_38003.column.isSelected = {
                title: 'ASSTS.LBL_ASSTS_SELECCIRR_76753',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXHQPTSGA_311547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT89_ISSELEDT936 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'type': "checkbox",
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.isSelected.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_CHECKBOXHQPTSGA_311547",
                        'ng-class': 'vc.viewState.QV_9498_38003.column.isSelected.element["' + options.model.uid + '"].style'
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.correspondent = {
                title: 'ASSTS.LBL_ASSTS_CORRESPAS_68079',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLWZ_171547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT52_CORRESNN936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.correspondent.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXLWZ_171547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.correspondent.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.correspondent.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.paymentReference = {
                title: 'ASSTS.LBL_ASSTS_REFERENAI_72258',
                titleArgs: {},
                tooltip: '',
                width: 220,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOPA_952547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT51_PAYMENNR936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.paymentReference.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOPA_952547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.paymentReference.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.paymentReference.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.correspTransactionCode = {
                title: 'ASSTS.LBL_ASSTS_IDTRANSCI_58250',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEHM_244547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT24_CORRESAE936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.correspTransactionCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXEHM_244547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.correspTransactionCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9498_38003.column.correspTransactionCode.format",
                        'k-decimals': "vc.viewState.QV_9498_38003.column.correspTransactionCode.decimals",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.correspTransactionCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.type = {
                title: 'ASSTS.LBL_ASSTS_TIPOPAGOO_46459',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSHW_248547',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXSHW_248547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXSHW_248547',
                            'ca_tipo_pago_corresponsal',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXSHW_248547'];
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
            $scope.vc.grids.QV_9498_38003.AT69_TYPELRSC936 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.type.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSHW_248547",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9498_38003.column.type.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXSHW_248547",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9498_38003.column.type.template",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.type.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.customCode = {
                title: 'ASSTS.LBL_ASSTS_CLIENTEOP_58328',
                titleArgs: {},
                tooltip: '',
                width: 110,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "#",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDFK_426547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT64_CLIENTOO936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.customCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDFK_426547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.customCode.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9498_38003.column.customCode.format",
                        'k-decimals': "vc.viewState.QV_9498_38003.column.customCode.decimals",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.customCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.clientName = {
                title: 'ASSTS.LBL_ASSTS_NOMBREULS_81822',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMJQ_393547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT42_CLIENTAE936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.clientName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMJQ_393547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.clientName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.clientName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.isReverse = {
                title: 'ASSTS.LBL_ASSTS_ESREVERSS_35688',
                titleArgs: {},
                tooltip: '',
                width: 100,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMHA_711547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT27_ISREVESR936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.isReverse.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXMHA_711547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.isReverse.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.isReverse.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.recordsDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAREOG_98006',
                titleArgs: {},
                tooltip: '',
                width: 180,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDVOLGMZ_841547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT41_RECORDAA936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.recordsDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDVOLGMZ_841547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.recordsDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.recordsDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.valueDate = {
                title: 'ASSTS.LBL_ASSTS_FECHAVALO_78292',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDISONUC_635547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT23_VALUEDEA936 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.valueDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDISONUC_635547",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.valueDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_9498_38003.column.valueDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.userPayment = {
                title: 'ASSTS.LBL_ASSTS_USUARIOGA_83409',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZAJ_642547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT39_USERPATT936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.userPayment.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZAJ_642547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.userPayment.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.userPayment.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.paymentState = {
                title: 'ASSTS.LBL_ASSTS_ESTADOPAO_99328',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPWX_143547',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXPWX_143547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXPWX_143547',
                            'ca_estado_pago_corresponsal',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPWX_143547'];
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
            $scope.vc.grids.QV_9498_38003.AT76_PAYMENTE936 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.paymentState.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXPWX_143547",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9498_38003.column.paymentState.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXPWX_143547",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9498_38003.column.paymentState.template",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.paymentState.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.conciliate = {
                title: 'ASSTS.LBL_ASSTS_CONCILIOA_81081',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDNA_976547',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXDNA_976547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXDNA_976547',
                            'ca_estado_conciliacion',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXDNA_976547'];
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
            $scope.vc.grids.QV_9498_38003.AT14_CONCILEE936 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.conciliate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDNA_976547",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9498_38003.column.conciliate.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXDNA_976547",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9498_38003.column.conciliate.template",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.conciliate.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.notConciliationReason = {
                title: 'ASSTS.LBL_ASSTS_RAZNNOCOI_57253',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNNO_841547',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXNNO_841547 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXNNO_841547',
                            'ca_no_concilia_corresponsal',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXNNO_841547'];
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
            $scope.vc.grids.QV_9498_38003.AT88_NOTCONOR936 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.notConciliationReason.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNNO_841547",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9498_38003.column.notConciliationReason.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXNNO_841547",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9498_38003.column.notConciliationReason.template",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.notConciliationReason.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.conciliationUser = {
                title: 'ASSTS.LBL_ASSTS_USUARIOAL_55543',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXRZS_929547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT24_CONCILSI936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.conciliationUser.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXRZS_929547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.conciliationUser.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.conciliationUser.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.conciliationDate = {
                title: 'ASSTS.LBL_ASSTS_FECHACONI_78149',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDVIWNKI_312547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT37_CONCILAA936 = {
                control: function(container, options) {
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.conciliationDate.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_DATEFIELDVIWNKI_312547",
                        'kendo-ext-date-picker': "",
                        'placeholder': "{{dateFormatPlaceholder}}",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.conciliationDate.validationCode}}",
                        'ng-class': "vc.viewState.QV_9498_38003.column.conciliationDate.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.operation = {
                title: 'ASSTS.LBL_ASSTS_OPERACINN_92370',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZLT_301547',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXZLT_301547 = new kendo.data.DataSource({
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXZLT_301547.data([{
                code: 'AC',
                value: 'ACLARAR'
            }, {
                code: 'AP',
                value: 'APLICAR'
            }, {
                code: 'RV',
                value: 'REVERSAR'
            }]);
            $scope.vc.grids.QV_9498_38003.AT90_OPERATON936 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.operation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXZLT_301547",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9498_38003.column.operation.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXZLT_301547",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9498_38003.column.operation.template",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.operation.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.observation = {
                title: 'ASSTS.LBL_ASSTS_OBSERVACI_69856',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXARV_756547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT29_OBSERVTI936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.observation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXARV_756547",
                        'maxlength': 255,
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.observation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.observation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.codeCo = {
                title: 'codeCo',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNNC_733547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT16_CUSTOMOE936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.codeCo.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNNC_733547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.codeCo.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9498_38003.column.codeCo.format",
                        'k-decimals': "vc.viewState.QV_9498_38003.column.codeCo.decimals",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.codeCo.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9498_38003.column.codeRelation = {
                title: 'ASSTS.LBL_ASSTS_CDIGORELC_28027',
                titleArgs: {},
                tooltip: '',
                width: 125,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKAN_794547',
                element: []
            };
            $scope.vc.grids.QV_9498_38003.AT91_CODEREOA936 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9498_38003.column.codeRelation.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKAN_794547",
                        'data-validation-code': "{{vc.viewState.QV_9498_38003.column.codeRelation.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9498_38003.column.codeRelation.format",
                        'k-decimals': "vc.viewState.QV_9498_38003.column.codeRelation.decimals",
                        'data-cobis-group': "GroupLayout,G_CONCILISSR_584547,0",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9498_38003.column.codeRelation.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'isSelected',
                    title: '{{vc.viewState.QV_9498_38003.column.isSelected.title|translate:vc.viewState.QV_9498_38003.column.isSelected.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.isSelected.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.isSelected.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_9498_38003', 'isSelected', $scope.vc.grids.QV_9498_38003.AT89_ISSELEDT936.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_9498_38003', 'isSelected'),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.isSelected.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.isSelected.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.isSelected.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'correspondent',
                    title: '{{vc.viewState.QV_9498_38003.column.correspondent.title|translate:vc.viewState.QV_9498_38003.column.correspondent.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.correspondent.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.correspondent.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT52_CORRESNN936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.correspondent.style' ng-bind='vc.getStringColumnFormat(dataItem.correspondent, \"QV_9498_38003\", \"correspondent\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.correspondent.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.correspondent.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.correspondent.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'paymentReference',
                    title: '{{vc.viewState.QV_9498_38003.column.paymentReference.title|translate:vc.viewState.QV_9498_38003.column.paymentReference.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.paymentReference.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.paymentReference.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT51_PAYMENNR936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.paymentReference.style' ng-bind='vc.getStringColumnFormat(dataItem.paymentReference, \"QV_9498_38003\", \"paymentReference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.paymentReference.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.paymentReference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.paymentReference.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'correspTransactionCode',
                    title: '{{vc.viewState.QV_9498_38003.column.correspTransactionCode.title|translate:vc.viewState.QV_9498_38003.column.correspTransactionCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.correspTransactionCode.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.correspTransactionCode.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT24_CORRESAE936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.correspTransactionCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.correspTransactionCode, \"QV_9498_38003\", \"correspTransactionCode\"):kendo.toString(#=correspTransactionCode#, vc.viewState.QV_9498_38003.column.correspTransactionCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9498_38003.column.correspTransactionCode.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.correspTransactionCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.correspTransactionCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'type',
                    title: '{{vc.viewState.QV_9498_38003.column.type.title|translate:vc.viewState.QV_9498_38003.column.type.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.type.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.type.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT69_TYPELRSC936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.type.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXSHW_248547.get(dataItem.type).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.type.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.type.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.type.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'customCode',
                    title: '{{vc.viewState.QV_9498_38003.column.customCode.title|translate:vc.viewState.QV_9498_38003.column.customCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.customCode.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.customCode.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT64_CLIENTOO936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.customCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customCode, \"QV_9498_38003\", \"customCode\"):kendo.toString(#=customCode#, vc.viewState.QV_9498_38003.column.customCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9498_38003.column.customCode.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.customCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.customCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'clientName',
                    title: '{{vc.viewState.QV_9498_38003.column.clientName.title|translate:vc.viewState.QV_9498_38003.column.clientName.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.clientName.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.clientName.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT42_CLIENTAE936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.clientName.style' ng-bind='vc.getStringColumnFormat(dataItem.clientName, \"QV_9498_38003\", \"clientName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.clientName.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.clientName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.clientName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'isReverse',
                    title: '{{vc.viewState.QV_9498_38003.column.isReverse.title|translate:vc.viewState.QV_9498_38003.column.isReverse.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.isReverse.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.isReverse.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT27_ISREVESR936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.isReverse.style' ng-bind='vc.getStringColumnFormat(dataItem.isReverse, \"QV_9498_38003\", \"isReverse\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.isReverse.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.isReverse.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.isReverse.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'recordsDate',
                    title: '{{vc.viewState.QV_9498_38003.column.recordsDate.title|translate:vc.viewState.QV_9498_38003.column.recordsDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.recordsDate.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.recordsDate.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT41_RECORDAA936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.recordsDate.style' ng-bind='vc.getStringColumnFormat(dataItem.recordsDate, \"QV_9498_38003\", \"recordsDate\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.recordsDate.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.recordsDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.recordsDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'valueDate',
                    title: '{{vc.viewState.QV_9498_38003.column.valueDate.title|translate:vc.viewState.QV_9498_38003.column.valueDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.valueDate.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.valueDate.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT23_VALUEDEA936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.valueDate.style'>#=((valueDate !== null) ? kendo.toString(valueDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.valueDate.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.valueDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.valueDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'userPayment',
                    title: '{{vc.viewState.QV_9498_38003.column.userPayment.title|translate:vc.viewState.QV_9498_38003.column.userPayment.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.userPayment.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.userPayment.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT39_USERPATT936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.userPayment.style' ng-bind='vc.getStringColumnFormat(dataItem.userPayment, \"QV_9498_38003\", \"userPayment\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.userPayment.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.userPayment.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.userPayment.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'paymentState',
                    title: '{{vc.viewState.QV_9498_38003.column.paymentState.title|translate:vc.viewState.QV_9498_38003.column.paymentState.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.paymentState.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.paymentState.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT76_PAYMENTE936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.paymentState.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXPWX_143547.get(dataItem.paymentState).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.paymentState.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.paymentState.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.paymentState.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'conciliate',
                    title: '{{vc.viewState.QV_9498_38003.column.conciliate.title|translate:vc.viewState.QV_9498_38003.column.conciliate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.conciliate.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.conciliate.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT14_CONCILEE936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.conciliate.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXDNA_976547.get(dataItem.conciliate).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.conciliate.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.conciliate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.conciliate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'notConciliationReason',
                    title: '{{vc.viewState.QV_9498_38003.column.notConciliationReason.title|translate:vc.viewState.QV_9498_38003.column.notConciliationReason.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.notConciliationReason.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.notConciliationReason.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT88_NOTCONOR936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.notConciliationReason.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXNNO_841547.get(dataItem.notConciliationReason).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.notConciliationReason.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.notConciliationReason.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.notConciliationReason.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'conciliationUser',
                    title: '{{vc.viewState.QV_9498_38003.column.conciliationUser.title|translate:vc.viewState.QV_9498_38003.column.conciliationUser.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.conciliationUser.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.conciliationUser.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT24_CONCILSI936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.conciliationUser.style' ng-bind='vc.getStringColumnFormat(dataItem.conciliationUser, \"QV_9498_38003\", \"conciliationUser\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.conciliationUser.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.conciliationUser.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.conciliationUser.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'conciliationDate',
                    title: '{{vc.viewState.QV_9498_38003.column.conciliationDate.title|translate:vc.viewState.QV_9498_38003.column.conciliationDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.conciliationDate.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.conciliationDate.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT37_CONCILAA936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.conciliationDate.style'>#=((conciliationDate !== null) ? kendo.toString(conciliationDate, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.conciliationDate.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.conciliationDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.conciliationDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'operation',
                    title: '{{vc.viewState.QV_9498_38003.column.operation.title|translate:vc.viewState.QV_9498_38003.column.operation.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.operation.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.operation.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT90_OPERATON936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.operation.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXZLT_301547.get(dataItem.operation).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.operation.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.operation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.operation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'observation',
                    title: '{{vc.viewState.QV_9498_38003.column.observation.title|translate:vc.viewState.QV_9498_38003.column.observation.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.observation.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.observation.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT29_OBSERVTI936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.observation.style' ng-bind='vc.getStringColumnFormat(dataItem.observation, \"QV_9498_38003\", \"observation\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9498_38003.column.observation.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.observation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.observation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'codeCo',
                    title: '{{vc.viewState.QV_9498_38003.column.codeCo.title|translate:vc.viewState.QV_9498_38003.column.codeCo.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.codeCo.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.codeCo.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT16_CUSTOMOE936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.codeCo.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.codeCo, \"QV_9498_38003\", \"codeCo\"):kendo.toString(#=codeCo#, vc.viewState.QV_9498_38003.column.codeCo.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9498_38003.column.codeCo.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.codeCo.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.codeCo.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'codeRelation',
                    title: '{{vc.viewState.QV_9498_38003.column.codeRelation.title|translate:vc.viewState.QV_9498_38003.column.codeRelation.titleArgs}}',
                    width: $scope.vc.viewState.QV_9498_38003.column.codeRelation.width,
                    format: $scope.vc.viewState.QV_9498_38003.column.codeRelation.format,
                    editor: $scope.vc.grids.QV_9498_38003.AT91_CODEREOA936.control,
                    template: "<span ng-class='vc.viewState.QV_9498_38003.column.codeRelation.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.codeRelation, \"QV_9498_38003\", \"codeRelation\"):kendo.toString(#=codeRelation#, vc.viewState.QV_9498_38003.column.codeRelation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9498_38003.column.codeRelation.style",
                        "title": "{{vc.viewState.QV_9498_38003.column.codeRelation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.codeRelation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547 = {
                    tooltip: '',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547)) {
                    $scope.vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547 = {};
                }
                $scope.vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547.hidden = false;
                $scope.vc.grids.QV_9498_38003.columns.push({
                    field: 'VA_GRIDROWCOMMMAND_129547',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMAND_129547",
                        entity: "ConciliationManualSearch",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmand':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMAND_129547\", " + "vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547.enabled || vc.viewState.G_CONCILICOA_717547.disabled' " + "data-ng-click = 'vc.grids.QV_9498_38003.events.customRowClick($event, \"VA_GRIDROWCOMMMAND_129547\", \"#:entity#\", \"QV_9498_38003\")' " + "title = \"{{vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547.tooltip|translate}}\" " + "href = '\\#'>" + "#: text #" + "</a>"
                    },
                    width: 1,
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_9498_38003.column.VA_GRIDROWCOMMMAND_129547.hidden
                });
            }
            $scope.vc.viewState.QV_9498_38003.toolbar = {}
            $scope.vc.grids.QV_9498_38003.toolbar = [{
                name: 'export',
                text: "",
                template: '<div class="btn-group"><button type="button" class="btn btn-default dropdown-toggle cb-btn-export" data-toggle="dropdown" aria-expanded="false"><span class="glyphicon glyphicon-export"></span>{{\'DSGNR.SYS_DSGNR_MSGEXPORT_00036\'|translate}}</button><ul class="dropdown-menu" role="menu"><li><a class="cb-btn-export-xls" ng-click="grids.QV_9498_38003.saveAsExcel()" href="\\\#">Excel</a></li></ul></div>'
            }];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ASSTSNZKCUGDD_542_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ASSTSNZKCUGDD_542_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TASSTSNZ_39S",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ACLARARCN_35266",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TASSTSNZ_D29",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APLICARTN_46756",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TASSTSNZ_1SG",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_REVERSASA_54350",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXSHW_248547.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXPWX_143547.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXDNA_976547.read();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXNNO_841547.read();
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
                $scope.vc.render('VC_CONCILIALA_363542');
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
    var cobisMainModule = cobis.createModule("VC_CONCILIALA_363542", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_CONCILIALA_363542", {
            templateUrl: "VC_CONCILIALA_363542_FORM.html",
            controller: "VC_CONCILIALA_363542_CTRL",
            labelId: "ASSTS.LBL_ASSTS_CONCILINA_99171",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CONCILIALA_363542?" + $.param(search);
            }
        });
        VC_CONCILIALA_363542(cobisMainModule);
    }]);
} else {
    VC_CONCILIALA_363542(cobisMainModule);
}