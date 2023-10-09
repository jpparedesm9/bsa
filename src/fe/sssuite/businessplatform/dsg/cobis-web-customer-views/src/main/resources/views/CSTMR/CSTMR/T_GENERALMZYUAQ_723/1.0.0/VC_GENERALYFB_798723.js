//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.generalform = designerEvents.api.generalform || designer.dsgEvents();

function VC_GENERALYFB_798723(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GENERALYFB_798723_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GENERALYFB_798723_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_GENERALMZYUAQ_723",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GENERALYFB_798723",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_GENERALMZYUAQ_723",
        designerEvents.api.generalform,
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
                vcName: 'VC_GENERALYFB_798723'
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
                    taskId: 'T_GENERALMZYUAQ_723',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LegalPerson: "LegalPerson",
                    Person: "Person",
                    SpousePerson: "SpousePerson",
                    Mail: "Mail",
                    Context: "Context",
                    NaturalPerson: "NaturalPerson"
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
                    SpousePerson: {
                        personSecuential: 'AT12_PERSONNA845',
                        documentNumber: 'AT17_DOCUMETN845',
                        documentTypeDescription: 'AT23_DOCUMEEP845',
                        secondName: 'AT28_SECONDME845',
                        phone: 'AT33_PHONEXES845',
                        secondSurname: 'AT35_SECONDAR845',
                        expirationDate: 'AT36_EXPIRAAO845',
                        birthDate: 'AT37_BIRTHDEA845',
                        genderCode: 'AT37_GENDEROD845',
                        personType: 'AT43_PERSONYY845',
                        firstName: 'AT58_FIRSTNMA845',
                        surname: 'AT69_SURNAMEE845',
                        genderDescription: 'AT82_GENDERNE845',
                        countryOfBirth: 'AT90_COUNTRHY845',
                        documentType: 'AT93_DOCUMEYY845',
                        identificationRFC: 'AT96_IDENTICN845',
                        _pks: [],
                        _entityId: 'EN_SPOUSEPNN_845',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Mail: {
                        _pks: [],
                        _entityId: 'EN_1IOLWIMRH_577',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    Context: {
                        flag1: 'AT15_APPLICTM215',
                        flag2: 'AT15_FLAG2FIG215',
                        flag3: 'AT19_FLAG3XYE215',
                        renapoByCurp: 'AT21_RENAPORP215',
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
                        renapo: 'AT89_RENAPOOT215',
                        printReport: 'AT90_PRINTRRT215',
                        _pks: [],
                        _entityId: 'EN_CREDITLBQ_215',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
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
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                LegalPerson: {},
                Person: {},
                SpousePerson: {},
                Mail: {},
                Context: {},
                NaturalPerson: {}
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
                $scope.vc.execute("temporarySave", VC_GENERALYFB_798723, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GENERALYFB_798723, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GENERALYFB_798723, data, function() {});
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
            $scope.vc.viewState.VC_GENERALYFB_798723 = {
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
            //ViewState - Group: Group2882
            $scope.vc.createViewState({
                id: "G_GENERALATU_684739",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DATOSGERE_54146",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: Person, Attribute: typePerson
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXBFT_518739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEPSA_68089",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXBFT_518739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXBFT_518739', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXBFT_518739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXBFT_518739");
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
            //ViewState - Group: GroupLayout1446
            $scope.vc.createViewState({
                id: "G_GENERALSVX_509739",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DATOSGERE_54146",
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
            //ViewState - Group: Group1855
            $scope.vc.createViewState({
                id: "G_GENERALEAF_413739",
                hasId: true,
                componentStyle: [],
                label: 'Group1855',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKKE_345739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CONSECUEO_47801",
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: santanderCode
            $scope.vc.createViewState({
                id: "VA_SANTANDERCODEEE_289739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CDIGOSAAA_38846",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: santanderAccount
            $scope.vc.createViewState({
                id: "VA_SANTANDERACCOTO_124739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CUENTAILI_97010",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1735",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: firstName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXWXT_116739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVEC_991739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDOEN_22809",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: surname
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXBXR_146739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 33,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: secondSurname
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXFGQ_850739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 1,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_DOCUMENTTYPEFZR_461739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEDET_56783",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_DOCUMENTTYPEFZR_461739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_DOCUMENTTYPEFZR_461739', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_DOCUMENTTYPEFZR_461739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_DOCUMENTTYPEFZR_461739");
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
                id: "VA_TEXTINPUTBOXNJK_823739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODECU_69399",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: identificationRFC
            $scope.vc.createViewState({
                id: "VA_IDENTIFICATIFRC_163739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RFCCGUEPZ_59640",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioRenapoResult
            $scope.vc.createViewState({
                id: "VA_BIORENAPORESTTU_128739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADORAO_58902",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BIORENAPORESTTU_128739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BIORENAPORESTTU_128739', 'cl_respuesta_renapo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BIORENAPORESTTU_128739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BIORENAPORESTTU_128739");
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
                id: "VA_DATEFIELDEXOTID_585739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VENCIMICE_66538",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2707",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: email
            $scope.vc.createViewState({
                id: "VA_EMAILVIWJAKIOCI_922739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CORREOEOC_98049",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: genderCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGXM_696739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GNERODLCB_53869",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXGXM_696739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXGXM_696739', 'cl_sexo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXGXM_696739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXGXM_696739");
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
                id: "VA_DATEFIELDKWUZZN_303739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETE_15731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: maritalStatusCode
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXJOG_550739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_ESTADOCII_70291",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXJOG_550739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXJOG_550739', 'cl_ecivil', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXJOG_550739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXJOG_550739");
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
            //ViewState - Entity: NaturalPerson, Attribute: numCycles
            $scope.vc.createViewState({
                id: "VA_9419JJQLECKWUON_319739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NROSDECET_24618",
                format: "####",
                decimals: 0,
                validationCode: 2,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: countyOfBirth
            $scope.vc.createViewState({
                id: "VA_COUNTYOFBIRTHHH_490739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DENACIMTN_68832",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COUNTYOFBIRTHHH_490739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COUNTYOFBIRTHHH_490739', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COUNTYOFBIRTHHH_490739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COUNTYOFBIRTHHH_490739");
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
            //ViewState - Entity: NaturalPerson, Attribute: riskLevel
            $scope.vc.createViewState({
                id: "VA_RISKLEVELELRQOM_660739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELRISE_12098",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: NaturalPerson, Attribute: creditBureau
            $scope.vc.createViewState({
                id: "VA_CREDITBUREAUDCS_699739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_BURCRDITT_49242",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.None
            });
            $scope.vc.createViewState({
                id: "Spacer1358",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: personType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXWLA_925739",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: relationId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHRV_786739",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Group: Group1120
            $scope.vc.createViewState({
                id: "G_GENERALUYI_773739",
                hasId: true,
                componentStyle: [],
                label: 'Group1120',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioIdentificationType
            $scope.vc.createViewState({
                id: "VA_BIOIDENTIFICITO_287739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOIDENA_34496",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_BIOIDENTIFICITO_287739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_BIOIDENTIFICITO_287739', 'cl_tipo_identif_bio', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_BIOIDENTIFICITO_287739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_BIOIDENTIFICITO_287739");
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
                id: "VA_BIOEMISSIONNUUU_579739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMEROEMSS_16133",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioOCR
            $scope.vc.createViewState({
                id: "VA_BIOOCRPFNDHELMR_160739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_OCRTSJTOG_74280",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioReaderKey
            $scope.vc.createViewState({
                id: "VA_BIOREADERKEYXPM_644739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CLAVEELEC_39076",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioCIC
            $scope.vc.createViewState({
                id: "VA_BIOCICSOGTHMGMK_830739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CICQWKFMH_28550",
                validationCode: 64,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: NaturalPerson, Attribute: bioHasFingerprint
            $scope.vc.createViewState({
                id: "VA_BIOHASFINGERTRN_308739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PERSONAST_97760",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1956",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1115
            $scope.vc.createViewState({
                id: "G_GENERALMIP_351739",
                hasId: true,
                componentStyle: [],
                label: 'Group1115',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: NaturalPerson, Attribute: colectivo
            $scope.vc.createViewState({
                id: "VA_7690NBEFQLFYVXT_868739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPOMEROO_32945",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_7690NBEFQLFYVXT_868739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_7690NBEFQLFYVXT_868739', 'cl_tipo_mercado', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_7690NBEFQLFYVXT_868739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_7690NBEFQLFYVXT_868739");
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
                id: "VA_8419VXYRMDJDVPV_121739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NIVELCLVE_85366",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_8419VXYRMDJDVPV_121739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_8419VXYRMDJDVPV_121739', 'cl_nivel_cliente_colectivo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_8419VXYRMDJDVPV_121739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_8419VXYRMDJDVPV_121739");
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
            $scope.vc.model.SpousePerson = {
                personSecuential: $scope.vc.channelDefaultValues("SpousePerson", "personSecuential"),
                documentNumber: $scope.vc.channelDefaultValues("SpousePerson", "documentNumber"),
                documentTypeDescription: $scope.vc.channelDefaultValues("SpousePerson", "documentTypeDescription"),
                secondName: $scope.vc.channelDefaultValues("SpousePerson", "secondName"),
                phone: $scope.vc.channelDefaultValues("SpousePerson", "phone"),
                secondSurname: $scope.vc.channelDefaultValues("SpousePerson", "secondSurname"),
                expirationDate: $scope.vc.channelDefaultValues("SpousePerson", "expirationDate"),
                birthDate: $scope.vc.channelDefaultValues("SpousePerson", "birthDate"),
                genderCode: $scope.vc.channelDefaultValues("SpousePerson", "genderCode"),
                personType: $scope.vc.channelDefaultValues("SpousePerson", "personType"),
                firstName: $scope.vc.channelDefaultValues("SpousePerson", "firstName"),
                surname: $scope.vc.channelDefaultValues("SpousePerson", "surname"),
                genderDescription: $scope.vc.channelDefaultValues("SpousePerson", "genderDescription"),
                countryOfBirth: $scope.vc.channelDefaultValues("SpousePerson", "countryOfBirth"),
                documentType: $scope.vc.channelDefaultValues("SpousePerson", "documentType"),
                identificationRFC: $scope.vc.channelDefaultValues("SpousePerson", "identificationRFC")
            };
            //ViewState - Group: Group1534
            $scope.vc.createViewState({
                id: "G_GENERALEAO_954739",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CONYUGEXZ_74987",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: SpousePerson, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXHWM_415739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CONSECUEO_47801",
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "Spacer2671",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: firstName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVJE_867739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PRIMERNRB_92048",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: secondName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNVW_269739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_SEGUNDOEN_22809",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: surname
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDTF_989739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDPT_76332",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: secondSurname
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDFU_862739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_APELLIDAE_84502",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDYK_693739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEDET_56783",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXDYK_693739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXDYK_693739', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXDYK_693739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXDYK_693739");
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
            //ViewState - Entity: SpousePerson, Attribute: documentNumber
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXGF_770739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODECU_69399",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: identificationRFC
            $scope.vc.createViewState({
                id: "VA_IDENTIFICATIFFR_867739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RFCCGUEPZ_59640",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: expirationDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDKPKNOQ_427739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VENCIMICE_66538",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: birthDate
            $scope.vc.createViewState({
                id: "VA_BIRTHDATEHFEDFC_460739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADETE_15731",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: SpousePerson, Attribute: genderCode
            $scope.vc.createViewState({
                id: "VA_GENDERCODEVBBDG_772739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GNERODLCB_53869",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_GENDERCODEVBBDG_772739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_GENDERCODEVBBDG_772739', 'cl_sexo', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_GENDERCODEVBBDG_772739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_GENDERCODEVBBDG_772739");
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
            //ViewState - Entity: SpousePerson, Attribute: countryOfBirth
            $scope.vc.createViewState({
                id: "VA_COUNTRYOFBIRHTH_170739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DENACIMTN_68832",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_COUNTRYOFBIRHTH_170739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_COUNTRYOFBIRHTH_170739', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_COUNTRYOFBIRHTH_170739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_COUNTRYOFBIRHTH_170739");
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
            //ViewState - Entity: SpousePerson, Attribute: documentTypeDescription
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQDU_362739",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
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
            //ViewState - Group: Group2242
            $scope.vc.createViewState({
                id: "G_GENERALAIR_501739",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_PERSONARR_26461",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Entity: LegalPerson, Attribute: personSecuential
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXTMT_413739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CONSECUEO_47801",
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            $scope.vc.createViewState({
                id: "Spacer2982",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: businessName
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXBNS_113739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RAZNSOCLL_50091",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: tradename
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXKUG_213739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NOMBRECCA_25114",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: documentType
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNLL_783739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_TIPODEDOE_99116",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXNLL_783739 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXNLL_783739', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXNLL_783739'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.error([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXNLL_783739");
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
            //ViewState - Entity: LegalPerson, Attribute: documentNumber
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXDXR_200739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_NMERODETE_20552",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: constitutionDate
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXXTK_742739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_FECHADECC_24510",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query
            });
            //ViewState - Entity: LegalPerson, Attribute: emailAddress
            $scope.vc.createViewState({
                id: "VA_EMAILADDRESSOAU_817739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CORREOEOC_98049",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: LegalPerson, Attribute: relationId
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXVNB_220739",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.Mail = {};
            //ViewState - Group: Group1906
            $scope.vc.createViewState({
                id: "G_GENERALEZZ_522739",
                hasId: true,
                componentStyle: [],
                label: 'Group1906',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2785",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONUBNHVJA_668739",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            $scope.vc.model.Context = {
                flag1: $scope.vc.channelDefaultValues("Context", "flag1"),
                flag2: $scope.vc.channelDefaultValues("Context", "flag2"),
                flag3: $scope.vc.channelDefaultValues("Context", "flag3"),
                renapoByCurp: $scope.vc.channelDefaultValues("Context", "renapoByCurp"),
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
                renapo: $scope.vc.channelDefaultValues("Context", "renapo"),
                printReport: $scope.vc.channelDefaultValues("Context", "printReport")
            };
            //ViewState - Group: Group1321
            $scope.vc.createViewState({
                id: "G_GENERALSJI_869739",
                hasId: true,
                componentStyle: [],
                label: 'Group1321',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1979",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_GENERALMZYUAQ_723_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_GENERALMZYUAQ_723_CANCEL",
                componentStyle: [],
                label: 'Cancel',
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
                $scope.vc.render('VC_GENERALYFB_798723');
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
    var cobisMainModule = cobis.createModule("VC_GENERALYFB_798723", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_GENERALYFB_798723", {
            templateUrl: "VC_GENERALYFB_798723_FORM.html",
            controller: "VC_GENERALYFB_798723_CTRL",
            label: "GeneralForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GENERALYFB_798723?" + $.param(search);
            }
        });
        VC_GENERALYFB_798723(cobisMainModule);
    }]);
} else {
    VC_GENERALYFB_798723(cobisMainModule);
}