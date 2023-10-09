//Entity: PaymentPlan
    //PaymentPlan.tableType (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2605_BLYE585 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
        //loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		
		var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = 'ALEMANA';
        valores[0].value = cobis.translate("BUSIN.DLB_BUSIN_CAPITAIJO_52111");
        valores[1] = new resultado();
        valores[1].code = 'FRANCESA';
        valores[1].value = cobis.translate("BUSIN.DLB_BUSIN_CUOTAFIJA_27408");
        valores[2] = new resultado();
        valores[2].code = 'MANUAL';
        valores[2].value = cobis.translate("BUSIN.DLB_BUSIN_MANUALFEE_56430");

        return valores;
        
    };