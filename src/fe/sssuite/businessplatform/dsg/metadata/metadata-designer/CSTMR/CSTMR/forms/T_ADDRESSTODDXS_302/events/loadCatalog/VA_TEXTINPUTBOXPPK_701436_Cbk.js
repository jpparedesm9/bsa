//Entity: PhysicalAddress
//PhysicalAddress.parishCode (ComboBox) View: AddressPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalogCallback.VA_TEXTINPUTBOXPPK_701436 = function (entities, loadCatalogCallbackEventArgs) {
    loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_POSTALCODERCKFJ_389436');
    loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_TEXTINPUTBOXTCU_205436');
	loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_TEXTINPUTBOXQVZ_987436');
	loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_TEXTINPUTBOXPPK_701436');
};