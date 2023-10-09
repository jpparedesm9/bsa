//Entity: Person
    //Person.typePerson (ComboBox) View: GeneralForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXBFT_518739 = function( loadCatalogDataEventArgs ) {
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
        valores[0].code = "P";
        valores[0].value = "Natural";
        valores[1] = new resultado();
        valores[1].code = "C";
        valores[1].value = "Juridica";
        return valores;
    };