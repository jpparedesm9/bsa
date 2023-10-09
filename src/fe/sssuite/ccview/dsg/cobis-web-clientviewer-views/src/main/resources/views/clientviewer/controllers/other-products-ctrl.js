(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER, cobis.modules.CUSTOMER, 'ui.bootstrap']);

    app.controller("clientviewer.otherProductsController", ['$scope',
   '$rootScope', '$filter', '$modal', '$routeParams',
    function ($scope, $rootScope, $filter, $modal, $routeParams) {
            $rootScope.spid = 0;

                $scope.OthersProductsColumns = [
                    {
                        field: "affiliateDate",
                        title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_OPENING_DATE'),
                        width: "130px"
                    },
                    {
                        field: "profile",
                        title: $filter('translate')('CLIENTVIEWER.LABELS.LBL_AMOUNT'),
                        width: "130px"
                    },
                    {
                        field: "stateRegistry",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_DESCRIPTION'),
                        width: "130px"
                    }
                 ];
                $scope.ApplicationLoansColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "operationType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "130px"
                    },
                    {
                        field: "operation",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT'),
                        width: "200px"
                    },
                    {
                        field: "dateApt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                        width: "130px"
                    },
                    {
                        field: "dateVto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                        width: "130px"
                    },
                    {
                        field: "currencyDesc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amountCapital",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_ORIG'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "balance_due",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BALANCE_DUE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "balance",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CAPITAL_BALANCE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "rate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'),
                        width: "130px",
                        format: "{0:0.0000}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "state",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                        width: "130px"
                    }
                 ];
                $scope.CCEColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "operationType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "operation",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT'),
                        width: "200px"
                    },
                    {
                        field: "dateApt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                        width: "130px"
                    },
                    {
                        field: "dateVto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                        width: "130px"
                    },
                    {
                        field: "currencyDesc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amountCapital",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_ORIG'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "beneficiary",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BENEFICIARY'),
                        width: "130px"
                    }
                 ];
                $scope.CDEColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "operationType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "operation",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT'),
                        width: "200px"
                    },
                    {
                        field: "dateApt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                        width: "130px"
                    },
                    {
                        field: "dateVto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                        width: "130px"
                    },
                    {
                        field: "currencyDesc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amountCapital",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_ORIG'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "beneficiary",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BENEFICIARY'),
                        width: "130px"
                    }
                 ];
                $scope.CDIColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "operationType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "operation",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT'),
                        width: "130px"
                    },
                    {
                        field: "dateApt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                        width: "130px"
                    },
                    {
                        field: "dateVto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                        width: "130px"
                    },
                    {
                        field: "currencyDesc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amountCapital",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_ORIG'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "beneficiary",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BENEFICIARY'),
                        width: "130px"
                    }
                 ];
                $scope.CreditsLinesPendingColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "operationType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "operation",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT'),
                        width: "200px"
                    },
                    {
                        field: "dateApt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                        width: "130px"
                    },
                    {
                        field: "dateVto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                        width: "130px"
                    },
                    {
                        field: "currencyDesc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amountCapital",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_ORIG'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "aviable",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BALANCE_DUE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "balance",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CAPITAL_BALANCE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "rate",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_RATE'),
                        width: "130px",
                        format: "{0:0.0000}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "state",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                        width: "130px"
                    }
                 ];
                $scope.GuaranteesPendingColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "warrantyType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "code",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_NUMBER_GUARANTEED'),
                        width: "130px"
                    },
                    {
                        field: "warrantyDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "initialValue",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_INICIAL_VALUE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "actualValue",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENT_VALUE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "percet",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_POR_MRC'),
                        width: "130px"
                    },
                    {
                        field: "state",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                        width: "130px"
                    },
                    {
                        field: "guarantor",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_WARRANTY_NAME'),
                        width: "130px"
                    }
                 ];
                $scope.OtherComextColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "operationType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "operation",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TRAMIT'),
                        width: "130px"
                    },
                    {
                        field: "dateApt",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_APT'),
                        width: "130px"
                    },
                    {
                        field: "dateVto",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_VTO'),
                        width: "130px"
                    },
                    {
                        field: "currencyDesc",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "amountCapital",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_AMOUNT_ORIG'),
                        width: "80px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "beneficiary",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_BENEFICIARY'),
                        width: "130px"
                    }
                 ];
                $scope.PromissoryNotesColumns = [
                    {
                        field: "clientName",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CLIENT_NAME'),
                        width: "150px",
                        hidden: "true"
                    },
                    {
                        field: "warrantyType",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_TYPE_OP_DESC'),
                        width: "150px"
                    },
                    {
                        field: "code",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_NUMBER_GUARANTEED'),
                        width: "130px"
                    },
                    {
                        field: "warrantyDescription",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_MONEY_DESC'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "initialValue",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_INICIAL_VALUE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "actualValue",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_CURRENT_VALUE'),
                        width: "130px",
                        format: "{0:n}",
                        attributes: {
                            style: "text-align:right;"
                        }
                    },
                    {
                        field: "state",
                        title: $filter('translate')('COMMONS.HEADERS.HDR_STATE'),
                        width: "130px"
                    }
                 ];


                //$scope.dsApplicationLoansSource ={};   
                $scope.isVisibleOthersProducts = true;
                $scope.isVisibleApplicationLoansSource = true;
                $scope.isVisibleCEESource = true;
                $scope.isVisibleCDESource = true;
                $scope.isVisibleCDISource = true;
                $scope.isVisibleCreditsLinesPendingSource = true;
                $scope.isVisibleGuaranteesPendingSource = true;
                $scope.isVisibleOtherComextSource = true;
                $scope.isVisiblePromissoryNotesSource = true;


                //Use to format to date fields
                $scope.convertFields = function (data, type) {
                    var currentAc = data;


                    if (type == undefined) {
                        for (var i in currentAc) {
                            if (currentAc[i].dateApt != undefined) {
                                var dateChange = new Date($filter('date')(parseInt(currentAc[i].dateApt.substring(currentAc[i].dateApt.indexOf("(")+1, currentAc[i].dateApt.indexOf(")")), "dd/MM/yyyy"))).toLocaleDateString();
                                currentAc[i].dateApt = dateChange;

                            }
                        }
                    } else {
                        for (var i in currentAc) {
                            if (currentAc[i].dateApt != undefined) {
                                var dateChange = new Date($filter('date')(parseInt(currentAc[i].dateApt.substring(currentAc[i].dateApt.indexOf("(")+1, currentAc[i].dateApt.indexOf(")")), "dd/MM/yyyy")));
                                currentAc[i].dateApt = dateChange.toLocaleDateString();
                            }
                            if (currentAc[i].dateVto != undefined) {
                                dateChange = new Date($filter('date')(parseInt(currentAc[i].dateVto.substring(currentAc[i].dateVto.indexOf("(")+1, currentAc[i].dateVto.indexOf(")")), "dd/MM/yyyy")));
                                currentAc[i].dateVto = dateChange.toLocaleDateString();
                            }

                            if (currentAc[i].lastMovDate != null) {
                                dateChange = new Date($filter('date')(parseInt(currentAc[i].lastMovDate.substring(currentAc[i].lastMovDate.indexOf("(")+1, currentAc[i].lastMovDate.indexOf(")")), "dd/MM/yyyy")));
                                currentAc[i].lastMovDate = dateChange.toLocaleDateString();
                            }
                        }
                    }

                    return currentAc;
                }

                $scope.dsOthersProducts = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsOthers),
                    schema: {
                        model: {
                            fields: {
                                affiliateDate: {
                                    type: "string"
                                },
                                profile: {
                                    type: "number"
                                },
                                stateRegistry: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });

                $scope.dsApplicationLoansSource = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsApplicationLoans),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                operationType: {
                                    type: "string"
                                },
                                operation: {
                                    type: "string"
                                },
                                dateApt: {
                                    type: "string"
                                },
                                dateVto: {
                                    type: "string"
                                },
                                currencyDesc: {
                                    type: "string"
                                },
                                amountCapital: {
                                    type: "number"
                                },
                                balance_due: {
                                    type: "number"
                                },
                                balance: {
                                    type: "number"
                                },
                                rate: {
                                    type: "number"
                                },
                                state: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });
                $scope.dsCCE = new kendo.data.DataSource({
                    data: $scope.convertFields(cobis.userContext.getValue('CONTINGENCIES2')),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                operationType: {
                                    type: "string"
                                },
                                operation: {
                                    type: "string"
                                },
                                dateApt: {
                                    type: "string"
                                },
                                dateVto: {
                                    type: "string"
                                },
                                currencyDesc: {
                                    type: "string"
                                },
                                amountCapital: {
                                    type: "number"
                                },
                                beneficiary: {
                                    type: "string"
                                }
                            }
                        }
                    },
                    filter: [{
                        field: "type_operation",
                        operator: "eq",
                        value: "CCE"
            }]
                });
                $scope.dsCDE = new kendo.data.DataSource({
                    data: $scope.convertFields(cobis.userContext.getValue('CONTINGENCIES2')),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                operationType: {
                                    type: "string"
                                },
                                operation: {
                                    type: "string"
                                },
                                dateApt: {
                                    type: "string"
                                },
                                dateVto: {
                                    type: "string"
                                },
                                currencyDesc: {
                                    type: "string"
                                },
                                amountCapital: {
                                    type: "number"
                                },
                                beneficiary: {
                                    type: "string"
                                }
                            }
                        }
                    },
                    filter: [{
                        field: "type_operation",
                        operator: "eq",
                        value: "CDE"
            }]
                });
                $scope.dsCDI = new kendo.data.DataSource({
                    data: $scope.convertFields(cobis.userContext.getValue('CONTINGENCIES2')),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                operationType: {
                                    type: "string"
                                },
                                operation: {
                                    type: "string"
                                },
                                dateApt: {
                                    type: "string"
                                },
                                dateVto: {
                                    type: "string"
                                },
                                currencyDesc: {
                                    type: "string"
                                },
                                amountCapital: {
                                    type: "number"
                                },
                                beneficiary: {
                                    type: "string"
                                }
                            }
                        }
                    },
                    filter: [{
                        field: "type_operation",
                        operator: "eq",
                        value: "CDI"
            }]
                });
                $scope.dsCreditsLinesPendingSource = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsCreditsPendings),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                operationType: {
                                    type: "string"
                                },
                                operation: {
                                    type: "string"
                                },
                                dateApt: {
                                    type: "string"
                                },
                                dateVto: {
                                    type: "string"
                                },
                                currencyDesc: {
                                    type: "string"
                                },
                                amountCapital: {
                                    type: "number"
                                },
                                aviable: {
                                    type: "number"
                                },
                                balance: {
                                    type: "number"
                                },
                                rate: {
                                    type: "number"
                                },
                                state: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });
                $scope.dsGuaranteesPendingSource = new kendo.data.DataSource({
                    data: $rootScope.productsPendingGuaranties,
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                type_op_desc: {
                                    type: "string"
                                },
                                number_guaranteed: {
                                    type: "string"
                                },
                                money_desc: {
                                    type: "string"
                                },
                                inicial_value: {
                                    type: "number"
                                },
                                current_value: {
                                    type: "number"
                                },
                                por_mrc: {
                                    type: "number"
                                },
                                state: {
                                    type: "string"
                                },
                                warranty_name: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });
                $scope.dsOtherComextSource = new kendo.data.DataSource({
                    data: $scope.convertFields($rootScope.productsOtherComext),
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                operationType: {
                                    type: "string"
                                },
                                operation: {
                                    type: "string"
                                },
                                dateApt: {
                                    type: "string"
                                },
                                dateVto: {
                                    type: "string"
                                },
                                currencyDesc: {
                                    type: "string"
                                },
                                amountCapital: {
                                    type: "number"
                                },
                                beneficiary: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });
                $scope.dsPromissoryNotesSource = new kendo.data.DataSource({
                    data: $rootScope.productsPromissoryNotePending,
                    schema: {
                        model: {
                            fields: {
                                clientName: {
                                    type: "string"
                                },
                                type_op_desc: {
                                    type: "string"
                                },
                                number_guaranteed: {
                                    type: "string"
                                },
                                money_desc: {
                                    type: "string"
                                },
                                inicial_value: {
                                    type: "number"
                                },
                                current_value: {
                                    type: "number"
                                },
                                state: {
                                    type: "string"
                                }
                            }
                        }
                    }
                });



                $scope.isVisibleOthersProducts = ($rootScope.productsOthers != null && $rootScope.productsOthers.length > 0);
                $scope.isVisibleApplicationLoansSource = ($rootScope.productsApplicationLoans != null && $rootScope.productsApplicationLoans.length > 0);
                $scope.isVisibleCEESource = (cobis.userContext.getValue('CONTINGENCIES2') != null && cobis.userContext.getValue('CONTINGENCIES2').length > 0);
                $scope.isVisibleCDESource = (cobis.userContext.getValue('CONTINGENCIES2') != null && cobis.userContext.getValue('CONTINGENCIES2').length > 0);
                $scope.isVisibleCDISource = (cobis.userContext.getValue('CONTINGENCIES2') != null && cobis.userContext.getValue('CONTINGENCIES2').length > 0);
                $scope.isVisibleCreditsLinesPendingSource = ($rootScope.productsCreditsPendings != null && $rootScope.productsCreditsPendings.length > 0);
                $scope.isVisibleGuaranteesPendingSource = ($rootScope.productsPendingGuaranties != null && $rootScope.productsPendingGuaranties.length > 0);
                $scope.isVisibleOtherComextSource = ($rootScope.productsOtherComext != null && $rootScope.productsOtherComext.length > 0);
                $scope.isVisiblePromissoryNotesSource = ($rootScope.productsPromissoryNotePending != null && $rootScope.productsPromissoryNotePending.length > 0);

            

    }]);
}());