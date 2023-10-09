//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.paymentmaintenancemodal = designerEvents.api.paymentmaintenancemodal || designer.dsgEvents();

function VC_PAYMENTMDA_338828(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PAYMENTMDA_338828_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PAYMENTMDA_338828_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            subModuleId: "MNTNN",
            taskId: "T_PAYMENTMAIDLT_828",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PAYMENTMDA_338828",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/ASSTS/MNTNN/T_PAYMENTMAIDLT_828",
        designerEvents.api.paymentmaintenancemodal,
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
                vcName: 'VC_PAYMENTMDA_338828'
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
                    subModuleId: 'MNTNN',
                    taskId: 'T_PAYMENTMAIDLT_828',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    MethodsRetention: "MethodsRetention"
                },
                entities: {
                    MethodsRetention: {
                        product: 'AT44_PRODUCTT271',
                        description: 'AT87_DESCRIPO271',
                        category: 'AT56_CATEGORR271',
                        disbursement: 'AT94_DISBURSS271',
                        payment: 'AT57_PAYMENTT271',
                        retentiondays: 'AT30_RETENTNN271',
                        valueCode: 'AT27_VALUECEO271',
                        paymentAut: 'AT13_PAYMENTU271',
                        currencyRetention: 'AT63_CURRENNN271',
                        paymentATX: 'AT65_PAYMENTX271',
                        descCurrency: 'AT43_DESCCUYN271',
                        pcobis: 'AT94_PCOBISAE271',
                        descCOBIS: 'AT71_DESCCOIB271',
                        reversePro: 'AT44_REVERSRR271',
                        affectation: 'AT99_AFFECTAA271',
                        activePassive: 'AT93_ACTIVEIP271',
                        state: 'AT95_STATELNK271',
                        bankInstrument: 'AT55_BANKINNT271',
                        descripBank: 'AT65_DESCRIAP271',
                        canal: 'AT40_CANALFYR271',
                        descriptionCanal: 'AT13_DESCRINL271',
                        bankServices: 'AT57_BANKSECR271',
                        paymentMethods: 'AT88_PAYMENSE271',
                        transacction: 'AT28_TRANSACO271',
                        codeCategory: 'AT56_CODECATY271',
                        descriptionCategory: 'AT75_DESCRIGI271',
                        _pks: [],
                        _entityId: 'EN_METHODSRT_271',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                MethodsRetention: {}
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
                $scope.vc.execute("temporarySave", VC_PAYMENTMDA_338828, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PAYMENTMDA_338828, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PAYMENTMDA_338828, data, function() {});
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
            $scope.vc.viewState.VC_PAYMENTMDA_338828 = {
                style: []
            }
            //ViewState - Group: GroupLayout1108
            $scope.vc.createViewState({
                id: "G_PAYMENTNNO_964701",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1108',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.MethodsRetention = {
                product: $scope.vc.channelDefaultValues("MethodsRetention", "product"),
                description: $scope.vc.channelDefaultValues("MethodsRetention", "description"),
                category: $scope.vc.channelDefaultValues("MethodsRetention", "category"),
                disbursement: $scope.vc.channelDefaultValues("MethodsRetention", "disbursement"),
                payment: $scope.vc.channelDefaultValues("MethodsRetention", "payment"),
                retentiondays: $scope.vc.channelDefaultValues("MethodsRetention", "retentiondays"),
                valueCode: $scope.vc.channelDefaultValues("MethodsRetention", "valueCode"),
                paymentAut: $scope.vc.channelDefaultValues("MethodsRetention", "paymentAut"),
                currencyRetention: $scope.vc.channelDefaultValues("MethodsRetention", "currencyRetention"),
                paymentATX: $scope.vc.channelDefaultValues("MethodsRetention", "paymentATX"),
                descCurrency: $scope.vc.channelDefaultValues("MethodsRetention", "descCurrency"),
                pcobis: $scope.vc.channelDefaultValues("MethodsRetention", "pcobis"),
                descCOBIS: $scope.vc.channelDefaultValues("MethodsRetention", "descCOBIS"),
                reversePro: $scope.vc.channelDefaultValues("MethodsRetention", "reversePro"),
                affectation: $scope.vc.channelDefaultValues("MethodsRetention", "affectation"),
                activePassive: $scope.vc.channelDefaultValues("MethodsRetention", "activePassive"),
                state: $scope.vc.channelDefaultValues("MethodsRetention", "state"),
                bankInstrument: $scope.vc.channelDefaultValues("MethodsRetention", "bankInstrument"),
                descripBank: $scope.vc.channelDefaultValues("MethodsRetention", "descripBank"),
                canal: $scope.vc.channelDefaultValues("MethodsRetention", "canal"),
                descriptionCanal: $scope.vc.channelDefaultValues("MethodsRetention", "descriptionCanal"),
                bankServices: $scope.vc.channelDefaultValues("MethodsRetention", "bankServices"),
                paymentMethods: $scope.vc.channelDefaultValues("MethodsRetention", "paymentMethods"),
                transacction: $scope.vc.channelDefaultValues("MethodsRetention", "transacction"),
                codeCategory: $scope.vc.channelDefaultValues("MethodsRetention", "codeCategory"),
                descriptionCategory: $scope.vc.channelDefaultValues("MethodsRetention", "descriptionCategory")
            };
            //ViewState - Group: Group2410
            $scope.vc.createViewState({
                id: "G_PAYMENTCCT_512701",
                hasId: true,
                componentStyle: [],
                label: 'Group2410',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: product
            $scope.vc.createViewState({
                id: "VA_PRODUCTOFQZHBKU_354701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_IDENTIFRD_90451",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: description
            $scope.vc.createViewState({
                id: "VA_DESCRIPTIONSUZS_167701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESCRIPNI_65857",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: category
            $scope.vc.createViewState({
                id: "VA_CATEGORYPGXZQCK_157701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CATEGORAA_59396",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CATEGORYPGXZQCK_157701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CATEGORYPGXZQCK_157701', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CATEGORYPGXZQCK_157701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CATEGORYPGXZQCK_157701");
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
            //ViewState - Group: Group1760
            $scope.vc.createViewState({
                id: "G_PAYMENTLNN_635701",
                hasId: true,
                componentStyle: [],
                label: 'Group1760',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: currencyRetention
            $scope.vc.createViewState({
                id: "VA_CURRENCYRETETTO_736701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_MONEDATUB_92849",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CURRENCYRETETTO_736701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CURRENCYRETETTO_736701', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CURRENCYRETETTO_736701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CURRENCYRETETTO_736701");
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
            //ViewState - Entity: MethodsRetention, Attribute: valueCode
            $scope.vc.createViewState({
                id: "VA_VALUECODEEKTKMB_372701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_CODIGOVLO_98625",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: paymentMethods
            $scope.vc.createViewState({
                id: "VA_PAYMENTMETHODSD_816701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_APAGORERR_42797",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PAYMENTMETHODSD_816701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_PAYMENTMETHODSD_816701', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_PAYMENTMETHODSD_816701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_PAYMENTMETHODSD_816701");
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
            //ViewState - Group: Group1768
            $scope.vc.createViewState({
                id: "G_PAYMENTAMA_728701",
                hasId: true,
                componentStyle: [],
                label: 'Group1768',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: retentiondays
            $scope.vc.createViewState({
                id: "VA_RETENTIONDAYSSS_990701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DASRETECN_29008",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: activePassive
            $scope.vc.createViewState({
                id: "VA_ACTIVEPASSIVEEE_865701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_TIPOCARTR_61359",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ACTIVEPASSIVEEE_865701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'A',
                            value: 'Activa'
                        }, {
                            code: 'P',
                            value: 'Pasiva'
                        }, {
                            code: 'T',
                            value: 'Activa y Pasiva'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_ACTIVEPASSIVEEE_865701");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: MethodsRetention, Attribute: disbursement
            $scope.vc.createViewState({
                id: "VA_DISBURSEMENTDSI_289701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_DESEMBOOL_32055",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DISBURSEMENTDSI_289701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_DISBURSEMENTDSI_289701");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Group: Group1320
            $scope.vc.createViewState({
                id: "G_PAYMENTMNE_859701",
                hasId: true,
                componentStyle: [],
                label: 'Group1320',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: payment
            $scope.vc.createViewState({
                id: "VA_PAYMENTKWAZXHOL_773701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PAGOSBHJO_80531",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PAYMENTKWAZXHOL_773701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_PAYMENTKWAZXHOL_773701");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: MethodsRetention, Attribute: paymentAut
            $scope.vc.createViewState({
                id: "VA_PAYMENTAUTLPCHV_485701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PAGOSAUTT_98998",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PAYMENTAUTLPCHV_485701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_PAYMENTAUTLPCHV_485701");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: MethodsRetention, Attribute: paymentATX
            $scope.vc.createViewState({
                id: "VA_PAYMENTATXPGDKX_602701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PAGOPORAC_94053",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PAYMENTATXPGDKX_602701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_PAYMENTATXPGDKX_602701");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Group: Group2579
            $scope.vc.createViewState({
                id: "G_PAYMENTOEI_853701",
                hasId: true,
                componentStyle: [],
                label: 'Group2579',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: MethodsRetention, Attribute: state
            $scope.vc.createViewState({
                id: "VA_STATEUKNKICEOOK_121701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ESTADOEAI_33340",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_STATEUKNKICEOOK_121701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_STATEUKNKICEOOK_121701', 'cl_estado_ser', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_STATEUKNKICEOOK_121701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_STATEUKNKICEOOK_121701");
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
            //ViewState - Entity: MethodsRetention, Attribute: bankServices
            $scope.vc.createViewState({
                id: "VA_BANKSERVICESDQR_160701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_SERVICIOA_67043",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BANKSERVICESDQR_160701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_BANKSERVICESDQR_160701', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_BANKSERVICESDQR_160701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BANKSERVICESDQR_160701");
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
            //ViewState - Entity: MethodsRetention, Attribute: pcobis
            $scope.vc.createViewState({
                id: "VA_PCOBISNSCZVLGJB_151701",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_PRODUCTIB_77965",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PCOBISNSCZVLGJB_151701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_PCOBISNSCZVLGJB_151701', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_PCOBISNSCZVLGJB_151701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_PCOBISNSCZVLGJB_151701");
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
            //ViewState - Entity: MethodsRetention, Attribute: canal
            $scope.vc.createViewState({
                id: "VA_CANALAHHGQQRYXT_909701",
                componentStyle: [],
                tooltip: "ASSTS.LBL_ASSTS_CANALGFWW_89486",
                label: "ASSTS.LBL_ASSTS_CANALGFWW_89486",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CANALAHHGQQRYXT_909701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_CANALAHHGQQRYXT_909701', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_CANALAHHGQQRYXT_909701'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CANALAHHGQQRYXT_909701");
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
            //ViewState - Entity: MethodsRetention, Attribute: transacction
            $scope.vc.createViewState({
                id: "VA_TRANSACCTIONKAF_634701",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_TRANSACCTIONKAF_634701 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'D',
                            value: 'Debito '
                        }, {
                            code: 'C',
                            value: 'Credito'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_TRANSACCTIONKAF_634701 !== "undefined") {}
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PAYMENTMAIDLT_828_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PAYMENTMAIDLT_828_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TPAYMENT_TM7",
                componentStyle: [],
                label: "ASSTS.LBL_ASSTS_ACEPTARDV_64984",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TPAYMENT_08P",
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
                    $scope.vc.catalogs.VA_TRANSACCTIONKAF_634701.read();
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
                $scope.vc.render('VC_PAYMENTMDA_338828');
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
    var cobisMainModule = cobis.createModule("VC_PAYMENTMDA_338828", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "ASSTS"]);
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
        $routeProvider.when("/VC_PAYMENTMDA_338828", {
            templateUrl: "VC_PAYMENTMDA_338828_FORM.html",
            controller: "VC_PAYMENTMDA_338828_CTRL",
            label: "PaymentMaintenanceModal",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('ASSTS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PAYMENTMDA_338828?" + $.param(search);
            }
        });
        VC_PAYMENTMDA_338828(cobisMainModule);
    }]);
} else {
    VC_PAYMENTMDA_338828(cobisMainModule);
}