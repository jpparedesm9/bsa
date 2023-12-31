//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.legalpersoncomposite = designerEvents.api.legalpersoncomposite || designer.dsgEvents();

function VC_LEGALPERIP_319665(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_LEGALPERIP_319665_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_LEGALPERIP_319665_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_LEGALPERSOCCN_665",
            taskVersion: "1.0.0",
            viewContainerId: "VC_LEGALPERIP_319665",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_LEGALPERSOCCN_665",
        designerEvents.api.legalpersoncomposite,
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
                vcName: 'VC_LEGALPERIP_319665'
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
                    taskId: 'T_LEGALPERSOCCN_665',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LegalPerson: "LegalPerson",
                    LegalRepresentative: "LegalRepresentative",
                    EconomicInformationLegalPerson: "EconomicInformationLegalPerson"
                },
                entities: {
                    LegalPerson: {
                        coverageDescription: 'AT14_COVERARI669',
                        segmentDescription: 'AT14_LEGALTSR669',
                        constitutionDate: 'AT19_CONSTITO669',
                        personSecuential: 'AT29_PERSONNN669',
                        constitutionPlaceCode: 'AT34_CONSTIAT669',
                        segmentCode: 'AT47_LEGALTOE669',
                        legalpersonTypeDescription: 'AT49_LEGALNAD669',
                        documentType: 'AT53_DOCUMEEY669',
                        personType: 'AT53_PERSONPT669',
                        documentTypeDescription: 'AT59_DOCUMEND669',
                        legalpersonTypeCode: 'AT59_LEGALNED669',
                        coverageCode: 'AT60_COVERAOG669',
                        emailAddress: 'AT63_EMAILADR669',
                        tradename: 'AT67_TRADENEM669',
                        relationId: 'AT68_RELATIIO669',
                        businessName: 'AT69_BUSINEEM669',
                        acronym: 'AT91_ACRONYMM669',
                        documentNumber: 'AT92_DOCUMENN669',
                        expirationDate: 'AT94_EXPIRANO669',
                        constitutionPlaceDescription: 'AT98_CONSTIAE669',
                        _pks: [],
                        _entityId: 'EN_PERSONOWF_669',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    LegalRepresentative: {
                        effectiveDate: 'AT21_EFFECTEE503',
                        undefinedEffectiveDate: 'AT31_UNDEFIEF503',
                        legalRepresentativeCode: 'AT37_LEGALREE503',
                        notaryOffice: 'AT38_NOTARYEO503',
                        legalRepresentativeDescription: 'AT69_LEGALRRN503',
                        notary: 'AT74_NOTARYSH503',
                        _pks: [],
                        _entityId: 'EN_LEGALRETT_503',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    EconomicInformationLegalPerson: {
                        companyId: 'AT25_COMPANYI838',
                        totalCapital: 'AT33_TOTALCAA838',
                        comment: 'AT35_COMMENTT838',
                        revenues: 'AT39_REVENUEE838',
                        expenses: 'AT47_EXPENSEE838',
                        relation: 'AT50_RELATIOO838',
                        retentionTax: 'AT54_RETENTOI838',
                        netWorth: 'AT75_NETWORTT838',
                        numberOfEmployess: 'AT91_NUMBERPL838',
                        _pks: [],
                        _entityId: 'EN_ECONOMINE_838',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                LegalPerson: {},
                LegalRepresentative: {},
                EconomicInformationLegalPerson: {}
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
                $scope.vc.execute("temporarySave", VC_LEGALPERIP_319665, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_LEGALPERIP_319665, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_LEGALPERIP_319665, data, function() {});
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
            $scope.vc.viewState.VC_LEGALPERIP_319665 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_LEGALPERIP_319665",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_MANTENISO_94651",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_EZDCJRRUQH_303665",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: LegalPersonHeader
            $scope.vc.createViewState({
                id: "VC_QIDBKAOFBT_411749",
                hasId: true,
                componentStyle: [],
                label: 'LegalPersonHeader',
                enabled: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1579
            $scope.vc.createViewState({
                id: "G_LEGALPEOEE_264688",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1579',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1852
            $scope.vc.createViewState({
                id: "G_LEGALPEARR_339688",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group1852',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_LEGALPEARR_339688-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_GYFHHEGNQM_166665",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GeneralLegalPerson
            $scope.vc.createViewState({
                id: "VC_UKQMJWXLMP_676980",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INACINGEE_61728",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.LegalPerson = {
                coverageDescription: $scope.vc.channelDefaultValues("LegalPerson", "coverageDescription"),
                segmentDescription: $scope.vc.channelDefaultValues("LegalPerson", "segmentDescription"),
                constitutionDate: $scope.vc.channelDefaultValues("LegalPerson", "constitutionDate"),
                personSecuential: $scope.vc.channelDefaultValues("LegalPerson", "personSecuential"),
                constitutionPlaceCode: $scope.vc.channelDefaultValues("LegalPerson", "constitutionPlaceCode"),
                segmentCode: $scope.vc.channelDefaultValues("LegalPerson", "segmentCode"),
                legalpersonTypeDescription: $scope.vc.channelDefaultValues("LegalPerson", "legalpersonTypeDescription"),
                documentType: $scope.vc.channelDefaultValues("LegalPerson", "documentType"),
                personType: $scope.vc.channelDefaultValues("LegalPerson", "personType"),
                documentTypeDescription: $scope.vc.channelDefaultValues("LegalPerson", "documentTypeDescription"),
                legalpersonTypeCode: $scope.vc.channelDefaultValues("LegalPerson", "legalpersonTypeCode"),
                coverageCode: $scope.vc.channelDefaultValues("LegalPerson", "coverageCode"),
                emailAddress: $scope.vc.channelDefaultValues("LegalPerson", "emailAddress"),
                tradename: $scope.vc.channelDefaultValues("LegalPerson", "tradename"),
                relationId: $scope.vc.channelDefaultValues("LegalPerson", "relationId"),
                businessName: $scope.vc.channelDefaultValues("LegalPerson", "businessName"),
                acronym: $scope.vc.channelDefaultValues("LegalPerson", "acronym"),
                documentNumber: $scope.vc.channelDefaultValues("LegalPerson", "documentNumber"),
                expirationDate: $scope.vc.channelDefaultValues("LegalPerson", "expirationDate"),
                constitutionPlaceDescription: $scope.vc.channelDefaultValues("LegalPerson", "constitutionPlaceDescription")
            };
            //ViewState - Group: Group1822
            $scope.vc.createViewState({
                id: "G_GENERALLNA_884218",
                hasId: true,
                componentStyle: [],
                label: 'Group1822',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_PERSONSECUENALT_767218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGODEMA_27548",
                format: "#",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1717",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: tradename
            $scope.vc.createViewState({
                id: "VA_TRADENAMEDWNOWX_761218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RAZNSOCLL_50091",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: businessName
            $scope.vc.createViewState({
                id: "VA_BUSINESSNAMEYVT_165218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBRECAR_58217",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: acronym
            $scope.vc.createViewState({
                id: "VA_ACRONYMFPGZNGMA_160218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SIGLASHEU_94411",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: constitutionPlaceCode
            $scope.vc.createViewState({
                id: "VA_CONSTITUTIONALO_985218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_LUGARDENI_21742",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_CONSTITUTIONALO_985218 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_CONSTITUTIONALO_985218', 'cl_pais', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_CONSTITUTIONALO_985218'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_CONSTITUTIONALO_985218");
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
            //ViewState - Entity: LegalPerson, Attribute: coverageCode
            $scope.vc.createViewState({
                id: "VA_COVERAGECODEKYA_355218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_COBERTUAR_95403",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COVERAGECODEKYA_355218 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_COVERAGECODEKYA_355218', 'cl_cobertura', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_COVERAGECODEKYA_355218'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COVERAGECODEKYA_355218");
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
            //ViewState - Entity: LegalPerson, Attribute: segmentCode
            $scope.vc.createViewState({
                id: "VA_SEGMENTCODEGCBX_858218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEPAN_80704",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_SEGMENTCODEGCBX_858218 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_SEGMENTCODEGCBX_858218', 'cl_tip_resd', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_SEGMENTCODEGCBX_858218'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_SEGMENTCODEGCBX_858218");
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
            //ViewState - Entity: LegalPerson, Attribute: legalpersonTypeCode
            $scope.vc.createViewState({
                id: "VA_LEGALPERSONTDOE_564218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NATURALCU_10498",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_LEGALPERSONTDOE_564218 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_LEGALPERSONTDOE_564218', 'cl_tipn_jur', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_LEGALPERSONTDOE_564218'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_LEGALPERSONTDOE_564218");
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
                id: "VA_VABUTTONECKBAAP_763218",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BUSCARAUU_89471",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Container: LegalRepresentative
            $scope.vc.createViewState({
                id: "VC_EEYLNTXPGW_683573",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_REPRESELN_82777",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.LegalRepresentative = {
                effectiveDate: $scope.vc.channelDefaultValues("LegalRepresentative", "effectiveDate"),
                undefinedEffectiveDate: $scope.vc.channelDefaultValues("LegalRepresentative", "undefinedEffectiveDate"),
                legalRepresentativeCode: $scope.vc.channelDefaultValues("LegalRepresentative", "legalRepresentativeCode"),
                notaryOffice: $scope.vc.channelDefaultValues("LegalRepresentative", "notaryOffice"),
                legalRepresentativeDescription: $scope.vc.channelDefaultValues("LegalRepresentative", "legalRepresentativeDescription"),
                notary: $scope.vc.channelDefaultValues("LegalRepresentative", "notary")
            };
            //ViewState - Group: Group1957
            $scope.vc.createViewState({
                id: "G_LEGALRENEE_282183",
                hasId: true,
                componentStyle: [],
                label: 'Group1957',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VACOMPOSITEPXJW_128183",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalRepresentative, Attribute: legalRepresentativeDescription
            $scope.vc.createViewState({
                id: "VA_LEGALREPRESEDOV_726183",
                componentStyle: [],
                tooltip: "CSTMR.LBL_CSTMR_REPRESELN_82777",
                label: "CSTMR.LBL_CSTMR_REPRESELN_82777",
                validationCode: 32,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VAIMAGEBUTTONNN_454183",
                componentStyle: [],
                imageId: "glyphicon glyphicon-search",
                label: ".",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2887",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalRepresentative, Attribute: effectiveDate
            $scope.vc.createViewState({
                id: "VA_EFFECTIVEDATEEE_633183",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADEII_38004",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalRepresentative, Attribute: undefinedEffectiveDate
            $scope.vc.createViewState({
                id: "VA_UNDEFINEDEFFTED_315183",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INDEFINDD_73604",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2163",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalRepresentative, Attribute: notary
            $scope.vc.createViewState({
                id: "VA_NOTARYNIATUIHUR_589183",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBREDER_76802",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalRepresentative, Attribute: notaryOffice
            $scope.vc.createViewState({
                id: "VA_NOTARYOFFICETCR_359183",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBREDEA_54428",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Container: EconomicInformationLegalPerson
            $scope.vc.createViewState({
                id: "VC_AZLUZHPHQP_260249",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DATOSECNO_56122",
                enabled: designer.constants.mode.All
            });
            $scope.vc.model.EconomicInformationLegalPerson = {
                companyId: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "companyId"),
                totalCapital: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "totalCapital"),
                comment: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "comment"),
                revenues: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "revenues"),
                expenses: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "expenses"),
                relation: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "relation"),
                retentionTax: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "retentionTax"),
                netWorth: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "netWorth"),
                numberOfEmployess: $scope.vc.channelDefaultValues("EconomicInformationLegalPerson", "numberOfEmployess")
            };
            //ViewState - Group: Group1603
            $scope.vc.createViewState({
                id: "G_ECONOMILGE_495907",
                hasId: true,
                componentStyle: [],
                label: 'Group1603',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: revenues
            $scope.vc.createViewState({
                id: "VA_REVENUESQGEWIHS_280907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INGRESOSU_58372",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: expenses
            $scope.vc.createViewState({
                id: "VA_EXPENSESRCJVIIQ_307907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_EGRESOSLL_45908",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: netWorth
            $scope.vc.createViewState({
                id: "VA_NETWORTHIBLGQTH_695907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PATRIMOUB_99281",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: totalCapital
            $scope.vc.createViewState({
                id: "VA_TOTALCAPITALAYY_574907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TOTALACIT_27501",
                format: "c",
                decimals: kendo.cultures.current.numberFormat.decimals,
                validationCode: 34,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: retentionTax
            $scope.vc.createViewState({
                id: "VA_RETENTIONTAXELL_629907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RETENCIOP_14498",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2237",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: numberOfEmployess
            $scope.vc.createViewState({
                id: "VA_NUMBEROFEMPLSOS_350907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODEAL_38122",
                format: "######",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: relation
            $scope.vc.createViewState({
                id: "VA_RELATIONZASQMMJ_993907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RELACINLO_69491",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RELATIONZASQMMJ_993907 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RELATIONZASQMMJ_993907', 'cl_relacion_banco', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RELATIONZASQMMJ_993907'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RELATIONZASQMMJ_993907");
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
                id: "Spacer2280",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: EconomicInformationLegalPerson, Attribute: comment
            $scope.vc.createViewState({
                id: "VA_COMMENTSCTJBKBX_371907",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_COMENTASO_77518",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_LEGALPERSOCCN_665_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_LEGALPERSOCCN_665_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TLEGALPE_CLM",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
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
                $scope.vc.render('VC_LEGALPERIP_319665');
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
    var cobisMainModule = cobis.createModule("VC_LEGALPERIP_319665", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_LEGALPERIP_319665", {
            templateUrl: "VC_LEGALPERIP_319665_FORM.html",
            controller: "VC_LEGALPERIP_319665_CTRL",
            labelId: "CSTMR.LBL_CSTMR_MANTENISO_94651",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_LEGALPERIP_319665?" + $.param(search);
            }
        });
        VC_LEGALPERIP_319665(cobisMainModule);
    }]);
} else {
    VC_LEGALPERIP_319665(cobisMainModule);
}