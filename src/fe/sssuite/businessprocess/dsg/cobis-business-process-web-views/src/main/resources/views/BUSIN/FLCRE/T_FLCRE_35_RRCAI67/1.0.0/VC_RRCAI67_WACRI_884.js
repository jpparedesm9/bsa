//Designer Generator v 6.1.1 - release SPR 2017-03 17/02/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.warrantiescreation = designerEvents.api.warrantiescreation || designer.dsgEvents();

function VC_RRCAI67_WACRI_884(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_RRCAI67_WACRI_884_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_RRCAI67_WACRI_884_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout",

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
            taskId: "T_FLCRE_35_RRCAI67",
            taskVersion: "1.0.0",
            viewContainerId: "VC_RRCAI67_WACRI_884",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/BUSIN/FLCRE/T_FLCRE_35_RRCAI67",
        designerEvents.api.warrantiescreation,
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
                vcName: 'VC_RRCAI67_WACRI_884'
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
                    taskId: 'T_FLCRE_35_RRCAI67',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CustomerSearch: "CustomerSearch",
                    WarrantyGeneral: "WarrantyGeneral",
                    WarrantySituation: "WarrantySituation",
                    WarrantyLocation: "WarrantyLocation",
                    WarrantyPoliciy: "WarrantyPoliciy",
                    WarrantyDescription: "WarrantyDescription",
                    SharedWarrantyInfo: "SharedWarrantyInfo",
                    SharedEntityWarranty: "SharedEntityWarranty"
                },
                entities: {
                    CustomerSearch: {
                        identificationType: 'AT19_IDENTIIE765',
                        warrantyType: 'AT45_WARRANPT765',
                        identification: 'AT77_IDENTINO765',
                        FlagCriteria: 'AT_CTM765CRTA11',
                        Customer: 'AT_CTM765CSER32',
                        CustomerId: 'AT_CTM765CTRD40',
                        TypeObject: 'AT_CTM765EBCT18',
                        OfficerId: 'AT_CTM765FCED82',
                        Flagexit: 'AT_CTM765LGET20',
                        Officer: 'AT_CTM765OFIE85',
                        Principal: 'AT_CTM765PRIL69',
                        Expromission: 'AT_CTM765RMII18',
                        Sector: 'AT_CTM765SCTR12',
                        TypeOperation: 'AT_CTM765TETI67',
                        TypeProcess: 'AT_CTM765TPOE49',
                        _pks: [],
                        _entityId: 'EN_CTMERSEAR765',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarrantyGeneral: {
                        accountAho: 'AT34_ACCOUNTH527',
                        guarantortype: 'AT49_GUARANTO527',
                        balanceAvailable: 'AT79_BALANCIL527',
                        suitability: 'AT82_SUITABIT527',
                        appraisalValue: 'AT_ARA527AIUE66',
                        branchOffice: 'AT_ARA527BRNC47',
                        code: 'AT_ARA527CODE39',
                        coverage: 'AT_ARA527CVER40',
                        admissionDate: 'AT_ARA527DONA32',
                        fixedTermAmount: 'AT_ARA527DRMA89',
                        valueSource: 'AT_ARA527ESOE58',
                        externalCode: 'AT_ARA527EXTE36',
                        office: 'AT_ARA527FICE71',
                        filial: 'AT_ARA527FILL12',
                        fixedTerm: 'AT_ARA527IDER64',
                        initialValue: 'AT_ARA527ILAE17',
                        instruction: 'AT_ARA527INRT24',
                        currency: 'AT_ARA527MONY07',
                        mandatoryDocument: 'AT_ARA527NORM65',
                        warrantyType: 'AT_ARA527NTYY17',
                        currentValue: 'AT_ARA527NVLE38',
                        documentNumber: 'AT_ARA527OEBE33',
                        constitutionDate: 'AT_ARA527OSUI69',
                        percentageCoverage: 'AT_ARA527RAGO02',
                        guarantor: 'AT_ARA527RNTR34',
                        description: 'AT_ARA527RTIO86',
                        status: 'AT_ARA527STTU29',
                        tramitNumber: 'AT_ARA527TRMB60',
                        appraisalDate: 'AT_ARA527VADT05',
                        owner: 'AT_ARA527WNER42',
                        _pks: [],
                        _entityId: 'EN_ARANYGENL527',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarrantySituation: {
                        amount: 'AT15_AMOUNTBB414',
                        legalStatus: 'AT24_LEGALSSA414',
                        commercialOrIndustry: 'AT33_COMMERYN414',
                        lastValuation: 'AT41_LASTVAAU414',
                        admissibility: 'AT42_ADMISSIY414',
                        sinister: 'AT45_SINISTEE414',
                        expirationControl: 'AT46_EXPIRACL414',
                        instruction: 'AT48_INSTRUON414',
                        depletive: 'AT50_DEPLETIV414',
                        expiration: 'AT71_EXPIRAOT414',
                        penalty: 'AT89_PENALTYY414',
                        constitution: 'AT91_CONSTITU414',
                        classWarranty: 'AT_WAN414CLAS83',
                        legalSufficiency: 'AT_WAN414ELCY82',
                        guaranteeFund: 'AT_WAN414GAEP94',
                        inspectType: 'AT_WAN414IPTE19',
                        judicialCollectionType: 'AT_WAN414JILL44',
                        returnDate: 'AT_WAN414NDTE59',
                        inspectReason: 'AT_WAN414NSPC91',
                        totalInitialValue: 'AT_WAN414NTLL52',
                        periodicity: 'AT_WAN414RDII95',
                        suitable: 'AT_WAN414SUIE31',
                        retirementDate: 'AT_WAN414TEAE97',
                        sharedType: 'AT_WAN414TYPE06',
                        _pks: [],
                        _entityId: 'EN_WANTYSTTO414',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarrantyLocation: {
                        addressDescription: 'AT10_ADDRESRC270',
                        accountingOffice: 'AT47_ACCOUNFI270',
                        documentLocation: 'AT50_DOCUMENO270',
                        documentCity: 'AT55_DOCUMENY270',
                        licenseNumber: 'AT59_LICENSRM270',
                        warrantyCity: 'AT88_WARRANIT270',
                        licenseDateExpiration: 'AT96_LICENSOO270',
                        address: 'AT_WAR270ADDE81',
                        city: 'AT_WAR270CITY71',
                        parish: 'AT_WAR270PARI91',
                        phone: 'AT_WAR270PHON02',
                        repository: 'AT_WAR270POTR53',
                        province: 'AT_WAR270RVNE46',
                        storeKeeper: 'AT_WAR270SOER62',
                        _pks: [],
                        _entityId: 'EN_WARRLOCTN270',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarrantyPoliciy: {
                        numberPolicy: 'AT_WRA629UEIC78',
                        insurance: 'AT_WRA629NSNE69',
                        type: 'AT_WRA629TYPE21',
                        description: 'AT_WRA629ERII42',
                        effectiveDate: 'AT_WRA629FTVD85',
                        effectiveDateEnd: 'AT_WRA629FCVN12',
                        endorsementDate: 'AT_WRA629EDRT46',
                        endorsementDateEnd: 'AT_WRA629REMN20',
                        coin: 'AT_WRA629COIN39',
                        policyValue: 'AT_WRA629POLI06',
                        endorsementValue: 'AT_WRA629DSTL03',
                        state: 'AT_WRA629STTE04',
                        custody: 'AT_WRA629CSTD36',
                        branchOffice: 'AT_WRA629AHOI94',
                        custodyType: 'AT_WRA629CUSD60',
                        externalCode: 'AT_WRA629RNAO54',
                        isNew: 'AT_WRA629ISNE61',
                        insuranceDescription: 'AT_WRA629EERN75',
                        _pks: [],
                        _entityId: 'EN_WRANTYPIY629',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    WarrantyDescription: {
                        reason: 'AT24_REASONXG906',
                        periodicity: 'AT48_PERIODTT906',
                        controlVisit: 'AT51_CONTROII906',
                        description: 'AT84_DESCRIIP906',
                        _pks: [],
                        _entityId: 'EN_WARRANTEI_906',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    SharedWarrantyInfo: {
                        shared: 'AT32_SHAREDFV168',
                        _pks: [],
                        _entityId: 'EN_SHAREDWRR_168',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    SharedEntityWarranty: {
                        sharedPercentage: 'AT12_SHAREDEN638',
                        date: 'AT20_DATEMSEI638',
                        value: 'AT45_AMOUNTGP638',
                        corporation: 'AT57_CORPORAO638',
                        bookValue: 'AT71_BOOKVALL638',
                        nameEntity: 'AT74_NAMEAWMV638',
                        valueComercial: 'AT78_VALUECOR638',
                        entity: 'AT91_WZDDWDEX638',
                        _pks: [],
                        _entityId: 'EN_SHAREDWRR_638',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_ERWRLCIE_4097 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_ERWRLCIE_4097 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_ERWRLCIE_4097_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_ERWRLCIE_4097_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_WRANTYPIY629',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_ERWRLCIE_4097',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_ERWRLCIE_4097_filters = {};
            $scope.vc.queryProperties.Q_SHAREDTR_2783 = {
                autoCrud: true
            };
            $scope.vc.getRequestQuery_Q_SHAREDTR_2783 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_SHAREDTR_2783_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_SHAREDTR_2783_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SHAREDWRR_638',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_SHAREDTR_2783',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_SHAREDTR_2783_filters = {};
            $scope.vc.queryProperties.Q_QRYLIENT_5474 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_QRYLIENT_5474 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_QRYLIENT_5474_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_QRYLIENT_5474_filters;
                    parametersAux = {};
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_CTMERSEAR765',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_QRYLIENT_5474',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        this.parameters = {};
                    }
                }
            };
            $scope.vc.queries.Q_QRYLIENT_5474_filters = {};
            var defaultValues = {
                CustomerSearch: {},
                WarrantyGeneral: {},
                WarrantySituation: {},
                WarrantyLocation: {},
                WarrantyPoliciy: {},
                WarrantyDescription: {},
                SharedWarrantyInfo: {},
                SharedEntityWarranty: {}
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
                $scope.vc.execute("temporarySave", VC_RRCAI67_WACRI_884, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_RRCAI67_WACRI_884, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_RRCAI67_WACRI_884, data, function() {});
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
            $scope.vc.viewState.VC_RRCAI67_WACRI_884 = {
                style: []
            }
            //ViewState - Container: warrantiesCreation
            $scope.vc.createViewState({
                id: "VC_RRCAI67_WACRI_884",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GARANTASQ_18496",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: warrantiesCreation
            $scope.vc.createViewState({
                id: "VC_HQDJAJMFVI_195I67",
                hasId: true,
                componentStyle: [],
                label: 'warrantiesCreation',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: F_warrantiesCreation
            $scope.vc.createViewState({
                id: "VC_RRCAI67_RENRA_706",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GENERALZG_27069",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Warranties
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_08",
                hasId: true,
                componentStyle: [],
                label: 'Warranties',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: ButtonGroup
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_17",
                hasId: true,
                componentStyle: [],
                label: 'ButtonGroup',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0717_0000605",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Warranties Tabs]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_05",
                hasId: true,
                componentStyle: [],
                label: '[Warranties Tabs]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [General]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_58",
                hasId: true,
                componentStyle: [],
                label: '[General]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_16",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CLIENTESS_73230",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.CustomerSearch = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    CustomerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "CustomerId", 0)
                    },
                    Customer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "Customer", '')
                    },
                    OfficerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "OfficerId", 0)
                    },
                    Officer: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "Officer", '')
                    },
                    warrantyType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "warrantyType", ''),
                        validation: {
                            warrantyTypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    identificationType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "identificationType", '')
                    },
                    identification: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("CustomerSearch", "identification", '')
                    }
                }
            });
            $scope.vc.model.CustomerSearch = new kendo.data.DataSource({
                pageSize: 5,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_QRYLIENT_5474';
                            var queryRequest = $scope.vc.getRequestQuery_Q_QRYLIENT_5474();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_QRYLI5474_83',
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'CustomerSearch',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QRYLI5474_83', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                            } else {
                                options.error(args.rowData);
                            }
                        });
                        // end block
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'CustomerSearch',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_QRYLI5474_83', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                    model: $scope.vc.types.CustomerSearch
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_QRYLI5474_83").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_QRYLIENT_5474 = $scope.vc.model.CustomerSearch;
            $scope.vc.trackers.CustomerSearch = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.CustomerSearch);
            $scope.vc.model.CustomerSearch.bind('change', function(e) {
                $scope.vc.trackers.CustomerSearch.track(e);
            });
            $scope.vc.grids.QV_QRYLI5474_83 = {};
            $scope.vc.grids.QV_QRYLI5474_83.queryId = 'Q_QRYLIENT_5474';
            $scope.vc.viewState.QV_QRYLI5474_83 = {
                style: undefined
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column = {};
            $scope.vc.grids.QV_QRYLI5474_83.editable = {
                mode: $scope.vc.viewState.GR_ARANSCATIO07_16.disabled ? false : 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_QRYLI5474_83.events = {
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
                    $scope.vc.trackers.CustomerSearch.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_QRYLI5474_83.selectedRow = e.model;
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
                    //this block of code only appears if the grid has set a BeforeEnterInLineRow
                    var args = {
                        nameEntityGrid: 'CustomerSearch',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_QRYLI5474_83", args, function() {
                        if (args.cancel) {
                            $("#QV_QRYLI5474_83").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_QRYLI5474_83");
                    $scope.vc.hideShowColumns("QV_QRYLI5474_83", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_QRYLI5474_83.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_QRYLI5474_83.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_QRYLI5474_83.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_QRYLI5474_83 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_QRYLI5474_83 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_QRYLI5474_83.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_QRYLI5474_83.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_QRYLI5474_83.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "CustomerSearch",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_QRYLI5474_83", args);
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
            $scope.vc.grids.QV_QRYLI5474_83.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_QRYLI5474_83.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_QRYLI5474_83.column.CustomerId = {
                title: 'BUSIN.DLB_BUSIN_CGODECLTE_92528',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "########",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ARANSCATIO0716_CTRD364',
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765CTRD40 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.CustomerId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_ARANSCATIO0716_CTRD364",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.CustomerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYLI5474_83.column.CustomerId.format",
                        'k-decimals': "vc.viewState.QV_QRYLI5474_83.column.CustomerId.decimals",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'ng-class': "vc.viewState.QV_QRYLI5474_83.column.CustomerId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column.Customer = {
                title: 'BUSIN.LBL_BUSIN_NOMBREWCB_98365',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ARANSCATIO0716_CSER244',
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765CSER32 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.Customer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_ARANSCATIO0716_CSER244",
                        'maxlength': 250,
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.Customer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'ng-class': "vc.viewState.QV_QRYLI5474_83.column.Customer.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column.OfficerId = {
                title: 'BUSIN.LBL_BUSIN_CDIGODELL_96628',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ARANSCATIO0716_FCED022',
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765FCED82 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.OfficerId.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_ARANSCATIO0716_FCED022",
                        'maxlength': 50,
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.OfficerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_QRYLI5474_83.column.OfficerId.format",
                        'k-decimals': "vc.viewState.QV_QRYLI5474_83.column.OfficerId.decimals",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'ng-class': "vc.viewState.QV_QRYLI5474_83.column.OfficerId.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column.Officer = {
                title: 'BUSIN.LBL_BUSIN_NOMBERDFA_71078',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_ARANSCATIO0716_OFIE095',
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765OFIE85 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.Officer.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_ARANSCATIO0716_OFIE095",
                        'maxlength': 250,
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.Officer.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'ng-class': "vc.viewState.QV_QRYLI5474_83.column.Officer.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column.warrantyType = {
                title: 'BUSIN.LBL_BUSIN_TIPOGARNE_99251',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXQNJ_419_16',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQNJ_419_16 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXQNJ_419_16',
                            'cu_tipo_garante',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQNJ_419_16'];
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
            $scope.vc.grids.QV_QRYLI5474_83.AT45_WARRANPT765 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.warrantyType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQNJ_419_16",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_QRYLI5474_83.column.warrantyType.element["' + options.model.uid + '"].style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXQNJ_419_16",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_QRYLI5474_83.column.warrantyType.template",
                        'required': '',
                        'data-required-msg': $filter('translate')('BUSIN.LBL_BUSIN_TIPOGARNE_99251') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.warrantyType.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'dsgrequired': "",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'placeholder': "vc.getPlaceHolder()",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column.identificationType = {
                title: 'BUSIN.LBL_BUSIN_TIPODEDOE_45902',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXOAU_350_16',
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.AT19_IDENTIIE765 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.identificationType.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOAU_350_16",
                        'maxlength': 64,
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.identificationType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'ng-class': "vc.viewState.QV_QRYLI5474_83.column.identificationType.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column.identification = {
                title: 'BUSIN.LBL_BUSIN_IDENTIFCA_38355',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXNFV_989_16',
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.AT77_IDENTINO765 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_QRYLI5474_83.column.identification.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXNFV_989_16",
                        'maxlength': 30,
                        'data-validation-code': "{{vc.viewState.QV_QRYLI5474_83.column.identification.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'data-cobis-group': "GroupLayout,GR_ARANSCATIO07_58,0",
                        'ng-class': "vc.viewState.QV_QRYLI5474_83.column.identification.element['" + options.model.uid + "'].style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'CustomerId',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.CustomerId.title|translate:vc.viewState.QV_QRYLI5474_83.column.CustomerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.CustomerId.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.CustomerId.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765CTRD40.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.CustomerId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.CustomerId, \"QV_QRYLI5474_83\", \"CustomerId\"):kendo.toString(#=CustomerId#, vc.viewState.QV_QRYLI5474_83.column.CustomerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.CustomerId.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.CustomerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.CustomerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'Customer',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.Customer.title|translate:vc.viewState.QV_QRYLI5474_83.column.Customer.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.Customer.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.Customer.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765CSER32.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.Customer.element[dataItem.uid].style'>#if (Customer !== null) {# #=Customer# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.Customer.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.Customer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.Customer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'OfficerId',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.OfficerId.title|translate:vc.viewState.QV_QRYLI5474_83.column.OfficerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.OfficerId.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.OfficerId.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765FCED82.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.OfficerId.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.OfficerId, \"QV_QRYLI5474_83\", \"OfficerId\"):kendo.toString(#=OfficerId#, vc.viewState.QV_QRYLI5474_83.column.OfficerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.OfficerId.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.OfficerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.OfficerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'Officer',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.Officer.title|translate:vc.viewState.QV_QRYLI5474_83.column.Officer.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.Officer.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.Officer.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT_CTM765OFIE85.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.Officer.element[dataItem.uid].style'>#if (Officer !== null) {# #=Officer# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.Officer.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.Officer.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.Officer.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'warrantyType',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.warrantyType.title|translate:vc.viewState.QV_QRYLI5474_83.column.warrantyType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.warrantyType.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.warrantyType.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT45_WARRANPT765.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.warrantyType.element[dataItem.uid].style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQNJ_419_16.get(dataItem.warrantyType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.warrantyType.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.warrantyType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.warrantyType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'identificationType',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.identificationType.title|translate:vc.viewState.QV_QRYLI5474_83.column.identificationType.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.identificationType.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.identificationType.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT19_IDENTIIE765.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.identificationType.element[dataItem.uid].style'>#if (identificationType !== null) {# #=identificationType# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.identificationType.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.identificationType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.identificationType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                    field: 'identification',
                    title: '{{vc.viewState.QV_QRYLI5474_83.column.identification.title|translate:vc.viewState.QV_QRYLI5474_83.column.identification.titleArgs}}',
                    width: $scope.vc.viewState.QV_QRYLI5474_83.column.identification.width,
                    format: $scope.vc.viewState.QV_QRYLI5474_83.column.identification.format,
                    editor: $scope.vc.grids.QV_QRYLI5474_83.AT77_IDENTINO765.control,
                    template: "<span ng-class='vc.viewState.QV_QRYLI5474_83.column.identification.element[dataItem.uid].style'>#if (identification !== null) {# #=identification# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_QRYLI5474_83.column.identification.style",
                        "title": "{{vc.viewState.QV_QRYLI5474_83.column.identification.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_QRYLI5474_83.column.identification.hidden
                });
            }
            $scope.vc.viewState.QV_QRYLI5474_83.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_QRYLI5474_83.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_QRYLI5474_83.columns.push({
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_QRYLI5474_83.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_QRYLI5474_83.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_QRYLI5474_83.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                },
                CEQV_201_QV_QRYLI5474_83_514: {
                    visible: true
                }
            }
            $scope.vc.grids.QV_QRYLI5474_83.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_QRYLI5474_83.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_ARANSCATIO07_16.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }, {
                "name": "CEQV_201_QV_QRYLI5474_83_514",
                "text": "{{'BUSIN.DLB_BUSIN_ELIMINARM_02558'|translate}}",
                "template": "<button id='CEQV_201_QV_QRYLI5474_83_514' ng-if='vc.viewState.QV_QRYLI5474_83.toolbar.CEQV_201_QV_QRYLI5474_83_514.visible' data-ng-click='vc.executeGridCommand(\"CEQV_201_QV_QRYLI5474_83_514\",\"CustomerSearch\")' class='btn btn-default cb-grid-button cb-btn-custom-gridcommand' title=\"{{'BUSIN.DLB_BUSIN_ELIMINARM_02558'|translate}}\"> #: text #</button>"
            }];
            $scope.vc.model.WarrantyGeneral = {
                accountAho: $scope.vc.channelDefaultValues("WarrantyGeneral", "accountAho"),
                guarantortype: $scope.vc.channelDefaultValues("WarrantyGeneral", "guarantortype"),
                balanceAvailable: $scope.vc.channelDefaultValues("WarrantyGeneral", "balanceAvailable"),
                suitability: $scope.vc.channelDefaultValues("WarrantyGeneral", "suitability"),
                appraisalValue: $scope.vc.channelDefaultValues("WarrantyGeneral", "appraisalValue"),
                branchOffice: $scope.vc.channelDefaultValues("WarrantyGeneral", "branchOffice"),
                code: $scope.vc.channelDefaultValues("WarrantyGeneral", "code"),
                coverage: $scope.vc.channelDefaultValues("WarrantyGeneral", "coverage"),
                admissionDate: $scope.vc.channelDefaultValues("WarrantyGeneral", "admissionDate"),
                fixedTermAmount: $scope.vc.channelDefaultValues("WarrantyGeneral", "fixedTermAmount"),
                valueSource: $scope.vc.channelDefaultValues("WarrantyGeneral", "valueSource"),
                externalCode: $scope.vc.channelDefaultValues("WarrantyGeneral", "externalCode"),
                office: $scope.vc.channelDefaultValues("WarrantyGeneral", "office"),
                filial: $scope.vc.channelDefaultValues("WarrantyGeneral", "filial"),
                fixedTerm: $scope.vc.channelDefaultValues("WarrantyGeneral", "fixedTerm"),
                initialValue: $scope.vc.channelDefaultValues("WarrantyGeneral", "initialValue"),
                instruction: $scope.vc.channelDefaultValues("WarrantyGeneral", "instruction"),
                currency: $scope.vc.channelDefaultValues("WarrantyGeneral", "currency"),
                mandatoryDocument: $scope.vc.channelDefaultValues("WarrantyGeneral", "mandatoryDocument"),
                warrantyType: $scope.vc.channelDefaultValues("WarrantyGeneral", "warrantyType"),
                currentValue: $scope.vc.channelDefaultValues("WarrantyGeneral", "currentValue"),
                documentNumber: $scope.vc.channelDefaultValues("WarrantyGeneral", "documentNumber"),
                constitutionDate: $scope.vc.channelDefaultValues("WarrantyGeneral", "constitutionDate"),
                percentageCoverage: $scope.vc.channelDefaultValues("WarrantyGeneral", "percentageCoverage"),
                guarantor: $scope.vc.channelDefaultValues("WarrantyGeneral", "guarantor"),
                description: $scope.vc.channelDefaultValues("WarrantyGeneral", "description"),
                status: $scope.vc.channelDefaultValues("WarrantyGeneral", "status"),
                tramitNumber: $scope.vc.channelDefaultValues("WarrantyGeneral", "tramitNumber"),
                appraisalDate: $scope.vc.channelDefaultValues("WarrantyGeneral", "appraisalDate"),
                owner: $scope.vc.channelDefaultValues("WarrantyGeneral", "owner")
            };
            //ViewState - Group: [Grupo sin nombre]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_09",
                hasId: true,
                componentStyle: [],
                label: '[Grupo sin nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: code
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_CODE053",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CIGEARNTA_66805",
                format: "##########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: externalCode
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_EXTE434",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CIGOETERN_54771",
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: documentNumber
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_OEBE980",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DOCUMENTO_76502",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: initialValue
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_ILAE518",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_VALRINICL_45750",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: currency
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_MONY430",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                label: "BUSIN.DLB_BUSIN_MONEDAWDW_15876",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0709_MONY430 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ARANSCATIO0709_MONY430', 'cl_moneda', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0709_MONY430'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0709_MONY430");
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
            //ViewState - Entity: WarrantyGeneral, Attribute: currentValue
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_NVLE498",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VALORACPT_26885",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.All,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: valueSource
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_ESOE640",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FUENTEVRA_34635",
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0709_ESOE640 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ARANSCATIO0709_ESOE640', 'cu_fuente_valor', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0709_ESOE640'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0709_ESOE640");
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
            //ViewState - Entity: WarrantyGeneral, Attribute: appraisalValue
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_AIUE963",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VALORCOEA_75782",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: appraisalDate
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_VADT830",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FHDEAVALO_98024",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: coverage
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_CVER937",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_COBERTURA_71496",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0709_CVER937 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0709_CVER937', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0709_CVER937'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0709_CVER937");
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
            //ViewState - Entity: WarrantyGeneral, Attribute: fixedTerm
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_IDER508",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PLAZOFIJO_08224",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: accountAho
            $scope.vc.createViewState({
                id: "VA_ACCOUNTAHOJMZWG_417O07",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CUENTADOR_68900",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: fixedTermAmount
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_DRMA851",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_MNIPONIBE_79299",
                label: "BUSIN.DLB_BUSIN_MNIPONIBE_79299",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: balanceAvailable
            $scope.vc.createViewState({
                id: "VA_BALANCEAVAILALL_926O07",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SALDODINL_75776",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: constitutionDate
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_OSUI766",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CONSTITUN_61833",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: guarantor
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_RNTR310",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GARANTESP_21525",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: guarantortype
            $scope.vc.createViewState({
                id: "VA_GUARANTORTYPEEE_866O07",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_TIPOGARNE_99251",
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GUARANTORTYPEEE_866O07 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GUARANTORTYPEEE_866O07', 'cu_tipo_garante', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GUARANTORTYPEEE_866O07'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GUARANTORTYPEEE_866O07");
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
            //ViewState - Entity: WarrantyGeneral, Attribute: suitability
            $scope.vc.createViewState({
                id: "VA_SUITABILITYBRTD_975O07",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_GRADOQRBK_95236",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SUITABILITYBRTD_975O07 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SUITABILITYBRTD_975O07', 'cu_grado_gtia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SUITABILITYBRTD_975O07'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SUITABILITYBRTD_975O07");
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
            //ViewState - Entity: WarrantyGeneral, Attribute: description
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_RTIO767",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DESCRIPCN_50497",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: WarrantyGeneral, Attribute: instruction
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0709_INRT049",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_INSTRUCIC_44129",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: F_classSituationView
            $scope.vc.createViewState({
                id: "VC_RRCAI67_GPUCN_030",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SITUACISE_11416",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Situacion - Clase]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_10",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SITUAIOLS_27898",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.WarrantySituation = {
                amount: $scope.vc.channelDefaultValues("WarrantySituation", "amount"),
                legalStatus: $scope.vc.channelDefaultValues("WarrantySituation", "legalStatus"),
                commercialOrIndustry: $scope.vc.channelDefaultValues("WarrantySituation", "commercialOrIndustry"),
                lastValuation: $scope.vc.channelDefaultValues("WarrantySituation", "lastValuation"),
                admissibility: $scope.vc.channelDefaultValues("WarrantySituation", "admissibility"),
                sinister: $scope.vc.channelDefaultValues("WarrantySituation", "sinister"),
                expirationControl: $scope.vc.channelDefaultValues("WarrantySituation", "expirationControl"),
                instruction: $scope.vc.channelDefaultValues("WarrantySituation", "instruction"),
                depletive: $scope.vc.channelDefaultValues("WarrantySituation", "depletive"),
                expiration: $scope.vc.channelDefaultValues("WarrantySituation", "expiration"),
                penalty: $scope.vc.channelDefaultValues("WarrantySituation", "penalty"),
                constitution: $scope.vc.channelDefaultValues("WarrantySituation", "constitution"),
                classWarranty: $scope.vc.channelDefaultValues("WarrantySituation", "classWarranty"),
                legalSufficiency: $scope.vc.channelDefaultValues("WarrantySituation", "legalSufficiency"),
                guaranteeFund: $scope.vc.channelDefaultValues("WarrantySituation", "guaranteeFund"),
                inspectType: $scope.vc.channelDefaultValues("WarrantySituation", "inspectType"),
                judicialCollectionType: $scope.vc.channelDefaultValues("WarrantySituation", "judicialCollectionType"),
                returnDate: $scope.vc.channelDefaultValues("WarrantySituation", "returnDate"),
                inspectReason: $scope.vc.channelDefaultValues("WarrantySituation", "inspectReason"),
                totalInitialValue: $scope.vc.channelDefaultValues("WarrantySituation", "totalInitialValue"),
                periodicity: $scope.vc.channelDefaultValues("WarrantySituation", "periodicity"),
                suitable: $scope.vc.channelDefaultValues("WarrantySituation", "suitable"),
                retirementDate: $scope.vc.channelDefaultValues("WarrantySituation", "retirementDate"),
                sharedType: $scope.vc.channelDefaultValues("WarrantySituation", "sharedType")
            };
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_14",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: WarrantySituation, Attribute: legalSufficiency
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0714_ELCY714",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_SUFIIELEG_03194",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.catalogs.VA_ARANSCATIO0714_ELCY714 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0714_ELCY714', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0714_ELCY714'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, null, 0);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_ARANSCATIO0714_ELCY714 !== "undefined") {}
            //ViewState - Entity: WarrantySituation, Attribute: suitable
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0714_SUIE758",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ADECUADAF_09602",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.catalogs.VA_ARANSCATIO0714_SUIE758 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0714_SUIE758', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0714_SUIE758'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, null, 0);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_ARANSCATIO0714_SUIE758 !== "undefined") {}
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_15",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: WarrantySituation, Attribute: sharedType
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_TYPE600",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_COMPRTIDA_49433",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: totalInitialValue
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_NTLL256",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_VALONIALT_85672",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: judicialCollectionType
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_JILL987",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_COBRANZDC_55301",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: retirementDate
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_TEAE147",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_FEHARETIO_40304",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: returnDate
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_NDTE308",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CHADVOLUN_05449",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: guaranteeFund
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_GAEP916",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FONDOGARN_50036",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: inspectType
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_IPTE389",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_NSPECCONA_97874",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: periodicity
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_RDII635",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PEDICIDAD_84211",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0715_RDII635 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ARANSCATIO0715_RDII635', 'cu_des_periodicidad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0715_RDII635'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0715_RDII635");
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
            //ViewState - Entity: WarrantySituation, Attribute: inspectReason
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0715_NSPC524",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MOTIVOMSN_14348",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0715_NSPC524 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ARANSCATIO0715_NSPC524', 'cu_motivo_noinspeccion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0715_NSPC524'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0715_NSPC524");
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
            //ViewState - Group: GroupLayout2194
            $scope.vc.createViewState({
                id: "G_CLASSSIIOO_535W85",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2194',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1120
            $scope.vc.createViewState({
                id: "G_CLASSSIAIA_336W85",
                hasId: true,
                componentStyle: [],
                label: 'Group1120',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: admissibility
            $scope.vc.createViewState({
                id: "VA_ADMISSIBILITYYY_351W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ADMISIBDI_24213",
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ADMISSIBILITYYY_351W85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_ADMISSIBILITYYY_351W85', 'cu_clase_custodia', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_ADMISSIBILITYYY_351W85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ADMISSIBILITYYY_351W85");
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
            //ViewState - Entity: WarrantySituation, Attribute: constitution
            $scope.vc.createViewState({
                id: "VA_CONSTITUTIONWGI_434W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FECHACOTI_66570",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: lastValuation
            $scope.vc.createViewState({
                id: "VA_LASTVALUATIONNN_406W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FECHALTOA_56815",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: expiration
            $scope.vc.createViewState({
                id: "VA_EXPIRATIONTLEAG_155W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FECHAVEIO_31529",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: legalStatus
            $scope.vc.createViewState({
                id: "VA_LEGALSTATUSXQXS_936W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_FECHAESTC_63775",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2169",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: instruction
            $scope.vc.createViewState({
                id: "VA_INSTRUCTIONCUCF_353W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_INSTRUCIC_44129",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2495
            $scope.vc.createViewState({
                id: "G_CLASSSIEWE_529W85",
                hasId: true,
                componentStyle: [],
                label: 'Group2495',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: classWarranty
            $scope.vc.createViewState({
                id: "VA_CLASSWARRANTYYY_283W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CARCTEREA_41329",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_CLASSWARRANTYYY_283W85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'A',
                            value: 'Abierta'
                        }, {
                            code: 'C',
                            value: 'Cerrada'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_CLASSWARRANTYYY_283W85 !== "undefined") {}
            //ViewState - Entity: WarrantySituation, Attribute: amount
            $scope.vc.createViewState({
                id: "VA_AMOUNTDTFTGPVCH_154W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CUANTATAS_45505",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_AMOUNTDTFTGPVCH_154W85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'D',
                            value: 'Determinada'
                        }, {
                            code: 'I',
                            value: 'Indeterminada'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_AMOUNTDTFTGPVCH_154W85 !== "undefined") {}
            //ViewState - Entity: WarrantySituation, Attribute: penalty
            $scope.vc.createViewState({
                id: "VA_PENALTYMOPKRWEK_852W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CASTIGADA_17000",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: depletive
            $scope.vc.createViewState({
                id: "VA_DEPLETIVEPEROPR_902W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_AGOTADATJ_50712",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: expirationControl
            $scope.vc.createViewState({
                id: "VA_EXPIRATIONCOLTN_883W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CONTROLEO_38150",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: commercialOrIndustry
            $scope.vc.createViewState({
                id: "VA_COMMERCIALORYIS_667W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ESTCOMELL_95422",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantySituation, Attribute: sinister
            $scope.vc.createViewState({
                id: "VA_SINISTERPHKURIC_776W85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_SINIESTRO_58444",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: F_localizationView
            $scope.vc.createViewState({
                id: "VC_RRCAI67_UOOME_567",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_LOCALIZAC_49335",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.WarrantyLocation = {
                addressDescription: $scope.vc.channelDefaultValues("WarrantyLocation", "addressDescription"),
                accountingOffice: $scope.vc.channelDefaultValues("WarrantyLocation", "accountingOffice"),
                documentLocation: $scope.vc.channelDefaultValues("WarrantyLocation", "documentLocation"),
                documentCity: $scope.vc.channelDefaultValues("WarrantyLocation", "documentCity"),
                licenseNumber: $scope.vc.channelDefaultValues("WarrantyLocation", "licenseNumber"),
                warrantyCity: $scope.vc.channelDefaultValues("WarrantyLocation", "warrantyCity"),
                licenseDateExpiration: $scope.vc.channelDefaultValues("WarrantyLocation", "licenseDateExpiration"),
                address: $scope.vc.channelDefaultValues("WarrantyLocation", "address"),
                city: $scope.vc.channelDefaultValues("WarrantyLocation", "city"),
                parish: $scope.vc.channelDefaultValues("WarrantyLocation", "parish"),
                phone: $scope.vc.channelDefaultValues("WarrantyLocation", "phone"),
                repository: $scope.vc.channelDefaultValues("WarrantyLocation", "repository"),
                province: $scope.vc.channelDefaultValues("WarrantyLocation", "province"),
                storeKeeper: $scope.vc.channelDefaultValues("WarrantyLocation", "storeKeeper")
            };
            //ViewState - Group: [Localizacion]
            $scope.vc.createViewState({
                id: "GR_ARANSCATIO07_11",
                hasId: true,
                componentStyle: [],
                label: '[Localizacion]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyLocation, Attribute: province
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0711_RVNE334",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_PROVINCEI_05002",
                label: "BUSIN.LBL_BUSIN_PROVINCAA_51289",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0711_RVNE334 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0711_RVNE334', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0711_RVNE334'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0711_RVNE334");
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
            //ViewState - Entity: WarrantyLocation, Attribute: city
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0711_CITY886",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_CANTONLBL_89836",
                label: "BUSIN.LBL_BUSIN_CANTNKMCE_70435",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0711_CITY886 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0711_CITY886', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0711_CITY886'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0711_CITY886");
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
            //ViewState - Entity: WarrantyLocation, Attribute: parish
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0711_PARI601",
                componentStyle: [],
                tooltip: "BUSIN.DLB_BUSIN_PARROQUIA_17731",
                label: "BUSIN.DLB_BUSIN_PARROQUIA_17731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0711_PARI601 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0711_PARI601', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0711_PARI601'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0711_PARI601");
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
            //ViewState - Entity: WarrantyLocation, Attribute: documentLocation
            $scope.vc.createViewState({
                id: "VA_DOCUMENTLOCAIIN_297E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_UBICACIDD_45591",
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTLOCAIIN_297E85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_DOCUMENTLOCAIIN_297E85', 'cu_ubicacion_doc', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTLOCAIIN_297E85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTLOCAIIN_297E85");
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
            //ViewState - Entity: WarrantyLocation, Attribute: documentCity
            $scope.vc.createViewState({
                id: "VA_DOCUMENTCITYYOL_507E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CIUDADDEO_74007",
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTCITYYOL_507E85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_DOCUMENTCITYYOL_507E85', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTCITYYOL_507E85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTCITYYOL_507E85");
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
            //ViewState - Entity: WarrantyLocation, Attribute: warrantyCity
            $scope.vc.createViewState({
                id: "VA_WARRANTYCITYHRC_437E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_CIUDADGTN_34921",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_WARRANTYCITYHRC_437E85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_WARRANTYCITYHRC_437E85', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_WARRANTYCITYHRC_437E85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_WARRANTYCITYHRC_437E85");
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
            //ViewState - Entity: WarrantyLocation, Attribute: accountingOffice
            $scope.vc.createViewState({
                id: "VA_ACCOUNTINGOFEIE_892E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_OFICINAOB_84775",
                validationCode: 32,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ACCOUNTINGOFEIE_892E85 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ACCOUNTINGOFEIE_892E85', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ACCOUNTINGOFEIE_892E85'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ACCOUNTINGOFEIE_892E85");
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
            //ViewState - Entity: WarrantyLocation, Attribute: address
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0711_ADDE588",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DIRECCINR_88355",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyLocation, Attribute: phone
            $scope.vc.createViewState({
                id: "VA_PHONEQGOOWRFNPX_974E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_TELFONOYK_91968",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyLocation, Attribute: storeKeeper
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0711_SOER604",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ALMACNDDT_73035",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_ARANSCATIO0711_SOER604 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_ARANSCATIO0711_SOER604', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_ARANSCATIO0711_SOER604'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_ARANSCATIO0711_SOER604");
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
            $scope.vc.createViewState({
                id: "VA_VASEPARATORUDOU_774E85",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyLocation, Attribute: repository
            $scope.vc.createViewState({
                id: "VA_ARANSCATIO0711_POTR327",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DEPOSIAIO_08984",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyLocation, Attribute: licenseNumber
            $scope.vc.createViewState({
                id: "VA_LICENSENUMBERRR_482E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_LICENCIOA_40219",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyLocation, Attribute: licenseDateExpiration
            $scope.vc.createViewState({
                id: "VA_LICENSEDATEEIIR_288E85",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VENCIMICC_73160",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: F_aditionalDataRenderWarantiesView
            $scope.vc.createViewState({
                id: "VC_RRCAI67_GUSME_893",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_ADICIONAL_77324",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GeneralGrp
            $scope.vc.createViewState({
                id: "GR_ITAEDEARVE21_02",
                hasId: true,
                componentStyle: [],
                label: 'GeneralGrp',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: RenderGrp
            $scope.vc.createViewState({
                id: "GR_ITAEDEARVE21_03",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'RenderGrp',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "GR_ITAEDEARVE21_03-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: F_WarrantyPolicies
            $scope.vc.createViewState({
                id: "VC_RRCAI67_GUPOB_764",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PLIZASYSD_39259",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: [Grupo Sin Nombre]
            $scope.vc.createViewState({
                id: "GR_WARAPLICIY67_02",
                hasId: true,
                componentStyle: [],
                label: '[Grupo Sin Nombre]',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.WarrantyPoliciy = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    numberPolicy: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarrantyPoliciy", "numberPolicy", ''),
                        validation: {
                            numberPolicyRegularExpression: function(input) {
                                return regularExpression(input);
                            }
                        }
                    },
                    insurance: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarrantyPoliciy", "insurance", '')
                    },
                    insuranceDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("WarrantyPoliciy", "insuranceDescription", '')
                    }
                }
            });
            $scope.vc.model.WarrantyPoliciy = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_ERWRLCIE_4097';
                            var queryRequest = $scope.vc.getRequestQuery_Q_ERWRLCIE_4097();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_ERWRL4097_89',
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
                                            'allowPaging': false,
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'WarrantyPoliciy',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_ERWRL4097_89', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
                            if (!args.cancel) {
                                options.success(args.row);
                            } else {
                                options.error(new Error('DeletingError'));
                            }
                        });
                        // end block
                    }
                },
                schema: {
                    model: $scope.vc.types.WarrantyPoliciy
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_ERWRL4097_89").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_ERWRLCIE_4097 = $scope.vc.model.WarrantyPoliciy;
            $scope.vc.trackers.WarrantyPoliciy = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.WarrantyPoliciy);
            $scope.vc.model.WarrantyPoliciy.bind('change', function(e) {
                $scope.vc.trackers.WarrantyPoliciy.track(e);
            });
            $scope.vc.grids.QV_ERWRL4097_89 = {};
            $scope.vc.grids.QV_ERWRL4097_89.queryId = 'Q_ERWRLCIE_4097';
            $scope.vc.viewState.QV_ERWRL4097_89 = {
                style: undefined
            };
            $scope.vc.viewState.QV_ERWRL4097_89.column = {};
            $scope.vc.grids.QV_ERWRL4097_89.editable = {
                mode: 'inline',
                confirmation: true
            };
            $scope.vc.grids.QV_ERWRL4097_89.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.WarrantyPoliciy(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "BUSIN",
                        subModuleId: "FLCRE",
                        taskId: "T_FLCRE_76_CRNTO32",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_CRNTO32_RRNYM_717',
                        title: 'BUSIN.DLB_BUSIN_POLICYXKX_68098',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_ERWRL4097_89", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                    $scope.vc.grids.QV_ERWRL4097_89.selectedRow = dataItem;
                    var rowIndex = grid.dataSource.indexOf(dataItem);
                    var row = grid.tbody.find(">tr:not(.k-grouping-row)").eq(rowIndex);
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem),
                        isNew: false,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "BUSIN",
                        subModuleId: "FLCRE",
                        taskId: "T_FLCRE_76_CRNTO32",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_CRNTO32_RRNYM_717',
                        title: 'BUSIN.DLB_BUSIN_POLICYXKX_68098',
                        size: 'lg'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_ERWRL4097_89", dialogParameters);
                },
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_ERWRL4097_89");
                    $scope.vc.hideShowColumns("QV_ERWRL4097_89", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_ERWRL4097_89.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_ERWRL4097_89.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_ERWRL4097_89.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_ERWRL4097_89 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_ERWRL4097_89 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                    if (angular.isDefined(this.options) && this.options.selectable && angular.isDefined($scope.vc.grids.QV_ERWRL4097_89.selectedRow)) {
                        $('[data-uid=' + $scope.vc.grids.QV_ERWRL4097_89.selectedRow.uid + ']').addClass("k-state-selected");
                    }
                },
                change: function(e) {
                    var grid = this;
                    var dataItem = grid.dataItem($(this.select()[0]));
                    if (this.select().length == 0 || this.select()[0].className.indexOf("k-grid-edit-row") < 0) {
                        $scope.vc.grids.QV_ERWRL4097_89.selectedItem = dataItem;
                        var args = {
                            nameEntityGrid: "WarrantyPoliciy",
                            rowData: dataItem,
                            rowIndex: grid.dataSource.indexOf(dataItem)
                        };
                        $scope.vc.gridRowSelecting("QV_ERWRL4097_89", args);
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
            $scope.vc.grids.QV_ERWRL4097_89.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_ERWRL4097_89.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_ERWRL4097_89.column.numberPolicy = {
                title: 'BUSIN.DLB_BUSIN_OLCYNUMBE_44906',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 1,
                componentId: 'VA_WARAPLICIY6702_UEIC089',
                element: []
            };
            $scope.vc.viewState.QV_ERWRL4097_89.column.insurance = {
                title: 'BUSIN.DLB_BUSIN_AGRORCDGO_54252',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WARAPLICIY6702_NSNE315',
                element: []
            };
            $scope.vc.viewState.QV_ERWRL4097_89.column.insuranceDescription = {
                title: 'BUSIN.DLB_BUSIN_ASEGURAOA_80576',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_WARAPLICIY6702_EERN636',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERWRL4097_89.columns.push({
                    field: 'numberPolicy',
                    title: '{{vc.viewState.QV_ERWRL4097_89.column.numberPolicy.title|translate:vc.viewState.QV_ERWRL4097_89.column.numberPolicy.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERWRL4097_89.column.numberPolicy.width,
                    format: $scope.vc.viewState.QV_ERWRL4097_89.column.numberPolicy.format,
                    template: "<span ng-class='vc.viewState.QV_ERWRL4097_89.column.numberPolicy.element[dataItem.uid].style'>#if (numberPolicy !== null) {# #=numberPolicy# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERWRL4097_89.column.numberPolicy.style",
                        "title": "{{vc.viewState.QV_ERWRL4097_89.column.numberPolicy.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERWRL4097_89.column.numberPolicy.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERWRL4097_89.columns.push({
                    field: 'insurance',
                    title: '{{vc.viewState.QV_ERWRL4097_89.column.insurance.title|translate:vc.viewState.QV_ERWRL4097_89.column.insurance.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERWRL4097_89.column.insurance.width,
                    format: $scope.vc.viewState.QV_ERWRL4097_89.column.insurance.format,
                    template: "<span ng-class='vc.viewState.QV_ERWRL4097_89.column.insurance.element[dataItem.uid].style'>#if (insurance !== null) {# #=insurance# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERWRL4097_89.column.insurance.style",
                        "title": "{{vc.viewState.QV_ERWRL4097_89.column.insurance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERWRL4097_89.column.insurance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_ERWRL4097_89.columns.push({
                    field: 'insuranceDescription',
                    title: '{{vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.title|translate:vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.width,
                    format: $scope.vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.format,
                    template: "<span ng-class='vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.element[dataItem.uid].style'>#if (insuranceDescription !== null) {# #=insuranceDescription# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.style",
                        "title": "{{vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_ERWRL4097_89.column.insuranceDescription.hidden
                });
            }
            $scope.vc.viewState.QV_ERWRL4097_89.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_ERWRL4097_89.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_ERWRL4097_89.columns.push({
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "WarrantyPoliciy",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_ERWRL4097_89.column.edit.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.GR_WARAPLICIY67_02.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_ERWRL4097_89.events.customEdit($event, \"#:entity#\", grids.QV_ERWRL4097_89)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_ERWRL4097_89.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_ERWRL4097_89.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_ERWRL4097_89.toolbar = [{
                "name": "create",
                "entity": "WarrantyPoliciy",
                "text": "",
                "template": "<button id = 'QV_ERWRL4097_89_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_ERWRL4097_89.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.GR_WARAPLICIY67_02.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_ERWRL4097_89.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }]; //ViewState - Container: WarrantyDescription
            $scope.vc.createViewState({
                id: "VC_WNDFAMBCWI_314855",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DESCRIPCN_50497",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1204
            $scope.vc.createViewState({
                id: "G_WARRANTSRR_447235",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1204',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.WarrantyDescription = {
                reason: $scope.vc.channelDefaultValues("WarrantyDescription", "reason"),
                periodicity: $scope.vc.channelDefaultValues("WarrantyDescription", "periodicity"),
                controlVisit: $scope.vc.channelDefaultValues("WarrantyDescription", "controlVisit"),
                description: $scope.vc.channelDefaultValues("WarrantyDescription", "description")
            };
            //ViewState - Group: Group1837
            $scope.vc.createViewState({
                id: "G_WARRANTPYR_201235",
                hasId: true,
                componentStyle: [],
                label: 'Group1837',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyDescription, Attribute: description
            $scope.vc.createViewState({
                id: "VA_DESCRIPTIONKCCH_290235",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_DESCRIPCN_50497",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: WarrantyDescription, Attribute: controlVisit
            $scope.vc.createViewState({
                id: "VA_CONTROLVISITCWN_191235",
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_VISITADNO_94817",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.catalogs.VA_CONTROLVISITCWN_191235 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'Si'
                        }, {
                            code: 'N',
                            value: 'No'
                        }]);
                    }
                },
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            if (typeof $scope.vc.catalogs.VA_CONTROLVISITCWN_191235 !== "undefined") {}
            //ViewState - Entity: WarrantyDescription, Attribute: periodicity
            $scope.vc.createViewState({
                id: "VA_PERIODICITYETNZ_810235",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_PEDICIDAD_84211",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_PERIODICITYETNZ_810235 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_PERIODICITYETNZ_810235', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_PERIODICITYETNZ_810235'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_PERIODICITYETNZ_810235");
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
            //ViewState - Entity: WarrantyDescription, Attribute: reason
            $scope.vc.createViewState({
                id: "VA_REASONQIMDHESAS_983235",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_MOTIVOMSN_14348",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_REASONQIMDHESAS_983235 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_REASONQIMDHESAS_983235', 'cu_motivo_noinspeccion', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_REASONQIMDHESAS_983235'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_REASONQIMDHESAS_983235");
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
            //ViewState - Container: SharedWarranty
            $scope.vc.createViewState({
                id: "VC_IOVWUHLHCJ_667170",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_COMPRTIDA_49433",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1259
            $scope.vc.createViewState({
                id: "G_SHAREDWTAN_711230",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1259',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.SharedWarrantyInfo = {
                shared: $scope.vc.channelDefaultValues("SharedWarrantyInfo", "shared")
            };
            //ViewState - Group: Group1977
            $scope.vc.createViewState({
                id: "G_SHAREDWATA_563230",
                hasId: true,
                componentStyle: [],
                label: 'Group1977',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: SharedWarrantyInfo, Attribute: shared
            $scope.vc.createViewState({
                id: "VA_8733SGHHBCGPQMZ_918230",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_COMPRTIDA_49433",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "Spacer1417",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout2135
            $scope.vc.createViewState({
                id: "G_SHAREDWARR_952230",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2135',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2768
            $scope.vc.createViewState({
                id: "G_SHAREDWATN_707230",
                hasId: true,
                componentStyle: [],
                label: 'Group2768',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.types.SharedEntityWarranty = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    entity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "entity", ''),
                        validation: {
                            entityRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    nameEntity: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "nameEntity", '')
                    },
                    value: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "value", 0),
                        validation: {
                            valueRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    sharedPercentage: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "sharedPercentage", 0),
                        validation: {
                            sharedPercentageRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    bookValue: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "bookValue", 0)
                    },
                    corporation: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "corporation", 0)
                    },
                    date: {
                        type: "date",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "date", new Date())
                    },
                    valueComercial: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("SharedEntityWarranty", "valueComercial", 0)
                    }
                }
            });
            $scope.vc.model.SharedEntityWarranty = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        if ((angular.isDefined(options.data) && angular.isDefined(options.data.refresh)) || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            promise = true;
                            var queryRequest = $scope.vc.getRequestQuery_Q_SHAREDTR_2783();
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'SharedEntityWarranty',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_2783_87838', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
                            if (!args.cancel) {
                                options.success(args.row);
                            } else {
                                options.error(new Error('DeletingError'));
                            }
                        });
                        // end block
                    }
                },
                schema: {
                    model: $scope.vc.types.SharedEntityWarranty
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_2783_87838").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_SHAREDTR_2783 = $scope.vc.model.SharedEntityWarranty;
            $scope.vc.trackers.SharedEntityWarranty = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.SharedEntityWarranty);
            $scope.vc.model.SharedEntityWarranty.bind('change', function(e) {
                $scope.vc.trackers.SharedEntityWarranty.track(e);
            });
            $scope.vc.grids.QV_2783_87838 = {};
            $scope.vc.grids.QV_2783_87838.queryId = 'Q_SHAREDTR_2783';
            $scope.vc.viewState.QV_2783_87838 = {
                style: undefined
            };
            $scope.vc.viewState.QV_2783_87838.column = {};
            $scope.vc.grids.QV_2783_87838.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_2783_87838.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.SharedEntityWarranty(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "BUSIN",
                        subModuleId: "FLCRE",
                        taskId: "T_EDITSHAREDTAR_411",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_EDITSHARAA_114411',
                        title: 'BUSIN.DLB_BUSIN_COMPRTIDA_49433',
                        size: 'sm'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_2783_87838", dialogParameters);
                },
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
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_2783_87838");
                    $scope.vc.hideShowColumns("QV_2783_87838", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_2783_87838.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_2783_87838.rows[dataView[i].uid].style.length; iStyle++) {
                                var styleName = $scope.vc.viewState.QV_2783_87838.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_2783_87838 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_2783_87838 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_2783_87838.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_2783_87838.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_2783_87838.column.entity = {
                title: 'BUSIN.LBL_BUSIN_CODIGOGEX_92577',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXBAE_489230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.nameEntity = {
                title: 'BUSIN.LBL_BUSIN_NOMBREWSC_76062',
                titleArgs: {},
                tooltip: '',
                width: 300,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXVEL_972230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.value = {
                title: 'BUSIN.LBL_BUSIN_VALORCOOP_13089',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVWF_910230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.sharedPercentage = {
                title: 'BUSIN.LBL_BUSIN_CORPORANC_97228',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXVPG_425230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.bookValue = {
                title: 'BUSIN.LBL_BUSIN_VALORCOET_52044',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXPFQ_278230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.corporation = {
                title: 'BUSIN.LBL_BUSIN_COMPARTOI_52524',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXLCH_312230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.date = {
                title: 'BUSIN.LBL_BUSIN_FECHAADSR_49562',
                titleArgs: {},
                tooltip: '',
                width: 150,
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                format: "d",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_DATEFIELDMDKCYC_604230',
                element: []
            };
            $scope.vc.viewState.QV_2783_87838.column.valueComercial = {
                title: 'valueComercial',
                titleArgs: {},
                tooltip: '',
                enabled: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQMD_511230',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'entity',
                    title: '{{vc.viewState.QV_2783_87838.column.entity.title|translate:vc.viewState.QV_2783_87838.column.entity.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.entity.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.entity.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.entity.element[dataItem.uid].style'>#if (entity !== null) {# #=entity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2783_87838.column.entity.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.entity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.entity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'nameEntity',
                    title: '{{vc.viewState.QV_2783_87838.column.nameEntity.title|translate:vc.viewState.QV_2783_87838.column.nameEntity.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.nameEntity.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.nameEntity.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.nameEntity.element[dataItem.uid].style'>#if (nameEntity !== null) {# #=nameEntity# #}#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2783_87838.column.nameEntity.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.nameEntity.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.nameEntity.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'value',
                    title: '{{vc.viewState.QV_2783_87838.column.value.title|translate:vc.viewState.QV_2783_87838.column.value.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.value.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.value.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.value.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.value, \"QV_2783_87838\", \"value\"):kendo.toString(#=value#, vc.viewState.QV_2783_87838.column.value.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2783_87838.column.value.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.value.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.value.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'sharedPercentage',
                    title: '{{vc.viewState.QV_2783_87838.column.sharedPercentage.title|translate:vc.viewState.QV_2783_87838.column.sharedPercentage.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.sharedPercentage.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.sharedPercentage.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.sharedPercentage.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.sharedPercentage, \"QV_2783_87838\", \"sharedPercentage\"):kendo.toString(#=sharedPercentage#, vc.viewState.QV_2783_87838.column.sharedPercentage.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2783_87838.column.sharedPercentage.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.sharedPercentage.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.sharedPercentage.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'bookValue',
                    title: '{{vc.viewState.QV_2783_87838.column.bookValue.title|translate:vc.viewState.QV_2783_87838.column.bookValue.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.bookValue.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.bookValue.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.bookValue.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.bookValue, \"QV_2783_87838\", \"bookValue\"):kendo.toString(#=bookValue#, vc.viewState.QV_2783_87838.column.bookValue.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2783_87838.column.bookValue.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.bookValue.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.bookValue.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'corporation',
                    title: '{{vc.viewState.QV_2783_87838.column.corporation.title|translate:vc.viewState.QV_2783_87838.column.corporation.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.corporation.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.corporation.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.corporation.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.corporation, \"QV_2783_87838\", \"corporation\"):kendo.toString(#=corporation#, vc.viewState.QV_2783_87838.column.corporation.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2783_87838.column.corporation.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.corporation.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.corporation.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'date',
                    title: '{{vc.viewState.QV_2783_87838.column.date.title|translate:vc.viewState.QV_2783_87838.column.date.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.date.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.date.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.date.element[dataItem.uid].style'>#=((date !== null) ? kendo.toString(date, 'd') : '')#</span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_2783_87838.column.date.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.date.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.date.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_2783_87838.columns.push({
                    field: 'valueComercial',
                    title: '{{vc.viewState.QV_2783_87838.column.valueComercial.title|translate:vc.viewState.QV_2783_87838.column.valueComercial.titleArgs}}',
                    width: $scope.vc.viewState.QV_2783_87838.column.valueComercial.width,
                    format: $scope.vc.viewState.QV_2783_87838.column.valueComercial.format,
                    template: "<span ng-class='vc.viewState.QV_2783_87838.column.valueComercial.element[dataItem.uid].style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.valueComercial, \"QV_2783_87838\", \"valueComercial\"):kendo.toString(#=valueComercial#, vc.viewState.QV_2783_87838.column.valueComercial.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_2783_87838.column.valueComercial.style",
                        "title": "{{vc.viewState.QV_2783_87838.column.valueComercial.tooltip|translate}}"
                    },
                    headerAttributes: {
                        "class": "text-right"
                    },
                    hidden: $scope.vc.viewState.QV_2783_87838.column.valueComercial.hidden
                });
            }
            $scope.vc.viewState.QV_2783_87838.column["delete"] = {
                element: []
            };
            $scope.vc.grids.QV_2783_87838.columns.push({
                command: [{
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_2783_87838.column.delete.element[dataItem.uid].style, #:cssMap#)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_2783_87838.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_2783_87838.toolbar = [{
                "name": "create",
                "entity": "SharedEntityWarranty",
                "text": "",
                "template": "<button id = 'QV_2783_87838_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_2783_87838.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_SHAREDWATN_707230.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_2783_87838.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }]; //ViewState - Container: SpecificationWarranty
            $scope.vc.createViewState({
                id: "VC_RXANIAZLPR_207323",
                hasId: true,
                componentStyle: [],
                label: "BUSIN.LBL_BUSIN_ESPECIFCA_46327",
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: Group1859
            $scope.vc.createViewState({
                id: "G_SPECIFIIRY_631679",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1859',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_SPECIFIIRY_631679-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_FLCRE_35_RRCAI67_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_FLCRE_35_RRCAI67_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancelar
            $scope.vc.createViewState({
                id: "CM_RRCAI67NLA20",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Guardar
            $scope.vc.createViewState({
                id: "CM_RRCAI67UAR18",
                componentStyle: [],
                label: "BUSIN.DLB_BUSIN_GUARDARWV_92974",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQNJ_419_16.read();
                    $scope.vc.catalogs.VA_ARANSCATIO0714_ELCY714.read();
                    $scope.vc.catalogs.VA_ARANSCATIO0714_SUIE758.read();
                    $scope.vc.catalogs.VA_CLASSWARRANTYYY_283W85.read();
                    $scope.vc.catalogs.VA_AMOUNTDTFTGPVCH_154W85.read();
                    $scope.vc.catalogs.VA_CONTROLVISITCWN_191235.read();
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
                $scope.vc.render('VC_RRCAI67_WACRI_884');
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
    var cobisMainModule = cobis.createModule("VC_RRCAI67_WACRI_884", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "BUSIN"]);
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
        $routeProvider.when("/VC_RRCAI67_WACRI_884", {
            templateUrl: "VC_RRCAI67_WACRI_884_FORM.html",
            controller: "VC_RRCAI67_WACRI_884_CTRL",
            labelId: "BUSIN.DLB_BUSIN_GARANTASQ_18496",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('BUSIN');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_RRCAI67_WACRI_884?" + $.param(search);
            }
        });
        VC_RRCAI67_WACRI_884(cobisMainModule);
    }]);
} else {
    VC_RRCAI67_WACRI_884(cobisMainModule);
}