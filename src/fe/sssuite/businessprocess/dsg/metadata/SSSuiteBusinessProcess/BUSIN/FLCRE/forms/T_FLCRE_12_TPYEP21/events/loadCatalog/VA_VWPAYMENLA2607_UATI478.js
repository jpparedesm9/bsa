//Entity: PaymentPlan
    //PaymentPlan.basCalculationInterest (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2607_UATI478 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        //loadCatalogDataEventArgs.commons.serverParameters.PaymentPlan = true;
		
		var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
				this.attributes = {};
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = 'E';
		valores[0].attributes = [{days: 360}];
        valores[0].value = cobis.translate("BUSIN.DLB_BUSIN_COMERCIAL_01521");
        valores[1] = new resultado();
        valores[1].code = 'R';
        valores[1].value = cobis.translate("BUSIN.DLB_BUSIN_REALNYEZK_63415");
		valores[1].attributes = [{days: 365}];
        return valores;
        
    };