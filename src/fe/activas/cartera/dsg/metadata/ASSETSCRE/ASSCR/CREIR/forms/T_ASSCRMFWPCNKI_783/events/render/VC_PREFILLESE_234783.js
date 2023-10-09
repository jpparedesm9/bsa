//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: prefilledRequest
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    document.getElementById('VA_CLIENTIDPDVYIIU_934167').readOnly = true;
};