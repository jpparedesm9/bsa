// (Button) 
task.executeCommand.CM_TASSTSCF_6AJ = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;

    var nav = executeCommandEventArgs.commons.api.navigation;
    nav.label = 'Carga de Archivo';
    nav.customAddress = {
        id: "assetsUpload",
        url: "/ASSTS/CMMNS/UPLOADFILE/upload-file.html",
        useMinification: false
    };
    nav.modalProperties = {
        size: 'md'
    };
    nav.scripts = [{
        module: "assetsUpload",
        files: ["/ASSTS/CMMNS/UPLOADFILE/services/upload-file-srv.js"
                                           , "/ASSTS/CMMNS/UPLOADFILE/controllers/upload-file-ctrl.js"]
        }];
    nav.openCustomModalWindow('assetsUpload');
};