/*global console */
//Designer Generator v 6.4.0.3 - SPR 2018-10 03/10/2018
/*jslint nomen: true, eqeq:true*/

/**
 * @module designerModule
 * @submodule designer.js
 */

var app;
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module unless amdModuleId is set
        define("designer", [], function () {
            return (factory(window.angular, window.kendo, window.kendo.jQuery, window.cobis));
        });
    } else {
        factory(window.angular, window.kendo, window.kendo.jQuery, window.cobis);
    }
} (this, function (angular, kendo, $, cobis) {
    if (!window.designer) {
        window.designer = {};
    }
    var designer = window.designer,
        timeOutIE = 600,
        exportFlag = true,
        objExport = null;
    designer.dsgEvents = function () {
        return {
            initData: {},
            initDataCallback: {},
            changeInitData: {},
            executeCommand: {},
            executeLabelCommand: {},
            executeCommandCallback: {},
            executeCrudCallback: {},
            onTabClosing: {},
            validateTransaction: {},
            callTransaction: {},
            showResult: {},
            closeModalEvent: {},
            change: {},
            changeGroup: {},
            changeCallback: {},
            changeWithError: {},
            loadCatalog: {},
            loadCatalogCallback: {},
            executeQuery: {},
            executeQueryCallback: {},
            textInputButtonEvent: {},
            textInputButtonCloseModalEvent: {},
            gridRowInserting: {},
            gridRowInsertingCallback: {},
            gridRowUpdating: {},
            gridRowUpdatingCallback: {},
            gridRowDeleting: {},
            gridRowDeletingCallback: {},
            gridRowSelecting: {},
            gridRowSelectingCallback: {},
            gridRowRendering: {},
            showGridRowDetailIcon: {},
            gridRowCommand: {},
            gridRowCommandCallback: {},
            gridCommand: {},
            gridCommandCallback: {},
            gridBeforeEnterInLineRow: {},
            gridAfterLeaveInLineRow: {},
            gridInitDetailTemplate: {},
            gridInitColumnTemplate: {},
            gridInitEditColumnTemplate: {},
            beforeOpenGridDialog: {},
            afterCloseGridDialog: {},
            textInputButtonEventGrid: {},
            textInputButtonCloseModalEventGrid: {},
            //deprecado utilizar el evento customInputRestriction
            customValidation: {},
            customInputRestriction: {},
            customValidate: {},
            //oncloseModal tiene evento de servidor
            onCloseModalEvent: {},
            onCloseModalEventCallback: {},
            exportColumns: {}
        };
    };

    app = angular.module('designerModule');
    /**
     * @class designer
     */
    app.service('designer', ["cobisMessage", "dsgnrUtils", "dsgnrCommons", "designerCRUD", "dsgnrCE", "$resource", "$parse", "$rootScope", "$location", "$modal", "$q", "$timeout", "dsgnrConfigPage", "$route", "$filter",
        function (cobisMessage, dsgnrUtils, dsgnrCommons, crud, dsgnrCustomEvents, $resource, $parse, $rootScope, $location, $modal, $q, $timeout, dsgnrConfigPage, $route, $filter) {

            var _vc = [],
                _event = dsgnrCommons.constants.event,
                _focusError = dsgnrCommons.utils.focusError,
                _focusControl = dsgnrCommons.utils.focusControl,
                _lifeCycle = {},
                _urlLiferayRest;

            function _validateBrowser(){
                var isChrome = !!window.chrome && !!window.chrome.webstore;
                if(isChrome){
                    var nAgt = navigator.userAgent;
                    var indexVersion = nAgt.indexOf("Chrome");
                    var version = parseInt(nAgt.substr(indexVersion+7, 2));
                    if (version > 61) {
                        var cssModal = $(".modal-body .cb-view-container");
                        if (cssModal.length > 0) {
                            cssModal.removeClass("cb-view-container");
                            cssModal.addClass("cb-view-container");
                        }
                    }
                }
            }

            _lifeCycle.prepareThread = function (page) {
                var deferrer = $q.defer();
                setTimeout(function () {
                    deferrer.resolve(page);
                }, 0);
                return deferrer.promise;
            };

            _lifeCycle.run = function (page, promise, scope) {
                promise.then(
                    function (page) {
                        return scope.vc.temporaryRead(page);
                    }
                ).then(
                    function (page) {
                        return scope.vc.initData(page, scope.vc);
                    }
                ).then(
                    function (page) {
                        return scope._initPage_CRUDExecuteQueryEntities(page);
                    }
                ).then(
                    function (page) {
                        scope.vc.afterInitData = {
                            flag: true
                        };
                        return scope._initPage_InitializeTrackers(page);
                    }
                ).then(
                    function (page) {
                        return scope._initPage_ChangeInitData(page);
                    }
                ).then(
                    function (page) {
                        var deferrer = $q.defer();
                        $timeout(function () {
                            deferrer.resolve(page);
                        }, 400);
                        return deferrer.promise;
                    }
                ).then(
                    function (page) {
                        return scope._initPage_ProcessRender(page);
                    }
                ).then(
                    function (page) {
                        scope.vc.validateForm();
                        if ($rootScope.count && $rootScope.count == 0) {
                            cobis.showMessageWindow.loading(false);
                        }
                        return page;
                    }
                ).then(
                    function (page) {
                        scope.vc.setWidthColumn();
                        //Este variable indica que se inicializaron todos los eventos de la pagina
                        scope.vc.loaded = true;
                        if(scope.vc.isModal()){
                            _validateBrowser();
                        }
                        return page;
                    }
                );
            };

            function _initCommonsEventArgs(eventArgs, controlId, vc) {
                eventArgs.commons.messageHandler = cobisMessage;
                eventArgs.commons.controlId = controlId;
                eventArgs.commons.execServer = true;
                eventArgs.commons.api = new dsgnrCommons.API(vc);                
                eventArgs.commons.types = vc.types;
                eventArgs.commons.args = vc.args;
                if (cobis.container.tabs.getCurrentTab() != null) {
                    eventArgs.commons.args = cobis.container.tabs.getCurrentTab().guid;
                }
            }

            function _clickTab(event, idGroup, idItem, hasEvent) {
                var acItem = this.viewState[idGroup].activeItem,
                    changedGroupEventArgs;
                this.viewState[idGroup].activeItem = idItem;
                if (acItem != idItem) {
                    if (hasEvent === true) {
                        changedGroupEventArgs = new dsgnrCommons.eventArgs.ChangedGroupEventArgs();
                        changedGroupEventArgs.commons.item.id = idItem;
                        _initCommonsEventArgs(changedGroupEventArgs, idGroup, this);
                        dsgnrCustomEvents.changeGroup(this.vcEvents, this.model, changedGroupEventArgs);
                    }
                }
            }

            function _getPlaceHolder() {
                var comboPlaceholder = "Seleccione";
                if (cobis.userContext.getValue(cobis.constant.CULTURE) === "en") {
                    comboPlaceholder = "Select";
                }
                return comboPlaceholder;
            }

            function _createViewState(metadata) {
                var that = this;
                that.viewState[metadata.id] = {
                    _readonly: undefined,
                    _disabled: undefined,
                    _visible: undefined
                };
                if (angular.isDefined(metadata.hasId)) {
                    that.viewState[metadata.id].statusStyle = {
                        success: false,
                        fail: false,
                        none: true,
                        numErrors: undefined
                    };
                }
                if (metadata.componentStyle) {
                    that.viewState[metadata.id].style = metadata.componentStyle;
                } else {
                    that.viewState[metadata.id].style = [];
                }
                if (angular.isDefined(metadata.htmlSection)) {
                    that.viewState[metadata.id].customView = {};
                    that.viewState[metadata.id].view = {};
                }
                if (angular.isDefined(metadata.labelImageId)) {
                    that.viewState[metadata.id].labelImageId = metadata.labelImageId;
                } else if (angular.isDefined(metadata.imageId)) {
                    that.viewState[metadata.id].imageId = metadata.imageId;
                }
                if (angular.isDefined(metadata.tooltip)) {
                    that.viewState[metadata.id].tooltip = metadata.tooltip;
                }
                if (metadata.label) {
                    that.viewState[metadata.id].label = metadata.label;
                    if (angular.isDefined(metadata.haslabelArgs)) {
                        that.viewState[metadata.id].labelArgs = {};
                    }
                }
                if (angular.isDefined(metadata.queryId)) {
                    that.viewState[metadata.id].queryId = metadata.queryId;
                }
                if (angular.isDefined(metadata.mask)) {
                    that.viewState[metadata.id].mask = metadata.mask;
                }
                if (angular.isDefined(metadata.format)) {
                    that.viewState[metadata.id].format = metadata.format;
                }
                if (angular.isDefined(metadata.prefix)) {
                    that.viewState[metadata.id].prefix = metadata.prefix;
                }
                if (angular.isDefined(metadata.suffix)) {
                    that.viewState[metadata.id].suffix = metadata.suffix;
                }
                if (angular.isDefined(metadata.decimals)) {
                    that.viewState[metadata.id].decimals = metadata.decimals;
                }
                if (angular.isDefined(metadata.validationCode)) {
                    that.viewState[metadata.id].validationCode = metadata.validationCode;
                }
                if (angular.isDefined(metadata.isComboBox)) {
                    that.viewState[metadata.id].template = '';
                }
                that.viewState[metadata.id].metadata = {};
                if (angular.isDefined(metadata.readOnly)) {
                    that.viewState[metadata.id].metadata.readOnly = metadata.readOnly;
                    Object.defineProperty(that.viewState[metadata.id], "readonly", {
                        get: function () {
                            if (angular.isDefined(this._readonly)) {
                                return this._readonly;
                            }
                            return dsgnrCommons.enums.hasFlag(this.metadata.readOnly, that.mode);
                        },
                        set: function (readonly) {
                            this._readonly = readonly;
                        }
                    });
                }
                if (angular.isDefined(metadata.enabled)) {
                    if (metadata.isAutoGenerated) {
                        Object.defineProperty(that.viewState[metadata.id], "disabled", {
                            get: function () {
                                if (angular.isDefined(this._disabled)) {
                                    return this._disabled;
                                }
                                return true;
                            },
                            set: function (disabled) {
                                this._disabled = disabled;
                            }
                        });
                    } else {
                        that.viewState[metadata.id].metadata.enabled = metadata.enabled;
                        Object.defineProperty(that.viewState[metadata.id], "disabled", {
                            get: function () {
                                if (angular.isDefined(this._disabled)) {
                                    return this._disabled;
                                }
                                return !dsgnrCommons.enums.hasFlag(this.metadata.enabled, that.mode);
                            },
                            set: function (disabled) {
                                this._disabled = disabled;
                            }
                        });
                    }
                }
                if (angular.isDefined(metadata.visible)) {
                    that.viewState[metadata.id].metadata.visible = metadata.visible;
                    Object.defineProperty(that.viewState[metadata.id], "visible", {
                        get: function () {
                            if (angular.isDefined(this._visible)) {
                                return this._visible;
                            }
                            return dsgnrCommons.enums.hasFlag(this.metadata.visible, that.mode);
                        },
                        set: function (visible) {
                            this._visible = visible;
                        }
                    });
                } else {
                    Object.defineProperty(that.viewState[metadata.id], "visible", {
                        get: function () {
                            if (angular.isDefined(this._visible)) {
                                return this._visible;
                            }
                            return true;
                        },
                        set: function (visible) {
                            this._visible = visible;
                        }
                    });
                }
            }

            function _setReadOnlyInputCombobox(controlId) {
                var isIE = kendo.support.browser.msie,
                    IEversion = kendo.support.browser.version,
                    control = $("#" + controlId);
                if (angular.isDefined(control) && control.data("kendoExtComboBox")) {
                    if (isIE && IEversion > 10) {
                        setTimeout(function () {
                            control = control.data("kendoExtComboBox");
                            control.input.attr("readonly", true);
                            if (!$(control.input).hasClass("non-readonly")) {
                                control.input.readOnly = true;
                                control.input.addClass("non-readonly");
                            }
                        }, timeOutIE);
                    } else {
                        control = control.data("kendoExtComboBox");
                        control.input.attr("readonly", true);
                        if (!$(control.input).hasClass("non-readonly")) {
                            control.input.readOnly = true;
                            control.input.addClass("non-readonly");
                        }
                    }

                }
            }

            function _setGridComboBoxDefaultValue(gridId, comboBoxId) {
                var grid = angular.element($("#" + gridId)).data("kendoExtGrid"),
                    rowData,
                    attribute,
                    comboBox,
                    cascadeId,
                    rowDataValue, comboBoxControl;
                if (grid) {
                    comboBoxControl = $("#" + comboBoxId);
                    rowData = grid.dataItem(comboBoxControl.closest("tr"));
                    if (rowData) {
                        attribute = comboBoxControl.attr("name");
                        rowDataValue = rowData[attribute];
                        comboBox = comboBoxControl.data("kendoExtComboBox");
                        if (comboBox) {
                            if (comboBox.selectedIndex === -1) { //si no selecciono un valor
                                if (comboBox.options.index === 0 && comboBox.dataSource.data().length > 0) { //si no tiene opciÃ³n en blanco
                                    //comboBox.select(0);
                                    rowData[attribute] = comboBox.dataSource.data()[0][comboBox.options.dataValueField];
                                    comboBox.text(comboBox.dataSource.data()[0][comboBox.options.dataTextField]);
                                } else { //si tiene opciÃ³n en blanco
                                    if (rowData[attribute] === "" || rowData[attribute] === 0) {
                                        comboBox.text('');
                                        rowData[attribute] = null;
                                    }
                                }
                            } else {
                                if (rowDataValue && !comboBox.defaultValue) { //Si esta en edicion
                                    comboBox.value(rowDataValue);
                                    comboBox.defaultValue = true;
                                } else { //si es una fila nueva
                                    if (comboBox.dataSource.data().length > 0 && typeof comboBox.dataSource.data()[0][comboBox.options.dataValueField] === 'number') {
                                        rowData[attribute] = Number(comboBox.value());
                                    } else {
                                        rowData[attribute] = comboBox.value();
                                    }
                                }
                            }
                        } else {
                            cascadeId = $("#" + comboBoxId).attr("k-cascade-from");
                            if (cascadeId) {
                                if (rowData[attribute] === "") {
                                    rowData[attribute] = null;
                                }
                            }
                        }
                    }
                }
            }

            function _setComboBoxDefaultValue(controlId) {
                var model = $("#" + controlId).attr("ng-model");
                if (evalDsgnr("angular.element($('#" + controlId + "')).scope()." + model) === "") {
                    evalDsgnr("angular.element($('#" + controlId + "')).scope()." + model + "=null");
                }
            }

            function evalDsgnr(fn) {
                return new Function('return ' + fn)();
            }

            function _getParentValue(scope, entityName, attributeName) {
                if (angular.isDefined(scope.vc.model[entityName])) {
                    return scope.vc.model[entityName][attributeName];
                } else {
                    if (angular.isDefined(scope.vc.parentVc) && angular.isDefined(scope.vc.parentVc.model[entityName])) {
                        return scope.vc.parentVc.model[entityName][attributeName];
                    } else {
                        return null;
                    }
                }
            }

            function _validateForm() {
                /* Quitar este comentario para ser usado por BG
                 var formValidator = $("#validator").data("kendoValidator");
                 if(!formValidator.validate()){
                 formValidator.hideMessages();
                 }
                 */
            }

            function _setWidthColumn() {
                if (sessionStorage.getItem('columnSize') != null) {
                    cobis.logging.getLoggerManager().warn('ColumnSize Defined');
                } else {
                    dsgnrConfigPage.getWidth().then(function (data) {
                        if (angular.isDefined(data.queryView) && angular.isDefined(data.queryView.editDeleteBtns)) {
                            if (data.queryView.editDeleteBtns.width) {
                                sessionStorage.setItem('columnSize', data.queryView.editDeleteBtns.width);
                            } else {
                                cobis.logging.getLoggerManager().warn('No value was found ColumnSize standard buttons');
                                sessionStorage.setItem('columnSize', '100px');
                            }
                        }
                    }, function (data) {
                        cobis.logging.getLoggerManager().warn('It failed to get the configuration file');
                        sessionStorage.setItem('columnSize', '100px');
                    });
                }
            }

            function _clickFileUploader(visualAttributeId) {
                var fileUploader = null;
                if (visualAttributeId) {
                    fileUploader = angular.element('#' + visualAttributeId + '_gridUploader');
                } else {
                    fileUploader = angular.element('#fileUploader');
                }
                fileUploader.trigger('click');
            }

            function _removeFile(visualAttributeId) {
                _vc[this.id].uploaders[visualAttributeId].fileUploadAPI.removeFile();
            }

            function getFileUploaderApi(objectValidation, visualAttributeId, e, uploaders) {
                var fileUploaderAPI;
                if (!objectValidation) {
                    var scope = e.sender.$angular_scope;
                    var vaId = angular.element('#fileUploader').attr('visualAttributeId');
                    fileUploaderAPI = scope.vc.uploaders[vaId].fileUploadAPI;
                } else {
                    fileUploaderAPI = uploaders[visualAttributeId].fileUploadAPI;
                }
                return fileUploaderAPI;
            }

            function _onFileUpload(e, gridRowModel, visualAttributeId) {
                var fileUploaderAPI = getFileUploaderApi(gridRowModel, visualAttributeId, e, this.uploaders);
                fileUploaderAPI.onUpload(e, gridRowModel);
            }

            function _gridRowRendering(id, args) {
                var renderGridRowEventArgs = new dsgnrCommons.eventArgs.RenderGridRowEventArgs();
                _initCommonsEventArgs(renderGridRowEventArgs, id, this);
                renderGridRowEventArgs.rowData = args.rowData;
                renderGridRowEventArgs.rowIndex = args.rowIndex;
                renderGridRowEventArgs.nameEntityGrid = args.nameEntityGrid;
                //call to client event
                return dsgnrCustomEvents.gridRowRendering(this.vcEvents, this.model, renderGridRowEventArgs);
            }

            function _onFileSelect(e, visualAttributeId) {
                var fileUploaderAPI = getFileUploaderApi(visualAttributeId, visualAttributeId, e, this.uploaders);
                fileUploaderAPI.onSelect(e);
            }

            function _onSuccess(e, visualAttributeId) {
                var fileUploaderAPI = getFileUploaderApi(visualAttributeId, visualAttributeId, e, this.uploaders);
                fileUploaderAPI.onSuccess(e);
            }

            function _setVisibilityOfGridRowDetailIcon(queryViewId, rowId, showIcon) {
                var queryView = $("#" + queryViewId + " tbody"),
                    tdIcon = queryView.find("tr[data-uid=" + rowId + "]").find('.k-hierarchy-cell a'),
                    row = queryView.find("tr[data-uid=" + rowId + "]"),
                    trDetail = $(row).next(".k-detail-row");
                if (showIcon === false || typeof showIcon === "undefined") {
                    //row.css({ opacity: 0, cursor: 'default' }).click(function(e) { e.stopImmediatePropagation(); return false; });
                    tdIcon.hide();
                    if (trDetail) {
                        trDetail.remove();
                    }
                } else {
                    //row.css({ opacity: 1});
                    tdIcon.show();
                }
            }

            // Funcion para darle foco y click al boton con type="submit" que es llamado despues de dar enter en un control de formulario
            function _clickOnEnter(idButton) {
                var selector = $('#' + idButton);
                if (angular.isDefined(selector)) {
                    $timeout(function () {
                        angular.element(selector).trigger('focus');
                        angular.element(selector).trigger('click');
                    }, 100);
                }
            }

            function _addDsgnrId(entityName, data, trackers) {
                var i;
                if (trackers[entityName]) {
                    for (i in data) {
                        data[i].dsgnrId = dsgnrCommons.utils.uuid();
                    }
                }
            }

            function _nextSeq(entity) {
                if (this.seq[entity]) {
                    this.seq[entity] = this.seq[entity] - 1;
                } else {
                    this.seq[entity] = -1;
                }
                return this.seq[entity];
            }

            function _cleanData(data, parameters, filterParameters) {
                var newData = {},
                    key,
                    param;
                if (parameters && Object.getOwnPropertyNames(parameters).length > 0) {
                    for (key in data) {
                        for (param in parameters) {
                            if (parameters[param] === true) {
                                if (param === key) {
                                    if (data[key] instanceof kendo.data.DataSource) {
                                        newData[key] = data[key].data();
                                    } else {
                                        newData[key] = data[key];
                                    }
                                }
                            }
                        }
                        if (filterParameters && Object.getOwnPropertyNames(filterParameters).length > 0) {
                            for (var filter in filterParameters) {
                                if (filterParameters.hasOwnProperty(filter)) {
                                    if (filter === key) {
                                        newData[key] = data[key];
                                    }
                                }
                            }
                        }
                    }
                } else {
                    for (key in data) {
                        if (data[key] instanceof kendo.data.DataSource) {
                            newData[key] = data[key].data();
                        } else {
                            newData[key] = data[key];
                        }
                    }
                }
                return newData;
            }

            function _fillServerParameters(data, args, globalSeverParameters, eventName) {
                var newData = null;
                if (angular.isDefined(args) && angular.isDefined(args.commons)) {
                    if (Object.keys(args.commons.serverParameters).length > 0) {
                        newData = _cleanData(data, args.commons.serverParameters, args.parameters);
                        args.commons.serverParameters = {};
                    } else {
                        newData = _cleanData(data, globalSeverParameters);
                    }
                } else if (eventName === 'temporarySave' || eventName === 'readTemporaryData' || eventName === 'deleteTemporaryData') {
                    newData = _cleanData(data, globalSeverParameters);
                } else {
                    console.log('Asignar el argumento para server parameters');
                }
                return newData;
            }

            function _execute(event, source, data, callback, args, specialArgs) {
                var newData,
                    argmnts = this.args,
                    key,
                    request,
                    argsTemp = {};
                if (angular.isDefined(specialArgs)) {
                    newData = _fillServerParameters(data, specialArgs, this.serverParameters);
                } else {
                    newData = _fillServerParameters(data, args, this.serverParameters, event);
                }
                this.serverParameters = {};
                if (args) {
                    // copy scope.vc.args to the new args
                    for (key in this.args) {
                        if (!this.args.hasOwnProperty(key)) {
                            continue;
                        }
                        args[key] = this.args[key];
                    }
                    argmnts = args;
                }

                //Se envia al servidor los parametros de navegacion
                if (angular.isDefined(this.parentVc) && angular.isDefined(this.parentVc.customDialogParameters)) {
                    argmnts.customParameters = this.parentVc.customDialogParameters;
                }
                argmnts.viewContainerId = this.id;
                argmnts.version = this.taskVersion;
                argmnts.taskId = this.taskId;
                for (key in argmnts) {
                    if (argmnts.hasOwnProperty(key)) {
                        if (key === "commons") {
                            if (angular.isDefined(argmnts.commons) && angular.isDefined(argmnts.commons.api)) {
                                if(angular.isUndefined(argsTemp.commons)){
                                    argsTemp.commons = {};
                                }
                                for (ikey in argmnts.commons) {
                                    if (ikey !== "api") {
                                        argsTemp.commons[ikey] = argmnts.commons[ikey];
                                    }
                                }
                            } else {
                                argsTemp[key] = argmnts[key];
                            }
                        } else {
                            argsTemp[key] = argmnts[key];
                        }
                    }
                }
                request = {
                    event: event,
                    source: source,
                    data: newData,
                    args: argsTemp
                };
                this.server.post(request, callback, dsgnrCommons.utils.errorCallback);
            }

            function _executeService(event, source, data, args) {
                var newData = _fillServerParameters(data, args, null, event),
                    argmnts = this.args,
                    key,
                    request,
                    returnExecute;
                if (args) {
                    // copy scope.vc.args to the new args
                    for (key in this.args) {
                        if (!this.args.hasOwnProperty(key)) {
                            continue;
                        }
                        args[key] = this.args[key];
                    }
                    argmnts = args;
                }

                //Se envia al servidor los parametros de navegacion
                if (angular.isDefined(this.parentVc) && angular.isDefined(this.parentVc.customDialogParameters)) {
                    argmnts.customParameters = this.parentVc.customDialogParameters;
                }
                argmnts.viewContainerId = this.id;
                argmnts.version = this.taskVersion;
                argmnts.taskId = this.taskId;
                request = {
                    event: event,
                    source: source,
                    data: newData,
                    args: argmnts
                };
                returnExecute = this.server.post(request);
                return returnExecute.$promise;
            }


            function _executeCatalog(event, source, catalog, data, callback, config, cache) {
                var newData = _cleanData(data, this.serverParameters);
                this.serverParameters = {};
                var request = {
                    event: event,
                    source: source,
                    data: newData,
                    catalog: catalog,
                    args: {
                        viewContainerId: this.id,
                        version: this.taskVersion,
                        taskId: this.taskId,
                        cache: cache
                    }
                };
                if (config) {
                    request.args = {
                        config: config,
                        viewContainerId: this.id,
                        version: this.taskVersion,
                        taskId: this.taskId
                    };
                }
                this.server.post(request, callback, dsgnrCommons.utils.errorCallback);
            }


            function _initData(page, controller) {
                if (page.hasInitDataSupport) {
                    if (!page.hasTemporaryDataSupport || (page.hasTemporaryDataSupport && page.ejecTemporaryData && !page.hasTemporaryData)) {
                        var that = controller,
                            hasData;

                        var initDataEventArgs = new dsgnrCommons.eventArgs.InitDataEventArgs();
                        _initCommonsEventArgs(initDataEventArgs, page.vcName, that);

                        dsgnrCustomEvents.initCustomData(this.vcEvents, controller.model, initDataEventArgs);

                        hasData = initDataEventArgs.hasData;

                        if (this.serverEvents && initDataEventArgs.commons.execServer) {
                            return that.executeService(_event.InitData, page.vcName, controller.model, initDataEventArgs).then(
                                function (response) {
                                    page.hasInitData = that.processResponse(response, initDataEventArgs);
                                    page.ejecInitData = response.success;

                                    // Execute "initDataCallback" event
                                    var initDataCallbackEventArgs = new dsgnrCommons.eventArgs.InitDataCallbackEventArgs();
                                    _initCommonsEventArgs(initDataCallbackEventArgs, page.vcName, that);
                                    initDataCallbackEventArgs.success = response.success;
                                    dsgnrCustomEvents.initDataCallback(that.vcEvents, that.model, initDataCallbackEventArgs);

                                    return page;
                                }
                            );
                        } else {
                            page.hasInitData = hasData;
                            page.ejecInitData = true;
                            return page;
                        }
                    } else {
                        page.hasInitData = false;
                        page.ejecInitData = false;
                        return page;
                    }
                } else {
                    page.ejecInitData = false;
                    page.hasInitData = false;
                    return page;
                }
            }

            function _changeGroup(event) {
                var response = null,
                    that = this.$angular_scope.vc,
                    controlId = event.item.id,
                    index = controlId.lastIndexOf("_"),
                    parentId = "",
                    isTab = false,
                    panelBarChange = false;
                if (index !== -1) {
                    if (controlId.substring(index) === "_tab") {
                        controlId = controlId.substring(0, index);
                        parentId = event.contentElement.parentElement.id;
                        if (parentId.indexOf("_VAL") !== -1) {
                            parentId = parentId.substring(0, parentId.indexOf("_VAL"));
                        } else if (parentId.indexOf("_tab") !== -1) {
                            parentId = parentId.substring(0, parentId.indexOf("_tab"));
                        }
                        isTab = true;
                    } else {
                        parentId = event.item.parentElement.id;
                        parentId = parentId.substring(0, parentId.indexOf("_VAL"));
                        if (event.sender.options.expandMode === "single") {
                            if (event.item.attributes["aria-expanded"].value === "false") {
                                panelBarChange = true;
                            }
                        } else {
                            panelBarChange = true;
                        }
                    }
                }
                var promise = _createPromise(response);
                if (promise) {
                    promise.then(
                        function (response) {
                            var changedGroupEventArgs = new dsgnrCommons.eventArgs.ChangedGroupEventArgs();
                            changedGroupEventArgs.commons.item.id = controlId;
                            if (!isTab) {
                                // changedGroupEventArgs.commons.item.isOpen=$('#'+controlId)[0].attributes['aria-expanded'].value;
                                if (event.item.attributes[5].value == "false") {
                                    changedGroupEventArgs.commons.item.isOpen = false;
                                }
                            }
                            changedGroupEventArgs.eventName = _event.ChangeGroup;
                            _initCommonsEventArgs(changedGroupEventArgs, parentId, that);
                            if (isTab || panelBarChange) {
                                dsgnrCustomEvents.changeGroup(that.vcEvents, that.model, changedGroupEventArgs);
                            }
                        }
                    );
                }
            }

            function _changeInitData(page, controller) {
                if (page.hasChangeInitDataSupport) {
                    if (!page.hasTemporaryDataSupport || (page.hasTemporaryDataSupport && page.ejecTemporaryData && !page.hasTemporaryData)) {
                        //if(page.ejecTemporaryData && !page.hasTemporaryData){
                        var that = controller,
                            changeInitDataEventArgs = new dsgnrCommons.eventArgs.ChangeInitDataEventArgs(),
                            hasData;
                        _initCommonsEventArgs(changeInitDataEventArgs, page.vcName, that);

                        dsgnrCustomEvents.changeInitCustomData(this.vcEvents, controller.model, changeInitDataEventArgs);

                        hasData = changeInitDataEventArgs.hasData;

                        if (this.serverEvents && changeInitDataEventArgs.commons.execServer) {
                            return that.executeService(_event.ChangeInitData, page.vcName, controller.model, changeInitDataEventArgs).then(
                                function (response) {
                                    hasData = that.processResponse(response, changeInitDataEventArgs);
                                    page.hasChangeInitData = hasData;
                                    page.ejeChangeInitData = response.success;
                                    return page;
                                }
                            );
                        } else {
                            page.hasChangeInitData = hasData;
                            page.ejeChangeInitData = true;
                            return page;
                        }
                    } else {
                        page.hasChangeInitData = false;
                        page.ejeChangeInitData = false;
                        return page;
                    }
                } else {
                    page.ejeChangeInitData = false;
                    page.hasChangeInitData = false;
                    return page;
                }
            }

            /*
             * Comprueba si esta solicitud es de filtrado de cliente y en caso de serlo, setea el flag clientFiltering a true
             *
             * @method verifyAndCompleteProcessToFilterDataInClient
             * @param {Object} clientFiltering {value: boolean, dataToBeLoaded:   flag que indica si el filtrado se realizarÃ¡ en cliente y datos filtrados
             * @param {Object} component Objeto javascript que representa el comboBox
             * @param {Object} filter  InformaciÃ³n de filtrado creado por el componente comboBox
             * @param {Object} config  InformaciÃ³n de filtrado para el servicio de datos en el servidor
             * @return {void}
             */
            function _verifyAndCompleteProcessToFilterDataInClient(clientFiltering, component, filter, config) {
                var isAutocompleteComboBox = dsgnrUtils.combobox.isAutocompleteComboBox(component, config),
                    widget = component.data('kendoExtComboBox');
                if (angular.isDefined(widget) && isAutocompleteComboBox) {
                    var ds = widget.dataSource,
                        filtersOfLastRequest = ds.filtersOfLastRequest;
                    clientFiltering.value = dsgnrUtils.combobox.isClientFilteringRequest(filtersOfLastRequest, filter, component);
                    if (clientFiltering.value) {
                        if (angular.isUndefined(ds.dataToBeFilterInClient)) {
                            ds.dataToBeFilterInClient = ds.data();
                        }
                        clientFiltering.dataToBeLoaded = dsgnrUtils.combobox.filterDataInClient(widget, filter);
                    } else {
                        ds.dataToBeFilterInClient = undefined;
                    }
                    ds.filtersOfLastRequest = filter;
                }
            }


            function _loadCatalog(controlId, callback, filter, config, cache) {
                // callback - requerido para cuando se lo invoca via dataSource
                // filter - criterios de busqueda para catalogos dependientes
                // config - parÃ¡metros para servicios de datos
                var that = this,
                    component = $("#" + controlId),
                    isCascade = dsgnrUtils.combobox.isCascade(component),
                    clientFiltering = {
                        value: false,
                        dataToBeLoaded: []
                    };


                _verifyAndCompleteProcessToFilterDataInClient(clientFiltering, component, filter, config);

                if ((filter || !isCascade) && clientFiltering.value === false) {
                    var valores,
                        filters = [],
                        argsForServer,
                        loadCatalogEventArgs = new dsgnrCommons.eventArgs.LoadCatalogEventArgs(),
                        i;
                    _initCommonsEventArgs(loadCatalogEventArgs, controlId, this);
                    if (filter) {
                        if (filter.filters) {
                            for (i in filter.filters) {
                                filters.push(filter.filters[i].value);
                            }
                            loadCatalogEventArgs.filters = filters;
                        }
                        if (config) {
                            loadCatalogEventArgs.config = config;
                        }
                    }
                    argsForServer = {
                        filters: filters,
                        config: null,
                        cache: cache
                    };
                    if (config) {
                        argsForServer.config = config;
                    }
                    valores = dsgnrCustomEvents.loadCustomCatalog(this.vcEvents, loadCatalogEventArgs);
                    if (this.serverEvents && loadCatalogEventArgs.commons.execServer) {
                        if (callback) {
                            var model = {},
                                parameters;
                            if (Object.keys(loadCatalogEventArgs.commons.serverParameters).length > 0) {
                                parameters = loadCatalogEventArgs.commons.serverParameters;
                            } else {
                                parameters = this.serverParameters;
                            }

                            if (parameters && Object.getOwnPropertyNames(parameters).length > 0) {
                                model = this.model;
                            }
                            this.execute(_event.LoadCatalog, controlId, model, function (response) {
                                if (response.success) {
                                    _showResultMessages(null, true, response.messages, false, this);
                                } else {
                                    _showResultMessages(null, false, response.messages, false, this);
                                }
                                callback(response);
                                _checkStatusCombobox(that, controlId, component);
                                dsgnrCustomEvents.loadCustomCatalogCallback(that.vcEvents, that.model, loadCatalogEventArgs);
                            }, argsForServer, loadCatalogEventArgs);
                        } else {
                            this.execute(_event.LoadCatalog, controlId, null, function (response) {
                                if (response.success) {
                                    _showResultMessages(null, true, response.messages, false, this);
                                } else {
                                    _showResultMessages(null, false, response.messages, false, this);
                                }
                                that.catalogs[controlId].data(response.data['RESULT' + controlId]);
                                _checkStatusCombobox(that, controlId, component);
                            }, argsForServer, loadCatalogEventArgs);
                        }
                    } else if (valores == null || valores instanceof Array) {
                        if (callback) {
                            var response1 = {
                                data: [],
                                success: true
                            };
                            response1.data['RESULT' + controlId] = valores;
                            callback(response1);
                        } else {
                            that.catalogs[controlId].data(valores);
                        }
                    } else if (valores != null && angular.isDefined(valores.$$state)) {
                        _loadDataFromPromise(controlId, that.catalogs[controlId], valores, callback);
                    }
                } else {
                    if (callback) {
                        var response2 = {
                            data: {},
                            success: true
                        };
                        response2.data['RESULT' + controlId] = clientFiltering.dataToBeLoaded;
                        callback(response2);
                        _checkStatusCombobox(that, controlId, component);
                    }
                }
            }

            function _loadDataFromPromise(controlIdOrQueryId, catalogueOrQuery, promise, callback) {
                promise.then(function (valuesReturnFromPromise) {
                    valuesReturnFromPromise = _resetData(valuesReturnFromPromise);
                    if (callback) {
                        var response = {
                            data: [],
                            success: true
                        };
                        response.data['RESULT' + controlIdOrQueryId] = valuesReturnFromPromise;
                        callback(response);
                    } else {
                        catalogueOrQuery.data(valuesReturnFromPromise);
                    }
                }, function (reason) {
                    console.error('Failed: ' + reason);
                }, function (update) {
                    console.info('Got notification: ' + update);
                });
            }


            function _loadCatalogCobis(id, catalog, callback, config, filter, cache) {
                var component = $("#" + id),
                    clientFiltering = {
                        value: false,
                        dataToBeLoaded: []
                    },
                    conf = null,
                    that = this;

                if (config) {
                    conf = config;
                }

                _verifyAndCompleteProcessToFilterDataInClient(clientFiltering, component, filter, config);

                if (that.serverEvents && clientFiltering.value === false) {
                    if (callback) {
                        this.executeCatalog(_event.LoadCatalogCobis, id, catalog, '', callback, conf, cache);
                    } else {
                        this.executeCatalog(_event.LoadCatalogCobis, id, catalog, '', function (response) {
                            that.catalogs[id].data(response.data['RESULT' + id]);
                        }, conf, cache);
                    }
                } else {
                    if (callback) {
                        if (clientFiltering.dataToBeLoaded.length > 0) {
                            var dataTemp = {};
                            dataTemp['RESULT' + id] = clientFiltering.dataToBeLoaded;
                            callback({
                                data: dataTemp,
                                success: true
                            });
                        } else {
                            callback([]);
                        }
                    }
                }
            }

            function _checkStatusCombobox(that, controlId, component) {
                var isIE = kendo.support.browser.msie,
                    IEversion = kendo.support.browser.version;

                if (isIE && IEversion > 10 && angular.isDefined(that.viewState[controlId])) {
                    var viewStateCombo = (that.viewState[controlId].disabled || that.viewState[controlId].disabledingroup);
                    dsgnrUtils.component.forceEnabledAttributeForComponent(component, !viewStateCombo);

                }

            }

            function _executeQuery(controlId, queryId, mainEntityId, actionControl, callback, config, filter, cache) {
                var that = this,
                    component = $("#" + controlId),
                    clientFiltering = {
                        value: false,
                        dataToBeLoaded: []
                    },
                    clientValues = {},
                    queryRequest;

                if (typeof queryId === 'string') {
                    queryRequest = this.request.qr[queryId];
                } else {
                    queryRequest = queryId;
                    queryId = queryRequest.queryPk.queryId;
                }

                // para los metodos que todavia envian parameters
                // eliminar cuando ya todas las paginas se hayan regenerado
                if (typeof actionControl != 'boolean' && typeof mainEntityId != 'string') {
                    mainEntityId = actionControl;
                    actionControl = callback;
                    callback = config;
                    config = argmnts[6];
                }

                queryRequest.updateParameters();
                var parameters = queryRequest.parameters,
                    argsForServer = null,
                    executeQueryEventArgs = new dsgnrCommons.eventArgs.ExecuteQueryEventArgs();
                _initCommonsEventArgs(executeQueryEventArgs, queryId, this);
                if (config) {
                    argsForServer = {
                        config: config,
                        cache: cache,
                        controlId: controlId
                    };
                    executeQueryEventArgs.config = config;
                }
                executeQueryEventArgs.parameters = parameters;

                _verifyAndCompleteProcessToFilterDataInClient(clientFiltering, component, filter, config);

                clientValues = dsgnrCustomEvents.executeCustomQuery(this.vcEvents, executeQueryEventArgs);
                clientValues = _resetData(clientValues);
                if (this.serverEvents && executeQueryEventArgs.commons.execServer && clientFiltering.value === false) {
                    if (argsForServer == null) {
                        argsForServer = {
                            cache: cache,
                            controlId: controlId
                        };
                    }
                    if (callback) {
                        this.execute(_event.ExecuteQuery, queryId, parameters, function (response) {
                            if (response.success) {
                                _showResultMessages(null, true, response.messages, false, this);
                            } else {
                                _showResultMessages(null, false, response.messages, false, this);
                            }
                            clientValues = _resetData(response.data['RESULT' + queryId]);
                            callback(response);
                            _checkStatusCombobox(that, controlId, component);
                            dsgnrCustomEvents.executeCustomQueryCallback(that.vcEvents, that.model, executeQueryEventArgs);
                        }, argsForServer, executeQueryEventArgs);
                    } else {
                        this.execute(_event.ExecuteQuery, queryId, parameters, function (response) {
                            that.processExecuteQueryResponse(response, queryId, mainEntityId, actionControl, true);
                        }, argsForServer, executeQueryEventArgs);
                    }
                } else if (clientValues == null || clientValues instanceof Array) {
                    var response = {
                        data: [],
                        success: true
                    };
                    response.data['RESULT' + queryId] = clientValues;
                    if (clientFiltering.dataToBeLoaded.length > 0) {
                        response.data['RESULT' + queryId] = clientFiltering.dataToBeLoaded;
                    }
                    if (callback) {
                        callback(response);
                    } else {
                        that.processExecuteQueryResponse(response, queryId, mainEntityId, actionControl, false);
                    }
                } else if (clientValues != null && angular.isDefined(clientValues.$$state)) {
                    _loadDataFromPromise(queryId, that.queries[queryId], clientValues, callback);
                }

            }

            function _executeQueryControl(queryId, commandName, validator, flgVld, flgValidationEvent, viewContainerId, flgClose) {
                var promise,
                    that = this,
                    response;

                if (typeof queryId !== 'string') {
                    queryId = queryId.queryPk.queryId;
                }

                var executeQuery = function (that) {
                    if (angular.isDefined(that.queries[queryId])) {
                        that.queries[queryId].read({
                            refresh: true
                        }).then(function () {
                            if (angular.isDefined(that.queries[queryId].data()) && that.queries[queryId].data().length > 0) {
                                that.queries[queryId].page(1);
                            }
                        });
                    }
                };

                if (angular.isDefined(flgVld) && flgVld === true) {
                    promise = _createPromise(response);
                    if (promise) {
                        promise.then(
                            function () {
                                return _validateTransaction(that, queryId, validator, flgVld, flgValidationEvent, viewContainerId);
                            }
                        ).then(
                            function (response) {
                                if (response.success) {
                                    executeQuery(that);
                                }
                            }
                        );
                    }
                } else {
                    executeQuery(that);
                }

            }

            function _executeQueryAndAppendResults(queryId, queryViewId) {
                var queryRequest;
                if (angular.isDefined(queryViewId)) {
                    $('#' + queryViewId).find("[kendo-ext-grid^='grids']").addBack().each(function (i, element) {
                        $(element).data('kendoExtGrid').cancelRow();
                    });
                }
                if (typeof queryId !== 'string') {
                    queryId = queryId.queryPk.queryId;
                }
                if (angular.isDefined(this.queries[queryId])) {
                    this.queries[queryId].read({
                        refresh: true,
                        appendRecords: true
                    });

                }
            }

            function _processExecuteQueryResponse(response, queryId, mainEntityId, loadInModel, execServer) {
                var objectMetadata,
                    objectModel,
                    keyMetadata;
                if (response) {
                    // Si es un ActionControl
                    if (loadInModel) {
                        for (keyMetadata in this.metadata.entities) {
                            objectMetadata = this.metadata.entities[keyMetadata];
                            if (objectMetadata._entityId == mainEntityId) {
                                objectModel = this.model[keyMetadata];
                                if (this.model[keyMetadata] instanceof kendo.data.DataSource) { // grid
                                    if (response.data['RESULT' + queryId]) {
                                        this.model[keyMetadata].data(_resetData(response.data['RESULT' + queryId]));
                                        this.model[keyMetadata].sync();
                                    }
                                } else {
                                    if (response.data['RESULT' + queryId]) {
                                        var data = response.data['RESULT' + queryId];
                                        this.model[keyMetadata] = data[0];
                                    }
                                }
                            }
                        }
                    } else { // Si es un InputControl
                        if (this.queries[queryId] instanceof kendo.data.DataSource && response.data['RESULT' + queryId]) {
                            this.queries[queryId].data(response.data['RESULT' + queryId]);
                        }
                    }
                    this.mode = dsgnrCommons.constants.mode.Update;
                    if (response.success) {
                        _showResultMessages(null, true, response.messages, false, this);
                    } else {
                        _showResultMessages(null, false, response.messages, false, this);
                    }
                }
            }

            function _gridRowSelecting(id, args) {
                var that = this,
                    gridRowSelectingEventArgs = new dsgnrCommons.eventArgs.GridRowSelectingEventArgs();
                _initCommonsEventArgs(gridRowSelectingEventArgs, id, this);
                gridRowSelectingEventArgs.rowData = args.rowData;
                gridRowSelectingEventArgs.rowIndex = args.rowIndex;
                gridRowSelectingEventArgs.nameEntityGrid = args.nameEntityGrid;

                // call to client event
                dsgnrCustomEvents.gridRowSelecting(this.vcEvents, this.model, gridRowSelectingEventArgs);
                if (this.serverEvents && gridRowSelectingEventArgs.commons.execServer) {
                    this.execute(_event.GridRowSelecting, id, this.model, function (response) {
                        that.processResponse(response, gridRowSelectingEventArgs);

                        // 2.- Execute "GridRowSelectingCallback" event
                        var gridRowSelectingCallbackEventArgs = new dsgnrCommons.eventArgs.GridRowSelectingCallbackEventArgs();
                        _initCommonsEventArgs(gridRowSelectingCallbackEventArgs, id, that);
                        gridRowSelectingCallbackEventArgs.success = response.success;
                        gridRowSelectingCallbackEventArgs.rowData = args.rowData;
                        gridRowSelectingCallbackEventArgs.rowIndex = args.rowIndex;
                        gridRowSelectingCallbackEventArgs.nameEntityGrid = args.nameEntityGrid;
                        dsgnrCustomEvents.gridRowSelectingCallback(that.vcEvents, that.model, gridRowSelectingCallbackEventArgs);
                    }, args, gridRowSelectingEventArgs);
                }
            }

            function _showGridRowDetailIcon(id, args) {
                var gridRowDetailIconEventArgs = new dsgnrCommons.eventArgs.GridRowSelectingEventArgs();
                _initCommonsEventArgs(gridRowDetailIconEventArgs, id, this);
                gridRowDetailIconEventArgs.rowData = args.rowData;
                gridRowDetailIconEventArgs.rowIndex = args.rowIndex;
                gridRowDetailIconEventArgs.nameEntityGrid = args.nameEntityGrid;
                //call to client event
                return dsgnrCustomEvents.showGridRowDetailIcon(this.vcEvents, this.model, gridRowDetailIconEventArgs);
            }


            function _gridInitDetailTemplate(id, args) {
                var gridInitDetailTemplateArgs = new dsgnrCommons.eventArgs.GridInitDetailTemplateArgs();
                _initCommonsEventArgs(gridInitDetailTemplateArgs, id, this);
                gridInitDetailTemplateArgs.modelRow = args.modelRow;

                // call to client event
                dsgnrCustomEvents.gridInitDetailTemplate(this.vcEvents, this.model, gridInitDetailTemplateArgs);
            }

            function _gridInitColumnTemplate(idGrid, idColumn, templateBase) {
                var gridInitColumnTemplateEventArgs = new dsgnrCommons.eventArgs.GridInitColumnTemplateArgs();
                _initCommonsEventArgs(gridInitColumnTemplateEventArgs, idGrid, this);
                gridInitColumnTemplateEventArgs.parameters = {};
                gridInitColumnTemplateEventArgs.parameters.templateBase = templateBase;
                return dsgnrCustomEvents.gridInitColumnTemplate(this.vcEvents, idGrid, idColumn, gridInitColumnTemplateEventArgs);
            }

            function _gridInitEditColumnTemplate(idGrid, idColumn, baseTemplate) {
                var columnTemplate = dsgnrCustomEvents.gridInitEditColumnTemplate(this.vcEvents, idGrid, idColumn);
                if (angular.isUndefined(columnTemplate)) {
                    return baseTemplate;
                }
                return columnTemplate;
            }

            function _changeGridColumnWidth(idGrid, columnIndex, width) {
                var gridHeader, gridContent, pattern, column;
                pattern = "#" + idGrid + " .k-grid-header";
                gridHeader = $(pattern);
                if (angular.isDefined(gridHeader)) {
                    pattern = "#" + idGrid + " .k-grid-content";
                    gridContent = $(pattern);
                    if (angular.isDefined(gridContent)) {
                        column = gridHeader.find('colgroup col');
                        if (angular.isDefined(column) && angular.isDefined(column[columnIndex])) {
                            column = gridContent.find('colgroup col');
                            column[columnIndex].style.width = width;
                        }
                    }
                }
            }

            function _executeGridRowCommand(id, args) {
                var that = this,
                    gridRowCommandEventArgs = new dsgnrCommons.eventArgs.GridRowCommandEventArgs();
                _initCommonsEventArgs(gridRowCommandEventArgs, id, this);
                gridRowCommandEventArgs.rowData = args.rowData;
                gridRowCommandEventArgs.rowIndex = args.rowIndex;
                gridRowCommandEventArgs.key = null;
                gridRowCommandEventArgs.nameEntityGrid = args.nameEntityGrid;
                gridRowCommandEventArgs.refreshData = args.refreshData;
                gridRowCommandEventArgs.stopPropagation = args.stopPropagation;

                // call to client event
                dsgnrCustomEvents.gridRowCommand(that.vcEvents, that.model, gridRowCommandEventArgs).done(function () {
                    args.refreshData = gridRowCommandEventArgs.refreshData;
                    args.stopPropagation = gridRowCommandEventArgs.stopPropagation;

                    if (angular.isDefined(args.commandName) && args.commandName === 'DSG_UPLOAD_FILE_') {
                        gridRowCommandEventArgs.commons.api.fileUpload = gridRowCommandEventArgs.commons.api.fileUpload(id, gridRowCommandEventArgs, null, null, _event.ExecuteGridRowCommand, args, gridRowCommandEventArgs.commons.execServer);
                        gridRowCommandEventArgs.commons.execServer = false;
                    }

                    if (that.serverEvents && gridRowCommandEventArgs.commons.execServer) {
                        _executeEventInGrid(_event.ExecuteGridRowCommand, id, that.model, gridRowCommandEventArgs, args, that);
                    }
                });
            }

            // function executeGridCommand
            function _executeGridCommand(id, nameEntityGrid) {
                var that = this;
                var gridExecuteCommandEventArgs = new dsgnrCommons.eventArgs.GridExecuteCommandEventArgs();
                _initCommonsEventArgs(gridExecuteCommandEventArgs, id, this);
                gridExecuteCommandEventArgs.nameEntityGrid = nameEntityGrid;
                return dsgnrCustomEvents.gridCommand(that.vcEvents, that.model, gridExecuteCommandEventArgs).done(function () {
                    if (that.serverEvents && gridExecuteCommandEventArgs.commons.execServer) {
                        // TODO: validar si es necesario refrescar datos
                        var args = {
                            nameEntityGrid: nameEntityGrid
                        };
                        that.execute(_event.ExecuteGridCommand, id, that.model, function (response) {
                            that.processResponse(response, gridExecuteCommandEventArgs);
                            var gridCommandCallbackEventArgs = new dsgnrCommons.eventArgs.GridCommandCallbackEventArgs();
                            _initCommonsEventArgs(gridCommandCallbackEventArgs, id, that);
                            gridCommandCallbackEventArgs.success = response.success;
                            dsgnrCustomEvents.gridCommandCallback(that.vcEvents, that.model, gridCommandCallbackEventArgs);
                        }, args, gridExecuteCommandEventArgs);
                    }
                });
            }

            // this function is used for the following events:
            // gridRowInserting, gridRowUpdating, gridRowdeleting
            function _gridRowAction(id, eventName, args, callback) { // id is the
                // queryViewId
                var that = this,
                    response = null,
                    gridRowActionEventArgs = new dsgnrCommons.eventArgs.GridRowActionEventArgs();
                //console.log("_gridRowAction for " + id);
                _initCommonsEventArgs(gridRowActionEventArgs, id, this);

                var promise = _createPromise(response);

                if (promise) {
                    promise.then(
                        function (response) {
                            gridRowActionEventArgs.rowData = args.rowData;
                            gridRowActionEventArgs.nameEntityGrid = args.nameEntityGrid;

                            if (eventName == dsgnrCommons.constants.event.GridRowInserting) {
                                return dsgnrCustomEvents.gridRowInserting(that.vcEvents, that.model, gridRowActionEventArgs);

                            } else if (eventName == dsgnrCommons.constants.event.GridRowUpdating) {
                                return dsgnrCustomEvents.gridRowUpdating(that.vcEvents, that.model, gridRowActionEventArgs);

                            } else if (eventName == dsgnrCommons.constants.event.GridRowDeleting) {
                                return dsgnrCustomEvents.gridRowDeleting(that.vcEvents, that.model, gridRowActionEventArgs);
                            }
                        }
                    ).then(function () {
                        args.rowData = gridRowActionEventArgs.rowData;
                        args.cancel = gridRowActionEventArgs.cancel;
                        if (that.serverEvents && gridRowActionEventArgs.commons.execServer) {
                            that.execute(eventName, id, that.model, function (response) {
                                that.processResponse(response, gridRowActionEventArgs);
                                args.rowData = response.args.rowData;
                                args.cancel = response.args.cancel;
                                args.messages = response.messages;
                                args.success = response.success;
                                callback();

                                // 2. Execute "GridRowInsertingCallback" event
                                var gridRowActionCallbackEventArgs = new dsgnrCommons.eventArgs.GridRowActionCallbackEventArgs();
                                _initCommonsEventArgs(gridRowActionCallbackEventArgs, id, that);
                                gridRowActionCallbackEventArgs.success = response.success;
                                gridRowActionCallbackEventArgs.rowData = args.rowData;
                                gridRowActionCallbackEventArgs.success = args.success;
                                gridRowActionCallbackEventArgs.cancel = args.cancel;
                                gridRowActionCallbackEventArgs.messages = args.messages;

                                if (eventName == dsgnrCommons.constants.event.GridRowInserting) {
                                    dsgnrCustomEvents.gridRowInsertingCallback(that.vcEvents, that.model, gridRowActionCallbackEventArgs);
                                } else if (eventName == dsgnrCommons.constants.event.GridRowUpdating) {
                                    dsgnrCustomEvents.gridRowUpdatingCallback(that.vcEvents, that.model, gridRowActionCallbackEventArgs);
                                } else if (eventName == dsgnrCommons.constants.event.GridRowDeleting) {
                                    dsgnrCustomEvents.gridRowDeletingCallback(that.vcEvents, that.model, gridRowActionCallbackEventArgs);
                                }
                            }, args, gridRowActionEventArgs);
                        } else {
                            callback();
                        }
                    });
                }
            }

            // function gridBeforeEnterInLineRow
            function _gridBeforeEnterInLineRow(id, args, callback) {
                var gridBeforeEnterInLineRowEventArgs = new dsgnrCommons.eventArgs.GridBeforeEnterInLineRowEventArgs();
                _initCommonsEventArgs(gridBeforeEnterInLineRowEventArgs, id, this);
                gridBeforeEnterInLineRowEventArgs.inlineWorkMode = args.inlineWorkMode;
                gridBeforeEnterInLineRowEventArgs.nameEntityGrid = args.nameEntityGrid;
                gridBeforeEnterInLineRowEventArgs.rowData = args.rowData;

                dsgnrCustomEvents.gridBeforeEnterInLineRow(this.vcEvents, this.model, gridBeforeEnterInLineRowEventArgs);
                args.cancel = gridBeforeEnterInLineRowEventArgs.cancel;
                var serverArg = {
                    gridInlineWorkMode: args.inlineWorkMode,
                    rowData: args.rowData
                };

                // call to event in server
                if (this.serverEvents && gridBeforeEnterInLineRowEventArgs.commons.execServer) {
                    this.execute(_event.GridBeforeEnterInLineRow, id, this.model, function (response) {
                        if (response.args != null) {
                            for (var attributeName in response.args.rowData) {
                                if (attributeName !== "uid" && attributeName !== "dirty" && attributeName.substring(0, 4) !== "org_") {
                                    args.rowData.set(attributeName, response.args.rowData[attributeName]);
                                }
                            }
                        }
                        args.cancel = response.args.cancel;
                        _showResultMessages(null, true, response.messages, false, this);
                        callback();
                    }, serverArg, gridBeforeEnterInLineRowEventArgs);
                } else {
                    callback();
                }
            }

            // function gridAfterLeaveInLineRow
            function _gridAfterLeaveInLineRow(id, args) {
                var that = this;

                var gridAfterLeaveInLineRowEventArgs = new dsgnrCommons.eventArgs.GridAfterLeaveInLineRowEventArgs();
                _initCommonsEventArgs(gridAfterLeaveInLineRowEventArgs, id, this);
                gridAfterLeaveInLineRowEventArgs.inlineWorkMode = args.inlineWorkMode;
                gridAfterLeaveInLineRowEventArgs.nameEntityGrid = args.nameEntityGrid;

                dsgnrCustomEvents.gridAfterLeaveInLineRow(this.vcEvents, this.model, gridAfterLeaveInLineRowEventArgs);
                args.cancel = gridAfterLeaveInLineRowEventArgs.cancel;

                // call to event in server
                if (this.serverEvents && gridAfterLeaveInLineRowEventArgs.commons.execServer) {
                    this.execute(_event.GridAfterLeaveInLineRow, id, this.model, function (response) {
                        that.processResponse(response, gridAfterLeaveInLineRowEventArgs);
                    }, gridAfterLeaveInLineRowEventArgs);
                }
            }

            // Function Render
            // Receive the id of the viewContainer
            function _render(id) {
                var renderEventArgs = new dsgnrCommons.eventArgs.RenderEventArgs();
                _initCommonsEventArgs(renderEventArgs, id, this);

                // this event has only client implementation
                dsgnrCustomEvents.render(this.vcEvents, this.model, renderEventArgs);
            }

            // metodo para capturar el valor actual de los controles que tienen evento
            // changed
            function _focus(event, controlId, rowData, attributeName) {
                // this.currentValues[controlId] = event.currentTarget?
                // event.currentTarget.value : event.sender._selectedValue;
                if (rowData) {
                    this.focusValue = rowData[attributeName];
                } else {
                    var model = $('#' + controlId).attr('ng-model');
                    var getter = $parse(model.substring(3));
                    this.focusValue = getter(this);
                }
            }

            /**
             * Ejecuta el evento change de un VisualAttribute que esta en la cabecera
             * (no en una grilla)
             *
             * @method change2
             * @param {String}
             *            id Identificador del control
             * @param {Object}
             *            valor nuevo del atributo
             * @param {Object}
             *            valor anterior del atributo
             */
            function _change2(controlId, newValue, oldValue, isValid) {
                var that = this;
                var changedEventArgs = new dsgnrCommons.eventArgs.ChangedEventArgs();
                _initCommonsEventArgs(changedEventArgs, controlId, this);
                changedEventArgs.newValue = newValue;
                changedEventArgs.oldValue = oldValue;
                changedEventArgs.isValid = isValid;
                dsgnrCustomEvents.change(this.vcEvents, this.model, changedEventArgs);

                if (this.serverEvents && changedEventArgs.commons.execServer) {
                    var args = {
                        newValue: changedEventArgs.newValue,
                        oldValue: changedEventArgs.oldValue
                    };
                    this.execute(_event.Change, controlId, this.model, function (response) {
                        // 1. Execute response from server
                        that.processResponse(response, changedEventArgs);

                        // 2. Execute "changeCallback" event
                        var changeCallbackEventArgs = new dsgnrCommons.eventArgs.ChangeCallbackEventArgs();
                        _initCommonsEventArgs(changeCallbackEventArgs, controlId, that);
                        changeCallbackEventArgs.success = response.success;
                        changeCallbackEventArgs.oldValue = oldValue;
                        changeCallbackEventArgs.newValue = newValue;

                        dsgnrCustomEvents.changeCallback(that.vcEvents, that.model, changeCallbackEventArgs);

                        if (response.data.focus) {
                            _focusControl(controlId);
                        }
                    }, args, changedEventArgs);
                } else {
                    if (changedEventArgs.focus) {
                        _focusControl(controlId);
                    }
                }
            }

            function _change(event, controlId, rowData, attributeName, chkControl) {
                var that = this, newValue;
                var changedEventArgs = new dsgnrCommons.eventArgs.ChangedEventArgs();
                _initCommonsEventArgs(changedEventArgs, controlId.replace(/-.*/, ""), this);
                if (event) {
                    if (rowData) {
                        newValue = rowData[attributeName];
                    } else {
                        newValue = $parse($('#' + controlId).attr('ng-model').substring(3))(this);
                    }
                    // Si el valor ingresado es incorrecto (combobox) no debe lanzarse
                    // el change
                    var validator = $("#validator").data("kendoValidator");
                    var isValid = false;
                    if (angular.isDefined(validator) && validator !== null && validator.validateInput($("#" + controlId))) {
                        isValid = true;
                    }
                    if (!isValid && !that.vcEvents.changeWithError[controlId] && !that.vcEvents.changeWithError.allGrid) return;
                    if (event.sender && event.sender.selectedIndex == -1) return;
                    // If the values are different the change event is raised else no.
                    if ((_vc[this.idUid].focusValue !== newValue) || that.vcEvents.changeWithError[controlId] || that.vcEvents.changeWithError.allGrid) {
                        changedEventArgs.oldValue = _vc[this.idUid].focusValue;
                        changedEventArgs.newValue = newValue;
                        changedEventArgs.isValid = isValid;
                        if (rowData) {
                            changedEventArgs.rowData = rowData;
                        }

                        dsgnrCustomEvents.change(this.vcEvents, this.model, changedEventArgs);

                        var args = {
                            oldValue: changedEventArgs.oldValue,
                            newValue: changedEventArgs.newValue,
                            rowData: changedEventArgs.rowData
                        };

                        if (this.serverEvents && changedEventArgs.commons.execServer) {
                            this.execute(_event.Change, controlId.replace(/-.*/, ""), this.model, function (response) {
                                // 1. Execute response from server
                                that.processResponse(response, changedEventArgs);
                                // 2. UpdateRowData
                                if (response.args != null) {
                                    for (var attributeName in response.args.rowData) {
                                        if (attributeName !== "uid" && attributeName !== "dirty" && attributeName.substring(0, 4) !== "org_") {
                                            rowData.set(attributeName, response.args.rowData[attributeName]);
                                        }
                                    }
                                }
                                // 3. Execute "changeCallback" event
                                var changeCallbackEventArgs = new dsgnrCommons.eventArgs.ChangeCallbackEventArgs();
                                _initCommonsEventArgs(changeCallbackEventArgs, controlId, that);
                                changeCallbackEventArgs.success = response.success;
                                changeCallbackEventArgs.oldValue = changedEventArgs.oldValue;
                                changeCallbackEventArgs.newValue = response.args.rowData;
                                changeCallbackEventArgs.rowData = rowData;

                                dsgnrCustomEvents.changeCallback(that.vcEvents, that.model, changeCallbackEventArgs);

                                if (response.data.focus) {
                                    _focusControl(controlId);
                                }
                            }, args, changedEventArgs);
                        } else {
                            if (changedEventArgs.focus) {
                                _focusControl(controlId);
                            }
                        }
                    }
                } else { // check box control
                    if ($(chkControl).attr("ng-true-value")) {
                        changedEventArgs.oldValue = (rowData) ? rowData[attributeName] : $parse($('#' + controlId).attr('ng-model').substring(3))(this);
                        var trueValue = $(chkControl).attr("ng-true-value");
                        var falseValue = $(chkControl).attr("ng-false-value");
                        changedEventArgs.newValue = (chkControl.checked) ? trueValue : falseValue;
                    } else {
                        changedEventArgs.newValue = chkControl.checked;
                        changedEventArgs.oldValue = !changedEventArgs.newValue;
                    }
                    if (rowData) {
                        changedEventArgs.rowData = rowData;
                    }
                    dsgnrCustomEvents.change(this.vcEvents, this.model, changedEventArgs);

                    var dataToServer = {
                        oldValue: changedEventArgs.oldValue,
                        newValue: changedEventArgs.newValue,
                        rowData: changedEventArgs.rowData,
                        model: this.model
                    };

                    if (this.serverEvents && changedEventArgs.commons.execServer) {
                        this.execute(_event.Change, controlId, dataToServer, function (response) {
                            // 1. Execute response from server
                            that.processResponse(response, changedEventArgs);
                            // 2. UpdateRowData
                            if (response.args != null) {
                                for (var attributeName in response.args.rowData) {
                                    if (attributeName !== "uid" && attributeName !== "dirty" && attributeName.substring(0, 4) !== "org_") {
                                        rowData.set(attributeName, response.args.rowData[attributeName]);
                                    }
                                }
                            }
                            // 3. Execute "changeCallback" event
                            var changeCallbackEventArgs = new dsgnrCommons.eventArgs.ChangeCallbackEventArgs();
                            _initCommonsEventArgs(changeCallbackEventArgs, controlId, that);
                            changeCallbackEventArgs.success = response.success;
                            changeCallbackEventArgs.oldValue = changedEventArgs.oldValue;
                            changeCallbackEventArgs.newValue = response.args.rowData;
                            changeCallbackEventArgs.rowData = rowData;

                            dsgnrCustomEvents.changeCallback(that.vcEvents, that.model, changeCallbackEventArgs);

                            if (response.data.focus) {
                                _focusControl(controlId);
                            }
                        }, changedEventArgs);
                    } else {
                        if (changedEventArgs.focus) {
                            _focusControl(controlId);
                        }
                    }
                }
            }

            function _validateTransaction(controller, controlId, validator, flgVld, flgValidationEvent, viewContainerId) {
                var that = controller;
                var validate = false;
                var response = {
                    success: false
                };

                if (flgVld && validator) {
                    that.submitted[validator.element.attr("id")] = true;
                    validateDateTimePicker();

                    if (!validator.validate()) {
                        if (_focusError(validator)) {
                            return validate;
                        }
                    }
                }

                if (flgVld && flgValidationEvent) {
                    var validateTransactionEventArgs = new dsgnrCommons.eventArgs.ValidateTransactionEventArgs();
                    _initCommonsEventArgs(validateTransactionEventArgs, viewContainerId, that);

                    validate = dsgnrCustomEvents.validateCustomTransaction(that.vcEvents, that.model, validateTransactionEventArgs);

                    if (that.serverEvents && validateTransactionEventArgs.commons.execServer) {
                        return that.executeService(_event.ValidateTransaction, viewContainerId, that.model).then(
                            function (responseServer) {
                                if (responseServer.success && angular.isDefined(responseServer.data.validate) && responseServer.data.validate) {
                                    response.success = true;
                                } else {
                                    _showResultMessages(null, false, responseServer.messages, false, this);
                                    response.success = false;
                                }
                                return response;
                            }
                        );
                    } else {
                        response.success = validate;
                        return response;
                    }
                } else {
                    response.success = true;
                    return response;
                }

            }

            function _createPromise(response) {
                var deferrer = $q.defer();
                setTimeout(function () {
                    deferrer.resolve(response);
                }, 0);
                return deferrer.promise;
            }

            function _executeEvent(event, controlId, model, eventArgs, flgClose, that) {
                that.execute(event, controlId, model, function (response) {
                    // 1. Refresh model with response data
                    that.processResponse(response, eventArgs);
                    // 2. Execute "executeCommandCallback" event
                    var executeCommandCallbackEventArgs = new dsgnrCommons.eventArgs.ExecuteCommandCallbackEventArgs();
                    _initCommonsEventArgs(executeCommandCallbackEventArgs, controlId, that);
                    executeCommandCallbackEventArgs.success = response.success;
                    dsgnrCustomEvents.executeCommandCallback(that.vcEvents, model, executeCommandCallbackEventArgs);
                    if (response.success) {
                        // 3. Try to close ViewContainer
                        that.closeViewContainer(flgClose);
                    }
                }, eventArgs);
            }

            function _executeEventInGrid(event, controlId, model, eventArgs, args, that) {
                that.execute(event, controlId, model, function (response) {
                    that.processResponse(response, eventArgs);
                    // 2. Execute "GridRowCommandCallback" event
                    var gridRowCommandCallbackEventArgs = new dsgnrCommons.eventArgs.GridRowCommandCallbackEventArgs();
                    _initCommonsEventArgs(gridRowCommandCallbackEventArgs, controlId, that);
                    gridRowCommandCallbackEventArgs.rowData = args.rowData;
                    gridRowCommandCallbackEventArgs.rowIndex = args.rowIndex;
                    gridRowCommandCallbackEventArgs.nameEntityGrid = args.nameEntityGrid;
                    gridRowCommandCallbackEventArgs.success = response.success;
                    dsgnrCustomEvents.gridRowCommandCallback(that.vcEvents, that.model, gridRowCommandCallbackEventArgs);
                }, args, eventArgs);
            }

            function _executeCommand(controlId, commandName, validator, flgVld, flgValidationEvent, viewContainerId, flgClose) {
                var response = null,
                    that = this,
                    executeCommandEventArgs = null,
                    promise = _createPromise(response),
                    respValidation = null;
                console.log("_execCommand for " + controlId);

                // Si el comando define no validar y cierra la pagina actual, es tipo
                // CANCEL
                if (!flgVld && flgClose && this.parentVc) {
                    this.closeViewContainer(flgClose, true);
                    return;
                }

                executeCommandEventArgs = new dsgnrCommons.eventArgs.ExecuteCommandEventArgs();
                _initCommonsEventArgs(executeCommandEventArgs, controlId, that);
                executeCommandEventArgs.eventName = _event.ExecuteCommand;
                executeCommandEventArgs.commandName = commandName;

                if (promise) {
                    promise.then(
                        function () {
                            if (flgVld === true || flgValidationEvent === true) {
                                respValidation = _validateTransaction(that, controlId, validator, flgVld, flgValidationEvent, viewContainerId);
                                if (respValidation.success === true) {
                                    return dsgnrCustomEvents.executeCustomCommand(that.vcEvents, that.model, executeCommandEventArgs);
                                } else {
                                    return respValidation;
                                }
                            } else {
                                return dsgnrCustomEvents.executeCustomCommand(that.vcEvents, that.model, executeCommandEventArgs);
                            }
                        }
                    ).then(function (response) {
                        if (commandName === 'DSG_UPLOAD_FILE_') {
                            if (angular.isUndefined(that.vcEvents.executeCommand[controlId])) {
                                executeCommandEventArgs.commons.execServer = false;
                                executeCommandEventArgs.commons.api.fileUpload = executeCommandEventArgs.commons.api.fileUpload(controlId, executeCommandEventArgs, flgClose, that, _event.ExecuteCommand, null, executeCommandEventArgs.commons.execServer);
                            } else {
                                //Se pone false porque no funciona con true y la personalizacion de servidor es con los eventos de uploadFile
                                executeCommandEventArgs.commons.api.fileUpload = executeCommandEventArgs.commons.api.fileUpload(controlId, executeCommandEventArgs, flgClose, that, _event.ExecuteCommand, null, executeCommandEventArgs.commons.execServer);
                            }
                        }
                        if (that.serverEvents && executeCommandEventArgs.commons.execServer && response) {
                            _executeEvent(_event.ExecuteCommand, controlId, that.model, executeCommandEventArgs, flgClose, that);
                        } else {
                            that.closeViewContainer(flgClose);
                        }
                    });
                }
            }

            function _executeLabelCommand(controlId, commandName) {
                var response = null;
                var that = this;
                console.log("_execLabelCommand for " + controlId);
                var promise = _createPromise(response);
                if (promise) {
                    promise.then(
                        function (response) {
                            var executeCommandEventArgs = new dsgnrCommons.eventArgs.ExecuteCommandEventArgs();
                            _initCommonsEventArgs(executeCommandEventArgs, controlId, that);
                            executeCommandEventArgs.eventName = _event.ExecuteLabelCommand;
                            executeCommandEventArgs.commandName = commandName;

                            dsgnrCustomEvents.executeCustomCommand(that.vcEvents, that.model, executeCommandEventArgs);
                        });
                }
            }

            function _clickTextInputButton(controlId) {
                var eventArgs = new dsgnrCommons.eventArgs.TextInputButtonEventArgs();
                _initCommonsEventArgs(eventArgs, controlId, this);
                eventArgs.model = this.model;
                dsgnrCustomEvents.textInputButtonEvent(this.vcEvents, this, eventArgs);
            }

            function _clickTextInputButtonGrid(controlId, modelRow) {
                var eventArgs = new dsgnrCommons.eventArgs.TextInputButtonGridEventArgs();
                _initCommonsEventArgs(eventArgs, controlId, this);
                eventArgs.modelRow = modelRow;
                dsgnrCustomEvents.textInputButtonEventGrid(this.vcEvents, this, eventArgs);
            }

            function _afterCloseModal(controlId, vcId, modalResult) {
                var eventArgs = new dsgnrCommons.eventArgs.TextInputButtonCloseModalEventArgs();
                _initCommonsEventArgs(eventArgs, controlId, this);
                eventArgs.model = this.model;
                eventArgs.vcId = vcId;
                eventArgs.modalResult = modalResult;
                dsgnrCustomEvents.textInputButtonCloseModalEvent(this.vcEvents, eventArgs);

                // -----

                eventArgs = new dsgnrCommons.eventArgs.CloseModalEventArgs();
                _initCommonsEventArgs(eventArgs, controlId, this);
                eventArgs.vcId = vcId;
                eventArgs.model = this.model;
                // eventArgs.parentModel=this.parentVc.model;
                eventArgs.result = modalResult;
                dsgnrCustomEvents.closeModalEvent(this.vcEvents, eventArgs);
            }

            function _afterCloseModalGrid(controlId, vcId, modelRow, modalResult) {
                var control = $('#' + controlId), grid = control.data("kendoGrid");
                if (grid) {
                    eventArgs = new dsgnrCommons.eventArgs.CloseModalEventArgs();
                    _initCommonsEventArgs(eventArgs, controlId, this);
                    eventArgs.vcId = vcId;
                    eventArgs.model = modelRow;
                    eventArgs.result = modalResult;
                    var gridArgs = eventArgs.commons.api.grid,
                        idx;
                    if (this.dialogParameters && this.dialogParameters.isModal) {
                        idx = this.dialogParameters.rowIndex;
                        this.dialogParameters.isModal = false;
                    } else {
                        idx = grid.dataSource.indexOf(modelRow);
                    }
                    var entity = (control.attr("k-data-source")).substring(9);
                    if (angular.isDefined(modalResult.model)) {
                        if (idx === -1) {

                            gridArgs.addRow(entity, modalResult.model[entity]);
                        } else {
                            gridArgs.updateRow(entity, idx, modalResult.model[entity]);
                        }
                    }
                    dsgnrCustomEvents.closeModalEvent(this.vcEvents, eventArgs);
                } else {
                    var eventArgs = new dsgnrCommons.eventArgs.TextInputButtonCloseModalEventArgs();
                    _initCommonsEventArgs(eventArgs, controlId, this);
                    eventArgs.modelRow = modelRow;
                    eventArgs.vcId = vcId;
                    eventArgs.modalResult = modalResult;
                    dsgnrCustomEvents.textInputButtonCloseModalEventGrid(this.vcEvents, eventArgs);
                }
            }

            function _closeModal(result) {
                if (angular.isDefined(this.parentVc)) {
                    var modalInstances = this.parentVc.modalInstances;
                    if (angular.isDefined(modalInstances) && angular.isDefined(modalInstances[this.id])) {
                        this.closeDialog();
                        if (result.dialogCloseResult === undefined) {
                            result.dialogCloseType = dsgnrCommons.constants.dialogCloseType.Interactive;
                        }
                        modalInstances[this.id].close(result);
                    } else if (angular.isDefined(this.autoSyncNavigation) && (this.autoSyncNavigation === false)) {
                        this.accept(null, null, false, this.id);
                    }
                }
            }

            function _handlerCloseModal(data) {
                var that = this;
                var controlId = data.controlId,
                    viewContainerId = data.viewContainerId,
                    modelRow = data.modelRow,
                    resultModal = data.resultModal,
                    callFromGrid = data.callFromGrid;
                var closeModalEventArgs = new dsgnrCommons.eventArgs.CloseModalEventArgs();
                _initCommonsEventArgs(closeModalEventArgs, controlId, this);
                closeModalEventArgs.vcId = this.id;
                closeModalEventArgs.closedViewContainerId = viewContainerId;
                closeModalEventArgs.dialogCloseResult = resultModal.dialogCloseResult;
                closeModalEventArgs.dialogCloseType = resultModal.dialogCloseType;
                closeModalEventArgs.result = resultModal;
                if (this.hasOnCloseModalEvent) {
                    dsgnrCustomEvents.onCloseModalEvent(this.vcEvents, this.model, closeModalEventArgs);
                    if (that.serverEvents && closeModalEventArgs.commons.execServer) {
                        that.execute(_event.OnCloseModalEvent, closeModalEventArgs.vcId, that.model, function (response) {
                            // 1. Refresh model with response data
                            that.processResponse(response, closeModalEventArgs);
                            // 2. Excute callback
                            var closeModalCallbackEventArgs = new dsgnrCommons.eventArgs.CloseModalCallbackEventArgs();
                            _initCommonsEventArgs(closeModalCallbackEventArgs, controlId, that);
                            closeModalCallbackEventArgs.success = response.success;
                            closeModalCallbackEventArgs.vcId = that.id;
                            closeModalCallbackEventArgs.closedViewContainerId = viewContainerId;
                            closeModalCallbackEventArgs.dialogCloseResult = resultModal.dialogCloseResult;
                            closeModalCallbackEventArgs.dialogCloseType = resultModal.dialogCloseType;
                            closeModalCallbackEventArgs.result = resultModal;
                            dsgnrCustomEvents.onCloseModalEventCallback(that.vcEvents, that.model, closeModalCallbackEventArgs);
                            if (resultModal.dialogCloseResult !== dsgnrCommons.constants.dialogCloseResult.Cancel) {
                                if (callFromGrid) {
                                    that.afterCloseModalGrid(controlId, viewContainerId, modelRow, resultModal);
                                } else {
                                    that.afterCloseModal(controlId, viewContainerId, resultModal);
                                }
                            }

                        }, closeModalEventArgs);
                    } else {
                        if (resultModal.dialogCloseResult !== dsgnrCommons.constants.dialogCloseResult.Cancel) {
                            if (callFromGrid) {
                                that.afterCloseModalGrid(controlId, viewContainerId, modelRow, resultModal);
                            } else {
                                that.afterCloseModal(controlId, viewContainerId, resultModal);
                            }
                        }
                    }
                } else {
                    //backwards compatibility. If the form has not onCloseModalEvent, probably has the events afterCloseModalGrid, afterCloseModal
                    if (resultModal.dialogCloseResult !== dsgnrCommons.constants.dialogCloseResult.Cancel) {
                        if (callFromGrid) {
                            that.afterCloseModalGrid(controlId, viewContainerId, modelRow, resultModal);
                        } else {
                            that.afterCloseModal(controlId, viewContainerId, resultModal);
                        }
                    }
                }
            }
			
			function _isColumnOfButton(element){
                var row = $(element).closest("tr"), colIdx = $("td", row).index(element), className = row.find("td")[colIdx].className;
                return (className.indexOf("btn-toolbar") > -1);
            }

            /**
             * Permite verificar si la actual ViewContainer esta abierta en una ventana
             * modal
             *
             * @method isModal
             * @for designer
             * @param scope
             */
            function _isModal(scope) {
                if (angular.isDefined(scope)) {
                    return typeof scope.$close === 'function';
                } else if (angular.isDefined(this.parentVc) &&
                    angular.isDefined(this.parentVc.modalInstances) &&
                    angular.isDefined(this.parentVc.modalInstances[this.id])) {
                    return true;
                }
                return false;
            }

            function _isDetailGrid(scope) {
                if (angular.isDefined(scope)) {
                    if (_isModal(scope)) {
                        return false;
                    } else if (scope.isDesignerDetail === true) {
                        return true;
                    }
                }
                return false;
            }

            function _accept(validator, e, flgValidationEvent, viewContainerId) {
                var response = null;
                var that = this;
                var promise = _createPromise(response);

                if (promise) {
                    promise.then(function () {
                        return _validateTransaction(that, '', validator, true, flgValidationEvent, viewContainerId);
                    }).then(function (response) {
                        if (response.success) {
                            that.beforeCloseGridDialog(dsgnrCommons.constants.dialogCloseResult.Accept, dsgnrCommons.constants.dialogCloseType.Interactive);
                            that.closeViewContainer(true);
                        }
                    });
                }
            }

            function _cancel(validator, e) {
                this.beforeCloseGridDialog(dsgnrCommons.constants.dialogCloseResult.Cancel, dsgnrCommons.constants.dialogCloseType.Interactive);
                this.closeViewContainer(true, true);
            }

            // renombra la columna id por id_ en el caso de ser usada en un grid
            function _renameIdAttribute(objArray) {
                if (objArray != null && objArray.length > 0 && objArray[0]["id"]) {
                    for (var n = 0; n < objArray.length; n++) {
                        objArray[n]["id_"] = objArray[n]["id"];
                        delete objArray[n]["id"];
                    }
                }
            }

            function _processResponse(response, eventArgs) {
                var hasData = false;
                for (var key in response.data) {
                    if (this.model[key]) {
                        if (this.model[key] instanceof kendo.data.DataSource) { // grid
                            if (response.data[key].length > 0) {
                                _processDataSourceResponse(key, response.data[key], eventArgs, this.model[key]);
                                hasData = true;
                            }
                        } else if (this.model[key] instanceof kendo.data.ObservableArray) { // combos
                            this.model[key].splice(0, this.model[key].length);
                            if (response.data[key].length > 0) {
                                for (var i in response.data[key]) {
                                    this.model[key].push(response.data[key][i]);
                                    hasData = true;
                                }
                            }
                        } else {
                            this.model[key] = response.data[key];
                            hasData = true;
                        }
                    }
                }
                if (response.success) {
                    _showResultMessages(null, true, response.messages, false, this);
                } else {
                    _showResultMessages(null, false, response.messages, false, this);
                }
                return hasData;
            }

            /**
             * Define el atributo dsgnrId para evitar que se ejecute el evento "create" del "transport"
             * al ejecutar la funcion sync(). Ademas elimina los atributos _new, _updated y _removed
             * para que los datos sean manejados los datos actuales (sin cambios).
             *
             */
            function _resetData(data) {
                if (angular.isDefined(data) && data !== null && angular.isArray(data)) {
                    return data.map(function (row) {
                        row.dsgnrId = dsgnrCommons.utils.uuid();
                        delete row._new;
                        delete row._updated;
                        delete row._removed;
                        return row;
                    });
                }
                return data;
            }

            function _processDataSourceResponse(entityName, responseDataList, eventArgs, model) {
                if (responseDataList[0]._reset === true) {
                    responseDataList = _getDesignerData(responseDataList);
                    model.data(responseDataList);
                    model.sync();
                } else {
                    var grid = eventArgs.commons.api.grid;
                    for (var i = 0; i < responseDataList.length; i++) {
                        var row = responseDataList[i];
                        if (row._new) {
                            delete row._new;
                            delete row._updated;
                            delete row._removed;
                            grid.addRow(entityName, row);
                        } else if (row._updated) {
                            delete row._new;
                            delete row._updated;
                            delete row._removed;
                            grid.updateRowByDsgnrId(entityName, row);
                        } else if (row._removed) {
                            delete row._new;
                            delete row._updated;
                            delete row._removed;
                            grid.removeRowByDsgnrId(entityName, row);
                        } else if (row._reset) {
                            grid.removeAllRows(entityName);
                        }
                    }
                }
            }

            function _getDesignerData(responseDataList) {
                responseDataList.splice(0, 1);
                return _resetData(responseDataList);
            }

            function _processTemporaryResponse(response) {
                var hasData = false;
                var dataResult, newTrackers;

                if (response.success) {
                    dataResult = response.data["model"];
                    newTrackers = response.data["trackers"];
                    for (var key in dataResult) {
                        if (this.model[key]) {
                            // grid
                            if (this.model[key] instanceof kendo.data.DataSource) {
                                if (dataResult[key].length > 0) {
                                    hasData = true;
                                    _renameIdAttribute(dataResult[key]);
                                    _addDsgnrId(key, dataResult[key], this.trackers);
                                    this.model[key].data(dataResult[key]);
                                    this.model[key].sync();
                                }
                                // combos
                            } else if (this.model[key] instanceof kendo.data.ObservableArray) {
                                this.model[key].splice(0, this.model[key].length);
                                if (dataResult[key].length > 0) {
                                    hasData = true;
                                    for (var i in dataResult[key]) {
                                        this.model[key].push(dataResult[key][i]);
                                    }
                                }
                            } else {
                                hasData = true;
                                this.model[key] = dataResult[key];
                            }

                            if (newTrackers != null && !$.isEmptyObject(newTrackers)) {
                                this.trackers[key] = new crud.DataSourceTracker(newTrackers[key].metadata, newTrackers[key].created, newTrackers[key].updated, newTrackers[key].removed);
                            }
                        }
                    }
                    _showResultMessages(null, true, response.messages, false, this);
                } else {
                    _showResultMessages(null, false, response.messages, false, this);
                }

                return hasData;
            }

            function _comboBoxChange(e) {
                var model = e.sender.element.context.getAttribute('ng-model');
                // elimina vc.
                var getter = $parse(model.substring(3));
                var setter = getter.assign;
                setter(this, e.sender.value());
                var that = this;
                $("input[relatedVisualAttribute='" + e.sender.element.context.id + "']").each(function (key, value) {
                    console.log(value.getAttribute('ng-model'));
                    var getModel = $parse(value.getAttribute('ng-model').substring(3));
                    var setModel = getModel.assign;
                    setModel(that, null);
                    that.loadDependentCatalog(value.id);
                });
            }

            function _loadDependentCatalogOnInit() {
                var that = this;
                if (that.serverEvents) {
                    $("input[relatedvisualattribute]").each(function (key, value) {
                        that.loadDependentCatalog(value.id);
                    });
                }
            }

            function _loadDependentCatalog(idDependent) {
                var that = this;
                this.execute("loadCatalog", idDependent, this.model, function (response) {
                    that.catalogs[idDependent].data(response.data['RESULT' + idDependent]);
                });
            }

            function _beforeOpenGridDialog(controlId, dialogParameters) {
                this.dialogParameters = dialogParameters;
                this.dialogParameters.controlId = controlId;
                var beforeOpenGridDialogEventArgs = new dsgnrCommons.eventArgs.BeforeOpenGridDialogEventArgs();
                _initCommonsEventArgs(beforeOpenGridDialogEventArgs, controlId, this);
                beforeOpenGridDialogEventArgs.dialogParameters = dialogParameters;
                dsgnrCustomEvents.beforeOpenGridDialog(this.vcEvents, this.model, beforeOpenGridDialogEventArgs);

                if (dialogParameters.isModal) {
                    if(!beforeOpenGridDialogEventArgs.cancel) {
                        var entity = ($('#' + controlId).attr("k-data-source")).substring(9);
                        var nav = beforeOpenGridDialogEventArgs.commons.api.navigation;
                        nav.address = {
                            moduleId: dialogParameters.moduleId,
                            subModuleId: dialogParameters.subModuleId,
                            taskId: dialogParameters.taskId,
                            taskVersion: dialogParameters.taskVersion,
                            viewContainerId: dialogParameters.viewContainerId
                        };

                        nav.modalProperties = {
                            callFromGrid: true
                        };
                        nav.queryParameters = {
                            mode: dialogParameters.rowIndex >= 0 ? 2 : 1
                        };
                        nav.customDialogParameters = {
                            rowIndex: dialogParameters.rowIndex,
                            currentRow: dialogParameters.rowIndex >= 0 ? dialogParameters.rowData : null,
                            entity: dialogParameters.rowIndex >= 0 ? entity : null
                        };
                        if (angular.isDefined(dialogParameters.title)) {
                            nav.label = dialogParameters.title;
                        }
                        if (angular.isDefined(dialogParameters.size)) {
                            nav.modalProperties.size = dialogParameters.size;
                        }
                        if (angular.isDefined(dialogParameters.height)) {
                            nav.modalProperties.height = dialogParameters.height;
                        }
                        nav.openModalWindow(this.dialogParameters.controlId, dialogParameters.rowData);
                    }
                } else if (dialogParameters.hasBeforeOpenDialogEvent) {
                    return beforeOpenGridDialogEventArgs.commons.api.navigation.dispatched;
                }
                return false;
            }

            /**
             * Al navegar a otra pantalla, esta funci&oacute;n es llamada luego de
             * cargar la pantalla, pero antes de ejecutar el ciclo de vida.
             *
             * Cuando la navegaci&oacute;n se origina en el bot&oacute;n [Nuevo] o el
             * bot&oacute;n [Editar] de una grilla, en el ViewContainer padre
             * (this.parentVc) se guarda el objeto 'dialogParameters' con los
             * par&aacutemetros:
             *
             * nameEntityGrid, nombre de la entidad que es utilizada por la grilla
             * origen; rowData, registro actual de la grilla (inclusive cuando se se
             * utiliza el bot&oacute;n [Nuevo]; isNew, identifica si el origen es el
             * bot&oacute;n [Nuevo] o el bot&oacute;n [Editar]; rowIndex, indice del
             * registro actual de la grilla.
             *
             * Con estos par&aacute;metros se intenta buscar la misma entidad a nivel de
             * cabecera en la pantalla hija. De esta manera es posible editar los datos
             * de un registro de la grilla en una pantalla independiente
             * (navegaci&oacute;).
             *
             * @method afterOpenGridDialog
             */
            function _afterOpenGridDialog() {
                var dialogParams = this.parentVc.dialogParameters,
                    nameEntityGrid,
                    rowData,
                    isNew,
                    parentTracker;

                if (angular.isDefined(dialogParams)) {
                    nameEntityGrid = dialogParams.nameEntityGrid;
                    rowData = dialogParams.rowData;
                    isNew = dialogParams.isNew;
                    if (angular.isDefined(nameEntityGrid)) {
                        parentTracker = this.parentVc.trackers[nameEntityGrid];
                    }
                }

                if (isNew === true) {
                    this.mode = dsgnrCommons.constants.mode.Insert;
                    this.args.mode = dsgnrCommons.constants.mode.Insert;
                } else if (isNew === false) {
                    this.mode = dsgnrCommons.constants.mode.Update;
                    this.args.mode = dsgnrCommons.constants.mode.Update;
                }

                if (angular.isDefined(nameEntityGrid) && angular.isDefined(this.model[nameEntityGrid])) {
                    for (var key in rowData) {
                        if (!rowData.hasOwnProperty(key)) continue;
                        if (key.substring(0, 1) == "$") {
                            var entityKey = key.substring(1);
                            if (this.model[entityKey] instanceof kendo.data.DataSource) {
                                if (rowData[key] instanceof kendo.data.ObservableArray || rowData[key] instanceof Array) {
                                    this.model[entityKey].data(rowData[key]);
                                } else {
                                    this.model[entityKey].data([rowData[key]]);
                                }
                                this.model[entityKey].sync();
                            } else {
                                this.model[entityKey] = rowData[key];
                            }
                        } else if (typeof (this.model[dialogParams.nameEntityGrid][key]) !== "undefined") {
                            var value = dialogParams.rowData.get(key);
                            if (typeof (dialogParams.rowData.get(key)) === "function") {
                                value = dialogParams.rowData.get(key)();
                                this.model[dialogParams.nameEntityGrid][key] = value;
                            } else {
                                this.model[dialogParams.nameEntityGrid][key] = value;
                            }
                        }
                    }

                    var entityMetadata = this.metadata.entities[nameEntityGrid];
                    var entityPks = entityMetadata._pks;
                    var entityPksMap = {};
                    entityPksMap[nameEntityGrid] = [];
                    for (var i in entityPks) {
                        entityPksMap[nameEntityGrid][i] = rowData.get(entityPks[i]);
                    }
                    this.pk = dsgnrCommons.utils.http.generatePrimaryKeyString(entityPksMap);
                    this.args.pk = this.pk;

                }

                if (angular.isDefined(parentTracker) && isNew === false) {
                    var trackers = parentTracker.getTrackers(rowData.trackId);
                    for (var key in trackers) {
                        if (!trackers.hasOwnProperty(key)) continue;
                        this.trackers[key] = trackers[key];
                    }
                }

            }

            function _beforeCloseGridDialog(dialogCloseResult, dialogCloseType) {
                var dialogResponse = {
                    dialogCloseResult: dialogCloseResult,
                    dialogCloseType: dialogCloseType
                };

                if (( dialogCloseResult === dsgnrCommons.constants.dialogCloseResult.Accept ) &&
                    ( angular.isDefined(this.autoSyncNavigation) && this.autoSyncNavigation === true )
                ) {
                    dialogResponse.model = this.model;
                    dialogResponse.trackers = this.trackers;
                }
                this.parentVc.dialogResponse = dialogResponse;
            }

            function _onCloseModalEvent() {
                var controlId = this.dialogParameters.controlId,
                    viewContainerId = this.id,
                    resultModal = this.customDialogResponse,
                    closeModalEventArgs = new dsgnrCommons.eventArgs.CloseModalEventArgs();
                _initCommonsEventArgs(closeModalEventArgs, controlId, this);
                closeModalEventArgs.vcId = this.id;
                closeModalEventArgs.closedViewContainerId = viewContainerId;
                closeModalEventArgs.dialogCloseResult = resultModal;
                closeModalEventArgs.dialogCloseType = 0;
                closeModalEventArgs.rowData = this.dialogParameters.rowData;
                closeModalEventArgs.isNew = this.dialogParameters.isNew;
                closeModalEventArgs.result = resultModal;
                if (this.hasOnCloseModalEvent) {
                    dsgnrCustomEvents.onCloseModalEvent(this.vcEvents, this.model, closeModalEventArgs);
                }
            }

            function _afterCloseGridDialog() {

                if (this.dialogParameters.hasAfterCloseDialogEvent) {
                    var afterCloseGridDialogEventArgs = new dsgnrCommons.eventArgs.AfterCloseGridDialogEventArgs();
                    _initCommonsEventArgs(afterCloseGridDialogEventArgs, this.dialogParameters.controlId, this);
                    afterCloseGridDialogEventArgs.dialogParameters = this.dialogParameters;
                    afterCloseGridDialogEventArgs.dialogResponse = this.dialogResponse;
                    afterCloseGridDialogEventArgs.customDialogResponse = this.customDialogResponse;
                    dsgnrCustomEvents.afterCloseGridDialog(this.vcEvents, this.model, afterCloseGridDialogEventArgs);
                    // Se debe soportar evento de servidor?
                }


                if (this.dialogResponse && this.dialogResponse.model && this.dialogParameters.nameEntityGrid) {

                    var nameEntityGrid = this.dialogParameters.nameEntityGrid;
                    var rowData = this.dialogParameters.rowData;
                    var isNew = this.dialogParameters.isNew;
                    var dataEntity = this.dialogResponse.model[nameEntityGrid];
                    var ds = this.model[nameEntityGrid];

                    // Se copian las entidades relacionadas
                    for (var key in this.dialogResponse.model) {
                        if (!this.dialogResponse.model.hasOwnProperty(key) || key == nameEntityGrid) continue;
                        var entityKey = "$" + key;
                        if (this.dialogResponse.model[key] instanceof kendo.data.DataSource) {
                            dataEntity[entityKey] = this.dialogResponse.model[key].data();
                        } else {
                            dataEntity[entityKey] = this.dialogResponse.model[key];
                        }
                    }

                    // Se agrega o se actualiza el registro del DataSource de la entidad
                    // padre
                    if (isNew) {
                        // dataEntity.trackId = dsgnrCommons.utils.uuid();
                        rowData = ds.add(dataEntity);
                    } else {
                        rowData = ds.getByUid(rowData.uid);
                        /*
                         * if (!rowData.get("trackId")) { rowData.set("trackId",
                         * dsgnrCommons.utils.uuid()); }
                         */
                        for (var key in dataEntity) {
                            if (!dataEntity.hasOwnProperty(key)) continue;
                            rowData.set(key, dataEntity[key]);
                        }
                    }

                    ds.sync();

                    if (this.dialogResponse.trackers) {
                        // Se copian los trackers relacionados con al tracker del
                        // DataSource de la entidad padre
                        var parentTracker = this.trackers[nameEntityGrid];
                        if (parentTracker) {
                            for (var key in this.dialogResponse.trackers) {
                                if (!this.dialogResponse.trackers.hasOwnProperty(key)) continue;
                                if (this.dialogResponse.trackers[key].isDirty()) {
                                    parentTracker.addTracker(rowData.trackId, key, this.dialogResponse.trackers[key]);
                                }
                            }
                        }
                    }
                    rowData.set("_loaded", true);
                }

                delete this.dialogParameter;
                delete this.dialogResponse;
                delete this.customDialogResponse;
            }

            //Â¡Â¡Â¡Verificar si se debe eliminar y usar _closeViewContainer!!!--Se esta utilizando en FNA
            function _closeDialog(viewContainerId, deleteRoutes) {
                var idViewContainer = viewContainerId;
                if (!angular.isDefined(viewContainerId)) {
                    idViewContainer = this.id;
                }
                delete _vc[idViewContainer];
                if (angular.isDefined(deleteRoutes)) {
                    if (deleteRoutes) {
                        _deleteRoutes(idViewContainer);
                    }
                } else {
                    _deleteRoutes(idViewContainer);
                }
            }

            function _deleteRoutes(idCurrentVC) {
                if (angular.isDefined($route.routes['/' + idCurrentVC])) {
                    delete $route.routes['/' + idCurrentVC];
                }
                if (angular.isDefined($route.routes['/' + idCurrentVC + '/'])) {
                    delete $route.routes['/' + idCurrentVC + '/'];
                }
            }

            function _closeViewContainer(flgClose, cancel) {
                if (angular.isUndefined(cancel)) {
                    cancel = false;
                }
                if (angular.isDefined(this.parentVc) && flgClose === true) {
                    delete _vc[this.id];
                    if (!this.childVc) {
                        _deleteRoutes(this.id);
                    }
                    if (this.isModal() && angular.isDefined(this.parentVc.modalInstances) &&
                        angular.isDefined(this.parentVc.modalInstances[this.id])) {
                        if (cancel === true) {
                            this.parentVc.modalInstances[this.id].dismiss({
                                dialogCloseResult: dsgnrCommons.constants.dialogCloseResult.Cancel,
                                dialogCloseType: dsgnrCommons.constants.dialogCloseType.Interactive
                            });
                        } else {
                            if (this.parentVc.openPageDesigner && this.parentVc.dialogResponse) {
                                this.parentVc.modalInstances[this.id].close(this.parentVc.dialogResponse);
                                this.parentVc.openPageDesigner = false;
                            } else {
                                if (this.parentVc.customDialogResponse) {
                                    this.parentVc.modalInstances[this.id].close(this.parentVc.customDialogResponse);
                                } else if (this.parentVc.dialogResponse) {
                                    this.parentVc.modalInstances[this.id].close(this.parentVc.dialogResponse);
                                }
                            }
                        }
                    } else {
                        $location.url(this.parentVc.id);
                    }
                }
            }

            function _addChildVc(childId) {
                if (childId) {
                    if (!$rootScope.vcParent) {
                        $rootScope.vcParent = {};
                    }
                    if (childId !== this.id) {
                        if (angular.isDefined(this.idUid) && this.id != this.idUid) {
                            $rootScope.vcParent[childId] = this.idUid;
                        } else {
                            $rootScope.vcParent[childId] = this.id;
                        }
                    }
                }
            }


            function _removeChildVc(childId) {
                if (childId) {
                    if ($rootScope.vcParent) {
                        if (childId !== this.id) {
                            delete $rootScope.vcParent[childId];
                            delete _vc[childId];
                        }
                    }
                }
            }

            function _parentVc(childId) {
                if (!$rootScope.vcParent) {
                    $rootScope.vcParent = {};
                }
                if (childId) {
                    return _vc[$rootScope.vcParent[childId]];
                }
                return _vc[$rootScope.vcParent[this.id]];
            }

            function _url(viewContainerId, queryParameters, pageURL) {
                this.addChildVc(viewContainerId);
                var sessionElement = {
                    queryParameters: queryParameters,
                    vcParent: {
                        customDialogParameters: this.customDialogParameters,
                        args: this.args,
                        dialogParameters: this.dialogParameters,
                        model: this.model,
                        childVc: this.childVc,
                        id: this.id,
                        idUid: this.idUid,
                        loaded: this.loaded,
                        mainVc: this.mainVc,
                        mode: this.mode,
                        moduleId: this.moduleId,
                        subModuleId: this.subModuleId,
                        taskId: this.taskId,
                        taskVersion: this.taskVersion
                    }
                };
                if (cobis.utils.isRunOnLiferay()) {
                    _storeInSession(viewContainerId, JSON.stringify(sessionElement)).then(function () {
                        if (angular.isDefined(pageURL)) {
                            window.top.location.href = pageURL;
                        } else {
                            if (angular.isDefined(queryParameters)) {
                                $location.url("/" + viewContainerId + "?" + $.param(queryParameters));
                            } else {
                                $location.url("/" + viewContainerId);
                            }
                        }
                    });
                } else {
                    if (angular.isDefined(queryParameters)) {
                        $location.url("/" + viewContainerId + "?" + $.param(queryParameters));
                    } else {
                        $location.url("/" + viewContainerId);
                    }
                }
            }

            function _dismissModal($dismiss) {
                this.closeDialog();
                $dismiss({
                    dialogCloseResult: dsgnrCommons.constants.dialogCloseResult.Cancel,
                    dialogCloseType: dsgnrCommons.constants.dialogCloseType.NonInteractive
                });
            }

            /**
             * Permite activar el foco de un componente de una grilla. Los botones que
             * se ubican en el toolbar de la grilla o en cada registro de la grila estan
             * disponibles cuando se ejecuta el evento dataBound. Para activar el foco
             * de un componente de la grilla se puede utilizar la funcion
             * args.commons.api.grid.focusCommand(gridId, commandId). Si la funcion
             * focusCommand no puede activar el foco del componente de grilla, la
             * peticion es encolada para que esta funcion trate de activar el foco
             * nuevamente.
             *
             * Esta funcion es llamada desde el JavaScript generado por cada
             * ViewContainer.
             *
             * @method gridDataBound
             * @param {String}
             *            gridId Identificador de la grilla (queryViewId)
             */
            function _gridDataBound(gridId) {
                if (this.viewState[gridId] && this.viewState[gridId].pendingFocus) {
                    var controlId = this.viewState[gridId].pendingFocus;
                    _focusControl(controlId);
                    delete this.viewState[gridId].pendingFocus;
                }
            }
			
			/**
             * FunciÃ³n para ejecutar el evento gridRowSelecting
             * @param grid
             * @param entity
             * @private
             */

            function _gridRowChange(grid, entityName, scope){
                var selectedRow = grid.select(),
                    dataItem = grid.dataItem(selectedRow[0]),
                    queryViewId = grid.element[0].id;

                if (selectedRow.length == 0 || selectedRow[0].className.indexOf("k-grid-edit-row") < 0) {
                    var args = {
                        nameEntityGrid: entityName,
                        rowData: dataItem,
                        rowIndex: grid.dataSource.indexOf(dataItem)
                    };

                    scope.vc.gridRowSelecting(queryViewId, args);
                    _executeApply(scope,grid);

                }


            }

            /**
             * FunciÃ³n que valida los cambios (hide y show) que se hicieron en el viewState
             * para conservarlos en las columnas de las grillas.
             */
            function _hideShowColumns(gridId, grid) {
                var columns = grid.columns,
                    hiddenColumn = false,
                    that = this;

                if (columns.length > 0) {
                    columns.forEach(function (column) {
                        if (angular.isDefined(that.viewState[gridId]) && angular.isDefined(that.viewState[gridId].column[column.field])) {
                            hiddenColumn = that.viewState[gridId].column[column.field].hidden;
                            if (column.hidden != hiddenColumn) {
                                if (hiddenColumn) {
                                    grid.hideColumn(column.field);
                                } else {
                                    grid.showColumn(column.field);
                                }
                            }
                        }
                    });
                }
            }

            // ********************************* CRUD
            // *************************************
            function _CRUDExecute(controlId, validator, flgVld, flgValidationEvent, viewContainerId, flgPrTrx, flgClose) {
                var that = this;
                var response = null;
                console.log("_executeCommandCRUD");

                // Si el comando define no validar y cerrar la pagina actual, es CANCEL
                if (!flgVld && flgClose && this.parentVc) {
                    this.closeViewContainer(flgClose, true);
                    return;
                }

                var promise = _createPromise(response);

                if (promise) {
                    promise.then(function (response) {
                        return _validateTransaction(that, controlId, validator, flgVld, flgValidationEvent, viewContainerId);
                    }).then(function (response) {
                        if (response.success) {
                            var transactionRequest = that.CRUDBuildTransactionRequest();
                            if (!flgPrTrx) {
                                if (transactionRequest.entityRequests.length > 0) {

                                    that.serverCRUD.post(transactionRequest, function (response) {
                                        // 1. Refresh model with response data
                                        that.CRUDProcessResponse(controlId, flgClose, response);

                                        // 2. Execute "executeCrudCallback" event
                                        var executeCrudCallbackEventArgs = new dsgnrCommons.eventArgs.ExecuteCrudCallbackEventArgs();
                                        _initCommonsEventArgs(executeCrudCallbackEventArgs, controlId, that);
                                        executeCrudCallbackEventArgs.success = response.success;
                                        dsgnrCustomEvents.executeCrudCallback(that.vcEvents, that.model, executeCrudCallbackEventArgs);

                                        if (response.success) {
                                            // 3. Try to close ViewContainer
                                            that.closeViewContainer(flgClose);
                                        }

                                    }, dsgnrCommons.utils.errorCallback);
                                } else {
                                    cobisMessage.showTranslateMessagesInfo('DSGNR.SYS_DSGNR_MSGTRNOKN_00018');
                                }
                            } else {
                                var callTransactionEventArgs = new dsgnrCommons.eventArgs.CallTransactionEventArgs();
                                _initCommonsEventArgs(callTransactionEventArgs, controlId, that);
                                dsgnrCustomEvents.callCustomTransaction(that.vcEvents, transactionRequest, callTransactionEventArgs);

                                this.closeViewContainer(flgClose);
                            }
                        }
                    });
                }

            }

            function _CRUDExecuteQueryEntities(page) {
                if (this.pk) {
                    var that = this;
                    var entitiesPk = [];
                    var entitiesToIgnorePk = [];
                    for (var entityName in this.metadata.entities) {
                        var entity = this.metadata.entities[entityName];
                        var DataEntityPK = {
                            entityId: entity._entityId,
                            version: entity._entityVersion
                        };
                        // verifico si la entidad ya tiene datos para ponerla como que
                        // debe ignorarse (se ignora las grillas)
                        if (this.model[entityName]) {
                            /*
                             * if (!(this.model[entityName] instanceof
                             * kendo.data.DataSource)) { var pkNames =
                             * this.metadata.entities[entityName]._pks; if(pkNames &&
                             * pkNames.length > 0){ var pk =
                             * this.model[entityName][pkNames[0]]; if(pk != null &&
                             * (isNaN(pk) || pk>=0)){
                             * entitiesToIgnorePk[entitiesToIgnorePk.length] =
                             * DataEntityPK; } } }
                             */
                            entitiesPk[entitiesPk.length] = DataEntityPK;
                        }
                    }
                    var pks = dsgnrCommons.utils.http.generatePrimaryKeyMap(this.pk);
                    var taskPkAux = {
                        moduleId: this.metadata.taskPk.moduleId,
                        subModuleId: this.metadata.taskPk.subModuleId,
                        taskId: this.metadata.taskPk.taskId,
                        version: this.metadata.taskPk.version
                    };
                    var queryEntitiesRequest = new crud.QueryEntitiesRequest(taskPkAux, entitiesPk, entitiesToIgnorePk, pks);
                    return this.serverCRUDQueryEntities.post(queryEntitiesRequest)
                        .$promise.then(function (response) {
                            that.CRUDProcessQueryEntityResponse(response);
                            return page;
                        });
                } else {
                    return page;
                }
            }

            function _CRUDExecuteQuery(queryId, callBack) {
                var that = this;
                var queryRequest;
                if (typeof queryId === 'string') {
                    queryRequest = this.request.qr[queryId];
                } else {
                    queryRequest = queryId;
                    queryId = queryRequest.queryPk.queryId;
                }
                queryRequest.updateParameters();
                if (that.serverEvents) {
                    that.serverCRUDQueryId.post(queryRequest).$promise.then(function (response) {
                        var data = that.CRUDProcessQueryResponse(response, queryId);
                        callBack(data);
                    }, dsgnrCommons.utils.errorCallback);
                }
            }

            function _CRUDExecuteQueryId(queryRequest, loadInModel, callBack,
                                         cache, isVisualAttribute, controlId, config, filter) {
                var that = this,
                    clientFiltering = {
                        value: false,
                        dataToBeLoaded: []
                    };

                var component = $("#" + controlId);

                queryRequest.updateParameters();
                if (angular.isDefined(cache)) {
                    queryRequest.parameters["cache"] = cache;
                }

                if (angular.isDefined(config) && config !== null) {
                    _verifyAndCompleteProcessToFilterDataInClient(clientFiltering, component, filter, config);
                }
                if (that.serverEvents) {
                    if (angular.isDefined(callBack)) {
                        that.serverCRUDQueryId.post(queryRequest).$promise.then(function (response) {
                            that.CRUDProcessQueryIdResponse(response, loadInModel, queryRequest, isVisualAttribute);
                            if (clientFiltering.dataToBeLoaded.length > 0) {
                                response.entityResponses = clientFiltering.dataToBeLoaded;
                            }
                            callBack(response);
                            _checkStatusCombobox(that, controlId, component);
                        }, dsgnrCommons.utils.errorCallback);
                    } else {
                        var returnExecute = that.serverCRUDQueryId.post(queryRequest, function (response) {
                            that.CRUDProcessQueryIdResponse(response, loadInModel, queryRequest, isVisualAttribute);
                        }, dsgnrCommons.utils.errorCallback);
                        return returnExecute.$promise;
                    }
                }
            }

            function _CRUDBuildTransactionRequest() {
                var transactionRequest = new crud.TransactionRequest(this.metadata.taskPk);
                var entityRequestTmp;
                for (var entityName in this.model) {
                    if (!this.metadata.entities[entityName]._transient) {
                        var entityRequest = transactionRequest.addEntityRequests(this.metadata.entities[entityName]._entityId, this.metadata.entities[entityName]._entityVersion);
                        if (!(this.model[entityName] instanceof kendo.data.DataSource)) {
                            entityRequestTmp = crud.utils.addActionToEntityRequest(this.model[entityName], this.metadata.entities[entityName], this.mode, entityRequest);
                        } else {
                            entityRequestTmp = crud.utils.addActionToEntityRequestGrid(transactionRequest, this.trackers[entityName], this.metadata.entities[entityName], entityRequest);
                        }
                        if (entityRequestTmp == null) {
                            transactionRequest.removeEntityRequests(this.metadata.entities[entityName]._entityId);
                        }
                    }
                }
                return transactionRequest;
            }

            function _CRUDProcessResponse(controlId, flgClose, response) {
                if (response.success) {
                    // cobisMessage.showTranslateMessagesInfo('DSGNR.SYS_DSGNR_MSGPROCOK_00033');

                    for (var i in response.entityResponses) {
                        var entityResponse = response.entityResponses[i];
                        var entityMetadata = dsgnrCommons.utils.metadata.findEntityById(this.metadata, entityResponse.entityId);
                        if (entityMetadata) {
                            var entityModel = this.model[entityMetadata._entityName];
                            if (entityModel) {
                                if (entityModel instanceof kendo.data.DataSource) {
                                    var filter = [];
                                    for (var j in entityResponse.pks) {
                                        var pk = entityResponse.pks[j];
                                        var attName = dsgnrCommons.utils.metadata.findAttNameByAttId(entityMetadata, pk.id);
                                        var attOldValue = pk.oldValue;
                                        filter.push({
                                            field: attName,
                                            operator: "equals",
                                            value: attOldValue
                                        });
                                    }
                                    entityModel.filter(filter);
                                    var row = entityModel.view()[0];
                                    for (var j in entityResponse.pks) {
                                        var pk = entityResponse.pks[j];
                                        var attName = dsgnrCommons.utils.metadata.findAttNameByAttId(entityMetadata, pk.id);
                                        var attValue = pk.value;
                                        row.set(attName, attValue);
                                    }
                                    entityModel.filter([]);
                                } else {
                                    var pk = entityResponse.pks[0];
                                    if (angular.isDefined(pk)) {
                                        var attName = dsgnrCommons.utils.metadata.findAttNameByAttId(entityMetadata, pk.id);
                                        entityModel[attName] = pk.value;
                                    }
                                }
                            }
                        }
                    }

                    this.mode = dsgnrCommons.constants.mode.Update;
                    // resetea el track changes
                    this.CRUDResetTrackers();

                    _showResultMessages(controlId, true, response.messages, true, this);

                    if (flgClose && this.parentVc) {
                        this.closeViewContainer(flgClose);
                    }

                } else {
                    // cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFAI_00034');
                    _showResultMessages(controlId, false, response.messages, true, this);
                }
            }

            function _showResultMessages(controlId, success, messages, autocrud, controller) {
                var customization = false;

                if (autocrud) {
                    var showResultEventArgs = new dsgnrCommons.eventArgs.ShowResultEventArgs();
                    _initCommonsEventArgs(showResultEventArgs, controlId, controller);
                    showResultEventArgs.messages = messages;
                    showResultEventArgs.success = success;

                    customization = dsgnrCustomEvents.showCustomResult(controller.vcEvents, showResultEventArgs);

                    if (!customization) {
                        if (success) {
                            cobisMessage.showTranslateMessagesInfo('DSGNR.SYS_DSGNR_MSGPROCOK_00033');
                        } else {
                            // todos los msgs y si no viene msg generico
                            if (messages instanceof Array && messages.length > 0) {
                                cobisMessage.showAllMessages(messages);
                            } else if (messages instanceof Array && messages.length == 0) {
                                cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFAI_00034');
                            }
                        }
                    }
                } else {
                    if (!success) {
                        if (messages instanceof Array && messages.length > 0) {
                            cobisMessage.showAllMessages(messages);
                        } else if (messages instanceof Array && messages.length == 0) {
                            cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFAI_00034');
                        }
                    } else {
                        if (messages instanceof Array && messages.length > 0) {
                            cobisMessage.showAllMessages(messages);
                        }
                    }
                }
            }

            function _CRUDProcessQueryResponse(response, queryId) {
                if (!response.success) {
                    cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFAI_00034');
                } else {
                    if (response.entityResponses && response.entityResponses.length > 0) {
                        var entityResponseName = dsgnrCommons.utils.metadata.findEntityNameByAttId(this.metadata, Object.keys(response.entityResponses[0])[0]),
                            objectMetadata = this.metadata.entities[entityResponseName];
                        if (this.model[entityResponseName] instanceof kendo.data.DataSource) {
                            var data = _CRUDResponse2BusinessObjects(objectMetadata, response, true);
                            data = _resetData(data);
                            this.CRUDResetTracker(entityResponseName);
                            return data;
                        }
                    }
                }
            }

            function _CRUDProcessQueryEntityResponse(response) {
                if (!response.success)
                    cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFAI_00034');
                else {
                    if (response.entityResponses) {
                        for (var i = 0; i < response.entityResponses.length; i++) {
                            // por cada entidad devuelta
                            var entitiesResponse = response.entityResponses[i];
                            if (entitiesResponse instanceof Array && !$.isEmptyObject(entitiesResponse)) {
                                var entityResponseName = dsgnrCommons.utils.metadata.findEntityNameByAttId(this.metadata, Object.keys(entitiesResponse[0])[0]),
                                    objectMetadata = this.metadata.entities[entityResponseName];
                                if (this.model[entityResponseName] instanceof kendo.data.DataSource) {
                                    var dataTransform = [], entityTransform = {};
                                    for (var k = 0; k < entitiesResponse.length; k++) {
                                        for (var attName in objectMetadata) {
                                            if (angular.isDefined(entitiesResponse[k][objectMetadata[attName]])) {
                                                entityTransform[attName] = entitiesResponse[k][objectMetadata[attName]];
                                            }
                                        }
                                        dataTransform.push(entityTransform);
                                    }
                                    this.model[entityResponseName].data(_resetData(dataTransform));
                                    this.model[entityResponseName].sync();
                                } else {
                                    if (entitiesResponse.length > 0) {
                                        for (var attName in objectMetadata) {
                                            if (entitiesResponse[0][objectMetadata[attName]]) {
                                                this.model[entityResponseName][attName] = entitiesResponse[0][objectMetadata[attName]];
                                            }
                                        }
                                    }
                                }
                            } else {
                                var entityResponseName = dsgnrCommons.utils.metadata.findEntityNameByAttId(this.metadata, Object.keys(entitiesResponse)[0]),
                                    objectMetadata = this.metadata.entities[entityResponseName];
                                for (var attName in objectMetadata) {
                                    if (entitiesResponse[objectMetadata[attName]]) {
                                        this.model[entityResponseName][attName] = entitiesResponse[objectMetadata[attName]];
                                    }
                                }
                            }
                        }
                    }

                }
            }

            function _CRUDProcessQueryIdResponse(response, loadInModel, queryIdRequest, isVisualAttribute) {
                if (!response.success) {
                    cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFAI_00034');
                } else {
                    if (response.entityResponses && response.entityResponses.length > 0) {
                        var entityResponseName = dsgnrCommons.utils.metadata.findEntityNameByAttId(this.metadata, Object.keys(response.entityResponses[0])[0]),
                            objectMetadata = this.metadata.entities[entityResponseName];
                        if (loadInModel) {
                            if (this.model[entityResponseName] instanceof kendo.data.DataSource) {
                                var data = _CRUDResponse2BusinessObjects(objectMetadata, response, true);
                                this.model[entityResponseName].data(_resetData(data));
                                this.model[entityResponseName].sync();
                                this.CRUDResetTracker(entityResponseName);
                            } else {
                                var entityResponse = response.entityResponses[0];
                                if (entityResponse) {
                                    for (var attName in objectMetadata) {
                                        if (entityResponse[objectMetadata[attName]]) {
                                            this.model[entityResponseName][attName] = entityResponse[objectMetadata[attName]];
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        // Si es exitosa la llamada pero no hay resultados se debe
                        // limpiar el DataSource que representa
                        // los datos de la entidad relacionada con la consulta.
                        var entityId = queryIdRequest.mainEntityPk.entityId;
                        var entityName = dsgnrCommons.utils.metadata.findEntityNameById(this.metadata, entityId);
                        if (entityName !== null && (this.model[entityName] instanceof kendo.data.DataSource) && (!angular.isDefined(isVisualAttribute) || !isVisualAttribute)) {
                            this.model[entityName].data([]);
                            this.model[entityName].sync();
                            this.CRUDResetTracker(entityName);
                        }
                    }
                }
            }

            function _CRUDResponse2BusinessObjects(objectMetadata, response, changeId) {
                var objects = [];
                for (var n = 0; n < response.entityResponses.length; n++) {
                    var objectResponse = _CRUDResponse2BusinessObject(objectMetadata, response.entityResponses[n], changeId);
                    objects.push(objectResponse);
                }
                return objects;
            }

            function _CRUDResponse2BusinessObject(objectMetadata, entityResponse, changeId) {
                var objectResponse = {};
                for (var attName in objectMetadata) {
                    if (typeof entityResponse[objectMetadata[attName]] != "undefined") {
                        if (changeId && attName == "id") {
                            objectResponse["id_"] = entityResponse[objectMetadata[attName]];
                        } else {
                            objectResponse[attName] = entityResponse[objectMetadata[attName]];
                        }
                    }
                }
                return objectResponse;
            }

            function _resetDataSourceTracker(entityName, trackers, model) {
                if (trackers[entityName]) {
                    trackers[entityName].clean();
                }
            }

            function _CRUDResetTrackers() {
                // resetea el track changes
                crud.addTrackers(this.model);
                for (var trackName in this.trackers) {
                    this.trackers[trackName].clean();
                }
            }

            function _CRUDResetTracker(entityName) {
                var tracker = this.trackers[entityName];
                if (tracker) {
                    tracker.clean();
                }
            }


            function _addChangeEventFlags(scope) {
                for (var i = 0; i < this.changeEvents.length; i++) {
                    var changeEvent = this.changeEvents[i];
                    scope.vc.viewState[changeEvent.controlId].changeFlag = true;
                }
            }


            function _addChangeEvents(scope) {
                this.addChangeEventFlags(scope);
                var that = this;
                for (var i = 0; i < this.changeEvents.length; i++) {
                    //En caso de existir ya un watch para el mismo elemento, se desenlaza
                    // y se enalza el nuevo evento
                    var changeEvent = this.changeEvents[i];
                    if (this.changeEvents[i].unbind !== undefined) {
                        this.changeEvents[i].unbind(); // desenlaza el watch anterior
                    }
                    var changeEventFunction = function (changeEvent) {
                        changeEvent.unbind = scope.$watch(changeEvent.model, function (newValue, oldValue, currentScope) {
                            if ((typeof newValue === "undefined" && typeof oldValue === "undefined") ||
                                (newValue === null && oldValue === null) ||
                                (typeof newValue === "undefined" && oldValue === null) ||
                                (newValue === null && typeof oldValue === "undefined") ||
                                (newValue === "" && oldValue === null) ||
                                (newValue === null && oldValue === "") ||
                                (newValue === oldValue)) {
                                return;
                            }

                            if ((newValue instanceof Date) && (oldValue instanceof Date)){
                                //creacion de variables temporales para no afectar a las variables originales
                                var newValueTmp = angular.copy(newValue);
                                var oldValueTmp = angular.copy(oldValue);
                                //seteo de milisegundos en (0) para no afectar la operacion de igualdad
                                newValueTmp.setMilliseconds(0);
                                oldValueTmp.setMilliseconds(0);
                                if(newValueTmp.getTime() === oldValueTmp.getTime()){
                                    return;
                                }
                            }

                            var validator = currentScope.validator;
                            if (angular.isUndefined(validator)) {
                                validator = $("#validator").data("kendoValidator");
                            }
                            var isValid = false;
                            if (angular.isDefined(validator) && validator !== null && validator.validateInput($("#" + changeEvent.elementId))) {
                                isValid = true;
                            }
                            if (isValid || that.vcEvents.changeWithError[changeEvent.controlId] || that.vcEvents.changeWithError.allGroup) {
                                var flag = currentScope.vc.viewState[changeEvent.controlId].changeFlag;
                                var isChangeEventActive = true;
                                if (angular.isDefined(flag) && flag === false) {
                                    isChangeEventActive = false;
                                }
                                if (isChangeEventActive) {
                                    currentScope.vc.change2(changeEvent.controlId, newValue, oldValue, isValid);
                                }
                            }
                        });
                    };
                    changeEventFunction(changeEvent);
                }
            }

            function _onTabClosing(viewContainerId, closingReason) {
                var that = this;
                var deferedArgs = $q.defer();
                var deferedEvent = $q.defer();
                var onTabClosingEventArgs = new dsgnrCommons.eventArgs.onTabClosingEventArgs();
                _initCommonsEventArgs(onTabClosingEventArgs, viewContainerId, that);
                onTabClosingEventArgs.deferred = deferedArgs;
                onTabClosingEventArgs.viewContainerId = viewContainerId;
                onTabClosingEventArgs.closingReason = closingReason;
                dsgnrCustomEvents.onTabClosingCommand(that.vcEvents, that.model, onTabClosingEventArgs).then(function () {
                    if (closingReason !== "sessionTimeout" && that.serverEvents && onTabClosingEventArgs.commons.execServer) {
                        var args = {};
                        args.closingReason = closingReason;
                        that.execute(_event.TabClosing, viewContainerId, that.model, function (response) {
                            //Callback code if needed
                            deferedEvent.resolve();
                        }, args);
                    } else {
                        deferedEvent.resolve();
                    }
                });
                return deferedEvent.promise;
            }

            function _customInputRestriction(id, args) {
                return dsgnrCustomEvents.customInputRestriction(this.vcEvents, id, args);
            }

            function _customValidate(validationData) {
                var that = this,
                    customValidateEventArgs = new dsgnrCommons.eventArgs.CustomValidateEventArgs();
                customValidateEventArgs.currentValue = validationData.currentValue;
                _initCommonsEventArgs(customValidateEventArgs, validationData.controlId, that);
                if (angular.isDefined(validationData.rowData)) {
                    customValidateEventArgs.rowData = validationData.rowData;
                }
                dsgnrCustomEvents.customValidate(that.vcEvents, that.model, customValidateEventArgs);
                validationData.isValid = customValidateEventArgs.isValid;
                validationData.errorMessage = customValidateEventArgs.errorMessage;
                validationData.currentValue = customValidateEventArgs.currentValue;
            }

            function _getCssClass(id, elementStyles, auxStylesMap, elementStylesByDsgnrId) {
                return dsgnrUtils.component.getCssClass(id, elementStyles, auxStylesMap, elementStylesByDsgnrId);
            }

            function _validateOnEnter(event) {
                dsgnrUtils.container.validateOnEnter(event);
            }

            function _activeContainer(isDisabled, idContainerBefore) {
                return dsgnrUtils.container.activeContainer(isDisabled, idContainerBefore);
            }

            function _isDisabledContainer(idContainer) {
                return dsgnrUtils.container.isDisabledContainer(idContainer);
            }

            function _activeContainer(isDisabled, idContainerBefore) {
                return dsgnrUtils.container.activeContainer(isDisabled, idContainerBefore);
            }

            function _isDisabledContainer(idContainer) {
                return dsgnrUtils.container.isDisabledContainer(idContainer);
            }

            function _convertCatalog(catalogResponse) {
                if (angular.isDefined(catalogResponse)) {
                    for (var itemCatalog in catalogResponse) {
                        var value = catalogResponse[itemCatalog].value;
                        if (value && value.indexOf(catalogResponse[itemCatalog].code + ' -') === -1) {
                            catalogResponse[itemCatalog].value = catalogResponse[itemCatalog].code + " - " + catalogResponse[itemCatalog].value;
                        }
                    }
                }
                return catalogResponse;
            }

            function _exportGrid(event, gridId, dataSource) {
                var arrayVA = [],
                    hiddenColumn = [],
                    tdHiddenTemp = $("tbody tr:first").find("td:hidden"),
                    counterHiddenTd = 0,
                    that = this,
                    objExportColumns = {},
                    objColumnsIndex = {};

                for (var i in tdHiddenTemp) {
                    if (tdHiddenTemp[i].attributes != undefined) {
                        hiddenColumn.push(tdHiddenTemp[i].attributes.getNamedItem('ng-class').nodeValue);
                    }
                    counterHiddenTd += counterHiddenTd + 1;
                    if (counterHiddenTd === tdHiddenTemp.length) {
                        break;
                    }
                }

                event.sender.columns.forEach(function (itemColumn) {
                    if (angular.isDefined(itemColumn.field)) {
                        objExportColumns[itemColumn.field] = !itemColumn.hidden;
                    }

                });

                that.grids[gridId].columns.forEach(function (itemrow, indexGrid) {
                    var flag = false;
                    hiddenColumn.some(function (itemHiddenCol) {
                        if (itemHiddenCol === itemrow.attributes["ng-class"]) {
                            flag = true;
                            return true;
                        }
                    });

                    if (!flag && itemrow.field !== undefined && that.viewState[gridId].column[itemrow.field] !== undefined) {
                        var vaId = that.viewState[gridId].column[itemrow.field].componentId;
                        if (vaId !== undefined) {
                            arrayVA[indexGrid] = vaId;
                        } else {
                            arrayVA[indexGrid] = '';
                        }
                    }

                    if (angular.isDefined(itemrow.field)) {
                        objColumnsIndex[itemrow.field] = indexGrid;
                    }

                });

                if (exportFlag) {
                    objExport = jQuery.extend({}, objExportColumns);
                }

                _exportColumns(that.vcEvents, gridId, objExportColumns, event).then(function (response) {
                    if (response) {
                        if (exportFlag) {
                            setColumnsToExport(objExportColumns, event);
                            event.preventDefault();
                            exportFlag = false;
                            event.sender.saveAsExcel();

                        } else {
                            setColumnsToExport(objExport, event);
                            exportFlag = true;

                        }

                    }

                    var thTitle = $('div#' + gridId).find('th');
                    if ((thTitle[0].textContent).trim() === '') { //cuando tiene detalle de grilla a la izquierda
                        thTitle.splice(0, 1);
                    }
                    var dataview = dataSource.data(),
                        workBookToExport = event.workbook,
                        auxColumns = [];
                    if (angular.isDefined(workBookToExport)){
                        if (workBookToExport.sheets.length > 0
                            && workBookToExport.sheets[0].rows.length > 0
                            && workBookToExport.sheets[0].rows[0].type === 'header'
                            && workBookToExport.sheets[0].rows[0].cells.length > 0) {
                            var cells = workBookToExport.sheets[0].rows[0].cells,
                                titleColumn,
                                fieldGrid;

                            cells.forEach(function (cell, index) {
                                if(angular.isDefined(cell.value) && cell.value!== null && cell.value.trim()!==''){
                                    fieldGrid = cell.value;
                                    fieldGrid = fieldGrid.substring(fieldGrid.indexOf("column."), fieldGrid.indexOf(".title"));
                                    fieldGrid = fieldGrid.replace('column.', '');

                                    auxColumns[index] = fieldGrid;
                                    titleColumn = $filter('translate')(that.viewState[gridId].column[fieldGrid].title);
                                    workBookToExport.sheets[0].rows[0].cells[index].value = titleColumn;
                                }
                            });
                        }

                        var rows = workBookToExport.sheets[0].rows,
                            indexColumn,
                            code,
                            value;
                        rows.forEach(function (itemRow, indexRow) {
                            if (indexRow > 0) {
                                angular.forEach(itemRow.cells, function (itemCell, indexCell) {
                                    indexColumn = objColumnsIndex[auxColumns[indexCell]];
                                    if (itemCell.value instanceof Date && that.grids[gridId].columns[indexColumn].format) {
                                        itemCell.value = kendo.toString(itemCell.value, that.grids[gridId].columns[indexColumn].format)
                                    }
                                    if (that.catalogs[arrayVA[indexColumn]] !== undefined) {
                                        code = itemCell.value;
                                        if (that.catalogs[arrayVA[indexColumn]] instanceof kendo.data.DataSource) {
                                            value = that.catalogs[arrayVA[indexColumn]].get(code);
                                            if (value !== undefined) {
                                                itemCell.value = value.value;
                                            }
                                        } else {
                                            value = that.catalogs[arrayVA[indexColumn]][dataview[indexRow - 1].uid].get(code);
                                            if (value !== undefined) {
                                                itemCell.value = value.value;
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                });
            }

            function _exportGridToExcel(gridId){
                var kendoGrid = angular.element("#"+gridId).data('kendoGrid');
                kendoGrid.saveAsExcel();
            }

            function _exportGridToPdf(gridId){
                var kendoGrid = angular.element("#"+gridId).data('kendoGrid');
                kendoGrid.saveAsPDF();
            }

            function setColumnsToExport(objColumns, event) {
                var hasExport;
                for (var key in objColumns) {
                    hasExport = objColumns[key];
                    if (hasExport) {
                        event.sender.showColumn(key);
                    } else {
                        event.sender.hideColumn(key);

                    }

                }
            }

            function _setFalseValueForCheckBoxIfNull(entityModel, attributeName, falseValue) {
                if (entityModel[attributeName] === null) {
                    entityModel[attributeName] = falseValue;
                }
            }

            function _getStringColumnFormat(data, qvId, attr) {
                if (angular.isDefined(data)) {
                    var format = this.viewState[qvId].column[attr].format;
                    return kendo.toString(data, format);
                } else {
                    return '';
                }
            }

            function _setBreadcrumbs(arrayLabels) {
                var scope = angular.element($("#"+this.id)).scope(), labels = [], label;
                arrayLabels.forEach(function(labelId){
                    label = $filter('translate')(labelId);
                    labels.push({
                        label: label,
                        path: ""
                    });
                });
                scope.breadcrumbs["getManual"] = labels;
            }

            function parseDateTimePicker(objectList) {
                if (objectList.length > 0) {
                    for (var d = 0; d < objectList.length; d++) {
                        if (/\_+/.test(objectList[d].value)) {
                            objectList[d].value = "";
                        }
                    }
                }
            }

            function validateDateTimePicker() {
                var datePickerList = $("input[data-role='extdatepicker']").filter("[required]");
                var dateTimePickerList = $("input[data-role='extdatetimepicker']").filter("[required]");
                var timePickerList = $("input[data-role='exttimepicker']").filter("[required]");
                parseDateTimePicker(datePickerList);
                parseDateTimePicker(dateTimePickerList);
                parseDateTimePicker(timePickerList);
            }

            function _exportColumns(vcEvents, gridId, columnsToExport, eventExportGrid) {
                var that = this;
                var exportColumnsEventArgs = new dsgnrCommons.eventArgs.ExportColumnsEventArgs();
                _initCommonsEventArgs(exportColumnsEventArgs, gridId, that);

                exportColumnsEventArgs.exportColumnsToExcel = columnsToExport;

                return dsgnrCustomEvents.exportColumns(vcEvents, gridId, exportColumnsEventArgs, eventExportGrid);
            }

            function _storeInSession(key, value) {
                var SessionManager = $resource(_urlLiferayRest + "/sessionManager/", {}, {save: {method: 'POST'}});
                return SessionManager.save({key: key}, value).$promise;
            }

            function _getFromSession(key) {
                var SessionManager = $resource(_urlLiferayRest + "/sessionManager/:key", {key: '@id'});
                var sessionElement = SessionManager.get({key: key});
                return sessionElement.$promise;
            }

            function _fillSessionInfo(sessionElement) {
                if (angular.isDefined(sessionElement.vcParent)) {
                    $rootScope.vcParent = sessionElement.vcParent;
                }
            }

            function _getGridTemplate (gridInitColumnTemplateEventArgs, options){
                var template, gridColumns = this.grids[gridInitColumnTemplateEventArgs.commons.controlId].columns;
                switch(options.templateName){
                    case 'six-fields-2-4':
                        template = "<div class='six-fields-2-4'>"+
                            "<div class='cb-flex cb-gutters cb-middle'>"+
                            "<div class='cb-grow'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[0])+"' class='field-1'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[0])+"</span></div><div><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[1])+"' class='field-2'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[1])+"</span></div>"+
                            "</div>"+
                            "<div class='row'>"+
                            "<div class='col-md-3'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[2])+"' class='field-3'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[2])+"</span></div><div class='col-md-3'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[3])+"' class='field-4'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[3])+"</span></div><div class='col-md-3'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[4])+"' class='field-5'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[4])+"</span></div><div class='col-md-3'><span title='"+options.columns[5]+"' class='field-6'>"+getLastFieldTemplateBase(options.columns[5], gridInitColumnTemplateEventArgs)+"</span></div></div>";
                        break;
                    case 'six-fields-3-3':
                        template = "<div class='six-fields-3-3'>"+
                            "<div class='cb-flex cb-gutters cb-middle'>"+
                            "<div class='cb-grow'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[0])+"' class='field-1'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[0])+"</span></div><div><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[1])+"' class='field-2'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[1])+"</span><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[2])+"' class='field-3'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[2])+"</span></div>"+
                            "</div>"+
                            "<div class='row'>"+
                            "<div class='col-md-3'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[3])+"' class='field-4'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[3])+"</span></div><div class='col-md-3'><span title='"+getGridColumnTitleByAlias(gridColumns,options.columns[4])+"' class='field-5'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[4])+"</span></div><div class='col-md-3'><span title='"+options.columns[5]+"' class='field-6'>"+getLastFieldTemplateBase(options.columns[5], gridInitColumnTemplateEventArgs)+"</span></div></div>";
                        break;

                    case 'summary-two-fields-vertical':
                        template = "<div class='summary-two-fields-vertical'><div class='field-1'><span translate>#= "+options.columns[0]+"#</span></div>"+
                            "<div><span title='"+options.columns[1]+"' class='field-2'>"+getLastFieldTemplateBase(options.columns[1], gridInitColumnTemplateEventArgs)+"</span></div></div>"
                        break;

                    case 'summary-two-fields-validation':
                        var descriptionTemplate = "<span ng-class='#= "+options.columns[2]+"# ? \"summary-template-title\" : \"summary-template-description\"' translate>#= "+options.columns[0]+"#</span>";
                        template = "<div class='summary-two-fields-validation'><div class='row'><div class='col-xs-6'><div class='field-1'>"+descriptionTemplate+"</div></div>"+
                            "<div class='col-xs-6'><span class='field-2'>"+getGridColumnTemplateByAlias(gridColumns,options.columns[1])+"</span></div></div></div>"
                        break;
                    default:
                        template="";
                        break;
                }
                return template;
            }

            function _getComboBoxTemplate(options){
                var template;
                switch(options.templateName){
                    case "two-fields":
                        template = '<div class="two-fields"><div class="row"><div class="col-xs-6"><span class="field-1"> #='+options.columns[0]+'#</span></div><div class="col-xs-6"><span class="field-2">#= '+options.columns[1]+'#</span></div></div></div>';
                        break;
                    case 'three-fields':
                        template = '<div class="three-fields"><div class="cb-flex cb-gutters cb-middle"><div class="cb-grow field-1">#='+options.columns[0]+'#</div><div><span class="field-2">#='+options.columns[1]+'#</span></div></div><div><span class="field-3">#='+options.columns[2]+'#</span></div></div>';
                        break;
                    case 'three-fields-horizontal':
                        template = '<div class="three-fields-horizontal"><div class="cb-flex cb-gutters cb-middle"><div class="cb-grow field-1">#='+options.columns[0]+'#</div><div><span class="field-2">#='+options.columns[1]+'#</span></div><div><span class="field-3">#='+options.columns[2]+'#</span></div></div></div>';
                        break;
                    default:
                        template="";
                        break;
                }
                return template;
            }

            function getGridColumnTemplateByAlias(columns, alias){
                var template = "";
                var column = columns.filter(function(col){
                    return col.field === alias;
                });
                if(column.length > 0 && typeof column[0].template !== "undefined"){
                    template = column[0].template;
                }
                return template;
            }

            function getGridColumnTitleByAlias(columns, alias){
                var title = "";
                var column = columns.filter(function(col){
                    return col.field === alias;
                });
                if(column.length > 0 && typeof column[0].title !== "undefined"){
                    title = column[0].title;
                }
                return title;
            }

            function getLastFieldTemplateBase(column, gridInitColumnTemplateEventArgs){
                var template = "";
                if(typeof column !== "undefined" && column.length>0){
                    template = gridInitColumnTemplateEventArgs.parameters.templateBase;
                }
                return template;
            }

            return {

                constants: dsgnrCommons.constants,
                enums: dsgnrCommons.enums,
                utils: dsgnrCommons.utils,

                initViewContainer: function (viewContainer, urlRestService, vcCustomEvents, rowData, urlLiferayRest) {
                    _urlLiferayRest = urlLiferayRest;

                    var sessionElement;
                    var viewContainerId = viewContainer.viewContainerId;
                    var vcId = viewContainerId;
                    if (angular.isDefined(rowData) && angular.isDefined(rowData.uid)) {
                        vcId = rowData.uid;
                    }
                    if (_vc[vcId]) {
                        _vc[vcId].loaded = true;
                        return _vc[vcId];
                    }
                    var moduleId = viewContainer.moduleId,
                        subModuleId = viewContainer.subModuleId,
                        taskId = viewContainer.taskId,
                        taskVersion = viewContainer.taskVersion,
                        parentVc = _parentVc(vcId),
                        mainVc = true,
                        childVc = false,
                        autoSyncNavigation = false,
                        serverEvents = viewContainer.serverEvents,
                        hasOnCloseModalEvent = viewContainer.hasCloseModalEvent === undefined ? false : viewContainer.hasCloseModalEvent;
                    if (parentVc) {
                        mainVc = false;
                        if ((parentVc.moduleId === moduleId && parentVc.subModuleId === subModuleId && parentVc.taskId === taskId && parentVc.taskVersion === taskVersion) ||
                            (angular.isDefined(parentVc.dialogParameters.isChild) && parentVc.dialogParameters.isChild === true)
                        ) {
                            childVc = true;
                        }

                        if (angular.isDefined(parentVc.dialogParameters.autoSync) && parentVc.dialogParameters.autoSync === true) {
                            autoSyncNavigation = true;
                        }
                    }

                    _vc[vcId] = {
                        accept: _accept,
                        addChangeEvents: _addChangeEvents,
                        addChangeEventFlags: _addChangeEventFlags,
                        addChildVc: _addChildVc,
                        autoSyncNavigation: autoSyncNavigation,
                        removeChildVc: _removeChildVc,
                        afterCloseModal: _afterCloseModal,
                        afterCloseModalGrid: _afterCloseModalGrid,
                        afterOpenGridDialog: _afterOpenGridDialog,
                        afterCloseGridDialog: _afterCloseGridDialog,
                        onCloseModalEvent: _onCloseModalEvent,
                        beforeOpenGridDialog: _beforeOpenGridDialog,
                        beforeCloseGridDialog: _beforeCloseGridDialog,
                        cancel: _cancel,
                        change: _change,
                        change2: _change2,
                        changeGroup: _changeGroup,
                        changeInitData: _changeInitData,
                        changeGridColumnWidth: _changeGridColumnWidth,
                        cleanData: _cleanData,
                        clickTab: _clickTab,
                        clickTextInputButton: _clickTextInputButton,
                        clickTextInputButtonGrid: _clickTextInputButtonGrid,
                        closeDialog: _closeDialog,
                        closeModal: _closeModal,
                        closeViewContainer: _closeViewContainer,
                        comboBoxChange: _comboBoxChange,
                        designerEventsConstants: _event,
                        dismissModal: _dismissModal,
                        execute: _execute,
                        executeCatalog: _executeCatalog,
                        executeCommand: _executeCommand,
                        executeEvent: _executeEvent,
                        executeEventInGrid: _executeEventInGrid,
                        executeLabelCommand: _executeLabelCommand,
                        executeGridRowCommand: _executeGridRowCommand,
                        executeGridCommand: _executeGridCommand,
                        executeQuery: _executeQuery,
                        executeQueryAndAppendResults: _executeQueryAndAppendResults,
                        executeQueryControl: _executeQueryControl,
                        executeService: _executeService,
                        focus: _focus,
                        gridAfterLeaveInLineRow: _gridAfterLeaveInLineRow,
                        gridBeforeEnterInLineRow: _gridBeforeEnterInLineRow,
                        gridDataBound: _gridDataBound,
                        gridRowAction: _gridRowAction,
						gridRowChange: _gridRowChange,
                        gridRowSelecting: _gridRowSelecting,
                        gridRowRendering: _gridRowRendering,
                        hideShowColumns: _hideShowColumns,
                        showGridRowDetailIcon: _showGridRowDetailIcon,
                        gridInitDetailTemplate: _gridInitDetailTemplate,
                        gridInitColumnTemplate: _gridInitColumnTemplate,
                        gridInitEditColumnTemplate: _gridInitEditColumnTemplate,
                        getPlaceHolder: _getPlaceHolder,
                        createViewState: _createViewState,
                        setGridComboBoxDefaultValue: _setGridComboBoxDefaultValue,
                        setReadOnlyInputCombobox: _setReadOnlyInputCombobox,
                        setComboBoxDefaultValue: _setComboBoxDefaultValue,
                        getParentValue: _getParentValue,
                        validateForm: _validateForm,
                        setWidthColumn: _setWidthColumn,
                        initData: _initData,
						isColumnOfButton: _isColumnOfButton,
                        isModal: _isModal,
                        isDetailGrid: _isDetailGrid,
                        loadCatalog: _loadCatalog,
                        loadCatalogCobis: _loadCatalogCobis,
                        loadDependentCatalog: _loadDependentCatalog,
                        loadDependentCatalogOnInit: _loadDependentCatalogOnInit,
                        nextSeq: _nextSeq,
                        processExecuteQueryResponse: _processExecuteQueryResponse,
                        processResponse: _processResponse,
                        getDesignerData: _getDesignerData,
                        processTemporaryResponse: _processTemporaryResponse,
                        render: _render,
                        url: _url,
                        childVc: childVc,
                        crud: crud,
                        id: viewContainerId,
                        idUid: vcId,
                        mainVc: mainVc,
                        moduleId: moduleId,
                        parentVc: parentVc,
                        serverEvents: serverEvents,
                        subModuleId: subModuleId,
                        taskId: taskId,
                        taskVersion: taskVersion,
                        urlRestService: urlRestService,
                        urlLiferayRest: urlLiferayRest,
                        vcEvents: vcCustomEvents,
                        server: dsgnrCommons.utils.createResource(urlRestService, true),
                        serverCRUD: dsgnrCommons.utils.createResource(urlRestService + "/crud", true),
                        serverCRUDQueryEntities: dsgnrCommons.utils.createResource(urlRestService + "/crudQueryEntities", true),
                        serverCRUDQueryId: dsgnrCommons.utils.createResource(urlRestService + "/crudQueryId", true),
                        args: {},
                        catalogs: {},
                        currentValues: {},
                        customDialogParameters: {},
                        dialogParameters: {},
                        serverParameters: {},
                        lifeCycle: _lifeCycle,
                        grids: {},
                        uploaders: {},
                        metadata: {},
                        modalInstances: {},
                        model: {},
                        request: {},
                        queries: {},
                        seq: {},
                        submitted: {},
                        tmpModel: {},
                        trackers: {},
                        types: {},
                        viewState: {},
                        CRUDBuildTransactionRequest: _CRUDBuildTransactionRequest,
                        CRUDExecute: _CRUDExecute,
                        CRUDExecuteQueryEntities: _CRUDExecuteQueryEntities,
                        CRUDExecuteQueryId: _CRUDExecuteQueryId,
                        CRUDExecuteQuery: _CRUDExecuteQuery,
                        CRUDProcessResponse: _CRUDProcessResponse,
                        CRUDProcessQueryEntityResponse: _CRUDProcessQueryEntityResponse,
                        CRUDProcessQueryIdResponse: _CRUDProcessQueryIdResponse,
                        CRUDProcessQueryResponse: _CRUDProcessQueryResponse,
                        CRUDResetTrackers: _CRUDResetTrackers,
                        CRUDResetTracker: _CRUDResetTracker,
                        changeEvents: [],
                        loaded: false,
                        clickFileUploader: _clickFileUploader,
                        removeFile: _removeFile,
                        onFileUpload: _onFileUpload,
                        getCssClass: _getCssClass,
                        validateOnEnter: _validateOnEnter,
                        activeContainer: _activeContainer,
                        isDisabledContainer: _isDisabledContainer,
                        onFileSelect: _onFileSelect,
                        onSuccess: _onSuccess,
                        setVisibilityOfGridRowDetailIcon: _setVisibilityOfGridRowDetailIcon,
                        clickOnEnter: _clickOnEnter,
                        rowData: rowData,
                        onTabClosing: _onTabClosing,
                        customInputRestriction: _customInputRestriction,
                        customValidate: _customValidate,
                        convertCatalog: _convertCatalog,
                        handlerCloseModal: _handlerCloseModal,
                        hasOnCloseModalEvent: hasOnCloseModalEvent,
                        exportGrid: _exportGrid,
                        exportGridToExcel: _exportGridToExcel,
                        exportGridToPdf: _exportGridToPdf,
                        sessionElement: sessionElement,
                        setFalseValueForCheckBoxIfNull: _setFalseValueForCheckBoxIfNull,
                        getStringColumnFormat: _getStringColumnFormat,
                        exportColumns: _exportColumns,
                        setBreadcrumbs: _setBreadcrumbs,
                        getGridTemplate: _getGridTemplate,
                        getComboBoxTemplate: _getComboBoxTemplate
                    };

                    if (cobis.utils.isRunOnLiferay()) {
                        if (_isModal(viewContainer.scope) || _isDetailGrid(viewContainer.scope) || viewContainer.isDesignerInclude) {
                            _vc[vcId].isModalPage = true;
                            _vc[vcId].sessionElement = {};
                        } else {
                            _vc[vcId].isModalPage = false;
                            _getFromSession(vcId).then(function (sessionObject) {
                                _vc[vcId].sessionElement = sessionObject;
                                var parentVc = sessionObject.vcParent;
                                var mainVc = true;
                                var childVc = false;
                                if (parentVc) {
                                    mainVc = false;
                                    if (parentVc.moduleId === moduleId && parentVc.subModuleId === subModuleId &&
                                        parentVc.taskId === taskId && parentVc.taskVersion === taskVersion) {
                                        childVc = true;
                                    }
                                }
                                _vc[vcId].childVc = childVc;
                                _vc[vcId].mainVc = mainVc;
                                _vc[vcId].parentVc = parentVc;
                                _fillSessionInfo(sessionObject, _vc, vcId);
                            });
                        }
                    }

                    return _vc[vcId];
                },

                initCustomViewContainer: function (id, vcCustomEvents, rowData) {
                    var vcId = id;
                    if (angular.isDefined(rowData) && angular.isDefined(rowData.uid)) {
                        vcId = rowData.uid;
                    }
                    if (_vc[vcId]) {
                        _vc[vcId].loaded = true;
                        return _vc[vcId];
                    }

                    var parentVc = _parentVc(vcId);
                    var mainVc = true;
                    var childVc = false;
					var autoSyncNavigation  = false;
                    if (parentVc) {
                        mainVc = false;
                    }

                    if (angular.isUndefined(vcCustomEvents)) {
                        vcCustomEvents = {};
                    }

                    _vc[vcId] = {
                        id: id,
                        model: {},
                        dialogParameters: {},
                        customDialogParameters: {},
                        vcEvents: {},
                        mainVc: mainVc,
                        childVc: childVc,
						autoSyncNavigation: autoSyncNavigation,
                        parentVc: parentVc,
                        addChildVc: _addChildVc,
                        removeChildVc: _removeChildVc,
                        isModal: _isModal,
                        isDetailGrid: _isDetailGrid,
                        closeDialog: _closeDialog,
                        closeModal: _closeModal,
                        closeViewContainer: _closeViewContainer,
                        modalInstances: {},
                        vcEvents: vcCustomEvents,
                        afterCloseModal: _afterCloseModal,
                        url: _url,
                        rowData: rowData,
                        loaded: false,
                        args: {},
                        handlerCloseModal: _handlerCloseModal
                    };

                    return _vc[vcId];
                },

                viewContainer: function (id) {
                    return _vc[id];
                }
            };
		}]);
	})
);
