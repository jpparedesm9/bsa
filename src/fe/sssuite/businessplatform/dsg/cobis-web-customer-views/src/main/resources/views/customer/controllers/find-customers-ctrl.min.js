(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CUSTOMER, [cobis.modules.CONTAINER]);


    app.directive('capitalize', function () {
        return {
            require: 'ngModel',
            link: function (scope, element, attrs, modelCtrl) {
                var capitalize = function (inputValue) {
                    if (!inputValue) {
                        inputValue = "";
                    }
                    var capitalized = inputValue.toUpperCase();
                    if (capitalized !== inputValue) {
                        modelCtrl.$setViewValue(capitalized);
                        modelCtrl.$render();
                    }
                    return capitalized;
                }
                modelCtrl.$parsers.push(capitalize);
                capitalize(scope[attrs.ngModel]); // capitalize initial value
            }
        };
    });


    var searchValidatorOptions = {
        rules: {
            requiredIfDependantNotNull: function (input) {

                var dependatElemntId = input.attr('dependantField'),
				    dependantElementValue = null,
					inputVal = input.val();
                if (input.is("[required-if-dependant-not-null]")) {
                    if (inputVal == "" || inputVal == null) {
                        var dependantElementValue = $("#" + dependatElemntId).val();
                        if (dependantElementValue == "" || dependantElementValue == null) {
                            return false;
                        }
                    }
                }
                return true;
            }
        },
        messages: {
            requiredIfDependantNotNull: function (input) {
                var message = input.data('msgRequiredIfDependantNotNull');
                return message;
            }
        }
    };

    app.controller("customer.queryCustomersController", ['$scope', '$location', '$filter', '$compile', '$rootScope', 'customer.queryCustomersService', 'designer', 'dsgnrCommons',
        function ($scope, $location, $filter, $compile, $rootScope, queryCustomersService, designer, dsgnrCommons) {

            $scope.vc = designer.initCustomViewContainer("findCustomer", $scope.customEvents);

            $scope.prospectPage = function () {

                var api = new dsgnrCommons.API($scope.vc),
                    nav = api.navigation;

                var newUrl = "${contextPath}/cobis/web/views/"
                    + 'CSTMR'
                    + "/"
                    + 'CSTMR'
                    + "/"
                    + 'T_PROSPECTCOOSS_684'
                    + "/"
                    + '1.0.0'
                    + "/"
                    + 'VC_PROSPECTMI_213684_TASK.HTML';
                var currentTab = cobis.container.tabs.getCurrentTab();

                cobis.container.tabs.changeCurrentTab(currentTab.id, newUrl, 'MNU_PROSPECTS', false);

            }

            if ($scope.vc.parentVc.customDialogParameters.mode == "findCompany") {
                $scope.types = "PJ";
                $scope.customerType = "C";
                $scope.isJuridicPerson = true;
                $scope.isName = false;
                $scope.isCompanyName = true;

            } else {
                $scope.types = "PN";
                $scope.isNaturalPerson = true;
                $scope.isName = true;
                $scope.isCompanyName = false;
            }
            $scope.criteria = "id";
            $scope.entities = "customer";
            $scope.isSecuencial = false;
            $scope.isId = false;
            $scope.txtCompanyName = "";
            $scope.txtName = "";
            $scope.txtLastName = "";
            $scope.isSelect = false;
            $scope.lastCodeCustomer = "";
            $scope.Size = "10";
            $scope.PageIndex = 0;
            $scope.Pages = new Array();
            $scope.isResultGrid = false;
            $scope.customerType = "P";
            $scope.oldTabName = "";
            $scope.openAsModal = "S";
            $scope.existButtonAdd = false;
            $scope.existButtonAddGroup = false;
            $scope.isSantander = false;

            $scope.searchValidatorOptions = searchValidatorOptions;


            //cambiar nombre de tab a búsqueda de clientes

            var getUrlParameter = function getUrlParameter(sParam) {


                if (cobis.container.tabs.getCurrentTab() != null && cobis.container.tabs.getCurrentTab().url != null && cobis.container.tabs.getCurrentTab().url.length > 0) {
                    var url = cobis.container.tabs.getCurrentTab().url;

                    url = url.substring(url.indexOf('?') + 1, url.length);

                    var sPageURL = decodeURIComponent(url),
                        sURLVariables = sPageURL.split('&'),
                        sParameterName,
                        i;

                    for (i = 0; i < sURLVariables.length; i++) {
                        sParameterName = sURLVariables[i].split('=');

                        if (sParameterName[0] === sParam) {
                            return sParameterName[1] === undefined ? true : sParameterName[1];
                        }
                    }

                }
            };

            $scope.openAsModal = getUrlParameter('modal');
            $scope.showNewCustomerButton = getUrlParameter('newCustomer');

            if ($scope.openAsModal == "N") {
                $scope.oldTabName = cobis.container.tabs.getCurrentTab().name;
                cobis.container.tabs.getCurrentTab().name = "MNU_CUSTOMER_SEARCH";
                cobis.containerScope.$apply();
            }

            //template para creaciÃ³n de prospectos

            if ($scope.showNewCustomerButton != "N") {
                $scope.prospectTemplate = [
                    {
                        name: $filter('translate')('COMMONS.LABELS.LBL_NEW_CUSTOMER'),
                        template: '<a ng-click="prospectPage()" class="btn btn-default" ><span class="fa fa-plus"></span><span translate>COMMONS.LABELS.LBL_NEW_CUSTOMER</span></a>'
                    }];
            }

            //init data para busqueda de clientes
            $scope.filters = [];
            $scope.filters.entity = [{
                id: 1,
                label: $filter('translate')('COMMONS.LABELS.LBL_CUSTOMER')
            }, {
                id: 2,
                label: $filter('translate')('COMMONS.LABELS.LBL_PROSPECT')
            }]
            $scope.filters.type = [{
                id: 1,
                label: $filter('translate')('COMMONS.LABELS.LBL_NATURAL_ENTITY')
            }, {
                id: 2,
                label: $filter('translate')('COMMONS.LABELS.LBL_LEGAL_ENTITY')
            }, {
                id: 3,
                label: $filter('translate')('COMMONS.LABELS.LBL_ECONOMIC_GROUP')
            }, {
                id: 4,
                label: $filter('translate')('COMMONS.LABELS.LBL_SOLITARY_GROUP')
            }]


            $scope.filters.field = [];

            //			$scope.selectedEntity = $scope.filters.entity[0];
            //			$scope.selectedType = $scope.filters.type[0];
            //$scope.selectedField = $scope.filters.field[0];




            $scope.getFields = function (type) {

                if (type == "GS" || type == "GE") {
                    $scope.filters.field = [{
                        id: 1,
                        label: $filter('translate')('COMMONS.LABELS.LBL_CODE_NUMBER')
                    }, {
                        id: 2,
                        label: $filter('translate')('COMMONS.LABELS.LBL_COMPANY_NAME')
                    }, {
                        id: 3,
                        label: $filter('translate')('COMMONS.LABELS.LBL_CONSECUTIVE')
                    }];
                } else if (type == "PN" || type == "PJ") {
                    $scope.filters.field = [{
                        id: 1,
                        label: $filter('translate')('COMMONS.LABELS.LBL_CODE_NUMBER')
                    }, {
                        id: 2,
                        label: $filter('translate')('COMMONS.LABELS.LBL_COMPANY_NAME')
                    }, {
                        id: 3,
                        label: $filter('translate')('COMMONS.LABELS.LBL_CONSECUTIVE')
                    }, {
                        id: 4,
                        label: $filter('translate')('COMMONS.LABELS.LBL_SANTANDER')
                    }];

                }

            };

            $scope.setEntity = function (entity) {
                $scope.selectedEntity = entity;
                $scope.isResultGrid = false;
                $scope.CleanControl();
                $scope.entities = $scope.selectedEntity.id == 1 ? "customer" : "prospect"

                $scope.autoCompleteDataSource = new kendo.data.DataSource({
                    data: []
                });
            };
            $scope.setType = function (type) {
                $scope.selectedType = type;
                $scope.types = type.id == 4 ? "GS" : $scope.types;
                $scope.types = type.id == 3 ? "GE" : $scope.types;
                $scope.types = type.id == 2 ? "PJ" : $scope.types;
                $scope.types = type.id == 1 ? "PN" : $scope.types;

                $scope.changeTypes();

                $scope.autoCompleteDataSource = new kendo.data.DataSource({
                    data: []
                });
            };
            $scope.setField = function (field) {
                $scope.selectedField = field;
                $scope.criteria = field.id == 4 ? "san" : $scope.criteria;
                $scope.criteria = field.id == 3 ? "sec" : $scope.criteria;
                $scope.criteria = field.id == 2 ? "name" : $scope.criteria;
                $scope.criteria = field.id == 1 ? "id" : $scope.criteria;
                $scope.changeCriteria();

                $scope.autoCompleteDataSource = new kendo.data.DataSource({
                    data: []
                });
            };
            //end init data

            $scope.CleanControl = function () {
                $scope.txtName = "";
                $scope.txtLastName = "";
                $scope.txtCompanyName = "";
                $scope.txtId = "";
                $scope.txtSecuencial = "";
                $scope.natural = [];
                $scope.company = [];
                $scope.group = [];
                $scope.groupColumns = [];
                $scope.companyColumns = [];
                $scope.naturalColumns = [];
                $scope.isPrevius = false;
                //$scope.txtSantander = "";
            };

            $scope.changeTypes = function () {
                if ($scope.types == "GE" && $scope.criteria == "id") {
                    $scope.criteria = "sec";
                }
                $scope.isSolidarityGroup = $scope.types == "GS";
                $scope.isEconomicGroup = $scope.types == "GE";
                $scope.isNaturalPerson = $scope.types == "PN";
                $scope.isJuridicPerson = $scope.types == "PJ";

                if ($scope.isNaturalPerson) {
                    $scope.customerType = "P";
                }
                if ($scope.isJuridicPerson) {
                    $scope.customerType = "C";
                }
                if ($scope.isEconomicGroup) {
                    $scope.customerType = "G";
                }
                if ($scope.isSolidarityGroup) {
                    $scope.customerType = "S";
                }
                $scope.getFields($scope.types);
                $scope.changeCriteria();
                $scope.CleanControl();
            };


            var selectEvent = false;

            $scope.onChangeAutoComplete = function () {

                if (selectEvent) {
                    $scope.search(null, "autoCompleteClickEvent");
                }
            }

            $scope.selectAutoComplete = function (e) {

                selectEvent = false;

                if (e == "_select") {
                    selectEvent = true;
                    $('#autoCompleteControl').change();
                }

            }

            $scope.changeDataSourceByText = function (e) {


                //Validación para evitar el pegado de letras cuando se ingresa secuencial
                if ($scope.criteria == "sec") {
                    if (/^[0-9]*$/.test($scope.txtSecuencial) == false) {
                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.MESSAGES.MSG_REQUIRED_NUMBERS", null, 10000, false);
                        return false;
                    }
                }
                //Validación para evitar el pegado de numeros cuando se ingresa el nombre
                if ($scope.criteria == "name") {
                    if (/^[a-zA-Z-áéíóúñÑÁÉÍÓÚ\s\W]*$/.test($scope.txtName) == false || /^[a-zA-Z-áéíóúñÑÁÉÍÓÚ\s\W]*$/.test($scope.txtLastName) == false || /^[a-zA-Z-áéíóúñÑÁÉÍÓÚ\s\W]*$/.test($scope.txtCompanyName) == false) {
                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.MESSAGES.MSG_REQUIRED_LETTERS", null, 10000, false);
                        return false;
                    }
                }
                //Validación para evitar el pegado de letras cuando se ingresa el codigo Santander
                if ($scope.criteria == "san") {
                    if (/^[0-9]*$/.test($scope.txtSantander) == false) {
                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.MESSAGES.MSG_REQUIRED_NUMBERS", null, 10000, false);
                        return false;
                    }
                }

                e.preventDefault();

                if ($scope.types == "PN" || $scope.types == "PJ") {
                    var searchCustomer = {};
                    if ($scope.criteria == "id") {
                        var searchValue = $scope.txtId.trim();
                        var mode = "";
                        if (searchValue.search('%') >= 0 || searchValue == "") {
                            mode = "0";
                        } else {
                            mode = "2";
                        }

                        if (searchValue == "%") {
                            searchValue = " ";
                        } else if (searchValue == "") {
                            searchValue = " ";
                        } else {
                            searchValue = $scope.trimEnd(searchValue, "%");
                        }

                        searchCustomer = {
                            subType: $scope.types == "PN" ? "P" : "C",
                            type: $scope.types == "PN" ? "8" : "2",
                            mode: mode,
                            comercialName: "",
                            clientNumber: "",
                            clientName: "",
                            clientLastName: "",
                            cedRuc: searchValue,
                            isClient: $scope.entities == "customer" ? "S" : "N",
                            size: $scope.Size,
                            lastCode: $scope.lastCodeCustomer,
                            clientNumberB: ""
                        }
                    } else if ($scope.criteria == "sec") {
                        var searchValue = $scope.txtSecuencial.trim();
                        var mode = "";
                        if (searchValue.search('%') >= 0) {
                            mode = "0";
                        } else {
                            mode = "2";
                        }

                        if (searchValue == null) {
                            searchValue = "-1";
                            mode = "0";
                        } else if (searchValue == "") {
                            searchValue = "-1";
                            mode = "0";
                        } else {
                            searchValue = $scope.trimEnd(searchValue, "%");
                        }
                        searchCustomer = {
                            subType: $scope.types == "PN" ? "P" : "C",
                            type: 1,
                            mode: mode,
                            comercialName: "",
                            clientNumber: searchValue,
                            clientName: "",
                            clientLastName: "",
                            cedRuc: "",
                            isClient: $scope.entities == "customer" ? "S" : "N",
                            size: $scope.Size,
                            lastCode: $scope.lastCodeCustomer,
                            clientNumberB: ""
                        }

                    } else if ($scope.criteria == "san") {
                        var searchValue = $scope.txtSantander.trim();
                        var mode = "";
                        if (searchValue.search('%') >= 0) {
                            mode = "0";
                        } else {
                            mode = "3";
                        }

                        if (searchValue == null) {
                            searchValue = "-1";
                            mode = "0";
                        } else if (searchValue == "") {
                            searchValue = "-1";
                            mode = "0";
                        } else {
                            searchValue = $scope.trimEnd(searchValue, "%");
                        }
                        searchCustomer = {
                            subType: $scope.types == "PN" ? "P" : "C",
                            type: 1,
                            mode: mode,
                            comercialName: "",
                            clientNumber: "",
                            clientName: "",
                            clientLastName: "",
                            cedRuc: "",
                            isClient: $scope.entities == "customer" ? "S" : "N",
                            size: $scope.Size,
                            lastCode: $scope.lastCodeCustomer,
                            clientNumberB: searchValue
                        }

                    } else if ($scope.criteria == "name") {
                        var clientName = $("#autoCompleteControl").val();

                        searchCustomer = {
                            subType: $scope.types == "PN" ? "P" : "C",
                            type: 5,
                            comercialName: clientName,
                            clientNumber: "",
                            clientName: clientName,
                            cedRuc: "",
                            isClient: $scope.entities == "customer" ? "S" : "N",
                            size: $scope.Size,
                            clientNumberB: ""
                        }

                    }

                    //UPPERCASE
                    if (clientName != null) {
                        $("#autoCompleteControl").val(clientName.toUpperCase());
                    }

                    if ($.trim(searchCustomer.clientName) != "" && $.trim(searchCustomer.clientName).length >= 7) {


                        $.ajax({
                            type: 'PUT',
                            url: "${contextPath}/resources/cobis/web/CustomerCommons/getCustomersByAutoCompleteText",
                            data: JSON.stringify(searchCustomer),
                            dataType: "json",
                            contentType: "application/json",
                            async: false,
                            success: function (_data) {

                                var result = _data.data;
                                var wDataSource = [];

                                if (result && result.length > 0) {

                                    if ($scope.types == "PN") {
                                        angular.forEach(result, function (_result) {
                                            wDataSource.push({
                                                name: _result.code.toString() + " - " +
													_result.fullName,
                                                id: _result.code
                                            })
                                        });
                                    }

                                    if ($scope.types == "PJ") {
                                        angular.forEach(result, function (_result) {
                                            wDataSource.push({
                                                name: _result.code.toString() + " - " + (_result.commercialName == "" || _result.commercialName == undefined ? _result.fullName : _result.commercialName),
                                                id: _result.code
                                            })
                                        });
                                    }

                                    $scope.autoCompleteDataSource = new kendo.data.DataSource({
                                        serverFiltering: true,
                                        data: wDataSource
                                    });

                                }
                                else {
                                    $scope.autoCompleteDataSource = new kendo.data.DataSource({
                                        data: []
                                    });
                                }
                            }
                        });



                    } else {
                        $scope.hideLoading();
                    }

                } else if ($scope.types == "GE" || $scope.types == "GS") {

                    //se usa el mismo objeto para 
                    var searchCustomer = {
                        clientName: "",
                        clientNumber: "",
                        clientNumberB: "",
                        isClient: $scope.entities == "customer" ? "S" : "N",
                        size: $scope.Size,
                        subType: $scope.types
                    }

                    if ($scope.criteria == "sec") {
                        searchCustomer.clientNumber = $scope.txtSecuencial;
                    } else if ($scope.criteria == "name") {
                        searchCustomer.clientName = $("#autoCompleteControl").val();

                    } else if ($scope.criteria == "san") {
                        searchCustomer.clientNumberB = $scope.txtSantander;
                    }


                    //UPPERCASE
                    if (searchCustomer.clientName != null) {
                        $("#autoCompleteControl").val(searchCustomer.clientName.toUpperCase());
                        searchCustomer.clientName = searchCustomer.clientName.toLocaleUpperCase();
                    }


                    if ($.trim(searchCustomer.clientName) != "" && $.trim(searchCustomer.clientName).length >= 7) {


                        $.ajax({
                            type: 'PUT',
                            url: "${contextPath}/resources/cobis/web/CustomerCommons/getCustomersByAutoCompleteText",
                            data: JSON.stringify(searchCustomer),
                            dataType: "json",
                            contentType: "application/json",
                            async: false,
                            success: function (_data) {

                                var result = _data.data;
                                var wDataSource = [];

                                if (result && result.length > 0) {


                                    if ($scope.types == "GE") {
                                        angular.forEach(result, function (_result) {
                                            wDataSource.push({
                                                name: _result.code.toString() + " - " +
													_result.fullName,
                                                id: _result.code
                                            })
                                        });
                                    }

                                    $scope.autoCompleteDataSource = new kendo.data.DataSource({
                                        serverFiltering: true,
                                        data: wDataSource
                                    });
                                }
                                else {
                                    $scope.autoCompleteDataSource = new kendo.data.DataSource({
                                        data: []
                                    });
                                }
                            }
                        });



                    } else {
                        $scope.hideLoading();
                    }

                }

            }


            $scope.changeCriteria = function () {
                $scope.isName = false;
                $scope.isCompanyName = false;
                $scope.isSecuencial = false;
                $scope.isId = false;
                $scope.isResultGrid = false;
                $scope.lastCodeCustomer = "";
                $scope.isSantander = false;

                $scope.CleanControl();

                if (($scope.types == "GE" || $scope.types == "GS" || $scope.types == "PJ") && $scope.criteria == "name") {
                    $scope.isName = false;
                    $scope.isCompanyName = false;

                    if ($scope.columnExist) {
                        $scope.isNameCriteria = true;
                    } else {
                        $scope.isCompanyName = true;
                    }

                } else if ($scope.types == "PN" && $scope.criteria == "name") {
                    $scope.isName = true;
                    $scope.isCompanyName = false;

                    if ($scope.columnExist) {
                        $scope.isNameCriteria = true;
                        $scope.isName = false;
                    }

                } else {
                    $scope.isName = false;
                    $scope.isCompanyName = false;
                    $scope.isNameCriteria = false;
                }

                if ($scope.criteria == "sec") {
                    $scope.isName = false;
                    $scope.isCompanyName = false;
                    $scope.isSecuencial = true;
                    $scope.isId = false;
                    $scope.isSantander = false;
                } else if ($scope.criteria == "id") {
                    $scope.isName = false;
                    $scope.isCompanyName = false;
                    $scope.isSecuencial = false;
                    $scope.isId = true;
                    $scope.isSantander = false;
                } else if ($scope.criteria == "san") {
                    $scope.isName = false;
                    $scope.isCompanyName = false;
                    $scope.isSecuencial = false;
                    $scope.isId = false;
                    $scope.isSantander = true;
                }
            };


            $scope.trimEnd = function (word, character) {
                var value = word
                if (word != null) {
                    if (value.search(character) >= 0) {
                        if (value.substring(value.length - 1, value.length) == character) {
                            value = value.substring(0, value.length - 1);

                            if (value.search(character) >= 0) {
                                value = $scope.trimEnd(value, character);
                            }
                        }
                    }
                }
                return value;
            }

            $scope.searchNext = function (e) {
                var lastCustomer = "";
                if ($scope.Pages.length > ($scope.PageIndex + 1)) {
                    $scope.PageIndex++;

                    if ($scope.types == "PN") {
                        $scope.natural = $scope.Pages[$scope.PageIndex];
                    } else if ($scope.types == "PJ") {
                        $scope.company = $scope.Pages[$scope.PageIndex];
                    } else {
                        $scope.group = $scope.Pages[$scope.PageIndex];
                    }

                } else {
                    if ($scope.types == "PN" && $scope.natural.length > 0) {
                        var index = $scope.natural.length - 1;
                        lastCustomer = $scope.natural[index];
                        $scope.Pages[$scope.PageIndex] = $scope.natural;
                    } else if ($scope.types == "PJ" && $scope.company.length > 0) {
                        var index = $scope.company.length - 1;
                        lastCustomer = $scope.company[index];
                        $scope.Pages[$scope.PageIndex] = $scope.company;
                    } else {
                        if ($scope.group.length > 0) {
                            var index = $scope.group.length - 1;
                            lastCustomer = $scope.group[index];
                            $scope.Pages[$scope.PageIndex] = $scope.group;
                        }

                    }
                    if (lastCustomer !== "") {
                        $scope.setLastCodeCustomer(lastCustomer);
                    }
                    $scope.PageIndex++;
                    $scope.search(e, "1");
                }

                $scope.isPrevius = true;


            };

            $scope.setLastCodeCustomer = function (lastCustomer) {
                if ($scope.criteria == "id") {
                    $scope.lastCodeCustomer = lastCustomer.documentId;
                } else if ($scope.criteria == "name") {
                    if ($scope.types == "PN") {
                        $scope.lastCodeCustomer = lastCustomer.name;
                    }
                    else if ($scope.types == "PJ") {
                        $scope.lastCodeCustomer = lastCustomer.commercialName;
                    }
                    else if ($scope.types == "GE") {
                        $scope.lastCodeCustomer = lastCustomer.groupName;
                    }
                    else if ($scope.types == "GS") {
                        $scope.lastCodeCustomer = lastCustomer.groupName;
                    }
                } else if ($scope.criteria == "sec") {
                    $scope.lastCodeCustomer = lastCustomer.code;
                } else if ($scope.criteria == "san") {
                    $scope.lastCodeCustomer = lastCustomer.code;
                }
            };

            $scope.searchPrevious = function (e) {
                if ($scope.PageIndex > 0) {
                    $scope.PageIndex--;
                    if ($scope.types == "PN") {
                        $scope.natural = $scope.Pages[$scope.PageIndex];
                    } else if ($scope.types == "PJ") {
                        $scope.company = $scope.Pages[$scope.PageIndex];
                    } else {
                        $scope.group = $scope.Pages[$scope.PageIndex];
                    }
                }

                if ($scope.PageIndex <= 0) {
                    $scope.isPrevius = false;
                }

                if ($scope.Pages.length > 0) {
                    $scope.isNext = true;
                }

            };

            $scope.search = function (e, flagNext) {

                /* if (flagNext != "1") {
                     $scope.natural = [];
                     $scope.company = [];
                     $scope.group = [];
                 } */

                //Validaci�n para evitar el pegado de letras cuando se ingresa secuencial
                if ($scope.criteria == "sec") {
                    if (/^[0-9]*$/.test($scope.txtSecuencial) == false) {
                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.MESSAGES.MSG_REQUIRED_NUMBERS", null, 10000, false);
                        return false;
                    }
                }
                //Validaci�n para evitar el pegado de numeros cuando se ingresa el nombre
                if ($scope.criteria == "name") {
                    if (/^[a-zA-Z-������������\s\W]*$/.test($scope.txtName) == false || /^[a-zA-Z-������������\s\W]*$/.test($scope.txtLastName) == false || /^[a-zA-Z-������������\s\W]*$/.test($scope.txtCompanyName) == false) {
                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.MESSAGES.MSG_REQUIRED_LETTERS", null, 10000, false);
                        return false;
                    }
                }
                //Validaci�n para evitar el pegado de letras cuando se ingresa codigo Santander
                if ($scope.criteria == "san") {
                    if (/^[0-9]*$/.test($scope.txtSantander) == false) {
                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.MESSAGES.MSG_REQUIRED_NUMBERS", null, 10000, false);
                        return false;
                    }
                }

                if (typeof (flagNext) == undefined || flagNext == "autoCompleteClickEvent") {
                    $scope.Pages = new Array();
                    $scope.PageIndex = 0;
                    $scope.lastCodeCustomer = "";
                }

                if (e != null) {
                    e.preventDefault();
                }

                if ($scope.val77.validate()) {
                    if ($scope.types == "PN" || $scope.types == "PJ") {
                        var searchCustomer = {};
                        if ($scope.criteria == "id") {
                            var searchValue = $scope.txtId.trim();
                            var mode = "";
                            if (searchValue.search('%') >= 0 || searchValue == "") {
                                mode = "0";
                            } else {
                                mode = "2";
                            }

                            if (searchValue == "%") {
                                searchValue = " ";
                            } else if (searchValue == "") {
                                searchValue = " ";
                            } else {
                                searchValue = $scope.trimEnd(searchValue, "%");
                            }

                            searchCustomer = {
                                subType: $scope.types == "PN" ? "P" : "C",
                                type: $scope.types == "PN" ? "8" : "2",
                                mode: mode,
                                comercialName: "",
                                clientNumber: "",
                                clientNumberB: "",
                                clientName: "",
                                clientLastName: "",
                                cedRuc: searchValue,
                                isClient: $scope.entities == "customer" ? "S" : "N",
                                size: $scope.Size,
                                lastCode: $scope.lastCodeCustomer
                            }
                        } else if ($scope.criteria == "sec") {
                            var searchValue = $scope.txtSecuencial.trim();
                            var mode = "";
                            if (searchValue.search('%') >= 0) {
                                mode = "0";
                            } else {
                                mode = "2";
                            }

                            if (searchValue == null) {
                                searchValue = "-1";
                                mode = "0";
                            } else if (searchValue == "") {
                                searchValue = "-1";
                                mode = "0";
                            } else {
                                searchValue = $scope.trimEnd(searchValue, "%");
                            }
                            searchCustomer = {
                                subType: $scope.types == "PN" ? "P" : "C",
                                type: 1,
                                mode: mode,
                                comercialName: "",
                                clientNumber: searchValue,
                                clientNumberB: "",
                                clientName: "",
                                clientLastName: "",
                                cedRuc: "",
                                isClient: $scope.entities == "customer" ? "S" : "N",
                                size: $scope.Size,
                                lastCode: $scope.lastCodeCustomer
                            }

                        } else if ($scope.criteria == "san") {
                            var searchValue = $scope.txtSantander.trim();
                            var mode = "";
                            if (searchValue.search('%') >= 0) {
                                mode = "0";
                            } else {
                                mode = "3";
                            }

                            if (searchValue == null) {
                                searchValue = "-1";
                                mode = "0";
                            } else if (searchValue == "") {
                                searchValue = "-1";
                                mode = "0";
                            } else {
                                searchValue = $scope.trimEnd(searchValue, "%");
                            }
                            searchCustomer = {
                                subType: $scope.types == "PN" ? "P" : "C",
                                type: 1,
                                mode: mode,
                                comercialName: "",
                                clientNumber: "",
                                clientNumberB: searchValue,
                                clientName: "",
                                clientLastName: "",
                                cedRuc: "",
                                isClient: $scope.entities == "customer" ? "S" : "N",
                                size: $scope.Size,
                                lastCode: $scope.lastCodeCustomer
                            }

                        } else if ($scope.criteria == "name") {
                            var firstName = $scope.txtName.trim();
                            var lastName = $scope.txtLastName.trim();
                            var companyName = $scope.txtName.trim();

                            if ($scope.types == "PN") {
                                firstName = $scope.columnExist == true ? $("#autoCompleteControl").val() : firstName;
                                lastName = $scope.columnExist == true ? $("#autoCompleteControl").val() : lastName;
                            }
                            if ($scope.types == "PJ") {
                                companyName = $scope.columnExist == true ? $("#autoCompleteControl").val() : companyName;
                                lastName = "";
                                firstName = "";
                            }
                            var mode = "";
                            if (lastName != null) {
                                if (lastName.search("%") >= 0) {

                                    mode = "0";
                                } else {
                                    if (lastName != "" || firstName != "")
                                        mode = "2";
                                }
                            }

                            if (companyName != null) {
                                if ($scope.types == "PJ" && companyName.search("%") >= 0) {
                                    mode = "0";
                                }
                            }

                            lastName = $scope.columnExist == true ? "" : lastName;

                            var lastName = $scope.trimEnd(lastName, "%");
                            var firstName = $scope.trimEnd(firstName, "%");
                            var companyName = $scope.trimEnd(companyName, "%");



                            searchCustomer = {
                                subType: $scope.types == "PN" ? "P" : "C",
                                type: 5,
                                mode: mode,
                                comercialName: companyName,
                                clientNumber: "",
                                clientNumberB: "",
                                clientName: firstName,
                                clientLastName: lastName,
                                //marriedLastName: "",
                                cedRuc: "",
                                isClient: $scope.entities == "customer" ? "S" : "N",
                                size: $scope.Size,
                                lastCode: $scope.lastCodeCustomer,
                                columnExist: $scope.columnExist == false ? 0 : 1
                            }

                        }



                        var _input = $("#autoCompleteControl").val();
                        var _id = "";



                        if (_input != null) {
                            _input = _input.split("-");
                            _id = $.trim(_input[0]);
                        }

                        //al presionar en autoComplete se simula búsqueda por id
                        if (flagNext == "autoCompleteClickEvent" && searchCustomer.subType == "P") {
                            searchCustomer.clientName = "";
                            searchCustomer.type = 1;
                            searchCustomer.clientNumber = _id;
                            searchCustomer.clientNumberB = "";
                        } else if (flagNext == "autoCompleteClickEvent" && searchCustomer.subType == "C") {
                            searchCustomer.comercialName = "";
                            searchCustomer.type = 1;
                            searchCustomer.clientNumber = _id;
                            searchCustomer.mode = 2;
                            searchCustomer.clientNumberB = "";
                        }

                        $scope.showLoading();
                        if ($.trim(searchCustomer.cedRuc) != "" || $.trim(searchCustomer.clientLastName) != "" || $.trim(searchCustomer.clientName) != "" || ($.trim(searchCustomer.clientNumber) != "" && $.trim(searchCustomer.clientNumber) != "-1") || $.trim(searchCustomer.comercialName) != "" || ($.trim(searchCustomer.clientNumberB) != "" && $.trim(searchCustomer.clientNumberB) != "-1")) {
                            var result = queryCustomersService.queryClientByParameters(searchCustomer);
                            result.then(function (data) {
                                var result = data;

                                if (result && result.length > 0) {

                                    $scope.customerType = result[0].customerType;

                                    if ($scope.types == "PJ") {
                                        $scope.company = new Array();
                                        result.forEach(function (rs, index) {
                                            rs.official = $.trim(rs.official) + " - " + $.trim(rs.descriptionOfficial)
                                            $scope.company.push(rs);
                                        });
                                        if ($scope.company.length == $scope.Size) {
                                            $scope.isNext = true;
                                        } else {
                                            $scope.isNext = false;
                                        }

                                        if ($scope.company.length > 0 && $scope.isJuridicPerson) {
                                            $scope.isResultGrid = true;
                                        }
                                    }
                                    if ($scope.types == "PN") {
                                        $scope.natural = new Array();
                                        result.forEach(function (rs, index) {

                                            rs.name = $.trim(rs.firstSurname) + " " + $.trim(rs.secondSurname) + " " + $.trim(rs.name) + " " + $.trim(rs.secondName);
                                            rs.official = $.trim(rs.official) + " - " + $.trim(rs.descriptionOfficial)

                                            $scope.natural.push(rs);
                                        });

                                        if ($scope.natural.length == $scope.Size) {
                                            $scope.isNext = true;
                                        } else {
                                            $scope.isNext = false;
                                        }

                                        if ($scope.natural.length > 0 && $scope.isNaturalPerson) {
                                            $scope.isResultGrid = true;
                                        }
                                    }

                                    if (!$scope.existButtonAdd) {

                                        var element = '&nbsp <button id="buttonAddNext" class="btn btn-default cb-btn-append-records" ng-click="searchNext($event)"><span class="glyphicon glyphicon-plus-sign"></span></button>';

                                        var _pagerFoot = $("#gridNaturalId").children(".k-pager-wrap.k-grid-pager.k-widget").children(".k-link.k-pager-nav.k-pager-last");
                                        _pagerFoot.after(element);

                                        $scope.naturalColumnsTemp = $('#gridNaturalId').data('kendoGrid').options.columns;

                                        var _pagerFootC = $("#gridCompanyId").children(".k-pager-wrap.k-grid-pager.k-widget").children(".k-link.k-pager-nav.k-pager-last");
                                        _pagerFootC.after(element);

                                        $scope.companyColumnsTemp = $('#gridCompanyId').data('kendoGrid').options.columns;

                                        //compilación
                                        $compile($("#gridNaturalId"))($scope);
                                        $compile($("#gridCompanyId"))($scope);

                                        $scope.existButtonAdd = true;
                                    }

                                    if ($scope.types == "PN") {

                                        var page = 0;
                                        page = Math.floor($scope.natural.length / $scope.Size);
                                        page = parseInt(page) <= 0 ? 1 : parseInt(page);
                                        var pageSize = $scope.natural.length >= $scope.Size ? $scope.Size : $scope.natural.length;

                                        $scope.naturalColumns = $scope.naturalColumnsTemp;


                                        //compilaciÃ³n
                                        $compile($("#gridNaturalId"))($scope);

                                    }

                                    if ($scope.types == "PJ") {

                                        var page = 0;
                                        page = Math.floor($scope.company.length / 10);
                                        page = parseInt(page) <= 0 ? 1 : parseInt(page);

                                        var pageSize = $scope.company.length >= $scope.Size ? $scope.Size : $scope.company.length;

                                        $scope.companyColumns = $scope.companyColumnsTemp;


                                        //compilaciÃ³n
                                        $compile($("#gridCompanyId"))($scope);

                                    }

                                    //llamar a select de grid
                                    if (selectEvent) {
                                        $scope.select();
                                    }

                                } else {

                                    //if (flagNext != "1") {
                                    $scope.changeCriteria();
                                    $scope.isResultGrid = false;
                                    cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.CUSTOMERS.MSG_SEARCH_CUSTOMER", null, 10000, false);
                                    //}
                                }
                                $scope.hideLoading();

                            }).then(function (data) {
                                $scope.hideLoading();
                            });
                        } else {
                            $scope.hideLoading();
                        }

                    } else if ($scope.types == "GE" || $scope.types == "GS") {
                        var searchGroup = {
                            typeValue: "1",
                            searchMode: "2",
                            searchValue: "",
                            groupCode: "",
                            customerCode: "",
                            groupName: null,
                            type: "",
                            isClient: $scope.entities == "customer" ? "S" : "N",
                            size: $scope.Size,
                            lastCode: $scope.lastCodeCustomer,
                            groupType: $scope.types == 'GE' ? 'G' : 'S'
                        };

                        if ($scope.criteria == "sec") {
                            searchGroup.type = 1;
                            searchGroup.groupCode = $scope.txtSecuencial.trim();
                        } else if ($scope.criteria == "name") {
                            searchGroup.type = 2;
                            if ($scope.isNameCriteria) {
                                searchGroup.groupName = $("#autoCompleteControl").val();
                            } else {
                                searchGroup.groupName = $scope.txtName.trim();
                            }
                        }

                        var _input = $("#autoCompleteControl").val();
                        var _id = "";

                        if (_input != null) {
                            _input = _input.split("-");
                            _id = $.trim(_input[0]);
                        }

                        // si se hace click desde el evento autocomplete 
                        if (flagNext == "autoCompleteClickEvent") {
                            searchGroup.customerCode = "";
                            searchGroup.groupCode = _id;
                            searchGroup.groupName = null;
                            searchGroup.searchMode = "2";
                            searchGroup.searchValue = "";
                            searchGroup.typeValue = "1";
                            searchGroup.type = "1";
                            searchGroup.groupType = $scope.types == 'GE' ? 'G' : 'S';
                        }

                        $scope.showLoading();
                        var result = queryCustomersService.queryGroupsByParameters(searchGroup);
                        result.then(function (data) {
                            var groups = data;
                            if (groups && groups.length > 0) {

                                $scope.customerType = data.groupType;

                                $scope.group = new Array();
                                groups.forEach(function (gr, index) {

                                    gr.groupOfficial = $.trim(gr.groupOfficial) + " - " + $.trim(gr.functionaryName);
                                    gr.groupRepresentative = $.trim(gr.groupRepresentative) + " - " + $.trim(gr.nomlar);

                                    $scope.group.push(gr);
                                });
                                if ($scope.group.length == $scope.Size) {
                                    $scope.isNext = true;
                                } else {
                                    $scope.isNext = false;
                                }

                                if ($scope.group.length > 0 && ($scope.isEconomicGroup || $scope.isSolidarityGroup)) {
                                    $scope.isResultGrid = true;
                                }

                                if (!$scope.existButtonAddGroup) {

                                    var element = '&nbsp <button id="buttonAddNext" class="btn btn-default cb-btn-append-records" ng-click="searchNext($event)"><span class="glyphicon glyphicon-plus-sign"></span></button>';

                                    var _pagerFoot = $("#gridGroupId").children(".k-pager-wrap.k-grid-pager.k-widget").children(".k-link.k-pager-nav.k-pager-last");
                                    _pagerFoot.after(element);

                                    $scope.existButtonAddGroup = true;

                                    $scope.groupColumnsTemp = $('#gridGroupId').data('kendoGrid').options.columns;

                                    $compile($("#gridGroupId"))($scope);
                                }

                                var page = 0;
                                page = Math.floor($scope.company.length / $scope.Size);
                                page = parseInt(page) <= 0 ? 1 : parseInt(page);
                                var pageSize = $scope.group.length >= $scope.Size ? $scope.Size : $scope.group.length;

                                $scope.groupColumns = $scope.groupColumnsTemp;


                                //compilaciÃ³n
                                $compile($("#gridGroupId"))($scope);

                                //llamar a select de grid
                                if (selectEvent) {
                                    $scope.select();
                                }

                            } else {
                                $scope.isResultGrid = false;
                                cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.CUSTOMERS.MSG_SEARCH_CUSTOMER", null, 10000, false);
                            }
                            $scope.hideLoading();
                        }).then(function (data) {
                            $scope.hideLoading();
                        });
                    }
                }

            };

            $scope.cancel = function (e) {
                $scope.$dismiss();
            };

            $scope.select = function (e) {



                if (selectEvent && $scope.natural != null && $scope.natural.length > 0) {
                    $rootScope.selectedData = {
                        califCartera: $scope.natural[0].califCartera,
                        code: $scope.natural[0].code,
                        commercialName: $scope.natural[0].commercialName == null ? "" : $scope.natural[0].commercialName,
                        customerType: $scope.natural[0].customerType,
                        documentId: $scope.natural[0].documentId,
                        documentType: $scope.natural[0].documentType,
                        isGroup: $scope.natural[0].customerType == "P" || $scope.natural[0].customerType == "C" ? false : true,
                        name: $scope.natural[0].name,
                        official: $scope.natural[0].official
                    }
                }
                if (selectEvent && $scope.company != null && $scope.company.length > 0) {
                    $rootScope.selectedData = {
                        califCartera: $scope.company[0].califCartera,
                        code: $scope.company[0].code,
                        commercialName: $scope.company[0].commercialName == null ? "" : $scope.company[0].commercialName,
                        customerType: $scope.company[0].customerType,
                        documentId: $scope.company[0].documentId,
                        documentType: $scope.company[0].documentType,
                        isGroup: $scope.company[0].customerType == "P" || $scope.company[0].customerType == "C" ? false : true,
                        name: $scope.company[0].name,
                        official: $scope.natural[0].official
                    }
                }

                if (selectEvent && $scope.group != null && $scope.group.length > 0) {
                    $rootScope.selectedData = {
                        code: $scope.group[0].groupId,
                        customerType: $scope.group[0].type,//G: Grupo Económico, S: Grupo Solidario
                        groupName: $scope.group[0].groupName,
                        isGroup: true,
                        name: $scope.group[0].groupName
                    }
                }

                $scope.setDialogParameters();

                var api = new dsgnrCommons.API($scope.vc),
                    nav = api.navigation,
                    response = {
                        selectedData: $rootScope.selectedData,
                        params: $scope.vc.parentVc.customDialogParameters
                    };
                $scope.showLoading();
                if ($scope.vc.parentVc != null && $scope.vc.parentVc.selectData != null) {
                    cobis.showMessageWindow.loading(false);
                    $scope.vc.parentVc.selectData(response);
                } else {
                    cobis.showMessageWindow.loading(false);
                }


                if ($scope.openAsModal == "N") {
                    cobis.container.tabs.getCurrentTab().name = $scope.oldTabName
                    cobis.containerScope.$apply();
                }

                $scope.vc.closeModal(response);
            }

            $scope.setDialogParameters = function () {
                if ($rootScope.selectedData && $rootScope.selectedData.code) {

                    if ($scope.vc && $scope.vc.parentVc) {
                        $scope.vc.parentVc.dialogParameters.CodeReceive = $rootScope.selectedData.code;
                        $scope.vc.parentVc.dialogParameters.isGroup = false;
                        $scope.vc.parentVc.dialogParameters.name = $rootScope.selectedData.name;
                        $scope.vc.parentVc.dialogParameters.documentId = $rootScope.selectedData.documentId;
                        if ($rootScope.selectedData.documentType != undefined) {
                            $scope.vc.parentVc.dialogParameters.documentType = $.trim($rootScope.selectedData.documentType.split("-")[0]);
                        }
                        $scope.vc.parentVc.dialogParameters.commercialName = $.trim($rootScope.selectedData.commercialName);
                        $scope.vc.parentVc.dialogParameters.customerType = $.trim($scope.customerType);
                        $scope.vc.parentVc.dialogParameters.califCartera = $.trim($rootScope.selectedData.califCartera);

                        if (null == $scope.vc.parentVc.dialogParameters.customerType || "" == $scope.vc.parentVc.dialogParameters.customerType) {
                            $scope.vc.parentVc.dialogParameters.customerType = $scope.types;
                        }
                        $scope.vc.parentVc.dialogParameters.officerId = $.trim($rootScope.selectedData.official);
                        $scope.vc.parentVc.dialogParameters.officerName = $.trim($rootScope.selectedData.descriptionOfficial);
                    }

                } else if ($rootScope.selectedData && $rootScope.selectedData.groupId) {

                    if ($scope.vc && $scope.vc.parentVc) {
                        $scope.vc.parentVc.dialogParameters.CodeReceive = $rootScope.selectedData.groupId;
                        $rootScope.selectedData.code = $rootScope.selectedData.groupId;
                        $scope.vc.parentVc.dialogParameters.isGroup = true;
                        $scope.vc.parentVc.dialogParameters.name = $rootScope.selectedData.groupName;
                        if ($rootScope.selectedData.documentType != undefined) {
                            $scope.vc.parentVc.dialogParameters.documentType = $.trim($rootScope.selectedData.documentType.split("-")[0]);
                        }
                        $scope.vc.parentVc.dialogParameters.groupName = $.trim($rootScope.selectedData.groupName);
                        $scope.vc.parentVc.dialogParameters.customerType = $.trim($rootScope.selectedData.customerType);
                    }
                }
            }



            $scope.onKeyPressDigit = function (event) {
                var inputValue = event.keyCode;
                if ((inputValue < 48) || (inputValue > 57)) {
                    event.preventDefault();
                }
            };
            $scope.onKeyPressLetter = function (event) {
                var inputValue = event.keyCode;
                if ((inputValue < 65 || inputValue > 90) && (inputValue < 97 || inputValue > 122) && inputValue != 241 && inputValue != 209 && inputValue != 32) {
                    event.preventDefault();
                }
            };

            $scope.onKeyPressAlfaNumeric = function (event) {
                var inputValue = event.keyCode;
                if ((inputValue < 65 || inputValue > 90) && (inputValue < 97 || inputValue > 122) &&
                    (inputValue < 48 || inputValue > 57) && (inputValue != 45) && inputValue != 241 && inputValue != 209) {
                    event.preventDefault();
                }
            };

            $scope.blockScreen = function () {
                $('form#customerSearch').block({
                    message: $('<div>Procesando..</div>'),
                    css: {
                        border: 'none',
                        backgroundColor: '#000',
                        opacity: .5,
                        color: '#fff'
                    }
                });
            };
            $scope.unblockScreen = function () {
                $('form#customerSearch').unblock();
            };

            $scope.hideLoading = function () {
                cobis.showMessageWindow.loading(false);

            }

            $scope.showLoading = function () {
                cobis.showMessageWindow.loading(true);
            }

            $scope.onSelection = function (kendoEvent) {

                var grid = kendoEvent.sender;
                var selectedData = grid.dataItem(grid.select());
                $rootScope.selectedData = {};
                if (selectedData && selectedData.code) {
                    $rootScope.selectedData.code = selectedData.code;
                    $rootScope.selectedData.isGroup = false;
                    $rootScope.selectedData.name = selectedData.name/* + " " + selectedData.firstSurname + " " + selectedData.secondSurname*/;
                    $rootScope.selectedData.documentId = selectedData.documentId;
                    if (selectedData.documentType != undefined) {
                        $rootScope.selectedData.documentType = $.trim(selectedData.documentType.split("-")[0]);
                    }
                    $rootScope.selectedData.commercialName = $.trim(selectedData.commercialName);
                    $rootScope.selectedData.customerType = $.trim($scope.customerType);
                    $rootScope.selectedData.califCartera = $.trim(selectedData.califCartera);

                    if ($scope.vc && $scope.vc.parentVc) {
                        $scope.vc.parentVc.dialogParameters.CodeReceive = selectedData.code;
                        $scope.vc.parentVc.dialogParameters.isGroup = false;
                        $scope.vc.parentVc.dialogParameters.name = selectedData.name + " " + selectedData.firstSurname + " " + selectedData.secondSurname;
                        $scope.vc.parentVc.dialogParameters.documentId = selectedData.documentId;
                        if (selectedData.documentType != undefined) {
                            $scope.vc.parentVc.dialogParameters.documentType = $.trim(selectedData.documentType.split("-")[0]);
                        }
                        $scope.vc.parentVc.dialogParameters.commercialName = $.trim(selectedData.commercialName);
                        $scope.vc.parentVc.dialogParameters.customerType = $.trim($scope.customerType);
                        $scope.vc.parentVc.dialogParameters.califCartera = $.trim(selectedData.califCartera);

                        if (null == $scope.vc.parentVc.dialogParameters.customerType || "" == $scope.vc.parentVc.dialogParameters.customerType) {
                            $scope.vc.parentVc.dialogParameters.customerType = $scope.types;
                        }
                        $scope.vc.parentVc.dialogParameters.officerId = $.trim(selectedData.official);
                        $scope.vc.parentVc.dialogParameters.officerName = $.trim(selectedData.descriptionOfficial);
                        $rootScope.selectedData.official = $.trim(selectedData.official.split("-")[0]);
                        $rootScope.selectedData.descriptionOfficial = $.trim(selectedData.official.split("-")[1]);
                    }

                } else if (selectedData && selectedData.groupId) {
                    $rootScope.selectedData.groupId = selectedData.groupId;
                    $rootScope.selectedData.isGroup = true;
                    $rootScope.selectedData.name = selectedData.groupName;
                    if (selectedData.documentType != undefined) {
                        $rootScope.selectedData.documentType = $.trim(selectedData.documentType.split("-")[0]);
                    }
                    $rootScope.selectedData.groupName = $.trim(selectedData.groupName);
                    $rootScope.selectedData.customerType = $scope.types == 'GE' ? 'G' : 'S';

                    if ($scope.vc && $scope.vc.parentVc) {
                        $scope.vc.parentVc.dialogParameters.CodeReceive = selectedData.groupId;
                        $scope.vc.parentVc.dialogParameters.isGroup = true;
                        $scope.vc.parentVc.dialogParameters.name = selectedData.groupName;
                        if (selectedData.documentType != undefined) {
                            $scope.vc.parentVc.dialogParameters.documentType = $.trim(selectedData.documentType.split("-")[0]);
                        }
                        $scope.vc.parentVc.dialogParameters.groupName = $.trim(selectedData.groupName);
                        $scope.vc.parentVc.dialogParameters.customerType = $scope.types == 'GE' ? 'G' : 'S';
                    }
                }
                $scope.isSelect = true;
                //selectEvent = true;
            };

            $scope.initData = function () {
                $("#loader_" + $scope.vcParent[$scope.vc.id]).hide();
                $("#loader_CONSOLIDATEPOS").hide();

                $scope.getFields("PN");

                setTimeout(function () {
                    $scope.selectedEntity = $scope.filters.entity[0];
                    $scope.selectedType = $scope.filters.type[0];
                    $scope.selectedField = $scope.filters.field[0];
                    if ($scope.selectedField.id == 1) {
                        $scope.isId = true;
                    }
                    $scope.$apply();
                }, 800);


                //comprobar si existe la columna en_nomlar
                var result = queryCustomersService.checkColumnExist("cobis", "cl_ente", "en_nomlar");
                result.then(function (data) {


                    if (null == data) {
                        $scope.isName = true;
                        $scope.columnExist = false;
                    } else {
                        $scope.columnExist = data.columnExist;
                        $scope.isNameCriteria = angular.copy($scope.columnExist);

                        if ($scope.columnExist) {
                            $scope.isName = false;
                        } else {
                            $scope.isName = true;
                        }
                    }

                }).then(function (data) {
                    $scope.hideLoading();
                });



            };

            $scope.getGroupColumns = function () {
                var groupRepresentativeColumn = '';
                if ($scope.types == 'GE') {
                    groupRepresentativeColumn = 'COMMONS.HEADERS.HDR_GROUP_REPRESENT';
                }
                else {
                    groupRepresentativeColumn = 'COMMONS.HEADERS.HDR_GROUP_PRESIDENT';
                }
                return [
                {
                    field: "groupId",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_ID'),
                    width: "10%"
                },
                {
                    field: "groupName",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_NAME'),
                    width: "30%"
                },
                {
                    field: "groupOfficial",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_OFFICIAL'),
                    width: "30%"
                },
					{
					    field: "groupRepresentative",
					    title: $filter('translate')(groupRepresentativeColumn),
					    width: "30%"
					}
                ];

            };

            $scope.groupColumns = [
				{
				    field: "groupId",
				    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_ID'),
				    width: "10%"
				},
				{
				    field: "groupName",
				    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_NAME'),
				    width: "30%"
				},
                {
                    field: "groupOfficial",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_OFFICIAL'),
                    width: "30%"
                },
                {
                    field: "groupRepresentative",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_GROUP_REPRESENT'),
                    width: "30%"
                }
            ];


            $scope.companyColumns = [
                {
                    field: "blocked",
                    title: " ",
                    width: "3%",
                    template: '<span class="fa fa-circle #if (blocked == "No"){#cb-text-green#}else{#cb-text-red#}#"></span>'
                },
				{
				    field: "code",
				    title: $filter('translate')('COMMONS.HEADERS.HDR_CUSTOMER_CODE'),
				    width: "12%"
				},
				{
				    field: "documentType",
				    title: $filter('translate')('COMMONS.HEADERS.HDR_DOCUMENT_TYPE'),
				    width: "18%"
				},
                {
                    field: "documentId",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_IDENTIFICATION'),
                    width: "15%"
                },
                {
                    field: "name",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_COMPANY_NAME'),
                    width: "25%"
                },
                {
                    field: "commercialName",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_COMMERCIAL_NAME'),
                    width: "15%"
                },
                {
                    field: "official",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_OFFICIAL'),
                    width: "25%"
                }
            ];

            $scope.naturalColumns = [
                {
                    field: "blocked",
                    title: " ",
                    width: "3%",
                    template: '<span class="fa fa-circle #if (blocked == "No"){#cb-text-green#}else{#cb-text-red#}#"></span>'
                },
                {
                    field: "code",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_CUSTOMER_CODE'),
                    width: "12%"
                },
                {
                    field: "documentType",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_DOCUMENT_TYPE'),
                    width: "23%"
                },
                {
                    field: "documentId",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_IDENTIFICATION'),
                    width: "13%"
                },
                {
                    field: "name",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_NAME'),
                    width: "24%"
                },
                {
                    field: "official",
                    title: $filter('translate')('COMMONS.HEADERS.HDR_OFFICER'),
                    width: "30%"
                }
            ];
        }]);
}());