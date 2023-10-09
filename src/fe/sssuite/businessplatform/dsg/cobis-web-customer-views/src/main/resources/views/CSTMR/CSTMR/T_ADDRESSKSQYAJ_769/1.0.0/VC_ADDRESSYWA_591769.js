//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.addressform = designerEvents.api.addressform || designer.dsgEvents();

function VC_ADDRESSYWA_591769(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ADDRESSYWA_591769_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ADDRESSYWA_591769_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "CSTMR",
            subModuleId: "CSTMR",
            taskId: "T_ADDRESSKSQYAJ_769",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ADDRESSYWA_591769",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_ADDRESSKSQYAJ_769",
        designerEvents.api.addressform,
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
                vcName: 'VC_ADDRESSYWA_591769'
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
                    moduleId: 'CSTMR',
                    subModuleId: 'CSTMR',
                    taskId: 'T_ADDRESSKSQYAJ_769',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    CustomerTmp: "CustomerTmp",
                    VirtualAddress: "VirtualAddress",
                    PhysicalAddress: "PhysicalAddress",
                    Context: "Context"
                },
                entities: {
                    CustomerTmp: {
                        code: 'AT42_CODEBJDS376',
                        _pks: [],
                        _entityId: 'EN_CUSTOMEPP_376',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    VirtualAddress: {
                        addressTypeDescription: 'AT31_PHYSICPD566',
                        addressId: 'AT41_PHYSICRE566',
                        addressType: 'AT77_ADDRESPP566',
                        addressDescription: 'AT84_COUNTRYY566',
                        personSecuential: 'AT85_PERSONNA566',
                        _pks: [],
                        _entityId: 'EN_PHYSICADS_566',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PhysicalAddress: {
                        sameAddressHome: 'AT12_SAMEADRO495',
                        countryCode: 'AT17_VIRTUASI495',
                        directionNumberInternal: 'AT20_DIRECTEI495',
                        longitude: 'AT34_LONGITDE495',
                        addressTypeDescription: 'AT34_PHYSICDE495',
                        addressType: 'AT41_ADDRESYS495',
                        neigborhoodCode: 'AT41_NEIGBOOE495',
                        provinceCode: 'AT42_PROVINDE495',
                        cityPoblation: 'AT46_CITYPOAT495',
                        reference: 'AT47_REFERECE495',
                        street: 'AT47_STREETBU495',
                        isShippingAddress: 'AT50_ISSHIPAS495',
                        parishDescription: 'AT53_PARISHOI495',
                        cityDescription: 'AT64_CITYDEPC495',
                        mail: 'AT66_MAILCDOZ495',
                        addressId: 'AT68_ADDRESDI495',
                        latitude: 'AT69_DEGREEDD495',
                        postalCode: 'AT69_POSTALOO495',
                        addressDescription: 'AT71_ADDRESIE495',
                        urbanType: 'AT71_URBANTEP495',
                        ownershipType: 'AT72_OWNERSHY495',
                        addressMessage: 'AT74_ADDRESSE495',
                        countryDescription: 'AT74_VIRTUARS495',
                        monthsInForce: 'AT75_MONTHSNE495',
                        residenceTime: 'AT78_RESIDEET495',
                        isMainAddress: 'AT79_ISMAINDE495',
                        neighborhoodcode: 'AT80_NEIGHBDR495',
                        neighborhood: 'AT81_NEIGHBHR495',
                        cityCode: 'AT83_CITYCODE495',
                        provinceDescription: 'AT85_PROVINEP495',
                        businessCode: 'AT87_BUSINESD495',
                        department: 'AT87_DEPARTNM495',
                        personSecuential: 'AT90_PERSONNN495',
                        directionNumber: 'AT91_DIRECTIO495',
                        parishCode: 'AT92_PARISHCO495',
                        numberOfResidents: 'AT95_NUMBERSR495',
                        _pks: [],
                        _entityId: 'EN_VIRTUALEA_495',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        flag1: 'AT15_APPLICTM215',
                        flag2: 'AT15_FLAG2FIG215',
                        flag3: 'AT19_FLAG3XYE215',
                        parents: 'AT25_PARENTSS215',
                        couple: 'AT33_COUPLEPS215',
                        married: 'AT41_MARRIEDD215',
                        minimumAge: 'AT41_MINIMUAG215',
                        accountIndividual: 'AT44_ACCOUNND215',
                        freeUnion: 'AT52_FREEUNNI215',
                        nameReport: 'AT52_NAMERERP215',
                        collectiveLevel: 'AT55_COLLECET215',
                        officeName: 'AT61_OFFICEAE215',
                        maximumAge: 'AT62_MAXIMUAA215',
                        son: 'AT70_SONFRKEM215',
                        mailState: 'AT79_MAILSTTT215',
                        defaultCountry: 'AT84_DEFAULYR215',
                        collective: 'AT85_COLLECVI215',
                        generateReport: 'AT85_GENERATP215',
                        roleEnabledQueryAccount: 'AT86_ROLEENBO215',
                        addressState: 'AT89_ADDRESST215',
                        renapo: 'AT89_RENAPOOT215',
                        printReport: 'AT90_PRINTRRT215',
                        roleEnabledDataModRequest: 'AT90_ROLEENUD215',
                        _pks: [],
                        _entityId: 'EN_CREDITLBQ_215',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_VIRTUALD_9303 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_VIRTUALD_9303 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_VIRTUALD_9303_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_VIRTUALD_9303_filters;
                    parametersAux = {
                        addressId: filters.addressId,
                        personalSecuential: filters.personalSecuential
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PHYSICADS_566',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_VIRTUALD_9303',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['addressId'] = this.filters.addressId;
                            this.parameters['personalSecuential'] = this.filters.personalSecuential;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_VIRTUALD_9303_filters = {};
            $scope.vc.queryProperties.Q_PHYSICDS_4851 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_PHYSICDS_4851 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PHYSICDS_4851_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PHYSICDS_4851_filters;
                    parametersAux = {
                        addressId: filters.addressId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_VIRTUALEA_495',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PHYSICDS_4851',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['addressId'] = this.filters.addressId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_PHYSICDS_4851_filters = {};
            var defaultValues = {
                CustomerTmp: {},
                VirtualAddress: {},
                PhysicalAddress: {},
                Context: {}
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
                $scope.vc.execute("temporarySave", VC_ADDRESSYWA_591769, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_ADDRESSYWA_591769, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_ADDRESSYWA_591769, data, function() {});
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
            $scope.vc.viewState.VC_ADDRESSYWA_591769 = {
                style: []
            }
            //ViewState - Group: GroupLayout1182
            $scope.vc.createViewState({
                id: "G_ADDRESSHQX_118566",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1182',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1973
            $scope.vc.createViewState({
                id: "G_ADDRESSXDI_956566",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1973',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_ADDRESSXDI_956566-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerTmp = {
                code: $scope.vc.channelDefaultValues("CustomerTmp", "code")
            };
            //ViewState - Group: Group1650
            $scope.vc.createViewState({
                id: "G_ADDRESSHTB_233566",
                hasId: true,
                componentStyle: [],
                label: 'Group1650',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: CustomerTmp, Attribute: code
            $scope.vc.createViewState({
                id: "VA_CODERWEMFUUBAQJ_654566",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGODEET_21744",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONYDIJDRL_132566",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARAUU_89471",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONWVQOBVO_763566",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_AUXLULFCN_62992",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group1485
            $scope.vc.createViewState({
                id: "G_ADDRESSRXH_631566",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCISE_23825",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.PhysicalAddress = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    addressTypeDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressTypeDescription", '')
                    },
                    ownershipType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "ownershipType", '')
                    },
                    street: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "street", ''),
                        validation: {
                            streetRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    directionNumber: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "directionNumber", 0),
                        validation: {
                            directionNumberRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    directionNumberInternal: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "directionNumberInternal", 0)
                    },
                    parishDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "parishDescription", '')
                    },
                    postalCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "postalCode", ''),
                        validation: {
                            postalCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    cityDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "cityDescription", '')
                    },
                    provinceDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "provinceDescription", '')
                    },
                    residenceTime: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "residenceTime", 0)
                    },
                    numberOfResidents: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "numberOfResidents", 0)
                    },
                    addressId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressId", 0)
                    },
                    personSecuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "personSecuential", 0)
                    },
                    countryDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "countryDescription", '')
                    },
                    isMainAddress: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "isMainAddress", false)
                    },
                    isShippingAddress: {
                        type: "boolean",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "isShippingAddress", false)
                    },
                    addressType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressType", ''),
                        validation: {
                            addressTypeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    countryCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "countryCode", 0),
                        validation: {
                            countryCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    provinceCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "provinceCode", 0),
                        validation: {
                            provinceCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    cityCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "cityCode", 0),
                        validation: {
                            cityCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    addressDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "addressDescription", '')
                    },
                    parishCode: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "parishCode", 0),
                        validation: {
                            parishCodeRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    },
                    neighborhood: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "neighborhood", '')
                    },
                    latitude: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "latitude", 0)
                    },
                    longitude: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "longitude", 0)
                    },
                    reference: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("PhysicalAddress", "reference", ''),
                        validation: {
                            referenceRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.PhysicalAddress = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_PHYSICDS_4851';
                            var queryRequest = $scope.vc.getRequestQuery_Q_PHYSICDS_4851();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_4851_97960',
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
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'PhysicalAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_4851_97960', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'PhysicalAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_4851_97960', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.PhysicalAddress
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_4851_97960").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PHYSICDS_4851 = $scope.vc.model.PhysicalAddress;
            $scope.vc.trackers.PhysicalAddress = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.PhysicalAddress);
            $scope.vc.model.PhysicalAddress.bind('change', function(e) {
                $scope.vc.trackers.PhysicalAddress.track(e);
            });
            $scope.vc.grids.QV_4851_97960 = {};
            $scope.vc.grids.QV_4851_97960.queryId = 'Q_PHYSICDS_4851';
            $scope.vc.viewState.QV_4851_97960 = {
                style: undefined
            };
            $scope.vc.viewState.QV_4851_97960.column = {};
            $scope.vc.grids.QV_4851_97960.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_4851_97960.events = {
                customCreate: function(e, entity) {
                    var dialogParameters = {
                        nameEntityGrid: entity,
                        rowData: new $scope.vc.types.PhysicalAddress(),
                        rowIndex: -1,
                        isNew: true,
                        hasBeforeOpenDialogEvent: false,
                        hasAfterCloseDialogEvent: false,
                        isModal: true,
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_ADDRESSTODDXS_302",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_ADDRESSITS_306302',
                        title: 'CSTMR.LBL_CSTMR_DIRECCINS_93646'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_4851_97960", dialogParameters);
                },
                customEdit: function(e, entity, grid) {
                    var dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
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
                        moduleId: "CSTMR",
                        subModuleId: "CSTMR",
                        taskId: "T_ADDRESSTODDXS_302",
                        taskVersion: "1.0.0",
                        viewContainerId: 'VC_ADDRESSITS_306302',
                        title: 'CSTMR.LBL_CSTMR_DIRECCINS_93646'
                    };
                    $scope.vc.beforeOpenGridDialog("QV_4851_97960", dialogParameters);
                },
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'PhysicalAddress',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_4851_97960", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_4851_97960");
                    $scope.vc.hideShowColumns("QV_4851_97960", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_4851_97960.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_4851_97960.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_4851_97960.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_4851_97960 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_4851_97960 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_4851_97960.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_4851_97960.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_4851_97960.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription = {
                title: 'CSTMR.LBL_CSTMR_TIPODEDNN_99499',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCWF_391566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.ownershipType = {
                title: 'CSTMR.LBL_CSTMR_TIPOVIVII_94718',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQYM_561566',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQYM_561566 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXQYM_561566',
                            'cl_tpropiedad',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQYM_561566'];
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
            $scope.vc.viewState.QV_4851_97960.column.street = {
                title: 'CSTMR.LBL_CSTMR_CALLEZGKG_90745',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXAAM_523566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.directionNumber = {
                title: 'CSTMR.LBL_CSTMR_NUMEROERE_80912',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXTRM_654566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal = {
                title: 'CSTMR.LBL_CSTMR_NUMEROIRR_97223',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEDV_219566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.parishDescription = {
                title: 'CSTMR.LBL_CSTMR_COLONIAHO_62033',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYZP_139566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.postalCode = {
                title: 'CSTMR.LBL_CSTMR_CPLTRUORJ_78149',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZGO_902566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.cityDescription = {
                title: 'CSTMR.LBL_CSTMR_MUNICIPIO_48290',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZWT_698566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.provinceDescription = {
                title: 'CSTMR.LBL_CSTMR_ESTADOWSN_97563',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXXJY_416566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.residenceTime = {
                title: 'CSTMR.LBL_CSTMR_AOSDOMIIC_89661',
                titleArgs: {},
                tooltip: '',
                width: 200,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWTT_538566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.numberOfResidents = {
                title: 'CSTMR.LBL_CSTMR_PERSONANE_31281',
                titleArgs: {},
                tooltip: '',
                width: 250,
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXUJU_368566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.addressId = {
                title: 'CSTMR.LBL_CSTMR_NMEROBVNL_26453',
                titleArgs: {},
                tooltip: '',
                width: 75,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXIJO_865566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.personSecuential = {
                title: 'personSecuential',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJOJ_503566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.countryDescription = {
                title: 'CSTMR.LBL_CSTMR_PASJNZPSV_26668',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXZPB_139566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.isMainAddress = {
                title: 'isMainAddress',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXIUPMNOH_942566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.isShippingAddress = {
                title: 'isShippingAddress',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_CHECKBOXYLUYHPM_737566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.addressType = {
                title: 'CSTMR.LBL_CSTMR_TIPODEDNN_99499',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZCX_337566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.countryCode = {
                title: 'countryCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXTCL_828566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.provinceCode = {
                title: 'provinceCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXRDK_707566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.cityCode = {
                title: 'cityCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXYIG_433566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.addressDescription = {
                title: 'CSTMR.LBL_CSTMR_DATOSCOON_45015',
                titleArgs: {},
                tooltip: '',
                width: 175,
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBHJ_130566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.parishCode = {
                title: 'parishCode',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXKHQ_381566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.neighborhood = {
                title: 'neighborhood',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXMAD_925566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.latitude = {
                title: 'latitude',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYBS_295566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.longitude = {
                title: 'longitude',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n",
                decimals: kendo.cultures.current.numberFormat.decimals,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXEIH_666566',
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.reference = {
                title: 'reference',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 32,
                componentId: 'VA_TEXTINPUTBOXZOA_592566',
                element: []
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressTypeDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.addressTypeDescription.title|translate:vc.viewState.QV_4851_97960.column.addressTypeDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressTypeDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressTypeDescription, \"QV_4851_97960\", \"addressTypeDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressTypeDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressTypeDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressTypeDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'ownershipType',
                    title: '{{vc.viewState.QV_4851_97960.column.ownershipType.title|translate:vc.viewState.QV_4851_97960.column.ownershipType.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.ownershipType.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.ownershipType.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.ownershipType.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQYM_561566.get(dataItem.ownershipType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.ownershipType.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.ownershipType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.ownershipType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'street',
                    title: '{{vc.viewState.QV_4851_97960.column.street.title|translate:vc.viewState.QV_4851_97960.column.street.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.street.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.street.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.street.style' ng-bind='vc.getStringColumnFormat(dataItem.street, \"QV_4851_97960\", \"street\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.street.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.street.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.street.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'directionNumber',
                    title: '{{vc.viewState.QV_4851_97960.column.directionNumber.title|translate:vc.viewState.QV_4851_97960.column.directionNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.directionNumber.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.directionNumber.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.directionNumber.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.directionNumber, \"QV_4851_97960\", \"directionNumber\"):kendo.toString(#=directionNumber#, vc.viewState.QV_4851_97960.column.directionNumber.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.directionNumber.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.directionNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.directionNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'directionNumberInternal',
                    title: '{{vc.viewState.QV_4851_97960.column.directionNumberInternal.title|translate:vc.viewState.QV_4851_97960.column.directionNumberInternal.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.directionNumberInternal.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.directionNumberInternal, \"QV_4851_97960\", \"directionNumberInternal\"):kendo.toString(#=directionNumberInternal#, vc.viewState.QV_4851_97960.column.directionNumberInternal.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.directionNumberInternal.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.directionNumberInternal.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.directionNumberInternal.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'parishDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.parishDescription.title|translate:vc.viewState.QV_4851_97960.column.parishDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.parishDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.parishDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.parishDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.parishDescription, \"QV_4851_97960\", \"parishDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.parishDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.parishDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.parishDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'postalCode',
                    title: '{{vc.viewState.QV_4851_97960.column.postalCode.title|translate:vc.viewState.QV_4851_97960.column.postalCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.postalCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.postalCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.postalCode.style' ng-bind='vc.getStringColumnFormat(dataItem.postalCode, \"QV_4851_97960\", \"postalCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.postalCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.postalCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.postalCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'cityDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.cityDescription.title|translate:vc.viewState.QV_4851_97960.column.cityDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.cityDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.cityDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.cityDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.cityDescription, \"QV_4851_97960\", \"cityDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.cityDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.cityDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.cityDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'provinceDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.provinceDescription.title|translate:vc.viewState.QV_4851_97960.column.provinceDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.provinceDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.provinceDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.provinceDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.provinceDescription, \"QV_4851_97960\", \"provinceDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.provinceDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.provinceDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.provinceDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'residenceTime',
                    title: '{{vc.viewState.QV_4851_97960.column.residenceTime.title|translate:vc.viewState.QV_4851_97960.column.residenceTime.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.residenceTime.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.residenceTime.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.residenceTime.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.residenceTime, \"QV_4851_97960\", \"residenceTime\"):kendo.toString(#=residenceTime#, vc.viewState.QV_4851_97960.column.residenceTime.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.residenceTime.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.residenceTime.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.residenceTime.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'numberOfResidents',
                    title: '{{vc.viewState.QV_4851_97960.column.numberOfResidents.title|translate:vc.viewState.QV_4851_97960.column.numberOfResidents.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.numberOfResidents.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.numberOfResidents.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.numberOfResidents.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.numberOfResidents, \"QV_4851_97960\", \"numberOfResidents\"):kendo.toString(#=numberOfResidents#, vc.viewState.QV_4851_97960.column.numberOfResidents.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.numberOfResidents.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.numberOfResidents.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.numberOfResidents.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressId',
                    title: '{{vc.viewState.QV_4851_97960.column.addressId.title|translate:vc.viewState.QV_4851_97960.column.addressId.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressId.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressId.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.addressId, \"QV_4851_97960\", \"addressId\"):kendo.toString(#=addressId#, vc.viewState.QV_4851_97960.column.addressId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressId.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'personSecuential',
                    title: '{{vc.viewState.QV_4851_97960.column.personSecuential.title|translate:vc.viewState.QV_4851_97960.column.personSecuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.personSecuential.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.personSecuential.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.personSecuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.personSecuential, \"QV_4851_97960\", \"personSecuential\"):kendo.toString(#=personSecuential#, vc.viewState.QV_4851_97960.column.personSecuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.personSecuential.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.personSecuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.personSecuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'countryDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.countryDescription.title|translate:vc.viewState.QV_4851_97960.column.countryDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.countryDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.countryDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.countryDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.countryDescription, \"QV_4851_97960\", \"countryDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.countryDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.countryDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.countryDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'isMainAddress',
                    title: '{{vc.viewState.QV_4851_97960.column.isMainAddress.title|translate:vc.viewState.QV_4851_97960.column.isMainAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.isMainAddress.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.isMainAddress.format,
                    template: "<input name='isMainAddress' type='checkbox' value='#=isMainAddress#' #=isMainAddress?checked='checked':''# disabled='disabled' data-bind='value:isMainAddress' ng-class='vc.viewState.QV_4851_97960.column.isMainAddress.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.isMainAddress.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.isMainAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.isMainAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'isShippingAddress',
                    title: '{{vc.viewState.QV_4851_97960.column.isShippingAddress.title|translate:vc.viewState.QV_4851_97960.column.isShippingAddress.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.isShippingAddress.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.isShippingAddress.format,
                    template: "<input name='isShippingAddress' type='checkbox' value='#=isShippingAddress#' #=isShippingAddress?checked='checked':''# disabled='disabled' data-bind='value:isShippingAddress' ng-class='vc.viewState.QV_4851_97960.column.isShippingAddress.style' />",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.isShippingAddress.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.isShippingAddress.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.isShippingAddress.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressType',
                    title: '{{vc.viewState.QV_4851_97960.column.addressType.title|translate:vc.viewState.QV_4851_97960.column.addressType.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressType.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressType.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressType.style' ng-bind='vc.getStringColumnFormat(dataItem.addressType, \"QV_4851_97960\", \"addressType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressType.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'countryCode',
                    title: '{{vc.viewState.QV_4851_97960.column.countryCode.title|translate:vc.viewState.QV_4851_97960.column.countryCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.countryCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.countryCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.countryCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.countryCode, \"QV_4851_97960\", \"countryCode\"):kendo.toString(#=countryCode#, vc.viewState.QV_4851_97960.column.countryCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.countryCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.countryCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.countryCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'provinceCode',
                    title: '{{vc.viewState.QV_4851_97960.column.provinceCode.title|translate:vc.viewState.QV_4851_97960.column.provinceCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.provinceCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.provinceCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.provinceCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.provinceCode, \"QV_4851_97960\", \"provinceCode\"):kendo.toString(#=provinceCode#, vc.viewState.QV_4851_97960.column.provinceCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.provinceCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.provinceCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.provinceCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'cityCode',
                    title: '{{vc.viewState.QV_4851_97960.column.cityCode.title|translate:vc.viewState.QV_4851_97960.column.cityCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.cityCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.cityCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.cityCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.cityCode, \"QV_4851_97960\", \"cityCode\"):kendo.toString(#=cityCode#, vc.viewState.QV_4851_97960.column.cityCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.cityCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.cityCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.cityCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'addressDescription',
                    title: '{{vc.viewState.QV_4851_97960.column.addressDescription.title|translate:vc.viewState.QV_4851_97960.column.addressDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.addressDescription.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.addressDescription.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.addressDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressDescription, \"QV_4851_97960\", \"addressDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.addressDescription.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.addressDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.addressDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'parishCode',
                    title: '{{vc.viewState.QV_4851_97960.column.parishCode.title|translate:vc.viewState.QV_4851_97960.column.parishCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.parishCode.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.parishCode.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.parishCode.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.parishCode, \"QV_4851_97960\", \"parishCode\"):kendo.toString(#=parishCode#, vc.viewState.QV_4851_97960.column.parishCode.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.parishCode.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.parishCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.parishCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'neighborhood',
                    title: '{{vc.viewState.QV_4851_97960.column.neighborhood.title|translate:vc.viewState.QV_4851_97960.column.neighborhood.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.neighborhood.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.neighborhood.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.neighborhood.style' ng-bind='vc.getStringColumnFormat(dataItem.neighborhood, \"QV_4851_97960\", \"neighborhood\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.neighborhood.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.neighborhood.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.neighborhood.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'latitude',
                    title: '{{vc.viewState.QV_4851_97960.column.latitude.title|translate:vc.viewState.QV_4851_97960.column.latitude.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.latitude.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.latitude.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.latitude.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.latitude, \"QV_4851_97960\", \"latitude\"):kendo.toString(#=latitude#, vc.viewState.QV_4851_97960.column.latitude.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.latitude.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.latitude.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.latitude.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'longitude',
                    title: '{{vc.viewState.QV_4851_97960.column.longitude.title|translate:vc.viewState.QV_4851_97960.column.longitude.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.longitude.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.longitude.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.longitude.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.longitude, \"QV_4851_97960\", \"longitude\"):kendo.toString(#=longitude#, vc.viewState.QV_4851_97960.column.longitude.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_4851_97960.column.longitude.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.longitude.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.longitude.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_4851_97960.columns.push({
                    field: 'reference',
                    title: '{{vc.viewState.QV_4851_97960.column.reference.title|translate:vc.viewState.QV_4851_97960.column.reference.titleArgs}}',
                    width: $scope.vc.viewState.QV_4851_97960.column.reference.width,
                    format: $scope.vc.viewState.QV_4851_97960.column.reference.format,
                    template: "<span ng-class='vc.viewState.QV_4851_97960.column.reference.style' ng-bind='vc.getStringColumnFormat(dataItem.reference, \"QV_4851_97960\", \"reference\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_4851_97960.column.reference.style",
                        "title": "{{vc.viewState.QV_4851_97960.column.reference.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_4851_97960.column.reference.hidden
                });
            }
            $scope.vc.viewState.QV_4851_97960.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_4851_97960.column.cmdEdition = {};
            $scope.vc.viewState.QV_4851_97960.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_4851_97960.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "customEdit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    entity: "PhysicalAddress",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", '': true}",
                    template: "<a ng-class='vc.getCssClass(\"customEdit\", " + "vc.viewState.QV_4851_97960.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_4851_97960.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSRXH_631566.disabled==true?true:false) " + "data-ng-click = 'vc.grids.QV_4851_97960.events.customEdit($event, \"#:entity#\", grids.QV_4851_97960)' " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_4851_97960.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_4851_97960.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSRXH_631566.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_4851_97960.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_4851_97960.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_4851_97960.toolbar = [{
                "name": "create",
                "entity": "PhysicalAddress",
                "text": "",
                "template": "<button id = 'QV_4851_97960_CUSTOM_CREATE' class = 'btn btn-default cb-grid-button' " + "ng-if = 'vc.viewState.QV_4851_97960.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_ADDRESSRXH_631566.disabled?true:false' " + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" " + "data-ng-click = 'vc.grids.QV_4851_97960.events.customCreate($event, \"#:entity#\")'> " + "<span class = 'glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            //ViewState - Group: Group2117
            $scope.vc.createViewState({
                id: "G_ADDRESSLJO_139566",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCINT_97175",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.VirtualAddress = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    addressId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressId", 0)
                    },
                    personSecuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "personSecuential", 0)
                    },
                    addressType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressType", '')
                    },
                    addressTypeDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressTypeDescription", '')
                    },
                    addressDescription: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("VirtualAddress", "addressDescription", ''),
                        validation: {
                            addressDescriptionRegularExpression: function(input) {
                                return regularExpression(input);
                            },
                            addressDescriptionRequired: function(input) {
                                return dsgRequiredFunction(input);
                            }
                        }
                    }
                }
            });
            $scope.vc.model.VirtualAddress = new kendo.data.DataSource({
                pageSize: 10,
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_VIRTUALD_9303';
                            var queryRequest = $scope.vc.getRequestQuery_Q_VIRTUALD_9303();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9303_67123',
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
                        //this block of code only appears if the grid has set a RowInsertingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'VirtualAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9303_67123', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                            nameEntityGrid: 'VirtualAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9303_67123', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                        //this block of code only appears if the grid has set a RowDeletingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'VirtualAddress',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9303_67123', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.VirtualAddress
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9303_67123").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_VIRTUALD_9303 = $scope.vc.model.VirtualAddress;
            $scope.vc.trackers.VirtualAddress = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.VirtualAddress);
            $scope.vc.model.VirtualAddress.bind('change', function(e) {
                $scope.vc.trackers.VirtualAddress.track(e);
            });
            $scope.vc.grids.QV_9303_67123 = {};
            $scope.vc.grids.QV_9303_67123.queryId = 'Q_VIRTUALD_9303';
            $scope.vc.viewState.QV_9303_67123 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9303_67123.column = {};
            $scope.vc.grids.QV_9303_67123.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_9303_67123.events = {
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
                    $scope.vc.trackers.VirtualAddress.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9303_67123.selectedRow = e.model;
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
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'VirtualAddress',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_9303_67123", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9303_67123");
                    $scope.vc.hideShowColumns("QV_9303_67123", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9303_67123.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9303_67123.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9303_67123.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9303_67123 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9303_67123 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_9303_67123.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9303_67123.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9303_67123.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9303_67123.column.addressId = {
                title: 'CSTMR.LBL_CSTMR_NMEROBVNL_26453',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBQK_646566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT41_PHYSICRE566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBQK_646566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9303_67123.column.addressId.format",
                        'k-decimals': "vc.viewState.QV_9303_67123.column.addressId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.personSecuential = {
                title: 'CSTMR.LBL_CSTMR_NMEROBVNL_26453',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXDYV_798566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT85_PERSONNA566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.personSecuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXDYV_798566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.personSecuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9303_67123.column.personSecuential.format",
                        'k-decimals': "vc.viewState.QV_9303_67123.column.personSecuential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.personSecuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.addressType = {
                title: 'addressType',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKCY_211566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT77_ADDRESPP566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKCY_211566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressType.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressType.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription = {
                title: 'addressTypeDescription',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXFTS_843566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT31_PHYSICPD566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressTypeDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXFTS_843566",
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressTypeDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressTypeDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9303_67123.column.addressDescription = {
                title: 'CSTMR.LBL_CSTMR_DIRECCIRV_56431',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 33,
                componentId: 'VA_TEXTINPUTBOXILB_303566',
                element: []
            };
            $scope.vc.grids.QV_9303_67123.AT84_COUNTRYY566 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9303_67123.column.addressDescription.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXILB_303566",
                        'regular-expression': "",
                        'regexppattern': "^[a-z0-9-_.]+@[a-z0-9-]+\.[a-z0-9-.]+$",
                        'data-regularExpression-msg': $filter('translate')('CSTMR.MSG_CSTMR_CORREOENI_83889'),
                        'required': '',
                        'data-required-msg': $filter('translate')('CSTMR.LBL_CSTMR_DIRECCIRV_56431') + ' ' + $filter('translate')('DSGNR.SYS_DSGNR_MSGREQURF_00032'),
                        'data-validation-code': "{{vc.viewState.QV_9303_67123.column.addressDescription.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-blur': "vc.change($event,'VA_TEXTINPUTBOXILB_303566',this.dataItem,'" + options.field + "')",
                        'ng-focus': "vc.focus($event,'VA_TEXTINPUTBOXILB_303566',this.dataItem,'" + options.field + "')",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9303_67123.column.addressDescription.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressId',
                    title: '{{vc.viewState.QV_9303_67123.column.addressId.title|translate:vc.viewState.QV_9303_67123.column.addressId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressId.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressId.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT41_PHYSICRE566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.addressId, \"QV_9303_67123\", \"addressId\"):kendo.toString(#=addressId#, vc.viewState.QV_9303_67123.column.addressId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressId.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'personSecuential',
                    title: '{{vc.viewState.QV_9303_67123.column.personSecuential.title|translate:vc.viewState.QV_9303_67123.column.personSecuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.personSecuential.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.personSecuential.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT85_PERSONNA566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.personSecuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.personSecuential, \"QV_9303_67123\", \"personSecuential\"):kendo.toString(#=personSecuential#, vc.viewState.QV_9303_67123.column.personSecuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9303_67123.column.personSecuential.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.personSecuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.personSecuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressType',
                    title: '{{vc.viewState.QV_9303_67123.column.addressType.title|translate:vc.viewState.QV_9303_67123.column.addressType.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressType.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressType.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT77_ADDRESPP566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressType.style' ng-bind='vc.getStringColumnFormat(dataItem.addressType, \"QV_9303_67123\", \"addressType\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressType.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressTypeDescription',
                    title: '{{vc.viewState.QV_9303_67123.column.addressTypeDescription.title|translate:vc.viewState.QV_9303_67123.column.addressTypeDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT31_PHYSICPD566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressTypeDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressTypeDescription, \"QV_9303_67123\", \"addressTypeDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressTypeDescription.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressTypeDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressTypeDescription.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9303_67123.columns.push({
                    field: 'addressDescription',
                    title: '{{vc.viewState.QV_9303_67123.column.addressDescription.title|translate:vc.viewState.QV_9303_67123.column.addressDescription.titleArgs}}',
                    width: $scope.vc.viewState.QV_9303_67123.column.addressDescription.width,
                    format: $scope.vc.viewState.QV_9303_67123.column.addressDescription.format,
                    editor: $scope.vc.grids.QV_9303_67123.AT84_COUNTRYY566.control,
                    template: "<span ng-class='vc.viewState.QV_9303_67123.column.addressDescription.style' ng-bind='vc.getStringColumnFormat(dataItem.addressDescription, \"QV_9303_67123\", \"addressDescription\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9303_67123.column.addressDescription.style",
                        "title": "{{vc.viewState.QV_9303_67123.column.addressDescription.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9303_67123.column.addressDescription.hidden
                });
            }
            $scope.vc.viewState.QV_9303_67123.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_9303_67123.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_9303_67123.column.cmdEdition = {};
            $scope.vc.viewState.QV_9303_67123.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_9303_67123.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_9303_67123.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9303_67123.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSLJO_139566.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_9303_67123.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9303_67123.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSLJO_139566.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_9303_67123.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            $scope.vc.viewState.QV_9303_67123.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_9303_67123.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_9303_67123.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_ADDRESSLJO_139566.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            $scope.vc.model.Context = {
                flag1: $scope.vc.channelDefaultValues("Context", "flag1"),
                flag2: $scope.vc.channelDefaultValues("Context", "flag2"),
                flag3: $scope.vc.channelDefaultValues("Context", "flag3"),
                parents: $scope.vc.channelDefaultValues("Context", "parents"),
                couple: $scope.vc.channelDefaultValues("Context", "couple"),
                married: $scope.vc.channelDefaultValues("Context", "married"),
                minimumAge: $scope.vc.channelDefaultValues("Context", "minimumAge"),
                accountIndividual: $scope.vc.channelDefaultValues("Context", "accountIndividual"),
                freeUnion: $scope.vc.channelDefaultValues("Context", "freeUnion"),
                nameReport: $scope.vc.channelDefaultValues("Context", "nameReport"),
                collectiveLevel: $scope.vc.channelDefaultValues("Context", "collectiveLevel"),
                officeName: $scope.vc.channelDefaultValues("Context", "officeName"),
                maximumAge: $scope.vc.channelDefaultValues("Context", "maximumAge"),
                son: $scope.vc.channelDefaultValues("Context", "son"),
                mailState: $scope.vc.channelDefaultValues("Context", "mailState"),
                defaultCountry: $scope.vc.channelDefaultValues("Context", "defaultCountry"),
                collective: $scope.vc.channelDefaultValues("Context", "collective"),
                generateReport: $scope.vc.channelDefaultValues("Context", "generateReport"),
                roleEnabledQueryAccount: $scope.vc.channelDefaultValues("Context", "roleEnabledQueryAccount"),
                addressState: $scope.vc.channelDefaultValues("Context", "addressState"),
                renapo: $scope.vc.channelDefaultValues("Context", "renapo"),
                printReport: $scope.vc.channelDefaultValues("Context", "printReport"),
                roleEnabledDataModRequest: $scope.vc.channelDefaultValues("Context", "roleEnabledDataModRequest")
            };
            //ViewState - Group: Group1878
            $scope.vc.createViewState({
                id: "G_ADDRESSXST_172566",
                hasId: true,
                componentStyle: [],
                label: 'Group1878',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1131",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ADDRESSKSQYAJ_769_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ADDRESSKSQYAJ_769_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TADDRESS_C49",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQYM_561566.read();
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
                $scope.vc.render('VC_ADDRESSYWA_591769');
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
    var cobisMainModule = cobis.createModule("VC_ADDRESSYWA_591769", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_ADDRESSYWA_591769", {
            templateUrl: "VC_ADDRESSYWA_591769_FORM.html",
            controller: "VC_ADDRESSYWA_591769_CTRL",
            labelId: "CSTMR.LBL_CSTMR_MANTENIEM_96975",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ADDRESSYWA_591769?" + $.param(search);
            }
        });
        VC_ADDRESSYWA_591769(cobisMainModule);
    }]);
} else {
    VC_ADDRESSYWA_591769(cobisMainModule);
}