//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RegularizeDispersionsRejectedForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        //task.showButtons(renderEventArgs)
        ASSETS.API.changeImageChecker(entities, renderEventArgs);
        
        $('#CEQV_201QV_3655_99787_294').attr("disabled",false);
        $('#CEQV_201QV_3655_99787_480').attr("disabled",false);
        $('#CEQV_201QV_3655_99787_212').attr("disabled",false);

		entities.SearchRejectedDispersions.action = 1;
    };