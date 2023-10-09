//Designer Generator v 6.1.1 - release SPR 2017-03 17/02/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.guaranteessearch = designerEvents.api.guaranteessearch || designer.dsgEvents();

function VC_GURNH31_OMREA_904(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GURNH31_OMREA_904_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GURNH31_OMREA_904_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

    function(cobisMessage, preferencesService, dsgnrUtils, designer, $scope, $location, $document, $parse, $filter, $modal, $q, $compile, $timeout) {
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
            moduleId: "BUSIN",
            subModuleId: "FLCRE",
            taskId: "T_FLCRE_24_GURNH31",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GURNH31_OMREA_904",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_24_GURNH31",
        designerEvents.api.guaranteessearch,
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
                hasCRUDSupport: true,
                vcName: 'VC_GURNH31_OMREA_904'
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
                    moduleId: 'BUSIN',
                    subModuleId: 'FLCRE',
                    taskId: 'T_FLCRE_24_GURNH31',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    GuaranteeSearchCriteria: "GuaranteeSearchCriteria",
                    WarrantieComext: "WarrantieComext",
                    Guarantees: "Guarantees"
                },
                entities: {
                    GuaranteeSearchCriteria: {
                        amount: 'AT36_AMOUNTHW652',
                        admissibility: 'AT50_ADMISSYI652',
                        warrantyMoney: 'AT51_WARRANEY652',
                        shared: 'AT69_SHAREDLK652',
                        character: 'AT99_CHARACTR652',
                        StatusGuarantee: 'AT_RSR652ATSN10',
                        CorrelativeEnd: 'AT_RSR652CRVT62',
                        Customer: 'AT_RSR652CUOM34',
                        StartDateAdmission: 'AT_RSR652DAMS45',
                        EndDateAdmission: 'AT_RSR652DSIT50',
                        ExternalCode: 'AT_RSR652NAOD52',
                        Officer: 'AT_RSR652OFIR79',
                        Office: 'AT_RSR652OICE69',
                        CorrelativeStart: 'AT_RSR652REAR78',
                        GuaranteeType: 'AT_RSR652RTTY26',
                        ExternalCodeNext: 'AT_RSR652XENC01',
                        _pks: [],
                        _entityId: 'EN_RSRCHERIA652',
                        _entityVersion: '1.0.0',
                        _transient: true
                    },
                    WarrantieComext: {
                        additionalCriteria: 'AT21_ADDITIAT747',
                        currencyWarrantie: 'AT_ARR747CRRR45',
                        warrantieType: 'AT_ARR747REYE05',
                        currencyComext: 'AT_ARR747URCO48',
                        _pks: [],
                        _entityId: 'EN_ARRNCMEXT747',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Guarantees: {
                        IdGuarantee: 'AT_WAR922ARAY63',
                        GuaranteeType: 'AT_WAR922WRTT98',
                        Description: 'AT_WAR922ESRO36',
                        Status: 'AT_WAR922SAUS53',
                        AdmissionDate: 'AT_WAR922SOND22',
                        Currency: 'AT_WAR922MNEY72',
                        InitialValue: 'AT_WAR922TIAU84',
                        CurrentValue: 'AT_WAR922RREN32',
                        CurrentValueMn: 'AT_WAR922RLEN39',
                        GuaranteeCode: 'AT_WAR922WNYE12',
                        Office: 'AT_WAR922OFCE10',
                        GuarantorName: 'AT_WAR922GRAO22',
                        CustomerId: 'AT_WAR922USTE21',
                        LocationDocument: 'AT_WAR922CCEN82',
                        DepartureDate: 'AT_WAR922DPAU69',
                        RepaymentDate: 'AT_WAR922RTDT03',
                        DocumentDescription: 'AT_WAR922ONTC17',
                        Subsidiary: 'AT_WAR922USIA41',
                        Custody: 'AT_WAR922CSDY36',
                        ExpiredWarranty: 'AT_WAR922XRRN27',
                        CloseOpen: 'AT_WAR922COPE12',
                        AppraisedValueDate: 'AT_WAR922REAE82',
                        GuarantorId: 'AT_WAR922URAO34',
                        UserCreation: 'AT_WAR922UCIN94',
                        ValueAvailable: 'AT_WAR922VEAL99',
                        Type: 'AT_WAR922TYPE30',
                        OfficeName: 'AT_WAR922ICAM67',
                        relation: 'AT_WAR922RLAN43',
                        IsPersonal: 'AT_WAR922PEOL38',
                        isHeritage: 'AT_WAR922HETA72',
                        customerName: 'AT_WAR922SRAE07',
                        _pks: [],
                        _entityId: 'EN_WARRANTYF922',
                        _entityVersion: '1.0.0',
                        _transient: true
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_QURARRNT_0892 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_QURARRNT_0892 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QURARRNT_0892_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QURARRNT_0892_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_WARRANTYF922',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QURARRNT_0892',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_QURARRNT_0892_filters = {};
            var defaultValues = {
                GuaranteeSearchCriteria: {},
                WarrantieComext: {},
                Guarantees: {}
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
                $scope.vc.execute("temporarySave", VC_GURNH31_OMREA_904, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GURNH31_OMREA_904, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GURNH31_OMREA_904, data, function() {});
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
            $scope.vc.viewState.VC_GURNH31_OMREA_904 = {
                style: []
            }
            //ViewState - Group: Contenedor Acordeón
            $scope.vc.createViewState({
                id: "GR_WRRNTSEACH85_04",
                hasId: true,
                componentStyle: [],
                label: 'Contenedor Acorde\u00f3n',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GuaranteeSearchCriteria = {
                amount: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "amount"),
                admissibility: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "admissibility"),
                warrantyMoney: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "warrantyMoney"),
                shared: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "shared"),
                character: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "character"),
                StatusGuarantee: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "StatusGuarantee"),
                CorrelativeEnd: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "CorrelativeEnd"),
                Customer: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "Customer"),
                StartDateAdmission: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "StartDateAdmission"),
                EndDateAdmission: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "EndDateAdmission"),
                ExternalCode: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "ExternalCode"),
                Officer: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "Officer"),
                Office: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "Office"),
                CorrelativeStart: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "CorrelativeStart"),
                GuaranteeType: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "GuaranteeType"),
                ExternalCodeNext: $scope.vc.channelDefaultValues("GuaranteeSearchCriteria", "ExternalCodeNext")
            };
            //ViewState - Group: Panel de Acordeón para GuaranteeSearchCriteria
            $scope.vc.createViewState({
                id: "GR_WRRNTSEACH85_05",
                hasId: true,
                componentStyle: [],
                label: 'Panel de Acorde\u00f3n para GuaranteeSearchCriteria',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: Customer
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_CUOM537",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CUSTOMERE_21294",
                label: "BUSIN.LBL_BUSIN_CLIENTESU_28757",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: Office
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_OICE113",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_OFFICEWWB_98352",
                label: "BUSIN.DLB_BUSIN_OFICINAJD_61287",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRNTSEACH8505_OICE113 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WRRNTSEACH8505_OICE113', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WRRNTSEACH8505_OICE113'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRNTSEACH8505_OICE113");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: StatusGuarantee
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_ATSN498",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_STATUSUAS_80798",
                label: "BUSIN.LBL_BUSIN_ESTADOGAT_65098",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRNTSEACH8505_ATSN498 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WRRNTSEACH8505_ATSN498', 'cu_est_custodia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WRRNTSEACH8505_ATSN498'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRNTSEACH8505_ATSN498");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: GuaranteeType
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_RTTY100",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_WRRANTTYP_57052",
                label: "BUSIN.DLB_BUSIN_TIPODERNT_79668",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRNTSEACH8505_RTTY100 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_WRRNTSEACH8505_RTTY100', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_WRRNTSEACH8505_RTTY100'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRNTSEACH8505_RTTY100");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: Officer
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_OFIR555",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_OFFICERTU_38261",
                label: "BUSIN.DLB_BUSIN_OFICIALMD_41585",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WRRNTSEACH8505_OFIR555 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_WRRNTSEACH8505_OFIR555', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_WRRNTSEACH8505_OFIR555'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WRRNTSEACH8505_OFIR555");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: ExternalCode
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_NAOD344",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CIGEARNTA_66805",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: warrantyMoney
            $scope.vc.createViewState({
                id: "VA_WARRANTYMONEYYY_531H85",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WARRANTYMONEYYY_531H85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_WARRANTYMONEYYY_531H85', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_WARRANTYMONEYYY_531H85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WARRANTYMONEYYY_531H85");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: StartDateAdmission
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_DAMS278",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_ATATDMISN_21428",
                label: "BUSIN.LBL_BUSIN_FECHAINNI_50312",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: EndDateAdmission
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8505_DSIT654",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_NDDATDSIN_58703",
                label: "BUSIN.LBL_BUSIN_FECHAFIDI_88357",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: character
            $scope.vc.createViewState({
                id: "VA_CHARACTERXARFCC_916H85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CARCTEREA_41329",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CHARACTERXARFCC_916H85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CHARACTERXARFCC_916H85', 'cu_caracter', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CHARACTERXARFCC_916H85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CHARACTERXARFCC_916H85");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_AMOUNTJOGOYWOLN_543H85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CUANTATAS_45505",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_AMOUNTJOGOYWOLN_543H85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_AMOUNTJOGOYWOLN_543H85', 'cu_cuantia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_AMOUNTJOGOYWOLN_543H85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_AMOUNTJOGOYWOLN_543H85");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: admissibility
            $scope.vc.createViewState({
                id: "VA_ADMISSIBILITYYY_972H85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ADMISIBDI_24213",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ADMISSIBILITYYY_972H85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ADMISSIBILITYYY_972H85', 'cu_clase_custodia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ADMISSIBILITYYY_972H85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ADMISSIBILITYYY_972H85");
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
            //ViewState - Entity: GuaranteeSearchCriteria, Attribute: shared
            $scope.vc.createViewState({
                id: "VA_SHAREDYBHVSIQMI_498H85",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_COMPRTIDA_49433",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SHAREDYBHVSIQMI_498H85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SHAREDYBHVSIQMI_498H85', 'cu_compartida', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SHAREDYBHVSIQMI_498H85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SHAREDYBHVSIQMI_498H85");
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
            $scope.vc.model.WarrantieComext = {
                additionalCriteria: $scope.vc.channelDefaultValues("WarrantieComext", "additionalCriteria"),
                currencyWarrantie: $scope.vc.channelDefaultValues("WarrantieComext", "currencyWarrantie"),
                warrantieType: $scope.vc.channelDefaultValues("WarrantieComext", "warrantieType"),
                currencyComext: $scope.vc.channelDefaultValues("WarrantieComext", "currencyComext")
            };
            //ViewState - Group: GroupSearch
            $scope.vc.createViewState({
                id: "GR_WRRNTSEACH85_07",
                hasId: true,
                componentStyle: [],
                label: 'GroupSearch',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantieComext, Attribute: additionalCriteria
            $scope.vc.createViewState({
                id: "VA_ADDITIONALCRAEA_272H85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CRITERICA_31395",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8507_0000044",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_EAHGUANES_27474",
                label: "BUSIN.LBL_BUSIN_BUSCARGTT_90350",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_WRRNTSEACH8507_0000435",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SIGUIENET_99185",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Panel de Acordeón para Guarantees
            $scope.vc.createViewState({
                id: "GR_WRRNTSEACH85_06",
                hasId: true,
                componentStyle: [],
                label: 'Panel de Acorde\u00f3n para Guarantees',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Guarantees = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    GuaranteeCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "GuaranteeCode", '')
                    },
                    GuaranteeType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "GuaranteeType", '')
                    },
                    Description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "Description", '')
                    },
                    CloseOpen: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "CloseOpen", '')
                    },
                    GuarantorId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "GuarantorId", 0)
                    },
                    GuarantorName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "GuarantorName", '')
                    },
                    CustomerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "CustomerId", 0)
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "customerName", '')
                    },
                    Custody: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "Custody", 0)
                    },
                    Office: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "Office", '')
                    },
                    OfficeName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "OfficeName", '')
                    },
                    Currency: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "Currency", '')
                    },
                    CurrentValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "CurrentValue", 0)
                    },
                    InitialValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "InitialValue", 0)
                    },
                    ValueAvailable: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "ValueAvailable", 0)
                    },
                    AppraisedValueDate: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "AppraisedValueDate", '')
                    },
                    ExpiredWarranty: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "ExpiredWarranty", '')
                    },
                    Status: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "Status", '')
                    },
                    UserCreation: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "UserCreation", '')
                    },
                    isHeritage: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Guarantees", "isHeritage", '')
                    },
                    IsPersonal: {
                        type: "string",
                        editable: true
                    }
                }
            });
            $scope.vc.model.Guarantees = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_QURARRNT_0892';
                            var queryRequest = $scope.vc.getRequestQuery_Q_QURARRNT_0892();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_QURAR0892_86',
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
                                            'pageSize': 5
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
                    model: $scope.vc.types.Guarantees
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_QURAR0892_86").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QURARRNT_0892 = $scope.vc.model.Guarantees;
            $scope.vc.trackers.Guarantees = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Guarantees);
            $scope.vc.model.Guarantees.bind('change', function(e) {
                $scope.vc.trackers.Guarantees.track(e);
            });
            $scope.vc.grids.QV_QURAR0892_86 = {};
            $scope.vc.grids.QV_QURAR0892_86.queryId = 'Q_QURARRNT_0892';
            $scope.vc.viewState.QV_QURAR0892_86 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QURAR0892_86.column = {};
            $scope.vc.grids.QV_QURAR0892_86.editable = false;
            $scope.vc.grids.QV_QURAR0892_86.events = {
                customRowClick: function(e, controlId, entity, idGrid) {
                    var grid = $("#" + idGrid).data("kendoGrid");
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    var args = {
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        nameEntityGrid: entity,
                        refreshData: false,
                        stopPropagation: false
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
                    $scope.vc.trackers.Guarantees.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QURAR0892_86.selectedRow = e.model;
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
                    $scope.vc.gridDataBound("QV_QURAR0892_86");
                    $scope.vc.hideShowColumns("QV_QURAR0892_86", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QURAR0892_86.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QURAR0892_86.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QURAR0892_86.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QURAR0892_86 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QURAR0892_86 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_QURAR0892_86.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QURAR0892_86.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_QURAR0892_86.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "Guarantees",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_QURAR0892_86", args);
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
            $scope.vc.grids.QV_QURAR0892_86.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QURAR0892_86.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeCode = {
                title: 'BUSIN.DLB_BUSIN_CIGEARNTA_66805',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_WNYE572',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922WNYE12 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_WNYE572",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeType = {
                title: 'BUSIN.DLB_BUSIN_TIPODERNT_79668',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_WRTT782',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922WRTT98 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.GuaranteeType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_WRTT782",
                        'maxlength': 40,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.GuaranteeType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.GuaranteeType.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.Description = {
                title: 'BUSIN.DLB_BUSIN_DESCRIPCN_50497',
                titleArgs: {},
                tooltip: '',
                width: 330,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_ESRO961',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922ESRO36 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.Description.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_ESRO961",
                        'maxlength': 200,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.Description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.Description.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.CloseOpen = {
                title: 'BUSIN.LBL_BUSIN_ABRIRCERR_38272',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_COPE731',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922COPE12 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.CloseOpen.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_COPE731",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.CloseOpen.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.CloseOpen.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorId = {
                title: 'BUSIN.LBL_BUSIN_CDIGOGAEE_93351',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_URAO726',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922URAO34 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.GuarantorId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_URAO726",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.GuarantorId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURAR0892_86.column.GuarantorId.format",
                        'k-decimals': "vc.viewState.QV_QURAR0892_86.column.GuarantorId.decimals",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.GuarantorId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorName = {
                title: 'BUSIN.LBL_BUSIN_NOMBREDAE_16673',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_GRAO344',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922GRAO22 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.GuarantorName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_GRAO344",
                        'maxlength': 300,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.GuarantorName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.GuarantorName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.CustomerId = {
                title: 'BUSIN.DLB_BUSIN_CGODECLTE_92528',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "###########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_USTE227',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922USTE21 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.CustomerId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_USTE227",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.CustomerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURAR0892_86.column.CustomerId.format",
                        'k-decimals': "vc.viewState.QV_QURAR0892_86.column.CustomerId.decimals",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.CustomerId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.customerName = {
                title: 'BUSIN.DLB_BUSIN_LJRXITRFW_70117',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_SRAE714',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922SRAE07 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.customerName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_SRAE714",
                        'maxlength': 250,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.customerName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.Custody = {
                title: 'BUSIN.LBL_BUSIN_CUSTODIAA_50582',
                titleArgs: {},
                tooltip: '',
                width: 80,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_CSDY015',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922CSDY36 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.Custody.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_CSDY015",
                        'maxlength': 20,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.Custody.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURAR0892_86.column.Custody.format",
                        'k-decimals': "vc.viewState.QV_QURAR0892_86.column.Custody.decimals",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.Custody.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.Office = {
                title: 'BUSIN.DLB_BUSIN_OFICINAJD_61287',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_OFCE394',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922OFCE10 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.Office.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_OFCE394",
                        'maxlength': 200,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.Office.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.Office.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.OfficeName = {
                title: 'BUSIN.LBL_BUSIN_NOMBREOII_13704',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_ICAM017',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922ICAM67 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.OfficeName.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_ICAM017",
                        'maxlength': 250,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.OfficeName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.OfficeName.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.Currency = {
                title: 'BUSIN.DLB_BUSIN_MONEDAWDW_15876',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_MNEY069',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_WRRNTSEACH8506_MNEY069 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_WRRNTSEACH8506_MNEY069',
                            'cl_moneda',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_WRRNTSEACH8506_MNEY069'];
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
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922MNEY72 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.Currency.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_MNEY069",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QURAR0892_86.column.Currency.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_WRRNTSEACH8506_MNEY069",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QURAR0892_86.column.Currency.template",
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.Currency.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.CurrentValue = {
                title: 'BUSIN.LBL_BUSIN_VALORACLA_58791',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_RREN112',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922RREN32 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.CurrentValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_RREN112",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.CurrentValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURAR0892_86.column.CurrentValue.format",
                        'k-decimals': "vc.viewState.QV_QURAR0892_86.column.CurrentValue.decimals",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.CurrentValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.InitialValue = {
                title: 'BUSIN.DLB_BUSIN_VALRINICL_45750',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_TIAU324',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922TIAU84 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.InitialValue.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_TIAU324",
                        'maxlength': 33,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.InitialValue.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURAR0892_86.column.InitialValue.format",
                        'k-decimals': "vc.viewState.QV_QURAR0892_86.column.InitialValue.decimals",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.InitialValue.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.ValueAvailable = {
                title: 'BUSIN.LBL_BUSIN_VALORAVAL_70080',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "#,##0.00",
                decimals: 2,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_VEAL269',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922VEAL99 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.ValueAvailable.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_VEAL269",
                        'maxlength': 28,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.ValueAvailable.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QURAR0892_86.column.ValueAvailable.format",
                        'k-decimals': "vc.viewState.QV_QURAR0892_86.column.ValueAvailable.decimals",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.ValueAvailable.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate = {
                title: 'BUSIN.LBL_BUSIN_FECHAAVLA_22992',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_REAE186',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922REAE82 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_REAE186",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty = {
                title: 'BUSIN.LBL_BUSIN_FECHAEXIN_41166',
                titleArgs: {},
                tooltip: '',
                width: 120,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_XRRN154',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922XRRN27 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_XRRN154",
                        'maxlength': 300,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.Status = {
                title: 'BUSIN.DLB_BUSIN_ESTADORJE_43391',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_SAUS837',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_WRRNTSEACH8506_SAUS837 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_WRRNTSEACH8506_SAUS837',
                            'cu_est_custodia',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_WRRNTSEACH8506_SAUS837'];
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
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922SAUS53 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.Status.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_SAUS837",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QURAR0892_86.column.Status.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_WRRNTSEACH8506_SAUS837",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QURAR0892_86.column.Status.template",
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.Status.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'k-cache-on-client': 'true',
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'k-index': "0",
                        'k-auto-bind': "true",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.UserCreation = {
                title: 'BUSIN.LBL_BUSIN_USUARIOSN_40305',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_UCIN541',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922UCIN94 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.UserCreation.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_UCIN541",
                        'maxlength': 100,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.UserCreation.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.UserCreation.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.isHeritage = {
                title: 'DSGNR.SYS_DSGNR_LBLESTETQ_00024',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WRRNTSEACH8506_HETA897',
                element: []
            };
            $scope.vc.grids.QV_QURAR0892_86.AT_WAR922HETA72 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QURAR0892_86.column.isHeritage.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_WRRNTSEACH8506_HETA897",
                        'maxlength': 1,
                        'data-validation-code': "{{vc.viewState.QV_QURAR0892_86.column.isHeritage.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_WRRNTSEACH85_04,2",
                        'ng-class': "vc.viewState.QV_QURAR0892_86.column.isHeritage.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QURAR0892_86.column.IsPersonal = {
                title: 'IsPersonal',
                titleArgs: {},
                tooltip: '',
                enabled: true,
                hidden: false,
                decimals: 0,
                style: [],
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'GuaranteeCode',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.title|translate:vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922WNYE12.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.element[dataItem.uid].style'>#if (GuaranteeCode !== null) {# #=GuaranteeCode# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'GuaranteeType',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.GuaranteeType.title|translate:vc.viewState.QV_QURAR0892_86.column.GuaranteeType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeType.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeType.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922WRTT98.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.GuaranteeType.element[dataItem.uid].style'>#if (GuaranteeType !== null) {# #=GuaranteeType# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.GuaranteeType.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.GuaranteeType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.GuaranteeType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'Description',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.Description.title|translate:vc.viewState.QV_QURAR0892_86.column.Description.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.Description.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.Description.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922ESRO36.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.Description.element[dataItem.uid].style'>#if (Description !== null) {# #=Description# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.Description.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.Description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.Description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'CloseOpen',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.CloseOpen.title|translate:vc.viewState.QV_QURAR0892_86.column.CloseOpen.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.CloseOpen.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.CloseOpen.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922COPE12.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.CloseOpen.element[dataItem.uid].style'>#if (CloseOpen !== null) {# #=CloseOpen# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.CloseOpen.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.CloseOpen.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.CloseOpen.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'GuarantorId',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.GuarantorId.title|translate:vc.viewState.QV_QURAR0892_86.column.GuarantorId.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorId.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorId.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922URAO34.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.GuarantorId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.GuarantorId, \"QV_QURAR0892_86\", \"GuarantorId\"):kendo.toString(#=GuarantorId#, vc.viewState.QV_QURAR0892_86.column.GuarantorId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.GuarantorId.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.GuarantorId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'GuarantorName',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.GuarantorName.title|translate:vc.viewState.QV_QURAR0892_86.column.GuarantorName.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorName.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorName.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922GRAO22.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.GuarantorName.element[dataItem.uid].style'>#if (GuarantorName !== null) {# #=GuarantorName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.GuarantorName.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.GuarantorName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.GuarantorName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'CustomerId',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.CustomerId.title|translate:vc.viewState.QV_QURAR0892_86.column.CustomerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.CustomerId.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.CustomerId.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922USTE21.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.CustomerId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.CustomerId, \"QV_QURAR0892_86\", \"CustomerId\"):kendo.toString(#=CustomerId#, vc.viewState.QV_QURAR0892_86.column.CustomerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.CustomerId.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.CustomerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.CustomerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.customerName.title|translate:vc.viewState.QV_QURAR0892_86.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.customerName.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.customerName.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922SRAE07.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.customerName.element[dataItem.uid].style'>#if (customerName !== null) {# #=customerName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.customerName.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'Custody',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.Custody.title|translate:vc.viewState.QV_QURAR0892_86.column.Custody.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.Custody.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.Custody.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922CSDY36.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.Custody.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.Custody, \"QV_QURAR0892_86\", \"Custody\"):kendo.toString(#=Custody#, vc.viewState.QV_QURAR0892_86.column.Custody.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.Custody.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.Custody.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.Custody.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'Office',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.Office.title|translate:vc.viewState.QV_QURAR0892_86.column.Office.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.Office.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.Office.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922OFCE10.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.Office.element[dataItem.uid].style'>#if (Office !== null) {# #=Office# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.Office.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.Office.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.Office.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'OfficeName',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.OfficeName.title|translate:vc.viewState.QV_QURAR0892_86.column.OfficeName.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.OfficeName.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.OfficeName.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922ICAM67.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.OfficeName.element[dataItem.uid].style'>#if (OfficeName !== null) {# #=OfficeName# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.OfficeName.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.OfficeName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.OfficeName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'Currency',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.Currency.title|translate:vc.viewState.QV_QURAR0892_86.column.Currency.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.Currency.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.Currency.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922MNEY72.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.Currency.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_WRRNTSEACH8506_MNEY069.get(dataItem.Currency).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.Currency.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.Currency.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.Currency.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'CurrentValue',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.CurrentValue.title|translate:vc.viewState.QV_QURAR0892_86.column.CurrentValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.CurrentValue.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.CurrentValue.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922RREN32.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.CurrentValue.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.CurrentValue, \"QV_QURAR0892_86\", \"CurrentValue\"):kendo.toString(#=CurrentValue#, vc.viewState.QV_QURAR0892_86.column.CurrentValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.CurrentValue.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.CurrentValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.CurrentValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'InitialValue',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.InitialValue.title|translate:vc.viewState.QV_QURAR0892_86.column.InitialValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.InitialValue.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.InitialValue.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922TIAU84.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.InitialValue.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.InitialValue, \"QV_QURAR0892_86\", \"InitialValue\"):kendo.toString(#=InitialValue#, vc.viewState.QV_QURAR0892_86.column.InitialValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.InitialValue.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.InitialValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.InitialValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'ValueAvailable',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.ValueAvailable.title|translate:vc.viewState.QV_QURAR0892_86.column.ValueAvailable.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.ValueAvailable.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.ValueAvailable.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922VEAL99.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.ValueAvailable.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.ValueAvailable, \"QV_QURAR0892_86\", \"ValueAvailable\"):kendo.toString(#=ValueAvailable#, vc.viewState.QV_QURAR0892_86.column.ValueAvailable.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.ValueAvailable.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.ValueAvailable.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.ValueAvailable.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'AppraisedValueDate',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.title|translate:vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922REAE82.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.element[dataItem.uid].style'>#if (AppraisedValueDate !== null) {# #=AppraisedValueDate# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.AppraisedValueDate.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'ExpiredWarranty',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.title|translate:vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922XRRN27.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.element[dataItem.uid].style'>#if (ExpiredWarranty !== null) {# #=ExpiredWarranty# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.ExpiredWarranty.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'Status',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.Status.title|translate:vc.viewState.QV_QURAR0892_86.column.Status.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.Status.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.Status.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922SAUS53.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.Status.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_WRRNTSEACH8506_SAUS837.get(dataItem.Status).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.Status.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.Status.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.Status.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'UserCreation',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.UserCreation.title|translate:vc.viewState.QV_QURAR0892_86.column.UserCreation.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.UserCreation.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.UserCreation.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922UCIN94.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.UserCreation.element[dataItem.uid].style'>#if (UserCreation !== null) {# #=UserCreation# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.UserCreation.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.UserCreation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.UserCreation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QURAR0892_86.columns.push({
                    field: 'isHeritage',
                    title: '{{vc.viewState.QV_QURAR0892_86.column.isHeritage.title|translate:vc.viewState.QV_QURAR0892_86.column.isHeritage.titleArgs}}',
                    width: $scope.vc.viewState.QV_QURAR0892_86.column.isHeritage.width,
                    format: $scope.vc.viewState.QV_QURAR0892_86.column.isHeritage.format,
                    editor: $scope.vc.grids.QV_QURAR0892_86.AT_WAR922HETA72.control,
                    template: "<span ng-class='vc.viewState.QV_QURAR0892_86.column.isHeritage.element[dataItem.uid].style'>#if (isHeritage !== null) {# #=isHeritage# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QURAR0892_86.column.isHeritage.style",
                        "title": "{{vc.viewState.QV_QURAR0892_86.column.isHeritage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QURAR0892_86.column.isHeritage.hidden
                });
            }
            $scope.vc.viewState.QV_QURAR0892_86.toolbar = {}
            $scope.vc.grids.QV_QURAR0892_86.toolbar = [];
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_24_GURNH31_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_24_GURNH31_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Choose
            $scope.vc.createViewState({
                id: "CM_GURNH31OOS11",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CHOOSEPHQ_89411",
                label: "BUSIN.DLB_BUSIN_SELECIOAR_14656",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_WRRNTSEACH8506_MNEY069.read();
                    $scope.vc.catalogs.VA_WRRNTSEACH8506_SAUS837.read();
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
                $scope.vc.render('VC_GURNH31_OMREA_904');
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
    var cobisMainModule = cobis.createModule("VC_GURNH31_OMREA_904", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_GURNH31_OMREA_904", {
            templateUrl: "VC_GURNH31_OMREA_904_FORM.html",
            controller: "VC_GURNH31_OMREA_904_CTRL",
            labelId: "BUSIN.LBL_BUSIN_BSQUEDAGG_65083",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GURNH31_OMREA_904?" + $.param(search);
            }
        });
        VC_GURNH31_OMREA_904(cobisMainModule);
    }]);
} else {
    VC_GURNH31_OMREA_904(cobisMainModule);
}