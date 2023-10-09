//Start signature to callBack event to VA_REFRESGRIDFLGAG_672778
    task.changeCallback.VA_REFRESGRIDFLGAG_672778 = function(entities, changeEventArgs) {
        //here your code
        if (mode == 2 && entities.Rates.clase == 'F')
            task.calculateTotal(0, entities.Rates, changeEventArgs)
    };