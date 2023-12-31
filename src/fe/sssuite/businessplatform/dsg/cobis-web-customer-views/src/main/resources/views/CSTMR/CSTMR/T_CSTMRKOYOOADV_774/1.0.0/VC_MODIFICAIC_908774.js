//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.modificationcurprfcform = designerEvents.api.modificationcurprfcform || designer.dsgEvents();

function VC_MODIFICAIC_908774(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_MODIFICAIC_908774_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_MODIFICAIC_908774_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CSTMRKOYOOADV_774",
            taskVersion: "1.0.0",
            viewContainerId: "VC_MODIFICAIC_908774",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CSTMRKOYOOADV_774",
        designerEvents.api.modificationcurprfcform,
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
                vcName: 'VC_MODIFICAIC_908774'
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
                    taskId: 'T_CSTMRKOYOOADV_774',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    NaturalPerson: "NaturalPerson",
                    Context: "Context"
                },
                entities: {
                    NaturalPerson: {
                        nameGroup: 'AT12_NAMEGRPU593',
                        secondSurname: 'AT12_SECONDUU593',
                        birthDate: 'AT16_BIRTHDET593',
                        secondName: 'AT16_SECONDMN593',
                        hasAlert: 'AT19_HASALETT593',
                        surname: 'AT19_SURNAMEE593',
                        maritalStatusDescription: 'AT21_MARITAPC593',
                        bioCIC: 'AT22_BIOCICTP593',
                        indefinite: 'AT22_INDEFIII593',
                        nationalityCode: 'AT22_NATIONLY593',
                        santanderAccount: 'AT24_SANTANDD593',
                        firstName: 'AT25_FIRSTNME593',
                        individualRisk: 'AT26_INDIVIRL593',
                        hasPartner: 'AT27_HASPARTN593',
                        bioOCR: 'AT29_BIOOCRXM593',
                        documentTypeDescription: 'AT30_DOCUMENN593',
                        hasListBlack: 'AT31_HASLISAK593',
                        monthsInForce: 'AT33_MONTHSIN593',
                        personPEP: 'AT33_PERSONEP593',
                        chargePub: 'AT34_CHARGEPU593',
                        technologicalDegree: 'AT34_TECHNOEI593',
                        personType: 'AT35_PERSONYP593',
                        spouse: 'AT35_SPOUSEQQ593',
                        officerCode: 'AT36_OFFICEDR593',
                        statusCode: 'AT36_STATUSCE593',
                        age: 'AT38_AGEXSCCY593',
                        bioHasFingerprint: 'AT38_BIOHASII593',
                        accountIndividual: 'AT39_ACCOUNIT593',
                        documentNumber: 'AT40_DOCUMENN593',
                        marriedSurname: 'AT43_MARRIERM593',
                        countryCode: 'AT44_COUNTRBF593',
                        bioReaderKey: 'AT45_BIOREAER593',
                        expirationDate: 'AT45_EXPIRANN593',
                        email: 'AT55_EMAILJMM593',
                        riskLevel: 'AT58_RISKLEEE593',
                        personSecuential: 'AT62_PERSONTA593',
                        genderDescription: 'AT64_MARITATS593',
                        identificationRFC: 'AT65_IDENTIIN593',
                        isLinked: 'AT68_LINKEDKL593',
                        nationalityCodeAux: 'AT68_NATIONXA593',
                        relChargePub: 'AT71_RELCHAPE593',
                        genderCode: 'AT72_GENDERUC593',
                        santanderCode: 'AT73_SANTANDD593',
                        bioIdentificationType: 'AT74_BIOIDEOA593',
                        maritalStatusCode: 'AT74_MARITASO593',
                        numCycles: 'AT76_NUMCYCEE593',
                        bioEmissionNumber: 'AT79_BIOEMIRN593',
                        documentType: 'AT81_DOCUMETE593',
                        hasProblems: 'AT82_HASPROBL593',
                        publicPerson: 'AT85_PUBLICSO593',
                        knownAs: 'AT87_KNOWNASS593',
                        nivelColectivo: 'AT89_NIVELCOT593',
                        countyOfBirth: 'AT92_COUNTYRF593',
                        idGroup: 'AT92_IDGROUPP593',
                        bioRenapoResult: 'AT93_BIORENSR593',
                        colectivo: 'AT93_COLECTVV593',
                        relationId: 'AT94_RELATINI593',
                        branchCode: 'AT98_BRANCHOC593',
                        creditBureau: 'AT98_CREDITUU593',
                        _pks: [],
                        _entityId: 'EN_NATURALES_593',
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
                        officeName: 'AT61_OFFICEAE215',
                        maximumAge: 'AT62_MAXIMUAA215',
                        son: 'AT70_SONFRKEM215',
                        defaultCountry: 'AT84_DEFAULYR215',
                        generateReport: 'AT85_GENERATP215',
                        renapo: 'AT89_RENAPOOT215',
                        printReport: 'AT90_PRINTRRT215',
                        _pks: [],
                        _entityId: 'EN_CREDITLBQ_215',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                NaturalPerson: {},
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
                $scope.vc.execute("temporarySave", VC_MODIFICAIC_908774, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_MODIFICAIC_908774, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_MODIFICAIC_908774, data, function() {});
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
            $scope.vc.viewState.VC_MODIFICAIC_908774 = {
                style: []
            }
            //ViewState - Group: GroupLayout2921
            $scope.vc.createViewState({
                id: "G_MODIFICFAC_913882",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout2921',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2526
            $scope.vc.createViewState({
                id: "G_MODIFICRNF_489882",
                hasId: true,
                componentStyle: [],
                htmlSection: true,
                label: 'Group2526',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "G_MODIFICRNF_489882-default-blank",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1809
            $scope.vc.createViewState({
                id: "G_MODIFICTOC_796882",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1809',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.NaturalPerson = {
                nameGroup: $scope.vc.channelDefaultValues("NaturalPerson", "nameGroup"),
                secondSurname: $scope.vc.channelDefaultValues("NaturalPerson", "secondSurname"),
                birthDate: $scope.vc.channelDefaultValues("NaturalPerson", "birthDate"),
                secondName: $scope.vc.channelDefaultValues("NaturalPerson", "secondName"),
                hasAlert: $scope.vc.channelDefaultValues("NaturalPerson", "hasAlert"),
                surname: $scope.vc.channelDefaultValues("NaturalPerson", "surname"),
                maritalStatusDescription: $scope.vc.channelDefaultValues("NaturalPerson", "maritalStatusDescription"),
                bioCIC: $scope.vc.channelDefaultValues("NaturalPerson", "bioCIC"),
                indefinite: $scope.vc.channelDefaultValues("NaturalPerson", "indefinite"),
                nationalityCode: $scope.vc.channelDefaultValues("NaturalPerson", "nationalityCode"),
                santanderAccount: $scope.vc.channelDefaultValues("NaturalPerson", "santanderAccount"),
                firstName: $scope.vc.channelDefaultValues("NaturalPerson", "firstName"),
                individualRisk: $scope.vc.channelDefaultValues("NaturalPerson", "individualRisk"),
                hasPartner: $scope.vc.channelDefaultValues("NaturalPerson", "hasPartner"),
                bioOCR: $scope.vc.channelDefaultValues("NaturalPerson", "bioOCR"),
                documentTypeDescription: $scope.vc.channelDefaultValues("NaturalPerson", "documentTypeDescription"),
                hasListBlack: $scope.vc.channelDefaultValues("NaturalPerson", "hasListBlack"),
                monthsInForce: $scope.vc.channelDefaultValues("NaturalPerson", "monthsInForce"),
                personPEP: $scope.vc.channelDefaultValues("NaturalPerson", "personPEP"),
                chargePub: $scope.vc.channelDefaultValues("NaturalPerson", "chargePub"),
                technologicalDegree: $scope.vc.channelDefaultValues("NaturalPerson", "technologicalDegree"),
                personType: $scope.vc.channelDefaultValues("NaturalPerson", "personType"),
                spouse: $scope.vc.channelDefaultValues("NaturalPerson", "spouse"),
                officerCode: $scope.vc.channelDefaultValues("NaturalPerson", "officerCode"),
                statusCode: $scope.vc.channelDefaultValues("NaturalPerson", "statusCode"),
                age: $scope.vc.channelDefaultValues("NaturalPerson", "age"),
                bioHasFingerprint: $scope.vc.channelDefaultValues("NaturalPerson", "bioHasFingerprint"),
                accountIndividual: $scope.vc.channelDefaultValues("NaturalPerson", "accountIndividual"),
                documentNumber: $scope.vc.channelDefaultValues("NaturalPerson", "documentNumber"),
                marriedSurname: $scope.vc.channelDefaultValues("NaturalPerson", "marriedSurname"),
                countryCode: $scope.vc.channelDefaultValues("NaturalPerson", "countryCode"),
                bioReaderKey: $scope.vc.channelDefaultValues("NaturalPerson", "bioReaderKey"),
                expirationDate: $scope.vc.channelDefaultValues("NaturalPerson", "expirationDate"),
                email: $scope.vc.channelDefaultValues("NaturalPerson", "email"),
                riskLevel: $scope.vc.channelDefaultValues("NaturalPerson", "riskLevel"),
                personSecuential: $scope.vc.channelDefaultValues("NaturalPerson", "personSecuential"),
                genderDescription: $scope.vc.channelDefaultValues("NaturalPerson", "genderDescription"),
                identificationRFC: $scope.vc.channelDefaultValues("NaturalPerson", "identificationRFC"),
                isLinked: $scope.vc.channelDefaultValues("NaturalPerson", "isLinked"),
                nationalityCodeAux: $scope.vc.channelDefaultValues("NaturalPerson", "nationalityCodeAux"),
                relChargePub: $scope.vc.channelDefaultValues("NaturalPerson", "relChargePub"),
                genderCode: $scope.vc.channelDefaultValues("NaturalPerson", "genderCode"),
                santanderCode: $scope.vc.channelDefaultValues("NaturalPerson", "santanderCode"),
                bioIdentificationType: $scope.vc.channelDefaultValues("NaturalPerson", "bioIdentificationType"),
                maritalStatusCode: $scope.vc.channelDefaultValues("NaturalPerson", "maritalStatusCode"),
                numCycles: $scope.vc.channelDefaultValues("NaturalPerson", "numCycles"),
                bioEmissionNumber: $scope.vc.channelDefaultValues("NaturalPerson", "bioEmissionNumber"),
                documentType: $scope.vc.channelDefaultValues("NaturalPerson", "documentType"),
                hasProblems: $scope.vc.channelDefaultValues("NaturalPerson", "hasProblems"),
                publicPerson: $scope.vc.channelDefaultValues("NaturalPerson", "publicPerson"),
                knownAs: $scope.vc.channelDefaultValues("NaturalPerson", "knownAs"),
                nivelColectivo: $scope.vc.channelDefaultValues("NaturalPerson", "nivelColectivo"),
                countyOfBirth: $scope.vc.channelDefaultValues("NaturalPerson", "countyOfBirth"),
                idGroup: $scope.vc.channelDefaultValues("NaturalPerson", "idGroup"),
                bioRenapoResult: $scope.vc.channelDefaultValues("NaturalPerson", "bioRenapoResult"),
                colectivo: $scope.vc.channelDefaultValues("NaturalPerson", "colectivo"),
                relationId: $scope.vc.channelDefaultValues("NaturalPerson", "relationId"),
                branchCode: $scope.vc.channelDefaultValues("NaturalPerson", "branchCode"),
                creditBureau: $scope.vc.channelDefaultValues("NaturalPerson", "creditBureau")
            };
            //ViewState - Group: Group1150
            $scope.vc.createViewState({
                id: "G_MODIFICRCU_286882",
                hasId: true,
                componentStyle: [],
                label: 'Group1150',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: surname
            $scope.vc.createViewState({
                id: "VA_SURNAMEJMXFJCDM_400882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondSurname
            $scope.vc.createViewState({
                id: "VA_SECONDSURNAMEEE_993882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1673",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: firstName
            $scope.vc.createViewState({
                id: "VA_FIRSTNAMEULIWNW_629882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondName
            $scope.vc.createViewState({
                id: "VA_SECONDNAMELPYWW_643882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDOEN_22809",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2488",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: birthDate
            $scope.vc.createViewState({
                id: "VA_BIRTHDATEKSDLAL_625882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETE_15731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: countyOfBirth
            $scope.vc.createViewState({
                id: "VA_COUNTYOFBIRTHHH_156882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DENACIMTN_68832",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COUNTYOFBIRTHHH_156882 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COUNTYOFBIRTHHH_156882', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COUNTYOFBIRTHHH_156882'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COUNTYOFBIRTHHH_156882");
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
                id: "Spacer2889",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: genderCode
            $scope.vc.createViewState({
                id: "VA_GENDERCODELZYIQ_211882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GENEROEHS_60662",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GENDERCODELZYIQ_211882 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GENDERCODELZYIQ_211882', 'cl_sexo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GENDERCODELZYIQ_211882'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GENDERCODELZYIQ_211882");
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
            //ViewState - Entity: NaturalPerson, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_DOCUMENTTYPEMOR_836882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_IDENTIFII_21251",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTTYPEMOR_836882 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_DOCUMENTTYPEMOR_836882', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTTYPEMOR_836882'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTTYPEMOR_836882");
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
            //ViewState - Group: Group1436
            $scope.vc.createViewState({
                id: "G_MODIFICAIR_201882",
                hasId: true,
                componentStyle: [],
                label: 'Group1436',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATORPLHG_215882",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2674
            $scope.vc.createViewState({
                id: "G_MODIFICORA_615882",
                hasId: true,
                componentStyle: [],
                label: 'Group2674',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: identificationRFC
            $scope.vc.createViewState({
                id: "VA_IDENTIFICATICCN_494882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RFCCGUEPZ_59640",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: documentNumber
            $scope.vc.createViewState({
                id: "VA_DOCUMENTNUMBEER_711882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODOCN_38523",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group2260
            $scope.vc.createViewState({
                id: "G_MODIFICCAN_105882",
                hasId: true,
                componentStyle: [],
                label: 'Group2260',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VASEPARATOROSCX_108882",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1979
            $scope.vc.createViewState({
                id: "G_MODIFICARO_457882",
                hasId: true,
                componentStyle: [],
                label: 'Group1979',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: santanderCode
            $scope.vc.createViewState({
                id: "VA_SANTANDERCODEEE_772882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOSAAA_38846",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: accountIndividual
            $scope.vc.createViewState({
                id: "VA_ACCOUNTINDIVILI_271882",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CUENTAILI_97010",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1615
            $scope.vc.createViewState({
                id: "G_MODIFICTRA_319882",
                hasId: true,
                componentStyle: [],
                label: 'Group1615',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONBISUTWO_919882",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CSTMRKOYOOADV_774_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CSTMRKOYOOADV_774_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TCSTMRKO_C00",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
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
                officeName: $scope.vc.channelDefaultValues("Context", "officeName"),
                maximumAge: $scope.vc.channelDefaultValues("Context", "maximumAge"),
                son: $scope.vc.channelDefaultValues("Context", "son"),
                defaultCountry: $scope.vc.channelDefaultValues("Context", "defaultCountry"),
                generateReport: $scope.vc.channelDefaultValues("Context", "generateReport"),
                renapo: $scope.vc.channelDefaultValues("Context", "renapo"),
                printReport: $scope.vc.channelDefaultValues("Context", "printReport")
            };
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
                $scope.vc.render('VC_MODIFICAIC_908774');
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
    var cobisMainModule = cobis.createModule("VC_MODIFICAIC_908774", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_MODIFICAIC_908774", {
            templateUrl: "VC_MODIFICAIC_908774_FORM.html",
            controller: "VC_MODIFICAIC_908774_CTRL",
            label: "ModificationCURPRFCForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_MODIFICAIC_908774?" + $.param(search);
            }
        });
        VC_MODIFICAIC_908774(cobisMainModule);
    }]);
} else {
    VC_MODIFICAIC_908774(cobisMainModule);
}