//Designer Generator v 6.3.3 - release SPR 2017-12 23/06/2017
var designerEvents = designerEvents || {};
designerEvents.api = designerEvents.api || {};
designerEvents.api.groupform = designerEvents.api.groupform || designer.dsgEvents();

function VC_GROUPEWRVJ_935520(cobisMainModule) {
    cobisMainModule.controllerProvider.register("VC_GROUPEWRVJ_935520_MAIN_CTRL", ["$scope", "breadcrumbs",

    function($scope, breadcrumbs) {
        $scope.breadcrumbs = breadcrumbs;
    }]);
    cobisMainModule.controllerProvider.register("VC_GROUPEWRVJ_935520_CTRL", ["cobisMessage", cobis.modules.CONTAINER + ".preferencesService", "dsgnrUtils", "designer", "$scope", "$location", "$document", "$parse", "$filter", "$modal", "$q", "$compile", "$timeout", "$translate",

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
            moduleId: "LOANS",
            subModuleId: "GROUP",
            taskId: "T_GROUPWJDAQBWK_520",
            taskVersion: "1.0.0",
            viewContainerId: "VC_GROUPEWRVJ_935520",
            hasCloseModalEvent: false,
            serverEvents: true
        },
            "${contextPath}/resources/LOANS/GROUP/T_GROUPWJDAQBWK_520",
        designerEvents.api.groupform,
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
                vcName: 'VC_GROUPEWRVJ_935520'
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
                    moduleId: 'LOANS',
                    subModuleId: 'GROUP',
                    taskId: 'T_GROUPWJDAQBWK_520',
                    version: '1.0.0',
                    user: $scope.vc.args.user
                },
                entityNames: {
                    Group: "Group"
                },
                entities: {
                    Group: {
                        hasGroupAccount: 'AT18_HASGROOA452',
                        meetingAddress: 'AT24_MEETINSD452',
                        nextVisitDate: 'AT28_NEXTVIAA452',
                        state: 'AT34_STATENKY452',
                        titular2Name: 'AT36_TITULARN452',
                        groupOffice: 'AT42_GROUPOFE452',
                        titularClient2: 'AT44_TITULAIE452',
                        userName: 'AT44_USERNAMM452',
                        addressMember: 'AT49_ADDRESSS452',
                        day: 'AT52_DAYBKCTB452',
                        constitutionDate: 'AT58_CONSTIAI452',
                        updateGroup: 'AT61_UPDATEPR452',
                        nameGroup: 'AT63_NAMEGROU452',
                        cycleNumber: 'AT65_CYCLENEU452',
                        payment: 'AT65_PAYMENTT452',
                        groupAccount: 'AT66_GROUPATO452',
                        otherPlace: 'AT67_OTHERPAC452',
                        titularClient1: 'AT70_TITULAEE452',
                        operation: 'AT71_OPERATIN452',
                        hasLiquidGar: 'AT73_HASLIQIU452',
                        time: 'AT77_TIMEBDBX452',
                        code: 'AT87_CODEJXPZ452',
                        titular1Name: 'AT87_TITULAR1452',
                        hasIndividualAccount: 'AT90_HASINDAT452',
                        officer: 'AT91_OFFICERR452',
                        _pks: [],
                        _entityId: 'EN_GROUPWBWL_452',
                        _entityVersion: '1.0.0',
                        _transient: false
                    }
                },
                relations: []
            };
            $scope.vc.queryProperties = {};
            var defaultValues = {
                Group: {}
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
                $scope.vc.execute("temporarySave", VC_GROUPEWRVJ_935520, data, function() {});
            };
            $scope.vc.temporaryRead = function() {
                if (page.hasTemporaryDataSupport) {
                    var data = {
                        model: $scope.vc.model,
                        temporaryStorePK: $scope.vc.metadata.taskPk
                    };
                    return $scope.vc.executeService("readTemporaryData", VC_GROUPEWRVJ_935520, data).then(

                    function(response) {
                        var result = $scope.vc.processTemporaryResponse(response);
                        if (result) {
                            $scope.vc.execute("deleteTemporaryData", VC_GROUPEWRVJ_935520, data, function() {});
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
            $scope.vc.viewState.VC_GROUPEWRVJ_935520 = {
                style: []
            }
            $scope.vc.model.Group = {
                hasGroupAccount: $scope.vc.channelDefaultValues("Group", "hasGroupAccount"),
                meetingAddress: $scope.vc.channelDefaultValues("Group", "meetingAddress"),
                nextVisitDate: $scope.vc.channelDefaultValues("Group", "nextVisitDate"),
                state: $scope.vc.channelDefaultValues("Group", "state"),
                titular2Name: $scope.vc.channelDefaultValues("Group", "titular2Name"),
                groupOffice: $scope.vc.channelDefaultValues("Group", "groupOffice"),
                titularClient2: $scope.vc.channelDefaultValues("Group", "titularClient2"),
                userName: $scope.vc.channelDefaultValues("Group", "userName"),
                addressMember: $scope.vc.channelDefaultValues("Group", "addressMember"),
                day: $scope.vc.channelDefaultValues("Group", "day"),
                constitutionDate: $scope.vc.channelDefaultValues("Group", "constitutionDate"),
                updateGroup: $scope.vc.channelDefaultValues("Group", "updateGroup"),
                nameGroup: $scope.vc.channelDefaultValues("Group", "nameGroup"),
                cycleNumber: $scope.vc.channelDefaultValues("Group", "cycleNumber"),
                payment: $scope.vc.channelDefaultValues("Group", "payment"),
                groupAccount: $scope.vc.channelDefaultValues("Group", "groupAccount"),
                otherPlace: $scope.vc.channelDefaultValues("Group", "otherPlace"),
                titularClient1: $scope.vc.channelDefaultValues("Group", "titularClient1"),
                operation: $scope.vc.channelDefaultValues("Group", "operation"),
                hasLiquidGar: $scope.vc.channelDefaultValues("Group", "hasLiquidGar"),
                time: $scope.vc.channelDefaultValues("Group", "time"),
                code: $scope.vc.channelDefaultValues("Group", "code"),
                titular1Name: $scope.vc.channelDefaultValues("Group", "titular1Name"),
                hasIndividualAccount: $scope.vc.channelDefaultValues("Group", "hasIndividualAccount"),
                officer: $scope.vc.channelDefaultValues("Group", "officer")
            };
            //ViewState - Group: Group1369
            $scope.vc.createViewState({
                id: "G_GROUPWKOIS_460725",
                hasId: true,
                componentStyle: [],
                label: 'Group1369',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: code
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGKH_387725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CDIGOBGIA_29707",
                format: "####",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: nameGroup
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXQKV_915725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NOMBREDEL_71895",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: groupOffice
            $scope.vc.createViewState({
                id: "VA_5477JBWRUUXKGYZ_479725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_SUCURSALL_92833",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.Insert + designer.constants.mode.Update + designer.constants.mode.Query,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_5477JBWRUUXKGYZ_479725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_5477JBWRUUXKGYZ_479725', 'cl_oficina', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_5477JBWRUUXKGYZ_479725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_5477JBWRUUXKGYZ_479725");
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
            //ViewState - Entity: Group, Attribute: state
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXGPY_589725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_ESTADOIKH_14850",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXGPY_589725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXGPY_589725', 'cl_estado_ambito', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXGPY_589725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                            $scope.vc.setComboBoxDefaultValue("VA_TEXTINPUTBOXGPY_589725");
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
            //ViewState - Entity: Group, Attribute: constitutionDate
            $scope.vc.createViewState({
                id: "VA_DATEFIELDBVXWGU_529725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_FECHADEON_20508",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: officer
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXNBX_864725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_OFICIALPP_48476",
                format: "n0",
                decimals: 0,
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXNBX_864725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalog('VA_TEXTINPUTBOXNBX_864725', function(response) {
                            if (response.success) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXNBX_864725'];
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
            //ViewState - Entity: Group, Attribute: addressMember
            $scope.vc.createViewState({
                id: "VA_8723IIAMUFLQPPL_567725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DIRECCIDT_21959",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: otherPlace
            $scope.vc.createViewState({
                id: "VA_9330BRACKQSJMLZ_312725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_OTROLUGAA_91030",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: meetingAddress
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXLLT_362725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DIRECCINR_95137",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: hasGroupAccount
            $scope.vc.createViewState({
                id: "VA_9596VHOLMQOEFOI_924725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TIENEUNAL_24954",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: groupAccount
            $scope.vc.createViewState({
                id: "VA_1940KQURTPVEVBJ_839725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_CUENTAGPP_81835",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer1391",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: titular1Name
            $scope.vc.createViewState({
                id: "VA_5634HKMSQGZFPUQ_212725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TITULAR11_75053",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: titular2Name
            $scope.vc.createViewState({
                id: "VA_4103IWRALHJMDZX_523725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TITULAR22_98361",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2474",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: hasIndividualAccount
            $scope.vc.createViewState({
                id: "VA_1778TBFOWZJSSYZ_913725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_TIENECUII_93177",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2815",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2894",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2732",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: day
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXPBI_949725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_DAREUNINN_57023",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_TEXTINPUTBOXPBI_949725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        $scope.vc.loadCatalogCobis('VA_TEXTINPUTBOXPBI_949725', 'ad_dia_semana', function(response) {
                            if (angular.isDefined(response.data)) {
                                var catalogResponse = response.data['RESULTVA_TEXTINPUTBOXPBI_949725'];
                                if (angular.isDefined(catalogResponse) && !$.isEmptyObject(catalogResponse)) {
                                    options.success(catalogResponse);
                                } else {
                                    options.success([]);
                                }
                            } else {
                                options.success([]);
                            }
                        }, {
                            filterType: 'startswith'
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
            //ViewState - Entity: Group, Attribute: time
            $scope.vc.createViewState({
                id: "VA_DATEFIELDPXOFDO_933725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_HORAREUIN_21270",
                validationCode: 32,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            $scope.vc.createViewState({
                id: "Spacer2498",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.None,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: payment
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXEPD_109725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_COMPORTPP_53225",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: cycleNumber
            $scope.vc.createViewState({
                id: "VA_TEXTINPUTBOXRNK_976725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_NRODECIOL_83110",
                format: "n0",
                decimals: 0,
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.Query,
                visible: designer.constants.mode.All
            });
            //ViewState - Entity: Group, Attribute: hasLiquidGar
            $scope.vc.createViewState({
                id: "VA_HASLIQUIDGARNFF_564725",
                componentStyle: [],
                label: "LOANS.LBL_LOANS_USARGARRT_64298",
                validationCode: 0,
                readOnly: designer.constants.mode.Query,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All,
                isComboBox: true
            });
            $scope.vc.catalogs.VA_HASLIQUIDGARNFF_564725 = new kendo.data.DataSource({
                transport: {
                    read: function(options) {
                        options.success([{
                            code: 'S',
                            value: 'SI'
                        }, {
                            code: 'N',
                            value: 'NO'
                        }]);
                        $scope.vc.setComboBoxDefaultValue("VA_HASLIQUIDGARNFF_564725");
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
                id: "VA_VABUTTONPDPCKGB_382725",
                componentStyle: [],
                label: '',
                validationCode: 0,
                readOnly: designer.constants.mode.None,
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.None
            });
            //ViewState - Command: Accept
            $scope.vc.createViewState({
                id: "T_GROUPWJDAQBWK_520_ACCEPT",
                componentStyle: [],
                label: 'Accept',
                enabled: designer.constants.mode.All,
                visible: designer.constants.mode.All
            });
            //ViewState - Command: Cancel
            $scope.vc.createViewState({
                id: "T_GROUPWJDAQBWK_520_CANCEL",
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
                $scope.vc.render('VC_GROUPEWRVJ_935520');
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
    var cobisMainModule = cobis.createModule("VC_GROUPEWRVJ_935520", ["ngResource", "ngRoute", "kendo.directives", "ui.bootstrap", "oc.lazyLoad", "pascalprecht.translate", cobis.modules.CONTAINER, "designerModule"], ["DSGNR", "LOANS"]);
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
        $routeProvider.when("/VC_GROUPEWRVJ_935520", {
            templateUrl: "VC_GROUPEWRVJ_935520_FORM.html",
            controller: "VC_GROUPEWRVJ_935520_CTRL",
            label: "GroupForm",
            resolve: {
                i18n: function($translatePartialLoader) {
                    $translatePartialLoader.addPart('DSGNR');
                    $translatePartialLoader.addPart('LOANS');
                }
            }
        }).otherwise({
            redirectTo: function(routeParams, path, search) {
                return "/VC_GROUPEWRVJ_935520?" + $.param(search);
            }
        });
        VC_GROUPEWRVJ_935520(cobisMainModule);
    }]);
} else {
    VC_GROUPEWRVJ_935520(cobisMainModule);
}