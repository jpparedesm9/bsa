//Entity: NaturalPerson
    //NaturalPerson.bioHasFingerprint (CheckBox) View: CustomerGeneralInfForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIOHASFINGERRRR_235213 = function(  entities, changedEventArgs ) {
        activeChange = true;
        changedEventArgs.commons.execServer = false;
        var customerId = entities.Person.personSecuential;
        if (customerId != undefined) {
            var filtro ={
                customerId:customerId,
                processInstance:"0",
                sinHuellaDactilar: (entities.NaturalPerson.bioHasFingerprint == null?"N":entities.NaturalPerson.bioHasFingerprint)
                        }
            //Refresh de la grilla para llenar la entidad
            changedEventArgs.commons.api.vc.parentVc = {}
            changedEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;
                
            //Refresh de la grilla para llenar la entidad
            changedEventArgs.commons.api.grid.refresh('QV_7463_28553',filtro);
        }
        
    };