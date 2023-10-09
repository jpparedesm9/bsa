//Entity: WarrantySituation
    //WarrantySituation.judicialCollectionType (CheckBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ARANSCATIO0715_JILL987 = function( entities, changeEventArgs ) {
                changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
        var api = changedEventArgs.commons.api;
        if (entities.WarrantySituation.judicialCollectionType) {
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.show(viewState, ['VA_ARANSCATIO0715_NDTE308']);
            api.viewState.enableValidation('VA_ARANSCATIO0715_TEAE147', VisualValidationTypeEnum.Required);
            api.viewState.enableValidation('VA_ARANSCATIO0715_NDTE308', VisualValidationTypeEnum.Required);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.enable(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        } else {
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.hide(viewState, ['VA_ARANSCATIO0715_NDTE308']);
            api.viewState.disableValidation('VA_ARANSCATIO0715_TEAE147', VisualValidationTypeEnum.Required);
            api.viewState.disableValidation('VA_ARANSCATIO0715_NDTE308', VisualValidationTypeEnum.Required);
            entities.WarrantySituation.retirementDate = null;
            entities.WarrantySituation.returnDate = null;
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0715_TEAE147']);
            BUSIN.API.disable(viewState, ['VA_ARANSCATIO0715_NDTE308']);
        }
        
    };