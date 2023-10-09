var OTHERCREDITDATA = {

    setValueSector: function (args, value, requestName) { //ENVIAR LA DECRIPCION DEL CATALOGO DEL SECTOR
        var rows = "";
        if (requestName === FLCRE.CONSTANTS.RequestName.Line) {
            rows = args.commons.api.vc.catalogs.VA_VIWLNEHADE4804_SCTR177.data();
        } else if (requestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo || requestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo) {
            rows = args.commons.api.vc.catalogs.VA_APITONEAEE5505_SCTR004.data();
        } else if (requestName === FLCRE.CONSTANTS.RequestName.GuaranteesTicket) {
            rows = args.commons.api.vc.catalogs.VA_IEWGUARNTK6806_UMRO301.data();
        } else {
            rows = args.commons.api.vc.catalogs.VA_OFICANSSEW2603_SCOR371.data();
        }

        for (var i = 0; i < rows.length; i++) {
            if (rows[i].code === value) {
                return rows[i].value;
            }
        }
        return '';
    },

    changeActivity: function (entities, args, requestName) {

        if (entities.OriginalHeader.TypeRequest == FLCRE.CONSTANTS.Tramite.Expromision && entities.OriginalHeader.Expromission != null) {
            var nuevoValorActividad = entities.Context.Flag2;
        } else {
            var nuevoValorActividad = args.newValue;
        }
        args.commons.execServer = false;

        if (nuevoValorActividad == entities.Context.Flag2) {
            entities.CreditOtherData.CreditDestination = null;
        } else {
            entities.CreditOtherData.CreditDestination = entities.CreditOtherData.ActivityDestinationCredit;
        }

        // Cambie el sector segun la actividad seleccionada	--se comenta porque ya no se utiliza para el sector de la actividad del cliente
        // se utilizara cuando se añada otro dato en las pantallas
        /*var arreglo = args.commons.api.vc.catalogs.VA_RIOTRDTAVI4904_TATT517.data();  // CAMBIA EL SECTOR SEGUN LA ACTIVIDAD SELECCIONADA
        for (var i = 0; i < arreglo.length; i++) {
            if (arreglo[i].code == nuevoValorActividad) {
                var sector = arreglo[i].attributes[0];
                if (nuevoValorActividad === entities.Context.Flag2 || sector === entities.IndexSizeActivity.ParameterFixedIncome) {
                    if (requestName === FLCRE.CONSTANTS.RequestName.Line || requestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo || requestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo) {
                        entities.LineHeader.Sector = entities.IndexSizeActivity.ParameterFixedIncome;
                    } else if (requestName === FLCRE.CONSTANTS.RequestName.GuaranteesTicket) {
                        entities.HeaderGuaranteesTicket.Sector = entities.IndexSizeActivity.ParameterFixedIncome;
                    } else {
                        entities.OfficerAnalysis.Sector = entities.IndexSizeActivity.ParameterFixedIncome;
                    }
                    args.commons.messageHandler.showMessagesInformation(OTHERCREDITDATA.setValueSector(args, entities.IndexSizeActivity.ParameterFixedIncome, requestName));
                } else {
                    if (requestName === FLCRE.CONSTANTS.RequestName.Line || requestName === FLCRE.CONSTANTS.RequestName.ModificacionLCPlazo
						|| requestName === FLCRE.CONSTANTS.RequestName.ModificacionLCMontoPlazo) {
                        entities.LineHeader.Sector = sector;
                    } else if (requestName === FLCRE.CONSTANTS.RequestName.GuaranteesTicket) {
                        entities.HeaderGuaranteesTicket.Sector = sector;
                    } else {
                        entities.OfficerAnalysis.Sector = sector;
                    }
                }
            }
        }*/
    },

    disableElements: function (entities, renderEventArgs, requestName) {
        if (entities.OfficerAnalysis != null || entities.OfficerAnalysis != undefined) {
            if (entities.OfficerAnalysis.Sector === null || entities.OfficerAnalysis.Sector === undefined || entities.OfficerAnalysis.Sector === entities.IndexSizeActivity.ParameterFixedIncome) {
                OTHERCREDITDATA.elements(entities, renderEventArgs);
            }
        } else if (entities.LineHeader != null || entities.LineHeader != undefined) {
            if (entities.LineHeader.Sector === null || entities.LineHeader.Sector === undefined || entities.LineHeader.Sector === entities.IndexSizeActivity.ParameterFixedIncome) {
                OTHERCREDITDATA.elements(entities, renderEventArgs);
            }
        }
    },

    elements: function (entities, renderEventArgs) {
        entities.IndexSizeActivity.Patrimony = "";
        entities.IndexSizeActivity.PersonalNumber = "";
        entities.IndexSizeActivity.Sales = "";
        entities.IndexSizeActivity.IndexSizeActivity = "";
        entities.IndexSizeActivity.AnnualSales = "";
        entities.IndexSizeActivity.ProductiveAssets = "";
        renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_ATRN190");
        renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_SALE147");
        renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_PESL753");
        renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NEIY699");
        renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_NULE410");
        renderEventArgs.commons.api.viewState.disable("VA_RIOTRDTAVI4909_RCIE187");
    }
};

document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');