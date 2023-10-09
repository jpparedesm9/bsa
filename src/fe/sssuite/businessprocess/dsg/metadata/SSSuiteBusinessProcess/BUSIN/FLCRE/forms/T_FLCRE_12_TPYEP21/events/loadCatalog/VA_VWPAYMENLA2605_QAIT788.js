//Entity: PaymentPlan
    //PaymentPlan.quotaInterest (ComboBox) View: VWPaymentPlan
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_VWPAYMENLA2605_QAIT788 = function(loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = false;
       		
		var resultado = new function () {
            function ItemDTO() {
                this.code = "";
                this.value = "";
            }
            return ItemDTO;
        }
        var valores = [];
        valores[0] = new resultado();
        valores[0].code = 'N';
        valores[0].value = cobis.translate("BUSIN.DLB_BUSIN_NIMERAUOA_05652");
        valores[1] = new resultado();
        valores[1].code = 'S';
        valores[1].value = cobis.translate("BUSIN.DLB_BUSIN_ENCTASRTE_23124");
        valores[2] = new resultado();
        valores[2].code = 'M';
        valores[2].value = cobis.translate("BUSIN.DLB_BUSIN_NOPAGARWI_44730");

        return valores;
        
    };