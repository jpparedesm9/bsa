//Entity: NaturalPerson
    //NaturalPerson.bioIdentificationType (ComboBox) View: GeneralForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BIOIDENTIFICITO_287739 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        if(changedEventArgs.newValue == 'INE'){
            changedEventArgs.commons.api.viewState.show('VA_BIOCICSOGTHMGMK_830739');
            changedEventArgs.commons.api.viewState.hide('VA_BIOEMISSIONNUUU_579739');
            changedEventArgs.commons.api.viewState.hide('VA_BIOOCRPFNDHELMR_160739');
            changedEventArgs.commons.api.viewState.hide('VA_BIOREADERKEYXPM_644739');
            entities.NaturalPerson.bioEmissionNumber = null;
            entities.NaturalPerson.bioOCR = null;
            entities.NaturalPerson.bioReaderKey = null;
        }else if(changedEventArgs.newValue == 'IFE'){
            changedEventArgs.commons.api.viewState.hide('VA_BIOCICSOGTHMGMK_830739');
            changedEventArgs.commons.api.viewState.show('VA_BIOEMISSIONNUUU_579739');
            changedEventArgs.commons.api.viewState.show('VA_BIOOCRPFNDHELMR_160739');
            changedEventArgs.commons.api.viewState.show('VA_BIOREADERKEYXPM_644739');
            entities.NaturalPerson.bioCIC = null;
        }
        
    };