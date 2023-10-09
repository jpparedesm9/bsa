/*global designerEvents, console */
/*(function () {
    "use strict";
    /*module.js*/
//Your code here*/
/*global designerEvents, console */
var ASSETS = {
    Parameters: {

    },
    Constants: {
        MENU_VALUE_DATE: "1",
        MENU_REVERSE: "2",
        MENU_APPLY_CLAUSE: "3",
        MENU_QUERYSGENERAL: "4",
        MENU_READJUSTMENT: "5",
        MENU_LOANSTATCE: "6",
        MENU_PROYECTINST: "7",
        MENU_PAYMENTSMANI: "8",
        MENU_RENOVATION: "9",
        MENU_INGOTROCARG: "10",
        MENU_IMPRESIONDOC: "11",
        MENU_PRORROGA: "12",
        MENU_DISBUSMNT: "13",
        MENU_BLOCK: "14",
        MODE_TYPE_GROUP: "G",
        MODE_TYPE_INDIVIDUAL: "I"
    },
    Header: {
        setDataStyle: function (vcMainId, vcHeaderId, entities, args) {
            var viewState = args.commons.api.viewState;
            var header = $("#" + vcHeaderId);
            var pageContent = $("#" + vcMainId);
            header.insertBefore(pageContent);
            viewState.addStyle(vcHeaderId, 'cb-form-header cb-no-margin cb-no-padding');
            viewState.addStyle('VA_VASIMPLELABELLL_143612',
					'label-header-principal');
            viewState
					.addStyle('VA_VASIMPLELABELLL_867612', 'label-header-main');

            var loan = entities.Loan;
            var clientName = loan.clientName + " - " + loan.idType + " " + loan.identityCardNumber;
            loan.office = loan.officeID + " - " + loan.office;
            $("#VA_2463BHBNLZPKLMU_865612").append(document.createTextNode(loan.currencyName));
            header.removeClass("container").addClass("container-fluid");
            $("#G_LOANHEAINF_340612").addClass("cb-group-flex")

            viewState.label('VA_VASIMPLELABELLL_143612', clientName);
            viewState.label('VA_5034UOFCASVGKTK_993612', loan.operationType);


            viewState.addStyle('VA_VASIMPLELABELLL_867612',
                   'textlink-withoutbackground');
            $("#VA_VASIMPLELABELLL_867612").parent().addClass('label-inline');
            //$("#VA_VASIMPLELABELLL_867612").append('  <span class="glyphicon 
            //glyphicon-info-sign"></span>');            
            //$("#G_LOANHEADOD_564612").parent().addClass('container-header-inside');
        },
        showPopupDetail: function (entities, args) {
            args.commons.execServer = false;
            var apiNav = args.commons.api.navigation;
            apiNav.address = {
                moduleId: 'ASSTS',
                subModuleId: 'CMMNS',
                taskId: 'T_LOANDETAILPPP_874',
                taskVersion: "1.0.0",
                viewContainerId: 'VC_LOANDETAUL_310874'
            };

            apiNav.popoverProperties = {
                width: '280',
                height: '200',
                position: 'bottom'

            };
            apiNav.queryParameters = {
                mode: args.commons.constants.mode.Insert
            };
            apiNav.customDialogParameters = {
                Loan: entities.Loan
            };
            apiNav.openPopover(args.commons.controlId);
        }
    },
    Amortization: {
        showTableAmortization: function (entities, renderEventArgs) {
            renderEventArgs.commons.execServer = false;
            var itemsNumber = entities.ItemsLoan.length;
            var indexEndColumn = 16;
            var i;
            for (i = 1; i < itemsNumber; i++) {
                renderEventArgs.commons.api.grid.title("QV_8237_80795", "items" + i, entities.ItemsLoan[i].concept, null, null);
            }
            for (i = itemsNumber ; i < indexEndColumn; i++) {
                renderEventArgs.commons.api.grid.hideColumn("QV_8237_80795",
                        "items" + i);
            }
        },
        CapitalBalance: function (data) {
            //Calcular Total Saldo Capital: Se resta Saldo Capital - Capital del último registro de la tabla de amortización
            $('tr.k-footer-template').contents().each(function () {
                if (this.cellIndex == 1) {
                    var div = document.createElement("div");
                    div.className = "text-right";
                    div.innerHTML = "Totales";
                    this.removeChild(this.childNodes[0]);
                    this.appendChild(div);
                }
                /*if (this.cellIndex == 3) {
                  var div = document.createElement("div");
                  div.className = "text-right";
                  div.innerHTML = "$" + parseFloat(Math.round((data[data.length - 1].balanceCap - data[data.length - 1].items1) * 100) / 100).toFixed(2);
                  this.removeChild(this.childNodes[0]);
                  this.appendChild(div);
                }*/
            });
        },
        resizeGrid: function (idGrid) {
            var gridElement = $("#" + idGrid),
            dataArea = gridElement.find(".k-grid-content"),
            length = angular.element(gridElement).data('kendoGrid').dataSource.data().length,
            heightOne = 44.44;
            if (dataArea.height() > 400) {
                dataArea.height(400);
            } else {
                dataArea.height(heightOne * length);
            }
        }
    },
    Utils: {
        getQueryStrings: function () {
            var queryDict = {};
            location.search.substr(1).split("&").forEach(function (item) {
                queryDict[item.split("=")[0]] = item.split("=")[1];
            });
            return queryDict;
        },
        managerException: function (err) {
            cobis.getMessageManager().showMessagesError(err);
            cobis.log.error(err);
        },
        Char_convert: function (original) {
            var chars = ["\u00e1", "\u00e0", "\u00e9", "\u00e8", "\u00ed", "\u00ec", "\u00f3", "\u00f2", "\u00fa", "\u00f9", "\u00c1", "\u00c0", "\u00c9", "\u00c8", "\u00cd", "\u00cc", "\u00d3", "\u00d2", "\u00da", "\u00d9", "\u00f1", "\u00d1"];
            var codes = ["%e1", "%e1", "%e9", "%e9", "%ed", "%ed", "%f3", "%f3", "%fa", "%fa", "%c1", "%c1", "%c9", "%c9", "%cd", "%cd", "%d3", "%d3", "%da", "%da", "%f1", "%d1"];
            if (original !== null && original !== undefined && original.constructor === String) {
                for (var i = 0; i < chars.length; i++) {
                    original = original.replace(chars[i], codes[i]);
                }
            }
            return original;
        },
        IsNull: function (parValue) {
            return (parValue === null || parValue === undefined);
        },
        IsNullOrEmpty: function (parValue) {
            return (ASSETS.Utils.IsNull(parValue) || parValue === '');
        },
        generarReporte: function (reporte, argumentos, title) {

            var Crue = '?myValue=' + Math.random() + '&';
            var formaMapeo = document.createElement("form");
            formaMapeo.target = 'popup_window_' + reporte;
            formaMapeo.method = "POST"; // or "post" if appropriate

            if (ASSETS.Utils.IsNullOrEmpty(reporte))
                formaMapeo.action = "${contextPath}/cobis/web/reporting/actions/reportingService" + Crue;
            else
                formaMapeo.action = "${contextPath}/cobis/web/reports/" + reporte + Crue;

            var param = "";
            for (var i = 0; i < argumentos.length; i++) {
                param = param + argumentos[i][0] + '=' + ASSETS.Utils.Char_convert(argumentos[i][1]) + '&'
            }
            param = param.substr(0, param.length - 1);
            var url = formaMapeo.action + param
            if (ASSETS.Utils.IsNullOrEmpty(title)) { title = 'Reporte'; }
            cobis.container.tabs.openNewTab('ctsConsole', url, title, true);

        },
        getIpServer: function () {
            return location.origin;
        },
        mappingEntity: function (entityOrigin, entityData) {
            for (attribute in entityOrigin) {
                entityOrigin[attribute] = entityData[attribute];
            }
        },
        convertDateWithoutHoursMinutesSecondsMilliseconds: function (date) {
            if (angular.isDefined(date) && date instanceof Date) {
                date.setHours(0);
                date.setMinutes(0);
                date.setSeconds(0);
                date.setMilliseconds(0);
            }
            return date;
        }
    },
    Navigation: {
        taskRedirect: function (subModuleId, taskId, viewContainerId, label, args, parameters) {

            args.commons.execServer = false;
            var apiNav = args.commons.api.navigation;
            apiNav.label = label;
            apiNav.address = {
                moduleId: 'ASSTS',
                subModuleId: subModuleId,
                taskId: taskId,
                taskVersion: "1.0.0",
                viewContainerId: viewContainerId
            };
            apiNav.customDialogParameters = {
                parameters: parameters
            };
            apiNav.navigate(args.commons.controlId);
        },
        openHistorical: function (entities, args, control) {
            var nav = args.commons.api.navigation;
            nav.label = 'Historial de Documentos';
            nav.address = {
                moduleId: 'ASSTS',
                subModuleId: 'QERYS',
                taskId: 'T_ASSTSNMDWVMHP_252',
                taskVersion: '1.0.0',
                viewContainerId: 'VC_CREDITDOUE_237252'
            };
            nav.queryParameters = {
                mode: 8
            };
            nav.modalProperties = {
                size: 'md',
                callFromGrid: false
            };
            nav.customDialogParameters = {
                processInstance: entities.processInstance,
                customerId: entities.customerId,
                groupId: entities.groupId,
                description: entities.description,
                documentId: entities.documentId,
                extension: entities.extension,
                folder: entities.folder
            };
            nav.openModalWindow(control, args.modelRow);
        }
    },
    API: {
        checker: function (entities, gridExecuteCommandEventArgs) {
            var check = true;
            if (entities.DetailRejectedDispersions.data().length != 0) {
                for (var i = 0 ; i <= entities.DetailRejectedDispersions.data().length - 1 ; i++) {
                    if (entities.DetailRejectedDispersions.data()[i].selection === false || entities.DetailRejectedDispersions.data()[i].selection === undefined) {
                        check = true;
                        break;
                    } else {
                        check = false;
                    }
                }
            }
            if (entities.DetailRejectedDispersions.data().length != 0) {
                for (var i = 0 ; i <= entities.DetailRejectedDispersions.data().length - 1 ; i++) {
                    gridExecuteCommandEventArgs.rowData = entities.DetailRejectedDispersions.data()[i];
                    if (check === true) {
                        gridExecuteCommandEventArgs.rowData.selection = true;

                    } else if (check === false) {
                        gridExecuteCommandEventArgs.rowData.selection = false;

                    }
                }
            }
            if (check === true) {
                $("input:checkbox").prop('checked', true)
                gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_480');
                gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_212');
            } else if (check === false) {
                $("input:checkbox").prop('checked', false)
                gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_212');
                gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_480');
            }
        },
        changeImageChecker: function (entities, args) {
            var check = true;
            if (entities.DetailRejectedDispersions.data().length != 0) {
                for (var i = 0 ; i <= entities.DetailRejectedDispersions.data().length - 1 ; i++) {
                    if (entities.DetailRejectedDispersions.data()[i].selection === false || entities.DetailRejectedDispersions.data()[i].selection === undefined) {
                        check = true;
                        break;
                    } else {
                        check = false;
                    }
                }
            }
            if (check === true) {
                args.commons.api.grid.hideToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_212');
                args.commons.api.grid.showToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_480');
            } else if (check === false) {
                args.commons.api.grid.hideToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_480');
                args.commons.api.grid.showToolBarButton('QV_3655_99787', 'CEQV_201QV_3655_99787_212');
            }
        }
    }
}
document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');