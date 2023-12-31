//Designer Generator v 6.4.0.5 - SPR 2019-03 15/02/2019
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.prospectcomposite = designerEvents.api.prospectcomposite || designer.dsgEvents();

function VC_PROSPECTMI_213684(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_PROSPECTMI_213684_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_PROSPECTMI_213684_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            taskId: "T_PROSPECTCOOSS_684",
            taskVersion: "1.0.0",
            viewContainerId: "VC_PROSPECTMI_213684",
            hasCloseModalEvent: true,
            serverEvents: true
        },
            "${contextPath}/resources/CSTMR/CSTMR/T_PROSPECTCOOSS_684",
        designerEvents.api.prospectcomposite,
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
                vcName: 'VC_PROSPECTMI_213684'
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
                    taskId: 'T_PROSPECTCOOSS_684',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    LegalPerson: "LegalPerson",
                    Person: "Person",
                    SpousePerson: "SpousePerson",
                    Mail: "Mail",
                    Context: "Context",
                    NaturalPerson: "NaturalPerson",
                    CustomerTmp: "CustomerTmp",
                    VirtualAddress: "VirtualAddress",
                    PhysicalAddress: "PhysicalAddress",
                    ScannedDocumentsDetail: "ScannedDocumentsDetail",
                    DocumentsUpload: "DocumentsUpload",
                    GeneralData: "GeneralData",
                    OriginalHeader: "OriginalHeader"
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
                    ScannedDocumentsDetail: {
                        customerName: 'AT22_CUSTOMEM612',
                        typeRequest: 'AT35_TYPERESQ612',
                        uploaded: 'AT46_UPLOADDE612',
                        file: 'AT47_FILEOVTQ612',
                        processInstance: 'AT65_PROCESNA612',
                        extension: 'AT70_EXTENSIN612',
                        documentId: 'AT88_DOCUMEDI612',
                        customerId: 'AT97_CUSTOMIR612',
                        description: 'AT98_DESCRIPT612',
                        _pks: [],
                        _entityId: 'EN_SCANNEDCL_612',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    DocumentsUpload: {
                        uploads: 'AT35_UPLOADSS493',
                        processInstance: 'AT36_PROCESES493',
                        clientId: 'AT59_CLIENTDI493',
                        _pks: [],
                        _entityId: 'EN_DOCUMENTO_493',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    GeneralData: {
                        loanType: 'AT50_LOANTYPE827',
                        paymentFrecuencyName: 'AT58_PAYMENCU827',
                        productTypeName: 'AT58_PRODUCYP827',
                        clientId: 'AT60_CLIENTDD827',
                        symbolCurrency: 'AT62_SYMBOLEY827',
                        vinculado: 'AT63_VINCULAO827',
                        sectorNeg: 'AT82_SECTOREE827',
                        _pks: [],
                        _entityId: 'EN_GENERALAA_827',
                        _entityVersion: '1.0.0',
                        _transient: false
                    },
                    OriginalHeader: {
                        currencyRequested: 'AT15_CURRENER498',
                        iDRequested: 'AT19_IDREQUET498',
                        term: 'AT24_TERMMYXW498',
                        subType: 'AT29_SUBTYPEE498',
                        amountAproved: 'AT30_AMOUNTPD498',
                        applicationNumber: 'AT43_APPLICNN498',
                        category: 'AT64_CATEGORY498',
                        amountRequested: 'AT71_AMOUNTEU498',
                        initialDate: 'AT71_INITIAEA498',
                        productType: 'AT73_PRODUCYY498',
                        operationNumber: 'AT75_OPERATNN498',
                        officerName: 'AT81_OFFICEAA498',
                        paymentFrequency: 'AT99_PAYMENYR498',
                        _pks: [],
                        _entityId: 'EN_ORIGINARE_498',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            $scope.vc.queryProperties.Q_SCANNELD_7463 = {
                autoCrud: false
            };
            $scope.vc.getRequestQuery_Q_SCANNELD_7463 = function() {
                var parametersAux = {};
                if ($.isEmptyObject($scope.vc.queries.Q_SCANNELD_7463_filters)) {
                    parametersAux = {};
                } else {
                    var filters = $scope.vc.queries.Q_SCANNELD_7463_filters;
                    parametersAux = {
                        customerId: filters.customerId,
                        processInstance: filters.processInstance,
                        typeRequest: filters.typeRequest
                    };
                }
                return {
                    mainEntityPk: {
                        entityId: 'EN_SCANNEDCL_612',
                        version: '1.0.0'
                    },
                    queryPk: {
                        queryId: 'Q_SCANNELD_7463',
                        version: '1.0.0'
                    },
                    parameters: parametersAux,
                    filters: {},
                    updateParameters: function() {
                        if ($.isEmptyObject(this.filters) && $.isEmptyObject(this.parameters)) {
                            //No tiene relaciones con otra entidad
                            this.parameters = {};
                        } else if (!$.isEmptyObject(this.filters)) {
                            this.parameters['customerId'] = this.filters.customerId;
                            this.parameters['processInstance'] = this.filters.processInstance;
                            this.parameters['typeRequest'] = this.filters.typeRequest;
                        }
                    }
                }
            };
            $scope.vc.queries.Q_SCANNELD_7463_filters = {};
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
                LegalPerson: {},
                Person: {},
                SpousePerson: {},
                Mail: {},
                Context: {},
                NaturalPerson: {},
                CustomerTmp: {},
                VirtualAddress: {},
                PhysicalAddress: {},
                ScannedDocumentsDetail: {},
                DocumentsUpload: {},
                GeneralData: {},
                OriginalHeader: {}
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
                $scope.vc.execute("temporarySave", VC_PROSPECTMI_213684, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_PROSPECTMI_213684, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_PROSPECTMI_213684, data, function() {});
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
            $scope.vc.viewState.VC_PROSPECTMI_213684 = {
                style: []
            }
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_PROSPECTMI_213684",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CREACINCO_36598",
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: ViewContainerBase
            $scope.vc.createViewState({
                id: "VC_VUWWUPIBAH_277684",
                hasId: true,
                componentStyle: [],
                label: 'ViewContainerBase',
                enabled: designer.constants.mode.All
            });
            //ViewState - Container: GeneralForm
            $scope.vc.createViewState({
                id: "VC_ODXEZDWELG_370723",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DATOSGERE_54146",
                enabled: designer.constants.mode.All
            });
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
                validationCode: 32,
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
            //ViewState - Container: AddressForm
            $scope.vc.createViewState({
                id: "VC_OHGJMSCFAL_971769",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DIRECCIOE_39222"
            });
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
                title: 'CSTMR.LBL_CSTMR_MUNICIPLL_42320',
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
            //ViewState - Container: ScannedDocumentsDetail
            $scope.vc.createViewState({
                id: "VC_RIZJHPLTPZ_320966",
                hasId: true,
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_DOCUMENAD_66478"
            });
            //ViewState - Group: Group1710
            $scope.vc.createViewState({
                id: "G_SCANNEDCIM_218611",
                hasId: true,
                componentStyle: [],
                label: 'Group1710',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.types.ScannedDocumentsDetail = kendo.data.Model.define({
                id: "dsgnrId",
                fields: {
                    dsgnrId: {
                        type: "string"
                    },
                    trackId: {
                        type: "string"
                    },
                    description: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "description", '')
                    },
                    customerId: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerId", 0)
                    },
                    uploaded: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "uploaded", '')
                    },
                    file: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "file", '')
                    },
                    documentId: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "documentId", '')
                    },
                    extension: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "extension", '')
                    },
                    customerName: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "customerName", '')
                    },
                    processInstance: {
                        type: "number",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "processInstance", 0)
                    },
                    typeRequest: {
                        type: "string",
                        editable: true,
                        defaultValue: $scope.vc.channelDefaultValues("ScannedDocumentsDetail", "typeRequest", '')
                    }
                }
            });
            $scope.vc.model.ScannedDocumentsDetail = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        var promise = false;
                        var isRefresh = (angular.isDefined(options.data) && angular.isDefined(options.data.refresh));
                        if (isRefresh || !designer.enums.hasFlag(designer.constants.mode.Insert, $scope.vc.mode)) {
                            var queryId = 'Q_SCANNELD_7463';
                            var queryRequest = $scope.vc.getRequestQuery_Q_SCANNELD_7463();
                            if (queryId && queryRequest) {
                                var queryLoaded = queryRequest.loaded;
                                if (angular.isUndefined(queryLoaded) || isRefresh === true) {
                                    queryRequest.loaded = true;
                                    queryRequest.updateParameters();
                                    promise = true;
                                    $scope.vc.executeQuery(
                                        'QV_7463_28553',
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
                        options.success(model);
                        var argsAfterLeave = {
                            inlineWorkMode: designer.constants.gridInlineWorkMode.Insert,
                            nameEntityGrid: 'ScannedDocumentsDetail'
                        };
                        $scope.vc.gridAfterLeaveInLineRow('QV_7463_28553', argsAfterLeave);
                    },
                    update: function(options) {
                        var model = options.data;
                        //this block of code only appears if the grid has set a RowUpdatingEvent
                        var args = {
                            rowData: model,
                            nameEntityGrid: 'ScannedDocumentsDetail',
                            cancel: false
                        }
                        $scope.vc.gridRowAction('QV_7463_28553', $scope.vc.designerEventsConstants.GridRowUpdating, args, function() {
                            if (!args.cancel) {
                                options.success(args.rowData);
                                var argsAfterLeave = {
                                    inlineWorkMode: designer.constants.gridInlineWorkMode.Update,
                                    nameEntityGrid: 'ScannedDocumentsDetail'
                                };
                                $scope.vc.gridAfterLeaveInLineRow('QV_7463_28553', argsAfterLeave);
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
                    model: $scope.vc.types.ScannedDocumentsDetail
                },
                aggregate: [],
                error: function(e) {
                    if (e.xhr.message && e.xhr.message === 'DeletingError') {
                        $("#QV_7463_28553").data("kendoExtGrid").cancelChanges();
                    }
                }
            });
            $scope.vc.queries.Q_SCANNELD_7463 = $scope.vc.model.ScannedDocumentsDetail;
            $scope.vc.trackers.ScannedDocumentsDetail = new $scope.vc.crud.DataSourceTracker(
            $scope.vc.metadata.entities.ScannedDocumentsDetail);
            $scope.vc.model.ScannedDocumentsDetail.bind('change', function(e) {
                $scope.vc.trackers.ScannedDocumentsDetail.track(e);
            });
            $scope.vc.grids.QV_7463_28553 = {};
            $scope.vc.grids.QV_7463_28553.queryId = 'Q_SCANNELD_7463';
            $scope.vc.viewState.QV_7463_28553 = {
                style: undefined
            };
            $scope.vc.viewState.QV_7463_28553.column = {};
            $scope.vc.grids.QV_7463_28553.editable = {
                mode: 'inline'
            };
            $scope.vc.grids.QV_7463_28553.events = {
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
                    $scope.vc.trackers.ScannedDocumentsDetail.cancelTrackedChanges(e.model);
                },
                edit: function(e) {
                    $scope.vc.grids.QV_7463_28553.selectedRow = e.model;
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
                        nameEntityGrid: 'ScannedDocumentsDetail',
                        cancel: false,
                        rowData: e.model
                    };
                    if (e.model.isNew()) {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Insert;
                    } else {
                        args.inlineWorkMode = designer.constants.gridInlineWorkMode.Update;
                    }
                    $scope.vc.gridBeforeEnterInLineRow("QV_7463_28553", args, function() {
                        if (args.cancel) {
                            $("#QV_7463_28553").data("kendoExtGrid").cancelChanges();
                        }
                        $scope.$apply();
                    });
                    //end block
                    $scope.vc.validateForm();
                },
                evalGridRowRendering: function(rowIndexArgs, rowDataArgs) {
                    var args = {
                        nameEntityGrid: 'ScannedDocumentsDetail',
                        rowData: rowDataArgs,
                        rowIndex: rowIndexArgs
                    };
                    $scope.vc.gridRowRendering("QV_7463_28553", args);
                },
                dataBound: function(e) {
                    var index;
                    var grid = e.sender;
                    $scope.vc.gridDataBound("QV_7463_28553");
                    $scope.vc.hideShowColumns("QV_7463_28553", grid);
                    var dataView = null;
                    dataView = this.dataSource.view();
                    var styleName, iStyle;
                    for (var i = 0; i < dataView.length; i++) {
                        if (typeof $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid] != "undefined") {
                            for (iStyle = 0; iStyle < $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid].style.length; iStyle++) {
                                styleName = $scope.vc.viewState.QV_7463_28553.rows[dataView[i].uid].style[iStyle];
                                if ($("#QV_7463_28553 tbody").find("tr[data-uid=" + dataView[i].uid + "]").hasClass(styleName) === false) {
                                    $("#QV_7463_28553 tbody").find("tr[data-uid=" + dataView[i].uid + "]").addClass(styleName);
                                }
                            }
                        }
                    }
                },
                dataBinding: function(e) {
                    var dataView = this.dataSource.view();
                    for (var i = 0; i < dataView.length; i++) {
                        $scope.vc.grids.QV_7463_28553.events.evalGridRowRendering(i, dataView[i]);
                    }
                }
            };
            //Comandos de registros del Grid
            $scope.vc.grids.QV_7463_28553.columns = [];
            //Registros de fila del Grid
            $scope.vc.viewState.QV_7463_28553.rows = [];
            //Controles de edicion en linea del Grid
            $scope.vc.viewState.QV_7463_28553.column.description = {
                title: 'CSTMR.LBL_CSTMR_DOCUMENSS_43494',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXGHR_415611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT98_DESCRIPT612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.description.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'id': "VA_TEXTINPUTBOXGHR_415611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.description.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.description.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.customerId = {
                title: 'customerId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXQGR_507611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT97_CUSTOMIR612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.customerId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXQGR_507611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.customerId.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7463_28553.column.customerId.format",
                        'k-decimals': "vc.viewState.QV_7463_28553.column.customerId.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.customerId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.uploaded = {
                title: 'CSTMR.LBL_CSTMR_CARGADOUC_57638',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYWQ_841611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT46_UPLOADDE612 = {
                control: function(container, options) {
                    $('<label ' +
                        'data-bind="text:' + options.field + '" ' +
                        'name="' + options.field + '" ' +
                        'class="control-label d-simple-label" ' +
                        'ng-class="vc.viewState.QV_7463_28553.column.uploaded.style"' +
                        'ng-show="designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"> ' +
                        '</label>')
                        .appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.file = {
                title: 'CSTMR.LBL_CSTMR_ARCHIVOYO_38473',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXTFB_124611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT47_FILEOVTQ612 = {
                control: function(container, options) {
                    $scope.vc.viewState.QV_7463_28553.column.file.disabledUpload = false;
                    $scope.vc.uploaders.VA_TEXTINPUTBOXTFB_124611 = {
                        maxSizeInMB: 10,
                        relativePath: null,
                        confirmUpload: false,
                        visualAttributeModel: '',
                        queryViewId: 'QV_7463_28553',
                        gridFieldName: 'file',
                        fileUploadAPI: null
                    };
                    var textInput = $('<input />', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.file.enabled",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-readonly': "true",
                        'id': "VA_TEXTINPUTBOXTFB_124611",
                        'type': "text",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.file.validationCode}}",
                        'class': "form-control"
                    });
                    var buttonUpload = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "vc.viewState.QV_7463_28553.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-mouseup': "vc.clickFileUploader('VA_TEXTINPUTBOXTFB_124611')",
                        'ng-mousedown': "vc.grids.QV_7463_28553.events.customRowClick($event, 'VA_TEXTINPUTBOXTFB_124611', 'ScannedDocumentsDetail', 'QV_7463_28553','DSG_UPLOAD_FILE_')"
                    });
                    var buttonSuccess = $('<button />', {
                        'class': "btn btn-primary btn-block",
                        'type': "button",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)"
                    });
                    var buttonRemove = $('<button />', {
                        'class': "btn btn-default btn-block",
                        'type': "button",
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.file.disabledUpload",
                        'ng-class': "vc.viewState.QV_7463_28553.column.file.style",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.All,vc.mode)",
                        'ng-click': "vc.removeFile('VA_TEXTINPUTBOXTFB_124611')"
                    });
                    var divRow = $('<div/>', {
                        'class': "input-group"
                    });
                    var innerDivRow = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var innerDivRow1 = $('<div/>', {
                        'class': "input-group-btn"
                    });
                    var innerDivShow = $('<div/>', {
                        'ng-show': "vc.viewState.QV_7463_28553.column.file.disabledUpload"
                    });
                    var innerDivhide = $('<div/>', {
                        'ng-hide': "vc.viewState.QV_7463_28553.column.file.disabledUpload"
                    });
                    var spanImageUpload = $('<span />', {
                        'class': "glyphicon glyphicon-paperclip"
                    });
                    var spanImageRemove = $('<span />', {
                        'class': "glyphicon glyphicon-remove-circle"
                    });
                    var spanImageSuccess = $('<span />', {
                        'class': "glyphicon glyphicon-ok"
                    });
                    spanImageUpload.appendTo(buttonUpload);
                    buttonUpload.appendTo(innerDivhide);
                    innerDivhide.appendTo(innerDivRow);
                    spanImageSuccess.appendTo(buttonSuccess);
                    buttonSuccess.appendTo(innerDivShow);
                    innerDivShow.appendTo(innerDivRow);
                    spanImageRemove.appendTo(buttonRemove);
                    buttonRemove.appendTo(innerDivRow1);
                    textInput.appendTo(divRow);
                    innerDivRow.appendTo(divRow);
                    innerDivRow1.appendTo(divRow);
                    divRow.appendTo(container);
                    var textInputFile = $('<input />', {
                        'name': "VA_TEXTINPUTBOXTFB_124611_gridUploader",
                        'id': "VA_TEXTINPUTBOXTFB_124611_gridUploader",
                        'type': "file"
                    }).kendoUpload({
                        'async': {
                            saveUrl: '${contextPath}/cobis/web/cobis-designer-engine-web/actions/fileupload?'
                        },
                        'class': "form-control",
                        'upload': function(e) {
                            $scope.vc.onFileUpload(e, options.model, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'select': function(e) {
                            $scope.vc.onFileSelect(e, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'success': function(e) {
                            $scope.vc.onSuccess(e, 'VA_TEXTINPUTBOXTFB_124611');
                        },
                        'multiple': false
                    });
                    var divRowUp = $('<div/>', {
                        'ng-hide': true
                    });
                    textInputFile.appendTo(divRowUp);
                    divRowUp.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.documentId = {
                title: 'documentId',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXYWP_542611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT88_DOCUMEDI612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.documentId.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXYWP_542611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.documentId.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.documentId.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.extension = {
                title: 'extension',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXSGM_136611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT70_EXTENSIN612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.extension.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXSGM_136611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.extension.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.extension.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.customerName = {
                title: 'customerName',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXCEB_498611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT22_CUSTOMEM612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.customerName.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXCEB_498611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.customerName.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.customerName.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.processInstance = {
                title: 'processInstance',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                format: "n0",
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXBPC_698611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT65_PROCESNA612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.processInstance.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXBPC_698611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.processInstance.validationCode}}",
                        'kendo-numeric-text-box': "",
                        'datatypes-Limit': "N",
                        'k-spinners': "false",
                        'k-step': "0",
                        'k-format': "vc.viewState.QV_7463_28553.column.processInstance.format",
                        'k-decimals': "vc.viewState.QV_7463_28553.column.processInstance.decimals",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.processInstance.style"
                    });
                    textInput.appendTo(container);
                }
            };
            $scope.vc.viewState.QV_7463_28553.column.typeRequest = {
                title: 'typeRequest',
                titleArgs: {},
                tooltip: '',
                enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                hidden: !designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode),
                readOnly: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode),
                decimals: 0,
                style: [],
                validationCode: 0,
                componentId: 'VA_TEXTINPUTBOXJXS_260611',
                element: []
            };
            $scope.vc.grids.QV_7463_28553.AT35_TYPERESQ612 = {
                control: function(container, options) {
                    var textInput = $('<input/>', {
                        'name': options.field,
                        'data-bind': "value:" + options.field,
                        'ng-disabled': "!vc.viewState.QV_7463_28553.column.typeRequest.enabled",
                        'ng-readonly': "designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)",
                        'ng-show': "designer.enums.hasFlag(designer.constants.mode.None,vc.mode)",
                        'id': "VA_TEXTINPUTBOXJXS_260611",
                        'data-validation-code': "{{vc.viewState.QV_7463_28553.column.typeRequest.validationCode}}",
                        'type': "text",
                        'class': "k-textbox",
                        'ng-model-onblur': "",
                        'ng-class': "vc.viewState.QV_7463_28553.column.typeRequest.style"
                    });
                    textInput.appendTo(container);
                }
            };
            //Creacion de columnas del Grid
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'description',
                    title: '{{vc.viewState.QV_7463_28553.column.description.title|translate:vc.viewState.QV_7463_28553.column.description.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.description.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.description.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT98_DESCRIPT612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.description.style' ng-bind='vc.getStringColumnFormat(dataItem.description, \"QV_7463_28553\", \"description\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.description.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.description.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.description.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'customerId',
                    title: '{{vc.viewState.QV_7463_28553.column.customerId.title|translate:vc.viewState.QV_7463_28553.column.customerId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.customerId.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.customerId.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT97_CUSTOMIR612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.customerId.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.customerId, \"QV_7463_28553\", \"customerId\"):kendo.toString(#=customerId#, vc.viewState.QV_7463_28553.column.customerId.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7463_28553.column.customerId.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.customerId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.customerId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'uploaded',
                    title: '{{vc.viewState.QV_7463_28553.column.uploaded.title|translate:vc.viewState.QV_7463_28553.column.uploaded.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.uploaded.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.uploaded.format,
                    editor: $scope.vc.gridInitEditColumnTemplate('QV_7463_28553', 'uploaded', $scope.vc.grids.QV_7463_28553.AT46_UPLOADDE612.control),
                    template: $scope.vc.gridInitColumnTemplate('QV_7463_28553', 'uploaded', "<span ng-class='vc.viewState.QV_7463_28553.column.uploaded.style' ng-bind='vc.getStringColumnFormat(dataItem.uploaded, \"QV_7463_28553\", \"uploaded\")'></span>"),
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.uploaded.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.uploaded.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.uploaded.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'file',
                    title: '{{vc.viewState.QV_7463_28553.column.file.title|translate:vc.viewState.QV_7463_28553.column.file.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.file.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.file.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT47_FILEOVTQ612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.file.style' ng-bind='vc.getStringColumnFormat(dataItem.file, \"QV_7463_28553\", \"file\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.file.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.file.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.file.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'documentId',
                    title: '{{vc.viewState.QV_7463_28553.column.documentId.title|translate:vc.viewState.QV_7463_28553.column.documentId.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.documentId.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.documentId.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT88_DOCUMEDI612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.documentId.style' ng-bind='vc.getStringColumnFormat(dataItem.documentId, \"QV_7463_28553\", \"documentId\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.documentId.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.documentId.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.documentId.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'extension',
                    title: '{{vc.viewState.QV_7463_28553.column.extension.title|translate:vc.viewState.QV_7463_28553.column.extension.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.extension.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.extension.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT70_EXTENSIN612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.extension.style' ng-bind='vc.getStringColumnFormat(dataItem.extension, \"QV_7463_28553\", \"extension\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.extension.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.extension.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.extension.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'customerName',
                    title: '{{vc.viewState.QV_7463_28553.column.customerName.title|translate:vc.viewState.QV_7463_28553.column.customerName.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.customerName.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.customerName.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT22_CUSTOMEM612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.customerName.style' ng-bind='vc.getStringColumnFormat(dataItem.customerName, \"QV_7463_28553\", \"customerName\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.customerName.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.customerName.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.customerName.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'processInstance',
                    title: '{{vc.viewState.QV_7463_28553.column.processInstance.title|translate:vc.viewState.QV_7463_28553.column.processInstance.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.processInstance.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.processInstance.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT65_PROCESNA612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.processInstance.style' ng-bind='(vc.getStringColumnFormat)?vc.getStringColumnFormat(dataItem.processInstance, \"QV_7463_28553\", \"processInstance\"):kendo.toString(#=processInstance#, vc.viewState.QV_7463_28553.column.processInstance.format)'></span>",
                    attributes: {
                        "class": "text-right",
                        "ng-class": "vc.viewState.QV_7463_28553.column.processInstance.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.processInstance.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.processInstance.hidden
                });
            }
            if (designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)) {
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'typeRequest',
                    title: '{{vc.viewState.QV_7463_28553.column.typeRequest.title|translate:vc.viewState.QV_7463_28553.column.typeRequest.titleArgs}}',
                    width: $scope.vc.viewState.QV_7463_28553.column.typeRequest.width,
                    format: $scope.vc.viewState.QV_7463_28553.column.typeRequest.format,
                    editor: $scope.vc.grids.QV_7463_28553.AT35_TYPERESQ612.control,
                    template: "<span ng-class='vc.viewState.QV_7463_28553.column.typeRequest.style' ng-bind='vc.getStringColumnFormat(dataItem.typeRequest, \"QV_7463_28553\", \"typeRequest\")'></span>",
                    attributes: {
                        "class": "",
                        "ng-class": "vc.viewState.QV_7463_28553.column.typeRequest.style",
                        "title": "{{vc.viewState.QV_7463_28553.column.typeRequest.tooltip|translate}}"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.typeRequest.hidden
                });
            }
            $scope.vc.viewState.QV_7463_28553.column.edit = {
                element: []
            };
            $scope.vc.viewState.QV_7463_28553.column.cmdEdition = {};
            $scope.vc.viewState.QV_7463_28553.column.cmdEdition.hidden = false;
            $scope.vc.grids.QV_7463_28553.columns.push({
                field: 'cmdEdition',
                title: ' ',
                command: [{
                    name: "edit",
                    text: "{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}",
                    cssMap: "{'btn': true, 'btn-default': true, 'cb-row-image-button': true" + ", 'k-grid-edit': true}",
                    template: "<a ng-class='vc.getCssClass(\"edit\", " + "vc.viewState.QV_7463_28553.column.edit.element[dataItem.uid].style, #:cssMap#, vc.viewState.QV_7463_28553.column.edit.element[dataItem.dsgnrId].style)' " + "title=\"{{'DSGNR.SYS_DSGNR_LBLEDIT00_00005'|translate}}\" " + "ng-disabled = (vc.viewState.G_SCANNEDCIM_218611.disabled==true?true:false) " + "href='\\#'>" + "<span class='glyphicon glyphicon-pencil'></span>" + "</a>"
                }],
                attributes: {
                    "class": "btn-toolbar"
                },
                hidden: designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode) === true ? true : $scope.vc.viewState.QV_7463_28553.column.cmdEdition.hidden,
                width: sessionStorage.columnSize || 100
            });
            if (designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode)) {
                $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611 = {
                    tooltip: '',
                    imageId: 'fa fa-download',
                    element: [],
                    enabled: designer.enums.hasFlag(designer.constants.mode.None, $scope.vc.mode)
                };
                if (angular.isUndefined($scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611)) {
                    $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611 = {};
                }
                $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.hidden = false;
                $scope.vc.grids.QV_7463_28553.columns.push({
                    field: 'VA_GRIDROWCOMMMNDD_972611',
                    title: ' ',
                    command: {
                        name: "VA_GRIDROWCOMMMNDD_972611",
                        entity: "ScannedDocumentsDetail",
                        text: "",
                        cssMap: "{'btn': true, 'btn-default': true, 'cb-row-button': true" + ", 'cb-btn-custom-vagridrowcommmndd':true}",
                        template: "<a ng-class='vc.getCssClass(\"VA_GRIDROWCOMMMNDD_972611\", " + "vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.element[dataItem.uid].style, #:cssMap#)' " + "ng-disabled = 'vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.enabled || vc.viewState.G_SCANNEDCIM_218611.disabled' " + "data-ng-click = 'vc.grids.QV_7463_28553.events.customRowClick($event, \"VA_GRIDROWCOMMMNDD_972611\", \"#:entity#\", \"QV_7463_28553\")' " + "title = \"{{vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.tooltip|translate}}\" " + "href = '\\#'>" + "<span ng-class='vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.imageId'></span>#: text #" + "</a>"
                    },
                    attributes: {
                        "class": "btn-toolbar"
                    },
                    hidden: $scope.vc.viewState.QV_7463_28553.column.VA_GRIDROWCOMMMNDD_972611.hidden
                });
            }
            $scope.vc.viewState.QV_7463_28553.toolbar = {}
            $scope.vc.grids.QV_7463_28553.toolbar = [];
            $scope.vc.model.DocumentsUpload = {
                uploads: $scope.vc.channelDefaultValues("DocumentsUpload", "uploads"),
                processInstance: $scope.vc.channelDefaultValues("DocumentsUpload", "processInstance"),
                clientId: $scope.vc.channelDefaultValues("DocumentsUpload", "clientId")
            };
            //ViewState - Group: Group2644
            $scope.vc.createViewState({
                id: "G_SCANNEDDSD_789611",
                hasId: true,
                componentStyle: [],
                label: 'Group2644',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1195",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Group: Group1669
            $scope.vc.createViewState({
                id: "G_SCANNEDOLM_531611",
                hasId: true,
                componentStyle: [],
                label: 'Group1669',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1422",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "VA_VABUTTONILJIEMT_921611",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_VALIDARTO_98546",
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_PROSPECTCOOSS_684_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_PROSPECTCOOSS_684_CANCEL",
                componentStyle: [],
                label: 'Cancel',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command1
            $scope.vc.createViewState({
                id: "CM_TPROSPEC_T8S",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_CONTINURR_72008",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command2
            $scope.vc.createViewState({
                id: "CM_TPROSPEC_MT4",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_GUARDARXV_17194",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Command3
            $scope.vc.createViewState({
                id: "CM_TPROSPEC_STR",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RBURFSLGP_18941",
                enabled: designer.constants.mode.All
            });
            //ViewState - Command: Command4
            $scope.vc.createViewState({
                id: "CM_TPROSPEC_MR6",
                componentStyle: [],
                label: "CSTMR.LBL_CSTMR_RENAPOLGN_84509",
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.model.GeneralData = {
                loanType: $scope.vc.channelDefaultValues("GeneralData", "loanType"),
                paymentFrecuencyName: $scope.vc.channelDefaultValues("GeneralData", "paymentFrecuencyName"),
                productTypeName: $scope.vc.channelDefaultValues("GeneralData", "productTypeName"),
                clientId: $scope.vc.channelDefaultValues("GeneralData", "clientId"),
                symbolCurrency: $scope.vc.channelDefaultValues("GeneralData", "symbolCurrency"),
                vinculado: $scope.vc.channelDefaultValues("GeneralData", "vinculado"),
                sectorNeg: $scope.vc.channelDefaultValues("GeneralData", "sectorNeg")
            };
            $scope.vc.model.OriginalHeader = {
                currencyRequested: $scope.vc.channelDefaultValues("OriginalHeader", "currencyRequested"),
                iDRequested: $scope.vc.channelDefaultValues("OriginalHeader", "iDRequested"),
                term: $scope.vc.channelDefaultValues("OriginalHeader", "term"),
                subType: $scope.vc.channelDefaultValues("OriginalHeader", "subType"),
                amountAproved: $scope.vc.channelDefaultValues("OriginalHeader", "amountAproved"),
                applicationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "applicationNumber"),
                category: $scope.vc.channelDefaultValues("OriginalHeader", "category"),
                amountRequested: $scope.vc.channelDefaultValues("OriginalHeader", "amountRequested"),
                initialDate: $scope.vc.channelDefaultValues("OriginalHeader", "initialDate"),
                productType: $scope.vc.channelDefaultValues("OriginalHeader", "productType"),
                operationNumber: $scope.vc.channelDefaultValues("OriginalHeader", "operationNumber"),
                officerName: $scope.vc.channelDefaultValues("OriginalHeader", "officerName"),
                paymentFrequency: $scope.vc.channelDefaultValues("OriginalHeader", "paymentFrequency")
            };
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
                $scope.vc.render('VC_PROSPECTMI_213684');
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
    var cobisMainModule = cobis.createModule("VC_PROSPECTMI_213684", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "CSTMR"]);
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
        $routeProvider.when("/VC_PROSPECTMI_213684", {
            templateUrl: "VC_PROSPECTMI_213684_FORM.html",
            controller: "VC_PROSPECTMI_213684_CTRL",
            labelId: "CSTMR.LBL_CSTMR_CREACINCO_36598",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('CSTMR');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_PROSPECTMI_213684?" + $.param(search);
            }
        });
        VC_PROSPECTMI_213684(cobisMainModule);
    }]);
} else {
    VC_PROSPECTMI_213684(cobisMainModule);
}