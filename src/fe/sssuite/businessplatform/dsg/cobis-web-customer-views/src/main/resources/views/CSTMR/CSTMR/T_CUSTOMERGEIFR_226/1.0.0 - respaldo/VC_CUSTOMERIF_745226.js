//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.customergeneralinfform = designerEvents.api.customergeneralinfform || designer.dsgEvents();

function VC_CUSTOMERIF_745226(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_CUSTOMERIF_745226_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_CUSTOMERIF_745226_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_CUSTOMERGEIFR_226",
            taskVersion: "1.0.0",
            viewContainerId: "VC_CUSTOMERIF_745226",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_CUSTOMERGEIFR_226",
        designerEvents.api.customergeneralinfform,
        $scope.rowData);
        $scope.vc.routeProvider = cobisMainModule.routeProvider;
        if (!$scope.vc.loaded) {
            var page = {
                hasTemporaryDataSupport: false,
                hasInitDataSupport: false,
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
                vcName: 'VC_CUSTOMERIF_745226'
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
                    taskId: 'T_CUSTOMERGEIFR_226',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    NaturalPerson: "NaturalPerson",
                    Context: "Context",
                    Person: "Person",
                    Parameters: "Parameters"
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
                        collectiveLevel: 'AT55_COLLECET215',
                        officeName: 'AT61_OFFICEAE215',
                        maximumAge: 'AT62_MAXIMUAA215',
                        son: 'AT70_SONFRKEM215',
                        defaultCountry: 'AT84_DEFAULYR215',
                        collective: 'AT85_COLLECVI215',
                        generateReport: 'AT85_GENERATP215',
                        roleEnabledQueryAccount: 'AT86_ROLEENBO215',
                        renapo: 'AT89_RENAPOOT215',
                        printReport: 'AT90_PRINTRRT215',
                        _pks: [],
                        _entityId: 'EN_CREDITLBQ_215',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Person: {
                        statusCode: 'AT26_STATUSCE767',
                        fullName: 'AT38_FULLNAEE767',
                        blocked: 'AT42_BLOCKEDD767',
                        operation: 'AT42_OPERATII767',
                        typePerson: 'AT61_TYPEPERS767',
                        office: 'AT75_OFFICEMF767',
                        santanderCode: 'AT76_SANTANRC767',
                        official: 'AT77_OFFICILL767',
                        personSecuential: 'AT89_PERSONCA767',
                        _pks: [],
                        _entityId: 'EN_PERSONUDL_767',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Parameters: {
                        minimumAge: 'AT43_MINIMUAE311',
                        screenMode: 'AT50_SCREENMD311',
                        allowUpdateNames: 'AT79_ALLOWUNA311',
                        idExpiration: 'AT93_IDEXPIRT311',
                        refresGrid: 'AT97_REFRESDR311',
                        _pks: [],
                        _entityId: 'EN_PARAMETER_311',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                NaturalPerson: {},
                Context: {},
                Person: {},
                Parameters: {}
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
                $scope.vc.execute("temporarySave", VC_CUSTOMERIF_745226, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_CUSTOMERIF_745226, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_CUSTOMERIF_745226, data, function() {});
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
            $scope.vc.viewState.VC_CUSTOMERIF_745226 = {
                style: []
            }
            $scope.vc.model.Person = {
                statusCode: $scope.vc.channelDefaultValues("Person", "statusCode"),
                fullName: $scope.vc.channelDefaultValues("Person", "fullName"),
                blocked: $scope.vc.channelDefaultValues("Person", "blocked"),
                operation: $scope.vc.channelDefaultValues("Person", "operation"),
                typePerson: $scope.vc.channelDefaultValues("Person", "typePerson"),
                office: $scope.vc.channelDefaultValues("Person", "office"),
                santanderCode: $scope.vc.channelDefaultValues("Person", "santanderCode"),
                official: $scope.vc.channelDefaultValues("Person", "official"),
                personSecuential: $scope.vc.channelDefaultValues("Person", "personSecuential")
            };
            //ViewState - Group: Group1954
            $scope.vc.createViewState({
                id: "G_CUSTOMEGNN_387213",
                hasId: true,
                componentStyle: [],
                label: 'Group1954',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Person, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_9366OENXNWUBACV_720213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SECUENCCN_71871",
                format: "##########",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Person, Attribute: santanderCode
            $scope.vc.createViewState({
                id: "VA_SANTANDERCODEEE_700213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOSAAA_38846",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Person, Attribute: typePerson
            $scope.vc.createViewState({
                id: "VA_TYPEPERSONLSDIM_548213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPONLGNZ_38251",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TYPEPERSONLSDIM_548213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TYPEPERSONLSDIM_548213', 'cl_tipo_persona', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TYPEPERSONLSDIM_548213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TYPEPERSONLSDIM_548213");
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
            //ViewState - Entity: Person, Attribute: statusCode
            $scope.vc.createViewState({
                id: "VA_STATUSCODEMPXFC_766213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOXKN_15577",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_STATUSCODEMPXFC_766213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_STATUSCODEMPXFC_766213', 'cl_estados_ente', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_STATUSCODEMPXFC_766213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_STATUSCODEMPXFC_766213");
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
            //ViewState - Entity: Person, Attribute: blocked
            $scope.vc.createViewState({
                id: "VA_BLOCKEDZUOBRBYZ_833213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOXKN_15577",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: GroupLayout1753
            $scope.vc.createViewState({
                id: "G_CUSTOMEEIR_814213",
                hasId: true,
                componentStyle: [],
                label: 'GroupLayout1753',
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
            //ViewState - Group: Group2980
            $scope.vc.createViewState({
                id: "G_CUSTOMEEAN_819213",
                hasId: true,
                componentStyle: [],
                label: 'Group2980',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: firstName
            $scope.vc.createViewState({
                id: "VA_FIRSTNAMEFPYKAF_649213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondName
            $scope.vc.createViewState({
                id: "VA_SECONDNAMESJJYD_721213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDOEN_22809",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: surname
            $scope.vc.createViewState({
                id: "VA_SURNAMESONBWSJR_285213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondSurname
            $scope.vc.createViewState({
                id: "VA_SECONDSURNAMEEE_733213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: santanderCode
            $scope.vc.createViewState({
                id: "VA_SANTANDERCODEEE_693213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOSAAA_38846",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_DOCUMENTTYPEAQM_964213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_IDENTIFII_74621",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTTYPEAQM_964213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_DOCUMENTTYPEAQM_964213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTTYPEAQM_964213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTTYPEAQM_964213");
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
            //ViewState - Entity: NaturalPerson, Attribute: documentNumber
            $scope.vc.createViewState({
                id: "VA_DOCUMENTNUMBRRE_960213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODOCM_93257",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: identificationRFC
            $scope.vc.createViewState({
                id: "VA_IDENTIFICATICCC_741213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RFCCGUEPZ_59640",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioRenapoResult
            $scope.vc.createViewState({
                id: "VA_BIORENAPORESTLT_770213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADORAO_58902",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BIORENAPORESTLT_770213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BIORENAPORESTLT_770213', 'cl_respuesta_renapo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BIORENAPORESTLT_770213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BIORENAPORESTLT_770213");
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
            //ViewState - Entity: NaturalPerson, Attribute: expirationDate
            $scope.vc.createViewState({
                id: "VA_EXPIRATIONDAEET_157213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VENCIMIIC_88444",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: indefinite
            $scope.vc.createViewState({
                id: "VA_INDEFINITEHGXSF_717213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_INDEFINDD_73604",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: genderCode
            $scope.vc.createViewState({
                id: "VA_GENDERCODEUTLBL_276213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GENEROEHS_60662",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GENDERCODEUTLBL_276213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GENDERCODEUTLBL_276213', 'cl_sexo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GENDERCODEUTLBL_276213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GENDERCODEUTLBL_276213");
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
            //ViewState - Entity: NaturalPerson, Attribute: birthDate
            $scope.vc.createViewState({
                id: "VA_BIRTHDATEEXJMQR_157213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETE_15731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: age
            $scope.vc.createViewState({
                id: "VA_AGEBOBZMCLMVRPC_425213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_EDADCZEWZ_28093",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: nationalityCodeAux
            $scope.vc.createViewState({
                id: "VA_NATIONALITYCEUD_733213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NACIONADA_99184",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NATIONALITYCEUD_733213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_NATIONALITYCEUD_733213', 'cl_nacionalidad', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_NATIONALITYCEUD_733213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NATIONALITYCEUD_733213");
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
            //ViewState - Entity: NaturalPerson, Attribute: nationalityCode
            $scope.vc.createViewState({
                id: "VA_NATIONALITYCEDE_860213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PASDENACT_53001",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_NATIONALITYCEDE_860213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_NATIONALITYCEDE_860213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_NATIONALITYCEDE_860213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_NATIONALITYCEDE_860213");
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
            //ViewState - Entity: NaturalPerson, Attribute: countyOfBirth
            $scope.vc.createViewState({
                id: "VA_COUNTYOFBIRTHHH_881213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DENACIMTN_68832",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COUNTYOFBIRTHHH_881213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COUNTYOFBIRTHHH_881213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COUNTYOFBIRTHHH_881213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COUNTYOFBIRTHHH_881213");
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
            //ViewState - Entity: NaturalPerson, Attribute: maritalStatusCode
            $scope.vc.createViewState({
                id: "VA_MARITALSTATUDCC_635213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOCLI_62371",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_MARITALSTATUDCC_635213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_MARITALSTATUDCC_635213', 'cl_ecivil', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_MARITALSTATUDCC_635213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_MARITALSTATUDCC_635213");
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
            //ViewState - Entity: NaturalPerson, Attribute: branchCode
            $scope.vc.createViewState({
                id: "VA_BRANCHCODEYMGYZ_548213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SUCURSANE_97906",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BRANCHCODEYMGYZ_548213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BRANCHCODEYMGYZ_548213', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BRANCHCODEYMGYZ_548213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BRANCHCODEYMGYZ_548213");
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
            //ViewState - Entity: NaturalPerson, Attribute: officerCode
            $scope.vc.createViewState({
                id: "VA_OFFICERCODEBNMM_892213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OFICIALOO_32160",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_OFFICERCODEBNMM_892213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_OFFICERCODEBNMM_892213', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_OFFICERCODEBNMM_892213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_OFFICERCODEBNMM_892213");
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
            //ViewState - Group: Group2415
            $scope.vc.createViewState({
                id: "G_CUSTOMENEF_379213",
                hasId: true,
                componentStyle: [],
                label: 'Group2415',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioIdentificationType
            $scope.vc.createViewState({
                id: "VA_BIOIDENTIFICPON_671213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOIDENA_34496",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BIOIDENTIFICPON_671213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BIOIDENTIFICPON_671213', 'cl_tipo_identif_bio', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BIOIDENTIFICPON_671213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BIOIDENTIFICPON_671213");
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
            //ViewState - Entity: NaturalPerson, Attribute: bioEmissionNumber
            $scope.vc.createViewState({
                id: "VA_BIOEMISSIONNRER_925213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROEMSS_16133",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioOCR
            $scope.vc.createViewState({
                id: "VA_BIOOCRWLTNZPKPV_627213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OCRTSJTOG_74280",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioReaderKey
            $scope.vc.createViewState({
                id: "VA_BIOREADERKEYGIL_809213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CLAVEELEC_39076",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioCIC
            $scope.vc.createViewState({
                id: "VA_BIOCICLKEOYOTBY_860213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CICQWKFMH_28550",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioHasFingerprint
            $scope.vc.createViewState({
                id: "VA_BIOHASFINGERRRR_235213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PERSONAST_97760",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1900
            $scope.vc.createViewState({
                id: "G_CUSTOMEEAG_441213",
                hasId: true,
                componentStyle: [],
                label: 'Group1900',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: hasProblems
            $scope.vc.createViewState({
                id: "VA_HASPROBLEMSUGXJ_814213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_EMPROBLOE_40030",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: personPEP
            $scope.vc.createViewState({
                id: "VA_PERSONPEPVOMMIN_199213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PERSONAPP_72606",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: chargePub
            $scope.vc.createViewState({
                id: "VA_CHARGEPUBGMPRKN_954213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_QUFUNCIEA_15102",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1595",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: publicPerson
            $scope.vc.createViewState({
                id: "VA_PUBLICPERSONWEB_369213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIENEREAA_64653",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: relChargePub
            $scope.vc.createViewState({
                id: "VA_RELCHARGEPUBFLT_742213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_QUPARENOT_52722",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_RELCHARGEPUBFLT_742213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_RELCHARGEPUBFLT_742213', 'cl_parentesco', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_RELCHARGEPUBFLT_742213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_RELCHARGEPUBFLT_742213");
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
                id: "Spacer2440",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: accountIndividual
            $scope.vc.createViewState({
                id: "VA_ACCOUNTINDIVIDU_206213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CUENTAILI_97010",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONRNZGSZY_345213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RCUENTAKR_41365",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: numCycles
            $scope.vc.createViewState({
                id: "VA_2243MMLUVKLVURR_784213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NROSDECET_24618",
                format: "####",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: hasPartner
            $scope.vc.createViewState({
                id: "VA_2752DHFODUBOKGB_166213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PARTNERHY_33027",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: hasListBlack
            $scope.vc.createViewState({
                id: "VA_2792JAYJXHGFXEG_699213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_LISTASNEE_99868",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONQGYEKJY_245213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_AUXLULFCN_62992",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: creditBureau
            $scope.vc.createViewState({
                id: "VA_CREDITBUREAUEXI_626213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BURCRDITT_49242",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: riskLevel
            $scope.vc.createViewState({
                id: "VA_RISKLEVELAWDYSV_480213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELRISE_12098",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: individualRisk
            $scope.vc.createViewState({
                id: "VA_INDIVIDUALRISSK_753213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RIESGOINL_38927",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: technologicalDegree
            $scope.vc.createViewState({
                id: "VA_TECHNOLOGICALDE_495213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTECNOIO_72518",
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: colectivo
            $scope.vc.createViewState({
                id: "VA_COLECTIVOXQJYTJ_296213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOMEROO_32945",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COLECTIVOXQJYTJ_296213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_COLECTIVOXQJYTJ_296213', 'cl_tipo_mercado', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_COLECTIVOXQJYTJ_296213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COLECTIVOXQJYTJ_296213");
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
            //ViewState - Entity: NaturalPerson, Attribute: nivelColectivo
            $scope.vc.createViewState({
                id: "VA_8271RNPIOCKBAMC_691213",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELCLVE_85366",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_8271RNPIOCKBAMC_691213 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_8271RNPIOCKBAMC_691213', 'cl_nivel_cliente_colectivo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_8271RNPIOCKBAMC_691213'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_8271RNPIOCKBAMC_691213");
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
                defaultCountry: $scope.vc.channelDefaultValues("Context", "defaultCountry"),
                collective: $scope.vc.channelDefaultValues("Context", "collective"),
                generateReport: $scope.vc.channelDefaultValues("Context", "generateReport"),
                roleEnabledQueryAccount: $scope.vc.channelDefaultValues("Context", "roleEnabledQueryAccount"),
                renapo: $scope.vc.channelDefaultValues("Context", "renapo"),
                printReport: $scope.vc.channelDefaultValues("Context", "printReport")
            };
            //ViewState - Group: Group1715
            $scope.vc.createViewState({
                id: "G_CUSTOMEFRR_977213",
                hasId: true,
                componentStyle: [],
                label: 'Group1715',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1517",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_CUSTOMERGEIFR_226_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_CUSTOMERGEIFR_226_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.Parameters = {
                minimumAge: $scope.vc.channelDefaultValues("Parameters", "minimumAge"),
                screenMode: $scope.vc.channelDefaultValues("Parameters", "screenMode"),
                allowUpdateNames: $scope.vc.channelDefaultValues("Parameters", "allowUpdateNames"),
                idExpiration: $scope.vc.channelDefaultValues("Parameters", "idExpiration"),
                refresGrid: $scope.vc.channelDefaultValues("Parameters", "refresGrid")
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
                $scope.vc.render('VC_CUSTOMERIF_745226');
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
    var cobisMainModule = cobis.createModule("VC_CUSTOMERIF_745226", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_CUSTOMERIF_745226", {
            templateUrl: "VC_CUSTOMERIF_745226_FORM.html",
            controller: "VC_CUSTOMERIF_745226_CTRL",
            labelId: "CSTMR.LBL_CSTMR_CLIENTESS_17006",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_CUSTOMERIF_745226?" + $.param(search);
            }
        });
        VC_CUSTOMERIF_745226(cobisMainModule);
    }]);
} else {
    VC_CUSTOMERIF_745226(cobisMainModule);
}