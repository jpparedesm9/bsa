//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.addresspopupform = designerEvents.api.addresspopupform || designer.dsgEvents();

function VC_ADDRESSITS_306302(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_ADDRESSITS_306302_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_ADDRESSITS_306302_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_ADDRESSTODDXS_302",
            taskVersion: "1.0.0",
            viewContainerId: "VC_ADDRESSITS_306302",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_ADDRESSTODDXS_302",
        designerEvents.api.addresspopupform,
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
                vcName: 'VC_ADDRESSITS_306302'
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
                    taskId: 'T_ADDRESSTODDXS_302',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Context: "Context",
                    Phone: "Phone",
                    PhysicalAddress: "PhysicalAddress",
                    CustomerTmp: "CustomerTmp",
                    PostalCodeTmp: "PostalCodeTmp"
                },
                entities: {
                    Context: {
                        flag1: 'AT15_APPLICTM215',
                        flag2: 'AT15_FLAG2FIG215',
                        flag3: 'AT19_FLAG3XYE215',
                        renapoByCurp: 'AT21_RENAPORP215',
                        parents: 'AT25_PARENTSS215',
                        channel: 'AT29_CHANNELL215',
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
                    },
                    Phone: {
                        phoneNumber: 'AT29_PHONENER911',
                        phoneType: 'AT45_PHONETYE911',
                        areaCode: 'AT52_AREACOED911',
                        phoneId: 'AT53_PHONEIDD911',
                        isChecked: 'AT69_ISCHECEE911',
                        personSecuential: 'AT74_PERSONCE911',
                        addressId: 'AT97_ADDRESIS911',
                        _pks: [],
                        _entityId: 'EN_PHONEBPJM_911',
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
                        isChecked: 'AT52_ISCHECDD495',
                        parishDescription: 'AT53_PARISHOI495',
                        paramVASMS: 'AT55_PARAMVMA495',
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
                    CustomerTmp: {
                        code: 'AT42_CODEBJDS376',
                        paramVamail: 'AT42_PARAMVLI376',
                        _pks: [],
                        _entityId: 'EN_CUSTOMEPP_376',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    PostalCodeTmp: {
                        cityCode: 'AT15_CITYCOED915',
                        parishCode: 'AT33_PARISHCD915',
                        provinceCode: 'AT71_PROVINOD915',
                        _pks: [],
                        _entityId: 'EN_POSTALCEE_915',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_PHONERJD_9891 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_PHONERJD_9891 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_PHONERJD_9891_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_PHONERJD_9891_filters;
                    parametersAux = {
                        phoneId: filters.phoneId,
                        personSecuential: filters.personSecuential,
                        addressId: filters.addressId
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_PHONEBPJM_911',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_PHONERJD_9891',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['phoneId'] = this.filters.phoneId;
                            this.parameters['personSecuential'] = this.filters.personSecuential;
                            this.parameters['addressId'] = this.filters.addressId;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_PHONERJD_9891_filters = {};
            var defaultValues = {
                Context: {},
                Phone: {},
                PhysicalAddress: {},
                CustomerTmp: {},
                PostalCodeTmp: {}
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
                $scope.vc.execute("temporarySave", VC_ADDRESSITS_306302, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_ADDRESSITS_306302, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_ADDRESSITS_306302, data, function() {});
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
            $scope.vc.viewState.VC_ADDRESSITS_306302 = {
                style: []
            }
            $scope.vc.model.PhysicalAddress = {
                sameAddressHome: $scope.vc.channelDefaultValues("PhysicalAddress", "sameAddressHome"),
                countryCode: $scope.vc.channelDefaultValues("PhysicalAddress", "countryCode"),
                directionNumberInternal: $scope.vc.channelDefaultValues("PhysicalAddress", "directionNumberInternal"),
                longitude: $scope.vc.channelDefaultValues("PhysicalAddress", "longitude"),
                addressTypeDescription: $scope.vc.channelDefaultValues("PhysicalAddress", "addressTypeDescription"),
                addressType: $scope.vc.channelDefaultValues("PhysicalAddress", "addressType"),
                neigborhoodCode: $scope.vc.channelDefaultValues("PhysicalAddress", "neigborhoodCode"),
                provinceCode: $scope.vc.channelDefaultValues("PhysicalAddress", "provinceCode"),
                cityPoblation: $scope.vc.channelDefaultValues("PhysicalAddress", "cityPoblation"),
                reference: $scope.vc.channelDefaultValues("PhysicalAddress", "reference"),
                street: $scope.vc.channelDefaultValues("PhysicalAddress", "street"),
                isShippingAddress: $scope.vc.channelDefaultValues("PhysicalAddress", "isShippingAddress"),
                isChecked: $scope.vc.channelDefaultValues("PhysicalAddress", "isChecked"),
                parishDescription: $scope.vc.channelDefaultValues("PhysicalAddress", "parishDescription"),
                paramVASMS: $scope.vc.channelDefaultValues("PhysicalAddress", "paramVASMS"),
                cityDescription: $scope.vc.channelDefaultValues("PhysicalAddress", "cityDescription"),
                mail: $scope.vc.channelDefaultValues("PhysicalAddress", "mail"),
                addressId: $scope.vc.channelDefaultValues("PhysicalAddress", "addressId"),
                latitude: $scope.vc.channelDefaultValues("PhysicalAddress", "latitude"),
                postalCode: $scope.vc.channelDefaultValues("PhysicalAddress", "postalCode"),
                addressDescription: $scope.vc.channelDefaultValues("PhysicalAddress", "addressDescription"),
                urbanType: $scope.vc.channelDefaultValues("PhysicalAddress", "urbanType"),
                ownershipType: $scope.vc.channelDefaultValues("PhysicalAddress", "ownershipType"),
                addressMessage: $scope.vc.channelDefaultValues("PhysicalAddress", "addressMessage"),
                countryDescription: $scope.vc.channelDefaultValues("PhysicalAddress", "countryDescription"),
                monthsInForce: $scope.vc.channelDefaultValues("PhysicalAddress", "monthsInForce"),
                residenceTime: $scope.vc.channelDefaultValues("PhysicalAddress", "residenceTime"),
                isMainAddress: $scope.vc.channelDefaultValues("PhysicalAddress", "isMainAddress"),
                neighborhoodcode: $scope.vc.channelDefaultValues("PhysicalAddress", "neighborhoodcode"),
                neighborhood: $scope.vc.channelDefaultValues("PhysicalAddress", "neighborhood"),
                cityCode: $scope.vc.channelDefaultValues("PhysicalAddress", "cityCode"),
                provinceDescription: $scope.vc.channelDefaultValues("PhysicalAddress", "provinceDescription"),
                businessCode: $scope.vc.channelDefaultValues("PhysicalAddress", "businessCode"),
                department: $scope.vc.channelDefaultValues("PhysicalAddress", "department"),
                personSecuential: $scope.vc.channelDefaultValues("PhysicalAddress", "personSecuential"),
                directionNumber: $scope.vc.channelDefaultValues("PhysicalAddress", "directionNumber"),
                parishCode: $scope.vc.channelDefaultValues("PhysicalAddress", "parishCode"),
                numberOfResidents: $scope.vc.channelDefaultValues("PhysicalAddress", "numberOfResidents")
            };
            //ViewState - Group: Group1426
            $scope.vc.createViewState({
                id: "G_ADDRESSKDI_897436",
                hasId: true,
                componentStyle: [],
                label: 'Group1426',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: addressType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHGW_672436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEDEC_99970",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXHGW_672436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXHGW_672436', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXHGW_672436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXHGW_672436");
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
            //ViewState - Entity: PhysicalAddress, Attribute: sameAddressHome
            $scope.vc.createViewState({
                id: "VA_SAMEADDRESSHMEO_362436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_MISMADOIC_19324",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: PhysicalAddress, Attribute: businessCode
            $scope.vc.createViewState({
                id: "VA_BUSINESSCODEWRI_405436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NEGOCIOSS_45525",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BUSINESSCODEWRI_405436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
                        $scope.vc.setComboBoxDefaultValue("VA_BUSINESSCODEWRI_405436");
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: PhysicalAddress, Attribute: ownershipType
            $scope.vc.createViewState({
                id: "VA_OWNERSHIPTYPEEE_464436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEPIP_83533",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OWNERSHIPTYPEEE_464436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_OWNERSHIPTYPEEE_464436', 'cl_tpropiedad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_OWNERSHIPTYPEEE_464436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OWNERSHIPTYPEEE_464436");
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
            //ViewState - Entity: PhysicalAddress, Attribute: countryCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXOJR_474436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASDSYTGI_62008",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXOJR_474436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXOJR_474436', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXOJR_474436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: PhysicalAddress, Attribute: postalCode
            $scope.vc.createViewState({
                id: "VA_POSTALCODERCKFJ_389436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOPOSL_94606",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: provinceCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTCU_205436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOXKN_15577",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXTCU_205436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXTCU_205436', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXTCU_205436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: PhysicalAddress, Attribute: cityCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQVZ_987436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_MUNICIPLL_42320",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXQVZ_987436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXQVZ_987436', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQVZ_987436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: PhysicalAddress, Attribute: parishCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPPK_701436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_COLONIAWA_55864",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXPPK_701436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXPPK_701436', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPPK_701436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                        },
                        options.data.filter, {
                            filterType: 'startswith'
                        }, 0);
                    }
                },
                serverFiltering: true,
                schema: {
                    model: {
                        id: "code"
                    }
                }
            });
            //ViewState - Entity: PhysicalAddress, Attribute: cityPoblation
            $scope.vc.createViewState({
                id: "VA_9082BHSPKGRBRWE_461436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CIUDADPBI_36978",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: neigborhoodCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXSGN_115436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BARRIOZAA_70495",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXSGN_115436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([]);
                        $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXSGN_115436");
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
                id: "Spacer2523",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: street
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXSOQ_562436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CALLEIMUG_56828",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: directionNumber
            $scope.vc.createViewState({
                id: "VA_DIRECTIONNUMREB_832436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROEXTT_27444",
                format: "####",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: directionNumberInternal
            $scope.vc.createViewState({
                id: "VA_DIRECTIONNUMBLR_612436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROINSN_68365",
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: reference
            $scope.vc.createViewState({
                id: "VA_REFERENCEDKFTKI_970436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_REFERENCA_29518",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: residenceTime
            $scope.vc.createViewState({
                id: "VA_RESIDENCETIMEEE_206436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIEMPODEO_65203",
                format: "n0",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RESIDENCETIMEEE_206436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RESIDENCETIMEEE_206436', 'cl_referencia_tiempo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RESIDENCETIMEEE_206436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RESIDENCETIMEEE_206436");
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
            //ViewState - Entity: PhysicalAddress, Attribute: numberOfResidents
            $scope.vc.createViewState({
                id: "VA_NUMBEROFRESISEN_632436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NODEPEROI_38390",
                format: "n0",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NUMBEROFRESISEN_632436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NUMBEROFRESISEN_632436', 'cl_referencia_tiempo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NUMBEROFRESISEN_632436'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NUMBEROFRESISEN_632436");
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
            //ViewState - Entity: PhysicalAddress, Attribute: addressDescription
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRVI_540436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCINT_16144",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITEUHHB_547436",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: latitude
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXMHX_382436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_LATITUDDO_30802",
                format: "#0.0000000",
                decimals: 7,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: longitude
            $scope.vc.createViewState({
                id: "VA_LONGITUDERIGRQK_939436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_LONGITUDD_77995",
                format: "#0.0000000",
                decimals: 7,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VAIMAGEBUTTONNN_491436",
                componentStyle: [],
                imageId: "glyphicon glyphicon-map-marker",
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: isMainAddress
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXAZI_207436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCIIC_71810",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: isShippingAddress
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHRB_708436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCISR_83092",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: PhysicalAddress, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGVC_373436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOCLNE_10968",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: PhysicalAddress, Attribute: addressId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXMDA_112436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_IDENTIFRI_98375",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONCRFQENP_394436",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARNN_41092",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1326
            $scope.vc.createViewState({
                id: "G_ADDRESSJWN_806436",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TELFONOSS_73492",
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.Phone = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    personSecuential: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "personSecuential", 0)
                    },
                    phoneId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "phoneId", 0)
                    },
                    phoneType: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "phoneType", '')
                    },
                    areaCode: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "areaCode", ''),
                        validation: {
                            areaCodeRegularExpression: function(input) {
                                return regularExpression(input);
                            }
                        }
                    },
                    phoneNumber: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "phoneNumber", ''),
                        validation: {
                            phoneNumberRegularExpression: function(input) {
                                return regularExpression(input);
                            },
                            phoneNumberCustomValidate: function(input) {
                                return customValidate(input);
                            }
                        }
                    },
                    addressId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "addressId", 0)
                    },
                    isChecked: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("Phone", "isChecked", '')
                    }
                }
            });
            $scope.vc.model.Phone = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_PHONERJD_9891';
                            var queryRequest = $scope.vc.getRequestQuery_Q_PHONERJD_9891();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_9891_52790',
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
                                            'pageSize': 0
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
                            nameEntityGrid: 'Phone',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9891_52790', $scope.vc.designerEventsConstants.GridRowInserting, args, function() {
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
                            nameEntityGrid: 'Phone',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9891_52790', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
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
                            nameEntityGrid: 'Phone',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_9891_52790', $scope.vc.designerEventsConstants.GridRowDeleting, args, function() {
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
                    model: $scope.vc.types.Phone
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_9891_52790").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_PHONERJD_9891 = $scope.vc.model.Phone;
            $scope.vc.trackers.Phone = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.Phone);
            $scope.vc.model.Phone.bind('change', function(e) {
                $scope.vc.trackers.Phone.track(e);
            });
            $scope.vc.grids.QV_9891_52790 = {};
            $scope.vc.grids.QV_9891_52790.queryId = 'Q_PHONERJD_9891';
            $scope.vc.viewState.QV_9891_52790 = {
                style: undefined
            };
            $scope.vc.viewState.QV_9891_52790.column = {};
            $scope.vc.grids.QV_9891_52790.editable = {
                mode: 'inline',
                confirmation: false
            };
            $scope.vc.grids.QV_9891_52790.events = {
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
                    $scope.vc.trackers.Phone.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_9891_52790.selectedRow = e.model;
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
                        nameEntityGrid: 'Phone',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_9891_52790", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_9891_52790");
                    $scope.vc.hideShowColumns("QV_9891_52790", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_9891_52790.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_9891_52790.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_9891_52790.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_9891_52790 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_9891_52790 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_9891_52790.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_9891_52790.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_9891_52790.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_9891_52790.column.personSecuential = {
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
                componentId: 'VA_TEXTINPUTBOXAUL_625436',
                element: []
            };
            $scope.vc.grids.QV_9891_52790.AT74_PERSONCE911 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.personSecuential.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXAUL_625436",
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.personSecuential.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9891_52790.column.personSecuential.format",
                        'k-decimals': "vc.viewState.QV_9891_52790.column.personSecuential.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9891_52790.column.personSecuential.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9891_52790.column.phoneId = {
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
                componentId: 'VA_TEXTINPUTBOXCPG_781436',
                element: []
            };
            $scope.vc.grids.QV_9891_52790.AT53_PHONEIDD911 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.phoneId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCPG_781436",
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.phoneId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9891_52790.column.phoneId.format",
                        'k-decimals': "vc.viewState.QV_9891_52790.column.phoneId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9891_52790.column.phoneId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9891_52790.column.phoneType = {
                title: 'CSTMR.LBL_CSTMR_TIPOTELON_26127',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQSJ_484436',
                template: "",
                element: []
            };
            $scope.vc.catalogs.VA_TEXTINPUTBOXQSJ_484436 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis(
                            'VA_TEXTINPUTBOXQSJ_484436',
                            'cl_ttelefono',

                        function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXQSJ_484436'];
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
            $scope.vc.grids.QV_9891_52790.AT45_PHONETYE911 = {
                control: function(container, options) {
                    var controlInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.phoneType.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQSJ_484436",
                        'kendo-ext-combo-box': "",
                        'ng-class': 'vc.viewState.QV_9891_52790.column.phoneType.style',
                        'k-data-source': "vc.catalogs.VA_TEXTINPUTBOXQSJ_484436",
                        'k-data-text-field': "'value'",
                        'k-data-value-field': "'code'",
                        'k-template': "vc.viewState.QV_9891_52790.column.phoneType.template",
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.phoneType.validationCode}}",
                        'k-filter': "'none'",
                        'k-min-length': "'1'",
                        'data-value-primitive': "true"
                    });
                    controlInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9891_52790.column.areaCode = {
                title: 'CSTMR.LBL_CSTMR_CODIGODAA_10229',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 1,
                componentId: 'VA_TEXTINPUTBOXOQK_778436',
                element: []
            };
            $scope.vc.grids.QV_9891_52790.AT52_AREACOED911 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.areaCode.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXOQK_778436",
                        'maxlength': 10,
                        'regular-expression': "",
                        'regexppattern': "[0-9]{1,8}",
                        'data-regularExpression-msg': $filter('translate')('CSTMR.MSG_CSTMR_ELVALORRO_55407'),
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.areaCode.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'designer-restrict-input': "numbers",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9891_52790.column.areaCode.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9891_52790.column.phoneNumber = {
                title: 'CSTMR.LBL_CSTMR_NMERODETL_29940',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 65,
                componentId: 'VA_TEXTINPUTBOXBZY_832436',
                element: []
            };
            $scope.vc.grids.QV_9891_52790.AT29_PHONENER911 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.phoneNumber.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBZY_832436",
                        'maxlength': 16,
                        'regular-expression': "",
                        'regexppattern': "[0-9]{4,15}",
                        'data-regularExpression-msg': $filter('translate')('CSTMR.MSG_CSTMR_ELVALORRO_55407'),
                        'custom-validate': "",
                        'data-customValidate-msg': $filter('translate')('DSGNR.SYS_DSGNR_MSGERRORE_00022'),
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.phoneNumber.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'designer-restrict-input': "numbers",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9891_52790.column.phoneNumber.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9891_52790.column.addressId = {
                title: 'addressId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXWJG_922436',
                element: []
            };
            $scope.vc.grids.QV_9891_52790.AT97_ADDRESIS911 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.addressId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXWJG_922436",
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.addressId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_9891_52790.column.addressId.format",
                        'k-decimals': "vc.viewState.QV_9891_52790.column.addressId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9891_52790.column.addressId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_9891_52790.column.isChecked = {
                title: 'isChecked',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXKFN_852436',
                element: []
            };
            $scope.vc.grids.QV_9891_52790.AT69_ISCHECEE911 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_9891_52790.column.isChecked.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXKFN_852436",
                        'data-validation-code': "{{vc.viewState.QV_9891_52790.column.isChecked.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_9891_52790.column.isChecked.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'personSecuential',
                    title: '{{vc.viewState.QV_9891_52790.column.personSecuential.title|translate:vc.viewState.QV_9891_52790.column.personSecuential.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.personSecuential.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.personSecuential.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT74_PERSONCE911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.personSecuential.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.personSecuential, \"QV_9891_52790\", \"personSecuential\"):kendo.toString(#=personSecuential#, vc.viewState.QV_9891_52790.column.personSecuential.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9891_52790.column.personSecuential.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.personSecuential.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.personSecuential.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'phoneId',
                    title: '{{vc.viewState.QV_9891_52790.column.phoneId.title|translate:vc.viewState.QV_9891_52790.column.phoneId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.phoneId.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.phoneId.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT53_PHONEIDD911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.phoneId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.phoneId, \"QV_9891_52790\", \"phoneId\"):kendo.toString(#=phoneId#, vc.viewState.QV_9891_52790.column.phoneId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9891_52790.column.phoneId.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.phoneId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.phoneId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'phoneType',
                    title: '{{vc.viewState.QV_9891_52790.column.phoneType.title|translate:vc.viewState.QV_9891_52790.column.phoneType.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.phoneType.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.phoneType.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT45_PHONETYE911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.phoneType.style' ng-bind='vc.catalogs.VA_TEXTINPUTBOXQSJ_484436.get(dataItem.phoneType).value'> </span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9891_52790.column.phoneType.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.phoneType.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.phoneType.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'areaCode',
                    title: '{{vc.viewState.QV_9891_52790.column.areaCode.title|translate:vc.viewState.QV_9891_52790.column.areaCode.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.areaCode.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.areaCode.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT52_AREACOED911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.areaCode.style' ng-bind='vc.getStringColumnFormat(dataItem.areaCode, \"QV_9891_52790\", \"areaCode\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9891_52790.column.areaCode.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.areaCode.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.areaCode.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'phoneNumber',
                    title: '{{vc.viewState.QV_9891_52790.column.phoneNumber.title|translate:vc.viewState.QV_9891_52790.column.phoneNumber.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.phoneNumber.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.phoneNumber.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT29_PHONENER911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.phoneNumber.style' ng-bind='vc.getStringColumnFormat(dataItem.phoneNumber, \"QV_9891_52790\", \"phoneNumber\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9891_52790.column.phoneNumber.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.phoneNumber.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.phoneNumber.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'addressId',
                    title: '{{vc.viewState.QV_9891_52790.column.addressId.title|translate:vc.viewState.QV_9891_52790.column.addressId.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.addressId.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.addressId.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT97_ADDRESIS911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.addressId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.addressId, \"QV_9891_52790\", \"addressId\"):kendo.toString(#=addressId#, vc.viewState.QV_9891_52790.column.addressId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_9891_52790.column.addressId.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.addressId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.addressId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'isChecked',
                    title: '{{vc.viewState.QV_9891_52790.column.isChecked.title|translate:vc.viewState.QV_9891_52790.column.isChecked.titleArgs}}',
                    width: $scope.vc.viewState.QV_9891_52790.column.isChecked.width,
                    format: $scope.vc.viewState.QV_9891_52790.column.isChecked.format,
                    editor: $scope.vc.grids.QV_9891_52790.AT69_ISCHECEE911.control,
                    template: "<span ng-class='vc.viewState.QV_9891_52790.column.isChecked.style' ng-bind='vc.getStringColumnFormat(dataItem.isChecked, \"QV_9891_52790\", \"isChecked\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_9891_52790.column.isChecked.style",
                        "title": "{{vc.viewState.QV_9891_52790.column.isChecked.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.isChecked.hidden
                });
            }
            $scope.vc.viewState.QV_9891_52790.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_9891_52790.column["delete"] = {
                element: []
            };
            $scope.vc.viewState.QV_9891_52790.column.cmdEdition = {};
            $scope.vc.viewState.QV_9891_52790.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_9891_52790.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_9891_52790.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9891_52790.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSJWN_806436.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }, {
                    name: "destroy",
                    text: "{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-delete': true}",
                    template: "<a ng-class='vc.getCssClass(\"destroy\", " + "vc.viewState.QV_9891_52790.column.delete.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_9891_52790.column.delete.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLDELETE_00008'|translate}}\" " + "ng-disabled = (vc.viewState.G_ADDRESSJWN_806436.disabled==true?true:false) " + ">" + "<span class='glyphicon glyphicon-remove'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_9891_52790.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436 = {
                    tooltip: '',
                    imageId: 'glyphicon glyphicon-ok',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436)) {
                    $scope.vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436 = {};
                }
                $scope.vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436.hidden = false;
                $scope.vc.grids.QV_9891_52790.columns.push({
                    field: 'VA_GRIDROWCOMMMAAD_321436',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMAAD_321436",
                        entity: "Phone",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmaad':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMAAD_321436\", " + "vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436.enabled || vc.viewState.G_ADDRESSJWN_806436.disabled' " + "data-ng-click = 'vc.grids.QV_9891_52790.events.customRowClick($event, \"VA_GRIDROWCOMMMAAD_321436\", \"#:entity#\", \"QV_9891_52790\")' " + "title = \"{{vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_9891_52790.column.VA_GRIDROWCOMMMAAD_321436.hidden
                });
            }
            $scope.vc.viewState.QV_9891_52790.toolbar = {
                create: {
                    visible: !designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode)
                }
            }
            $scope.vc.grids.QV_9891_52790.toolbar = [{
                "name": "create",
                "text": "",
                "template": "<button class = 'btn btn-default k-grid-add cb-grid-button' " + "ng-if = 'vc.viewState.QV_9891_52790.toolbar.create.visible' " + "ng-disabled = 'vc.viewState.G_ADDRESSJWN_806436.disabled?true:false'" + "title = \"{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}\" >" + "<span class='glyphicon glyphicon-plus-sign'></span>{{'DSGNR.SYS_DSGNR_LBLNEW000_00013'|translate}}</button>"
            }];
            $scope.vc.model.Context = {
                flag1: $scope.vc.channelDefaultValues("Context", "flag1"),
                flag2: $scope.vc.channelDefaultValues("Context", "flag2"),
                flag3: $scope.vc.channelDefaultValues("Context", "flag3"),
                renapoByCurp: $scope.vc.channelDefaultValues("Context", "renapoByCurp"),
                parents: $scope.vc.channelDefaultValues("Context", "parents"),
                channel: $scope.vc.channelDefaultValues("Context", "channel"),
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
            //ViewState - Group: Group1683
            $scope.vc.createViewState({
                id: "G_ADDRESSEEA_447436",
                hasId: true,
                componentStyle: [],
                label: 'Group1683',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1419",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_ADDRESSTODDXS_302_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_ADDRESSTODDXS_302_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TADDRESS_5TD",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ACEPTARZF_98506",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TADDRESS_DDD",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CANCELARR_82087",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.CustomerTmp = {
                code: $scope.vc.channelDefaultValues("CustomerTmp", "code"),
                paramVamail: $scope.vc.channelDefaultValues("CustomerTmp", "paramVamail")
            };
            $scope.vc.model.PostalCodeTmp = {
                cityCode: $scope.vc.channelDefaultValues("PostalCodeTmp", "cityCode"),
                parishCode: $scope.vc.channelDefaultValues("PostalCodeTmp", "parishCode"),
                provinceCode: $scope.vc.channelDefaultValues("PostalCodeTmp", "provinceCode")
            };
            if ($scope.vc.parentVc) {
                $scope.vc.afterOpenGridDialog();
            }
            var unregister = $scope.$watch('vc.afterInitData', function(newValue, oldValue) {
                if (newValue !== oldValue) {
                    unregister();
                    $scope.vc.catalogs.VA_TEXTINPUTBOXQSJ_484436.read();
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
                $scope.vc.render('VC_ADDRESSITS_306302');
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
    var cobisMainModule = cobis.createModule("VC_ADDRESSITS_306302", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_ADDRESSITS_306302", {
            templateUrl: "VC_ADDRESSITS_306302_FORM.html",
            controller: "VC_ADDRESSITS_306302_CTRL",
            labelId: "CSTMR.LBL_CSTMR_DIRECCINN_81106",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_ADDRESSITS_306302?" + $.param(search);
            }
        });
        VC_ADDRESSITS_306302(cobisMainModule);
    }]);
} else {
    VC_ADDRESSITS_306302(cobisMainModule);
}