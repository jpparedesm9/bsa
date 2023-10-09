//Designer Generator v 6.4.0 - release SPR 2017-15 04/08/2017
/**
 * M&oacute;dulo Angular con las funciones de invocaci&oacute;n de eventos de
 * personalizaci&oacute;n a nivel de Clientes
 *
 * @module designerModule
 * @submodule designerCommons.js
 * @since 1.0.0
 */
/*global console */
/*jslint eqeq: true, nomen: true, bitwise: true, vars: true*/

(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module unless amdModuleId is set
        define("designerCommons", [], function () {
            return (factory(window.angular, window.kendo, window.kendo.jQuery, window.cobis, window));
        });
    }else {
        factory(window.angular, window.kendo, window.kendo.jQuery, window.cobis, window);
    }
} (this, function (angular, kendo, $, cobis, window) {
    'use strict';
    var app = angular.module('designerModule', [cobis.modules.CONTAINER]), timeOutIE = 600,
        logger = cobis.logging.getLoggerManager('designerCommons.js');

    /**
     * Utilitarios
     *
     * @class dsgnrUtils
     */
    app.service('dsgnrUtils',
        function () {

            // ******** UTILITARIOS PARA COMBOBOX *********

            /**
             * Comprueba que un componente comboBox tiene habilitado
             * el filtrado predictivo(autocomplete)
             *
             * @method isAutocompleteComboBox
             * @for dsgnrUtils
             * @param {Object} component Objeto javascript que representa el comboBox
             * @param {Object} config Objeto con datos de filtrado, existe en loadCatalog(), loadCobisCatalog(), executeQuery()
             * @return {boolean} true (filtrado predictivo habilitado) | false (filtrado predictivo habilitado)
             * @example isAutocompleteComboBox($('#VA_ID'), config);
             */
            function isAutocompleteComboBox(component, config) {
                var result = false,
                    filter = component.attr('k-filter'),
                    minLength = component.attr('k-min-length');
                if (filter && minLength && config) {
                    result = true;
                }
                return result;
            }

            /**
             * Comprueba que un componente comboBox tiene asociado
             * un dataSource con datos
             *
             * @method isDataSourceEmpty
             * @for dsgnrUtils
             * @param {Object} component Objeto javascript que representa el comboBox
             * @return {boolean} true (dataSource Vacio) | false (dataSource sin datos)
             * @example isDataSourceEmpty($('#VA_ID'));
             */
            function isDataSourceEmpty(component) {
                var widget = component.data('kendoExtComboBox')|| component.data('kendoExtDropDownList'),
                    result = false;
                if (angular.isDefined(widget) && widget.dataSource.data() && widget.dataSource.data().length === 0) {
                    result = true;
                }
                return result;
            }

            /**
             * Comprueba si esta comboBox es dependiente de otro
             * comboBox
             *
             * @method isCascade
             * @for dsgnrUtils
             * @param {Object} component Objeto javascript que representa el comboBox
             * @return {boolean} true (comboBox dependiente) | false (comBox no dependiente)
             * @example isCascade($('#VA_ID'));
             */
            function isCascade(component) {
                var cascadeFrom = component.attr('k-cascade-from');
                return ((typeof cascadeFrom !== typeof undefined) && (cascadeFrom !== false));
            }

            /**
             * Agrega la propiedad parentId al resultado cuando un combo o un dropDownList tiene cascada y filtro de cliente
             * @param filter
             * @param isCascade
             * @param responseData
             * @param parentId
             */
            function setParentId(responseData, parentId) {
                if (angular.isDefined(responseData) && responseData.length>0 && angular.isDefined(parentId)) {
                    responseData.forEach(function (item) {
                        item.parentId = parentId;
                    });
                }
            }

            /**
             * Comprueba si esta solicitud de filtrado es en
             * cliente, sin consultar el servicio de datos
             *
             * @method isClientFilteringRequest
             * @for dsgnrUtils
             * @param {Object} filtersOfLastRequest filtros de combo utilizados en el anterior filtrado
             * @param {Object} filtersOfCurrentRequest filtros de combo para el filtrado de datos actual
             * @param {Object} component Objeto javascript que representa el comboBox
             * @return {boolean} true (filtrado en cliente) | false (filtrado en servidor)
             * @example isClientFilteringRequest(filtersOfLastRequest, filtersOfCurrentRequest, $('#VA_ID'));
             */
            function isClientFilteringRequest(filtersOfLastRequest, filtersOfCurrentRequest, component) {
                var result = false,
                    lastFilter = {},
                    currentFilter = {},
                    existsAutocompleteFilterOnCurrentRequest = false,
                    cascade = isCascade(component), kendoComponent = component.data('kendoExtComboBox') || component.data('kendoExtDropDownList'),
                    valueField = kendoComponent.options.dataValueField,
                    textField = kendoComponent.options.dataTextField,
                    filerClient=kendoComponent._state==="filter"?true:false,
                    state = false, indexfilerClient=-1;
                if (component.attr('k-cache-on-client') && component.attr('k-cache-on-client') === 'true') {
                    if (angular.isDefined(filtersOfCurrentRequest)) {
                        angular.forEach(filtersOfCurrentRequest.filters, function (item,index) {
                            if (item.field === textField ) {
                                indexfilerClient=index;
                                if(angular.isDefined(item.ignoreCase) && item.value !== ''){
                                    existsAutocompleteFilterOnCurrentRequest = true;
                                }
                            }
                        });
                        if(!filerClient && indexfilerClient!==-1){
                            filtersOfCurrentRequest.filters.splice(indexfilerClient, 1);
                            if(kendoComponent.select()!==0){
                                kendoComponent.text('');
                            }
                        }
                    }
                    if (existsAutocompleteFilterOnCurrentRequest && filerClient) {
                        result = true;
                    }
                }
                return result;
            }

            /**
             * filtra manualmente los datos de un comboBox de
             * acuerdo a los criterios de filtrado
             *
             * @method filterDataInClient
             * @for dsgnrUtils
             * @param {Array} widget Objecto de kendo que representa el combobox
             * @param {Object} filter Información de filtrado, obtenidos automáticamente en componentes tipo comboBox
             * @return {Array} Arreglo de objetos que cumplieron los criterios de filtrado
             * @example filterDataInClient(widget, filter);
             */

            function filterDataInClient(widget, filter) {
                var results = [],
                    autocompleteFilter = null,
                    operator = null,
                    textField = widget.options.dataTextField;
                angular.forEach(filter.filters, function (item) {
                    if (angular.isDefined(item.ignoreCase)) {
                        autocompleteFilter = item;
                    }
                });
                if (autocompleteFilter !== null) {
                    operator = autocompleteFilter.operator;
                    angular.forEach(widget.dataSource.dataToBeFilterInClient, function (item) {
                        if (angular.isDefined(item[textField])) {
                            var itemValue = item[textField].toLowerCase(),
                                filterValue = autocompleteFilter.value.toLowerCase(),
                                m = null;
                            switch (operator) {
                                case 'eq':
                                    if (itemValue === filterValue) {
                                        results.push(item);
                                    }
                                    break;
                                case 'neq':
                                    if (itemValue !== filterValue) {
                                        results.push(item);
                                    }
                                    break;
                                case 'startswith':
                                    if (itemValue.indexOf(filterValue) === 0) {
                                        results.push(item);
                                    }
                                    break;
                                case 'contains':
                                    if (itemValue.indexOf(filterValue) >= 0) {
                                        results.push(item);
                                    }
                                    break;
                                case 'endswith':
                                    m = itemValue.match(filterValue + "$");
                                    if (m && m[0] === filterValue) {
                                        results.push(item);
                                    }
                                    break;
                                default:
                                    break;
                            }
                        }
                    });
                }
                return results;
            }


            // ************ UTILITARIOS PARA COMPONENTES Y CONTENEDORES **********************
            /*
             * Indica si el elemento está habilitado para setear el
             * foco
             *
             * No es un método expuesto en el API
             */
            function focusable(element) {
                var map, mapName, img,
                    nodeName = element.nodeName.toLowerCase(),
                    isTabIndexNotNaN = !isNaN($.attr(element, "tabindex"));

                function visible(element) {
                    return $.expr.filters.visible(element) && !$(element).parents().addBack().filter(function () {
                            return $.css(this, "visibility") === "hidden";
                        }).length;
                }

                if ("area" === nodeName) {
                    map = element.parentNode;
                    mapName = map.name;
                    if (!element.href || !mapName || map.nodeName.toLowerCase() !== "map") {
                        return false;
                    }
                    img = $("img[usemap=#" + mapName + "]")[0];
                    return !!img && visible(img);
                }
                return (/input|select|textarea|button|object/.test(nodeName) ? !element.disabled :
                        "a" === nodeName ?
                        element.href || isTabIndexNotNaN : isTabIndexNotNaN) &&
                    // the element and all of its ancestors must be visible
                    visible(element);
            }

            /*
             * Indica si el elemento está habilitado para setear el
             * foco, agregando otras validaciones de tipo de control
             * kendo
             *
             * No es un método expuesto en el API
             */
            function isFocusable(invalid) {
                var uiInvalid = null,
                    visibleInvalid1 = null,
                    visibleInvalid = null;

                if (focusable(invalid)) {
                    return true;
                } else {
                    uiInvalid = $("#" + invalid.id);
                    if (uiInvalid.data("kendoNumericTextBox")) {
                        visibleInvalid1 = uiInvalid.siblings("input:visible");
                        if (visibleInvalid1.length > 0 && focusable(visibleInvalid1[0])) {
                            return true;
                        }
                    } else if (uiInvalid.data("kendoExtComboBox")) {
                        visibleInvalid = uiInvalid.data("kendoExtComboBox").input;
                        if (visibleInvalid.length > 0 && focusable(visibleInvalid[0])) {
                            return true;
                        }
                    } else if (uiInvalid.data("kendoExtDropDownList")) {
                        visibleInvalid1 = uiInvalid.parent();
                        if (visibleInvalid1.length > 0 && focusable(visibleInvalid1[0])) {
                            return true;
                        }
                    }
                }
                return false;
            }

            /**
             * Setea el foco al id del control enviado
             *
             * @method focusControl
             * @for dsgnrUtils
             * @param {String} id del control
             * @example focusControl(controlId)
             */
            function focusControl(controlId) {
                var id = "#" + controlId,
                    control = $(id),
                    instanceControl = null,
                    uiControl = null,
                    visibleControl1 = null,
                    visibleControl = null;

                if (control) {
                    instanceControl = control[0];
                    if (instanceControl && instanceControl.hasAttribute('id')) {
                        if (focusable(instanceControl)) {
                            instanceControl.focus();
                        } else {
                            uiControl = $("#" + instanceControl.id);
                            if (uiControl.data("kendoNumericTextBox")) {
                                visibleControl1 = uiControl.siblings("input:visible");
                                if (visibleControl1.length > 0 && focusable(visibleControl1[0])) {
                                    visibleControl1.focus();
                                }
                            } else if (uiControl.data("kendoExtComboBox")) {
                                visibleControl = uiControl.data("kendoExtComboBox").input;
                                if (visibleControl.length > 0 && focusable(visibleControl[0])) {
                                    visibleControl.focus();
                                }
                            } else if (uiControl.data("kendoExtDropDownList")) {
                                visibleControl = uiControl.parent()[0];
                                visibleControl.focus();
                            }
                        }
                    }
                }
            }

            /*
             * Setea el foco en el componente dentro del tab
             *
             * No es un método expuesto en el API
             */
            function enabledContainerForFocus(container, component, currentElement) {
                var index = null,
                    panelbar = null,
                    item = null;
                if (angular.isDefined(container.data)) {
                    if (container.data("kendoTabStrip")) {
                        index = $(component).closest('.k-content').index();
                        if (index > 0) {
                            index = index - 1;
                        }
                        container.data("kendoTabStrip").select(index);
                    } else if (container.data("kendoPanelBar")) {
                        panelbar = container.data("kendoPanelBar");
                        item = $(component).closest('.k-panelbar > .k-item');
                        if (item.length > 0) {
                            if (item.hasClass('k-state-disabled')) {
                                item.removeClass('k-state-disabled');
                            }
                            container.find('> .k-item > .k-content').hide(); //
                            panelbar.expand(item, false);
                        }
                    } else if (container[0].className.indexOf("tab-pane") > -1) {
                        clickTabVertical(container[0].id, component, currentElement);
                    }
                }
            }

            /*
             * Habilita un contenedor de tipo Tab que tenga un visual Atributte requerido Se usa en tabs verticales y horizontales
             *
             * No es un método expuesto en el API
             */
            function clickTabVertical(idContainer, component, currentElement) {
                var tabSelector, tab, scope, ngClickContent, idGroups, focusElement;
                tabSelector = $("#" + idContainer + "_tab");
                tab = tabSelector.find("a");
                if (tab.length > 0 && isValidatedControl(currentElement) === true) {
                    scope = angular.element($("#" + idContainer)).scope();
                    ngClickContent = tab.attr("ng-click");
                    idGroups = ngClickContent.split("'");
                    if (angular.isDefined(scope)) {
                        scope.vc.clickTab(null, idGroups[1], idGroups[3]);
                        tabSelector.closest('.nav-pills').find('li.active').last().removeClass('active');
                        tabSelector.addClass('active');
                        if (angular.isUndefined(component.nodeName) && component.nodeName !== "INPUT") {
                            component = currentElement;
                        }
                        focusElement = isFocusable(component);
                        if (!focusElement) {
                            callTypeAndEnable(idContainer, component, currentElement);
                        } else {
                            component.focus();
                        }
                    }
                }
            }

            /*
             * Obtiene el nuevo id del Elemento Return recursividad hacia enabledContainerForFocus
             *
             * No es un métodoexpuesto en el API
             */
            function callTypeAndEnable(idGroup, component, currentElement) {
                var elem = "#" + idGroup;
                var cont = getContainerType(elem, component);
                if (angular.isDefined(cont)) {
                    enabledContainerForFocus(cont, component, currentElement);
                }
            }

            /*
             * Obtiene el tipo de contenedor return para tab horizontal el contenedor principal return para tab
             * vertical el id del grupo que contiene al
             *
             * No es un método expuesto en el API
             */
            function getContainerType(idGroup, component) {
                var container;
                if (idGroup != null) {
                    container = $(idGroup).closest('.k-tabstrip, .k-panelbar');
                } else {
                    container = $(component).closest('.k-tabstrip, .k-panelbar');
                }
                if (container.length > 0) {
                    return container;
                }
            }

            /*
             * Setea el foco en el componente dentro del tab
             *
             * No es un método expuesto en el API
             */
            function focusContainer(component, container) {
                var el = component;
                if (container && container.length > 0) {
                    el = container.parent();
                }
                container = $(el).closest('.k-tabstrip, .k-panelbar, .tab-pane');
                if (container.length > 0) {
                    enabledContainerForFocus(container, el, component);
                    if (!isFocusable(component)) {
                        focusContainer(component, container);
                    }
                }
            }

            /**
             * Retorna si el contenedor está o no activo
             *
             * @method activeContainer
             * @for dsgnrUtils
             * @param {Boolean} isDisabled booleano que indica si está o no deshabilitado el contenedor
             * @param {String} idContainerBefore id del contenedor anterior
             * @return {Boolean} indica si está o no activo el contenedor
             * @example activeContainer(true,'ID_CONTENEDOR_ANTERIOR')
             */
            function activeContainer(isDisabled, idContainerBefore) {
                if (idContainerBefore !== null) {
                    return ((!isDisabled || !angular.isDefined(isDisabled)) && $('#' + idContainerBefore).hasClass('k-state-disabled'));
                } else {
                    return !isDisabled;
                }
            }

            /**
             * Retorna si tiene el contenedor la clase k-state-disabled
             *
             * @method isDisabledContainer
             * @for dsgnrUtils
             * @param {String} idContainer id del contenedor a evaluar
             * @return {Boolean} indica si está o no deshabilitado
             * @example isDisabledContainer(controlId)
             */
            function isDisabledContainer(idContainer) {
                return $('#' + idContainer).hasClass('k-state-disabled');
            }

            /**
             * Setea el foco en el primero elemento no válido
             *
             * @method focusError
             * @for dsgnrUtils
             * @param {Object} validator componente validator que tenga el grupo a validar
             * @example focusError(validator)
             */
            function focusError(validator) {
                var invalidArr = validator.element.find(".k-invalid"),
                    controlFocus = null;

                if (invalidArr) {
                    controlFocus = getElementFocusError(validator);
                    if (controlFocus === null) {
                        return false;
                    } else {
                        controlFocus.focus();
                        return true;
                    }
                }
                return false;
            }

            /**
             * Obtiene el primer elemento invalido si no existe retorna null
             *
             * @method getElementFocusError
             * @for dsgnrUtils
             * @param {Object} validator componente validator que tenga el grupo a validar
             * @example getElementFocusError(validator)
             */
            function getElementFocusError(validator) {
                var invalidArr = validator.element.find(".k-invalid"),
                    i = 0,
                    invalid = null,
                    uiInvalid = null,
                    visibleInvalid1 = null,
                    visibleInvalid = null;

                if (invalidArr) {
                    for (i = 0; i < invalidArr.length; i = i + 1) {
                        invalid = invalidArr[i];
                        if (invalid.tagName.toLowerCase() !== "div" && invalid.tagName.toLowerCase() !== "span") {
                            focusContainer(invalid);
                            if (focusable(invalid) || isValidatedControl(invalid) === true) {
                                if (!focusable(invalid)) {
                                    setTimeout(function () {
                                        focusControl(invalid.id);
                                    })
                                }
                                return invalid;
                            } else {
                                uiInvalid = $("#" + invalid.id);
                                if (uiInvalid.data("kendoNumericTextBox")) {
                                    visibleInvalid1 = uiInvalid.siblings("input:visible");
                                    if (visibleInvalid1.length > 0 && focusable(visibleInvalid1[0])) {
                                        return visibleInvalid1;
                                    }
                                } else if (uiInvalid.data("kendoExtComboBox")) {
                                    visibleInvalid = uiInvalid.data("kendoExtComboBox").input;
                                    if (visibleInvalid.length > 0 && focusable(visibleInvalid[0])) {
                                        return visibleInvalid;
                                    }
                                } else if (uiInvalid.data("kendoExtDropDownList")) {
                                    visibleInvalid1 = uiInvalid.parent();
                                    if (visibleInvalid1.length > 0 && focusable(visibleInvalid1[0])) {
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                }
                return null;
            }

            /*
             * Utilitarios para habilitar componentes mediante
             * atributos
             *
             * No es un método expuesto en el API
             */
            function isValidatedControl(control) {
                var isVisible = getVisibility(control);
                return !(control.disabled === true || isVisible === false);
            }

            /*
             * Utilitario para verificar si el control está ocultobuscando ng-hide en el classList del control
             *
             * No es un método expuesto en el API
             */
            function getVisibility(control) {
                return !control.classList.contains('ng-hide');
            }

            /*
             * Utilitarios para habilitar componentes mediante atributos
             *
             * No es un método expuesto en el API
             */
            function forceEnabledAttributeForComponent(component, value) {
                if (value === true) {
                    component.removeAttr('disabled');
                    component.removeAttr('aria-disabled');
                } else {
                    component.attr('disabled', 'disabled');
                    component.attr('aria-disabled', true);
                }
            }

            function forceEnabledAttributeForContainerItem(componentId, value) {
                var item = $("li.k-item[id='" + componentId + "'], li.k-item[id='" + componentId + "_tab']"),
                    container = null;

                if (item.length === 1) {
                    forceEnabledAttributeForComponent(item, value);
                    container = $(item).closest('.k-panelbar, .k-tabstrip');
                    if (value === true) {
                        if (item.hasClass('k-state-disabled')) {
                            item.removeClass('k-state-disabled');
                        }
                    } else if (value === false) {
                        // for a panelBar
                        if (item.attr('aria-expanded')) {
                            container.data('kendoPanelBar').select(item);
                            container.data('kendoPanelBar').collapse(item);
                        }
                        if (!item.hasClass('k-state-disabled')) {
                            item.addClass('k-state-disabled');
                        }

                    }
                }
            }

            /**
             * Selector de todos los elementos de un formulario dentro de un
             * contenedor
             *
             * @method getElementsIdsInsideAContainer
             * @for dsgnrUtils
             * @param {String} idGroup Identificador del contenedor
             * @example viewState.getElementsIdsInsideAContainer('ID_CTRL_1');
             */
            function getElementsIdsInsideAContainer(idGroup) {
                var idList = [];
                $("#" + idGroup).find('input, select, textarea, button, div.form-control, div.k-grid').each(function () {
                    var id = $(this)[0].id, index = id.indexOf('-');
                    if (index > 0) {
                        id = id.substring(0, index);
                    }
                    idList.push(id);
                });
                return idList.filter(function(e) {return e !== "";});
            }

            /**
             * Selector de todos los contenedores de un formulario dentro de un
             * contenedor
             *
             * @method getContainersIdsInsideAContainer
             * @for dsgnrUtils
             * @param {String} idGroup Identificador del contenedor
             * @example viewState.getContainersIdsInsideAContainer('ID_CTRL_1');
             */
            function getContainersIdsInsideAContainer(idGroup) {
                var idList = [];
                $("#" + idGroup).find("li.k-item").each(function () {
                    var id = $(this)[0].id;
                    idList.push(id);
                });
                return idList;
            }

            /**
             * Permite setear la propiedad disable/enable , hide/show para VisualAttributes y Layouts
             *
             * @metod setPropertyComponent
             * @param {object}
             * @example var params = {
                                    propertyType: 'disabled',
                                    property: 'disabled',
                                    id: id,
                                    blockParent: blockParent,
                                    vc: _vc
                                }
             */
            function setPropertyComponent(params) {
                var idList, idContainersList, idSubGroupList, isIE = kendo.support.browser.msie,
                    IEversion = kendo.support.browser.version, contraryProperty = null, viewStateCondicion = null,
                    isHorizontalTab = null, that = this;
                switch (params.propertyType) {
                    case 'disabled':
                        contraryProperty = 'enabled';
                        viewStateCondicion = params.property === 'disabled';
                        break;
                    case 'visible':
                        contraryProperty = 'visible';
                        viewStateCondicion = params.property === 'show';

                        break;

                    default:
                        break;
                }
                if (params.property === 'disabled' || params.property === 'hide') {
                    params.vc.viewState[params.id][params.propertyType] = viewStateCondicion;
                    params.vc.viewState[params.id].disabledingroup = false;
                    this.component.forceAttributeSetting(params.id, contraryProperty, false);

                    if (isGroupOrViewContainer(params.id)) {
                        //deshabilita elementos
                        idList = this.container.getElementsIdsInsideAContainer(params.id);
                        angular.forEach(idList, function (identification) {
                            if (identification && identification !== ""
                                && params.vc.viewState[identification]) {
                                var component = $("#" + identification);
                                params.vc.viewState[identification].disabledingroup = true;
                                if ((component.data("kendoExtComboBox") || component.attr('kendo-ext-combo-box') || component.data("kendoExtDropDownList") || component.attr('kendo-ext-drop-down-list')) && angular.isDefined(component.attr('k-cascade-from'))) {
                                    if (isIE && IEversion > 10) {
                                        setTimeout(function () {
                                            that.component.forceAttributeSetting(identification, contraryProperty, false);
                                        }, timeOutIE);
                                    } else {
                                        that.component.forceAttributeSetting(identification, contraryProperty, false);
                                    }
                                }
                            }
                        });
                        //deshabilita sub grupos
                        idSubGroupList = this.container.getGroupsIdsInsideAContainer(params.id);
                        angular.forEach(idSubGroupList, function (idSubGroup) {
                            if (idSubGroup.indexOf("_VAL") > -1) {
                                idSubGroup = idSubGroup.slice(0, (idSubGroup.length - (idSubGroup.length - idSubGroup.indexOf("_VAL"))));
                            }
                            if (angular.isDefined(params.vc.viewState[idSubGroup])) {
                                params.vc.viewState[idSubGroup][params.propertyType] = viewStateCondicion;
                            }
                        });
                        //deshabilita tabs(li)
                        idContainersList = this.container.getContainersIdsInsideAContainer(params.id);
                        angular.forEach(idContainersList, function (identification) {
                            if (identification && identification !== "" && params.vc.viewState[identification]) {
                                params.vc.viewState[identification].disabledingroup = true;
                                that.component.forceAttributeSetting(identification, contraryProperty, params.vc.viewState[identification].disabledingroup || params.vc.viewState[identification][params.propertyType]);
                            }
                        });
                        //habilita el componente padre dpendiendo de blockParent
                        // ABU compatibilidad con funcionamiento inicial del bloque de contenedores
                        if (params.blockParent === undefined || !params.blockParent && contraryProperty === 'enabled') {
                            params.vc.viewState[params.id][params.propertyType] = false;
                            this.component.forceAttributeSetting(params.id, contraryProperty, true);
                        }
                    } else if (params.id.indexOf("VA_") > -1) {
                        hideMessageRequired(params.id);
                    }
                } else {
                    params.vc.viewState[params.id][params.propertyType] = viewStateCondicion;
                    params.vc.viewState[params.id].disabledingroup = false;
                    this.component.forceAttributeSetting(params.id, params.propertyType, true);
                    if (isGroupOrViewContainer(params.id)) {
                        //habilita grupos
                        idList = this.container.getElementsIdsInsideAContainer(params.id);
                        angular.forEach(idList, function (identification) {
                            if (identification && identification !== "" && params.vc.viewState[identification]) {
                                params.vc.viewState[identification].disabledingroup = false;
                            }
                        });

                        //habilita sub grupos
                        idSubGroupList = this.container.getGroupsIdsInsideAContainer(params.id);
                        angular.forEach(idSubGroupList, function (idSubGroup) {
                            if (idSubGroup.indexOf("_VAL") > -1) {
                                idSubGroup = idSubGroup.slice(0, (idSubGroup.length - (idSubGroup.length - idSubGroup.indexOf("_VAL"))));
                            }
                            if (angular.isDefined(params.vc.viewState[idSubGroup])) {
                                params.vc.viewState[idSubGroup][params.propertyType] = viewStateCondicion;
                            }
                        });
                        //habilita tabs(li)
                        idContainersList = this.container.getContainersIdsInsideAContainer(params.id);
                        angular.forEach(idContainersList, function (identification) {
                            if (identification && identification !== "" && params.vc.viewState[identification]) {
                                params.vc.viewState[identification].disabledingroup = false;
                                that.component.forceAttributeSetting(identification, params.propertyType, !(params.vc.viewState[identification].disabledingroup || params.vc.viewState[identification].disabled));
                            }
                        });

                        //habilita tab Horizontal
                        if ($("#" + params.id).closest('.cb-group-collapsible').length === 0) {
                            var tabHorizontalElement = $("#" + params.id);
                            isHorizontalTab = tabHorizontalElement.closest('.k-tabstrip, .k-panelbar').attr("id");
                            if (angular.isDefined(isHorizontalTab) && isHorizontalTab !== null) {
                                focusVA(idList);
                            } else if (tabHorizontalElement.closest(".cb-group, .cb-group-tabbed-h").length > 0) {
                                idList = this.container.getElementsIdsInsideAContainer(idSubGroupList[idSubGroupList.length - 1]);
                                focusVA(idList);
                            }
                        }
                    }
                }
            }

			function isGroupOrViewContainer(id) {
				var firstLetters = id.substring(0,2), response = false;
				if (firstLetters === 'VC' || firstLetters === 'GR' || firstLetters === 'G_') {
					response = true;
				}
				return response;
			}

            /**
             * Permite setear el foco a visual attribute
             * @param idList lista de id de visual Attributes en un contenedor
             */
            function focusVA(idList) {
                var idListSanitized = idList.filter(function(identification) {
                    return identification !== "";
                });

                focusContainer($("#" + idListSanitized[0])[0]);

                setTimeout(function() {
                    focusControl(idListSanitized.filter(function(identification) {
                        return isValidatedControl($('#' + identification)[0]);
                    })[0]);
                });
            }

            /**
             * Permite remover el mensaje de validación requerida en un Visual Attribute.
             * @param idControl
             */
            function hideMessageRequired(idControl) {
                if (idControl !== "" && idControl !== null && idControl !== undefined) {
                    var selectorControl = $("#" + idControl).siblings();
                    if (selectorControl.length > 0) {
                        for (var i = 0; i < selectorControl.length; i++) {
                            if (compareExceptions(selectorControl[i])) {
                                $(selectorControl[i]).find("span").remove();
                            }
                        }
                    }
                }
            }

            /**
             * Permite comparar excepciones para remover validación requerida.
             * @param control
             * @returns {boolean}
             */
            function compareExceptions(control) {
                var response = true;
                if (control.attributes["class"].value === 'k-dropdown-wrap k-state-default'
                    || control.attributes["class"].value === 'input-group-btn'
                    || control.attributes["class"].value !== "k-widget k-tooltip k-tooltip-validation k-invalid-msg") {
                    response = false;
                }
                return response;
            }

            /**
             * Selector de todos los sub grupos de un formulario dentro de un
             * contenedor
             *
             * @method getGroupsIdsInsideAContainer
             * @for dsgnrUtils
             * @param {String} idGroup Identificador del contenedor
             * @example viewState.getGroupsIdsInsideAContainer('ID_CTRL_1');
             */
            function getGroupsIdsInsideAContainer(idGroup) {
                var idList = [];
                $("#" + idGroup).find('div[id^="G_"],div[id^="GR_"]').each(function () {
                    var id = $(this)[0].id;
                    idList.push(id);
                });
                return idList;
            }

            /*
             * Permite forzar el seteo de los atributos disabled,
             * readOnly para componentes de kendo Para los otros
             * componentes no se requiere utilizar este mecanismo.
             */
            function forceAttributeSetting(componentId, attributeKey, attributeValue) {
                var isIE = kendo.support.browser.msie, IEversion = kendo.support.browser.version,
                    component = $("#" + componentId), componentData = null, isComboBox = false,
                    isDatePicker = false, isKendoComponent = false, isContainer = false, cascadeFrom = null;

                if (component.length > 0) {
                    if (componentId.indexOf("VA_") !== -1) {
                        if (component.data("kendoExtComboBox") || component.attr('kendo-ext-combo-box')) {
                            componentData = component.data("kendoExtComboBox");
                            isKendoComponent = true;
                            isComboBox = true;
                        } else if (component.data("kendoNumericTextBox") || component.attr('kendo-numeric-text-box')) {
                            componentData = component.data("kendoNumericTextBox");
                            isKendoComponent = true;
                        } else if (component.data("kendoDatePicker") || component.attr('kendo-date-picker')) {
                            componentData = component.data("kendoDatePicker");
                            isDatePicker = true;
                            isKendoComponent = true;
                        } else if (component.data("kendoMaskedTextBox") || component.attr('kendo-masked-text-box')) {
                            componentData = component.data("kendoMaskedTextBox");
                            isKendoComponent = true;
                        } else if (component.data("kendoExtDropDownList") || component.attr('kendo-ext-drop-down-list')) {
                            componentData = component.data("kendoExtDropDownList");
                            isKendoComponent = true;
                        }
                    } else if (componentId.indexOf("GR_") !== -1) {
                        isContainer = true;
                    }

                    if (isKendoComponent) {
                        switch (attributeKey) {
                            case 'enabled':
                                if (isDatePicker === true) {
                                    //siempre se debe ejecutar este método, sin importar el navegador
                                    forceEnabledAttributeForComponent(component, attributeValue);
                                } else if (isIE && IEversion > 10) {
                                    cascadeFrom = component.attr('k-cascade-from');
                                    if (angular.isDefined(cascadeFrom)) {
                                        //en caso de un combox dependiente en IE 11 o superior
                                        setTimeout(function () {
                                            forceEnabledAttributeForComponent(component, attributeValue, isComboBox);
                                        }, timeOutIE);
                                    } else {
                                        //en caso de un cualquier componente kendo en IE 11 o superior
                                        forceEnabledAttributeForComponent(component, attributeValue, isComboBox);
                                    }
                                }
                                break;
                            case 'readonly':
                                componentData.readonly(attributeValue);
                                break;
                            case 'visible':
                                if (component.data("kendoNumericTextBox")) {
                                    if (attributeValue === true) {
                                        componentData.wrapper.find('*').removeClass('ng-hide');
                                    }
                                }
                                break;
                            default:
                                break;
                        }
                    } else if (isContainer) {
                        switch (attributeKey) {
                            case 'enabled':
                                forceEnabledAttributeForContainerItem(componentId, attributeValue);
                                break;
                            default:
                                break;
                        }
                    }
                }
            }

            function getCssClass(componentId, elementStyles, auxStylesMap, elementStylesByDsgnrId) {
                var css = '';
                elementStyles = angular.isDefined(elementStylesByDsgnrId) ? elementStylesByDsgnrId : elementStyles;
                if (angular.isDefined(elementStyles)) {
                    angular.forEach(elementStyles, function (value) {
                        css = css + value + ' ';
                    });
                }
                if (angular.isDefined(auxStylesMap)) {
                    angular.forEach(auxStylesMap, function (value, key) {
                        if (value === true) {
                            css = css + key + ' ';
                        }
                    });
                }
                return css;
            }

            function validateOnEnter(e, vc) {
                if (typeof (e) !== "undefined" && (e.keyCode === 13)) {
                    var idExecuteButton = "", element = e.target.id,
                        selectorElement = $("#" + element), exec = false, combo = e.target.getAttribute("aria-owns"),
                        queryView = selectorElement.parents(".cb-queryview"), otherGroup = false,
                        idCombo, parentIndependetValidation, simpleParent, idButtonSimpleParent, containers, numOfContainers, j, i, group,
                        parentOfGroup, numOfChildren, child, getIndependetValidation, idCommandOld, idCommandNew;

                    if (queryView.length === 0) {
                        if (combo !== null) {
                            idCombo = combo.substring(0, 25);
                            selectorElement = $("#" + idCombo);
                        }
                        parentIndependetValidation = selectorElement.parents("[cb-validator='cb-validation-independent']");
                        simpleParent = selectorElement.parents(".cb-group").first();
                        idButtonSimpleParent = simpleParent.find("button[type='submit']").attr('id');
                        if (parentIndependetValidation.length !== 0) {
                            idExecuteButton = parentIndependetValidation.find("button[type='submit']").attr('id');
                            if (typeof (idExecuteButton) === "undefined") {
                                logger.warn("Info: El grupo tiene validacion independiente pero no tiene boton tipo submit en el mismo grupo. Enter-Submit Not Found.");
                            }
                        } else if (typeof (idButtonSimpleParent) !== "undefined") {
                            idExecuteButton = idButtonSimpleParent;
                        } else {
                            otherGroup = true;
                        }
                    }
                    // si el boton está en el mismo grupo del elemento
                    if (typeof (idExecuteButton) !== "undefined" && otherGroup === false) {
                        vc.clickOnEnter(idExecuteButton);
                        exec = true;
                    } else if (otherGroup === true) { // el boton está en otro grupo ovista
                        containers = selectorElement.parents().find('.container');
                        numOfContainers = containers.length;
                        cbis: for (j = 0; j < numOfContainers; j = j + 1) {
                            group = containers.children().eq(j);
                            parentOfGroup = group.find('.cb-fields');
                            numOfChildren = parentOfGroup.length;
                            for (i = 0; i < numOfChildren; i = i + 1) {
                                child = parentOfGroup.children().eq(i);
                                getIndependetValidation = child.parents("[cb-validator='cb-validation-independent']");
                                if (typeof (getIndependetValidation) === 'undefined' || getIndependetValidation.length === 0) {
                                    idExecuteButton = child.find("button[type='submit']").attr('id');
                                    if (typeof (idExecuteButton) !== "undefined") {
                                        vc.clickOnEnter(idExecuteButton);
                                        exec = true;
                                        break cbis;
                                    }
                                }
                            }
                        }
                    }
                    // El boton tipo submit está en la barra de tarea "Command"
                    if (exec === false && otherGroup === true) {
                        idCommandOld = selectorElement.parents().find('.cb-control-bar-placeholder').find("button[type='submit']").attr('id');
                        idCommandNew = selectorElement.parents().find('.cb-navbar-placeholder').find("button[type='submit']").attr('id');
                        if (typeof (idCommandOld) !== "undefined") {
                            vc.clickOnEnter(idCommandOld);
                        } else if (typeof (idCommandNew) !== "undefined") {
                            vc.clickOnEnter(idCommandNew);
                        }
                    }
                }
            }

            /**
             * Permite obtener el componente de kendo dado el id de
             * grupo. Este método aplica contenedores tipo Tab,
             * Colapsables y Acodeón, caso contrario, devuelve null
             *
             *
             * @method getKendoContainer
             * @for dsgnrUtils
             * @param {String} idGroup Identificador del contenedor
             */
            function getKendoContainer(idGroup) {
                var container = null, componentWrapper, htmlComponent = null, containerType = null;

                componentWrapper = $("#" + idGroup);
                if (componentWrapper) {
                    if (componentWrapper.hasClass('cb-group-tabbed-h')) {
                        htmlComponent = $("#" + idGroup + " > .k-tabstrip-wrapper > .k-tabstrip");
                        containerType = "kendoTabStrip";
                    } else if (componentWrapper.hasClass('cb-group-collapsible')) {
                        htmlComponent = $("#" + idGroup + " > .k-tabstrip-wrapper > .k-tabstrip");
                        containerType = "kendoPanelBar";
                    } else if (componentWrapper.hasClass('cb-group-accordion')) {
                        htmlComponent = $("#" + idGroup + " > .k-tabstrip-wrapper > .k-tabstrip");
                        containerType = "kendoPanelBar";
                    }
                    if (containerType === 'kendoTabStrip') {
                        container = htmlComponent.data(containerType);
                    } else if (containerType === 'kendoPanelBar') {
                        container = htmlComponent.data(containerType);
                    }
                }
                return container;
            }

            /**
             * Permite obtener el index de un Tab seleccionado Este
             * método aplica contenedores tipo Tab, caso contrario,
             * devuelve null
             *
             * @method getSelectedIndexTab
             * @for dsgnrUtils
             * @param {String} container Identificador del contenedor
             */

            function getSelectedIndexTab(container) {
                var indexTab = -1;
                if (container.data("kendoTabStrip")) {
                    indexTab = container.data("kendoTabStrip").select().index();
                }
                return indexTab;

            }

            /**
             * Permite seleccionar un tab dado el index Este método
             * aplica contenedores tipo Tab,
             *
             * @method selectTab
             * @for dsgnrUtils
             * @param {String} container Identificador del contenedor
             * @param {Integer} index del tab que se requiere seleccionar
             */

            function selectTab(container, index) {
                if (container.data("kendoTabStrip")) {
                    container.data("kendoTabStrip").select(index);
                }
            }

            /**
             * Permite obtener el container dado un componente Este
             * método aplica contenedores tipo Tab,
             *
             * @method selectTab
             * @for dsgnrUtils
             * @param {String} container Identificador del contenedor
             * @param {Integer} index index del tab que se requiere seleccionar
             */
            function getContainerTab(component) {
                var container = $(component).closest('.k-tabstrip');
                if (container.length > 0) {
                    return container;
                } else {
                    return null;
                }
            }

            // ************ UTILITARIOS PARA DETERMINAR VERSIONES DE TAREAS, FRAMEWORK **********************

            function getDesignerFrameworkVersion() {
                var params = window.param,
                    stringVersion = null,
                    designerVersion = null;
                if (angular.isDefined(params)) {
                    stringVersion = params.dsgnr_vrsn;
                    if (angular.isDefined(stringVersion)) {
                        designerVersion = Number(stringVersion.substring(6, 10));
                    }
                }
                return designerVersion;
            }

            function isNewDesignerFrameworkVersion() {
                var version = getDesignerFrameworkVersion(), result = false;
                if (version !== null && version >= 1520) {
                    result = true;
                }
                return result;
            }

            // ************ UTILITARIOS PARA MINIFICATION **********************
            /*
             * Obtiene la url hacia el archivo generado manualmente dependiendo de variable js de session
             * 'debuggingMode' y flag de API de navegacion customAddress.useMinification
             */
            function getCustomFilePath(url, useMinification) {
                var filePath = url,
                    lengthUrl,
                    firstCharacter;
                if (useMinification !== false && sessionStorage && sessionStorage.getItem('debuggingMode') !== 'true') {
                    filePath = url.replace('.js', '.min.js');
                }
                lengthUrl = filePath.length;
                if (lengthUrl > 0) {
                    firstCharacter = filePath.charAt(0);
                    if (firstCharacter == '/' || firstCharacter == '\\') {
                        filePath = filePath.substr(1);
                    }
                }
                return filePath;
            }

            function getMinificationExt() {
                var extension = ".min";
                if (sessionStorage && sessionStorage.getItem('debuggingMode') === 'true') {
                    extension = "";
                }
                return extension;
            }

            return {
                combobox: {
                    isAutocompleteComboBox: isAutocompleteComboBox,
                    isClientFilteringRequest: isClientFilteringRequest,
                    isCascade: isCascade,
                    filterDataInClient: filterDataInClient,
                    setParentId:setParentId

                },
                component: {
                    forceAttributeSetting: forceAttributeSetting,
                    focusError: focusError,
                    getElementFocusError: getElementFocusError,
                    focusControl: focusControl,
                    getCssClass: getCssClass,
                    forceEnabledAttributeForComponent: forceEnabledAttributeForComponent
                },
                container: {
                    getElementsIdsInsideAContainer: getElementsIdsInsideAContainer,
                    getContainersIdsInsideAContainer: getContainersIdsInsideAContainer,
                    getGroupsIdsInsideAContainer: getGroupsIdsInsideAContainer,
                    validateOnEnter: validateOnEnter,
                    activeContainer: activeContainer,
                    isDisabledContainer: isDisabledContainer,
                    getKendoContainer: getKendoContainer,
                    getSelectedIndexTab: getSelectedIndexTab,
                    selectTab: selectTab,
                    getContainerTab: getContainerTab

                },
                task: {
                    getDesignerFrameworkVersion: getDesignerFrameworkVersion,
                    isNewDesignerFrameworkVersion: isNewDesignerFrameworkVersion
                },
                minification: {
                    getCustomFilePath: getCustomFilePath,
                    getMinificationExt: getMinificationExt
                },
				setPropertyComponent: setPropertyComponent
            };
        });

    /**
     * Invocador de Personalizaciones de Eventos
     *
     * @class dsgnrCommons
     *
     */
    app.service('dsgnrCommons', ["cobisMessage", "dsgnrUtils", "$resource", "$route", "$rootScope", "$modal", "$filter", "$injector", "$ocLazyLoad", "$http", "$timeout", "$q", "$parse",
        function (cobisMessage, dsgnrUtils, $resource, $route, $rootScope, $modal, $filter, $injector, $ocLazyLoad, $http, $timeout, $q, $parse) {

            if ($injector.has('dsgnrExt')) {
                var dsgnrExt = $injector.get('dsgnrExt');
            }

		    if ($injector.has('keepAliveUtils')) {
                var keepAliveUtils = $injector.get('keepAliveUtils');
            }


            /**
             * Colecci&oacute;n de constantes usadas en el API
             *
             * @property constants
             * @type Object
             */
            var _constants = {
                mode: {
                    None: 0,
                    Insert: 1,
                    Update: 2,
                    Delete: 4,
                    Query: 8,
                    All: 4095
                },
                event: {
                    InitData: "initData",
                    ChangeInitData: "changeInitData",
                    LoadCatalog: "loadCatalog",
                    LoadCatalogCobis: "loadCatalogCobis",
                    ExecuteQuery: "executeQuery",
                    ExecuteCommand: "executeCommand",
                    ExecuteLabelCommand: "executeLabelCommand",
                    ExecuteGridRowCommand: "gridRowCommand",
                    ExecuteGridCommand: "gridCommand",
                    GridRowUpdating: "gridRowUpdating",
                    GridRowInserting: "gridRowInserting",
                    GridRowDeleting: "gridRowDeleting",
                    GridRowSelecting: "gridRowSelecting",
                    GridRowRendering: "GridRowRendering",
                    ShowGridRowDetailIcon: "showGridRowDetailIcon",
                    ValidateTransaction: "validateTransaction",
                    GridBeforeEnterInLineRow: "gridBeforeEnterInLineRow",
                    GridAfterLeaveInLineRow: "gridAfterLeaveInLineRow",
                    Change: "change",
                    TabClosing: "tabClosing",
                    OnCloseModalEvent: "onCloseModalEvent"
                },
                gridInlineWorkMode: {
                    Insert: 0,
                    Update: 1,
                    Delete: 2
                },
                dialogCloseResult: {
                    Cancel: 1,
                    Accept: 2
                },
                dialogCloseType: {
                    // Si se cerro usando el boton de
                    // aceptar o cancel
                    Interactive: 0,
                    // Si cerro usando la [X] de la ventana
                    NonInteractive: 1
                },
                styles: {
                    Success: 0,
                    Fail: 1,
                    None: 2
                },
                labelTypes: {
                    LABEL: "LBL",
                    MESSAGE: "MSG",
                    SYSTEM: "SYS"
                },
                typeNavigation: {
                    NORMAL: "normal",
                    INPORTLET: "inPortlet",
                    OUTPORTLET: "outPortlet"
                }
            }, $designerPopover;

            if ($injector.has('$designerPopover')) {
                $designerPopover = $injector.get('$designerPopover');
            }

            function _uuid() {
                var s = [], hexDigits = "0123456789abcdef", i;
                for (i = 0; i < 36; i = i + 1) {
                    s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
                }
                s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
                s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
                s[8] = s[13] = s[18] = s[23] = "-";
                return s.join("");
            }

            function _lockUnlockScreen(time, option) {
                if (option === 1) {
                    if (angular.isDefined(time) && time !== null) {
                        cobis.showMessageWindow.loading(true);
                        setTimeout(function () {
                            cobis.showMessageWindow.loading(false);
                        }, time);
                    } else {
                        cobis.showMessageWindow.loading(true);
                        logger.warn("blockScreen: No se especifico tiempo para desbloquear la pantalla. Debe usar unlock screen en la pantalla a la que navego");
                    }
                } else {
                    cobis.showMessageWindow.loading(false);
                }
            }

            function _createInternalResource(url, transformRequest, transformResponse) {
                return $resource(url, {}, {
                    post: {
                        method: 'POST',
                        transformRequest: transformRequest,
                        transformResponse: transformResponse,
                        params: {
                            exceptionHandling: false,
                            returnOnlyData: false
                        }
                    }
                });
            }

            function _createResource(url, dateFiltering) {
                if (dateFiltering) {
                    var transformRequest = [

                            function (obj) {
								return JSON.stringify(obj, function (key, value) {
										if (this[key] instanceof Date) {
											var dateAsString = cobis.userContext.getValue(cobis.constant.TIME_ZONE_RAW_OFFSET);
											dateAsString = angular.isUndefined(dateAsString) || dateAsString === null ? true : false;
											console.log('[Request] DateAsString: ', dateAsString);
											if (dateAsString) {
											// Si el objeto de javascript es de tipo Date se convierte al formato "/Date(yyyy-MM-dd hh:mm:ss)/ sin usar diferencia horaria"
												return this[key].getSerializedDate();
											} else {
												// Si el objeto de javascript es de tipo Date se convierte al formato "/Date(time)/ usando diferencia horaria"
												var auxDate = new Date();
												var auxTime = this[key].getTime() - (cobis.userContext.getValue(cobis.constant.TIME_ZONE_RAW_OFFSET)) - auxDate.getTimezoneOffset() * 60000;
												return "/Date(" + auxTime + ")/";
											}
                                        }
                                        return value;
                                    });
                            },
                            function (data) {
                                if (!$rootScope.count) {
                                    $rootScope.count = 0;
                                }
                                $rootScope.count = $rootScope.count + 1;
                                // $("#spinner").show(); // show loading div for
                                // $("div[id^='loader'].loading-div").show(); // designer's service request
                                cobis.showMessageWindow.loading(true);
                                return data;
                            }],
                        transformResponse = function (data) {
                            var dataObject = {};
                            try {
                                dataObject = JSON.parse(data, function (key, value) {
                                    // Si el valor tiene el format "/Date(time)/" se
                                    // convierte los milisegundos (time)
                                    // en un objeto Date de javascript.
                                    if (value && value !== null && typeof (value) === "string" && value.indexOf("/Date(") == 0 &&
                                        value.charAt(value.length - 1) == "/" && value.charAt(value.length - 2) == ")") {
										var dateAsString = cobis.userContext.getValue(cobis.constant.TIME_ZONE_RAW_OFFSET);
											dateAsString = angular.isUndefined(dateAsString) || dateAsString === null ? true : false;
											console.log('[Response] DateAsString: ', dateAsString);
											if (dateAsString) {
												// ... se retorna fecha a partir de cadena sin tomar en cuenta diferencia horaria
												return new Date().fromSerializedDate(value);
											} else {
												// ...se convierte los milisegundos (time)
												// en un objeto Date de javascript, tomando en cuenta diferencia horaria
												var time = parseInt(value.substring(6, value.length - 2), 10);
												var auxDate = new Date();
												return new Date(time + (cobis.userContext.getValue(cobis.constant.TIME_ZONE_RAW_OFFSET)) + auxDate.getTimezoneOffset() * 60000);
											}
                                    }
                                    return value;
                                });
                            } catch (e) {
                            }
                            return dataObject;
                        };
                    return _createInternalResource(url, transformRequest, transformResponse);
                }
                return _createInternalResource(url);
            }

            function _errorCallback(response) {
                if (angular.isDefined(response.status)) {
                    if (response.data.messages[0].code !== 80103) { // codigo de invalid session
                        cobisMessage.showMessagesError(response.status + " - " + response.statusText);
                        logger.error("Error: " + response);
                    }
                } else {
                    if (response.messages !== "Internal Server Error" && response.messages !== "Unauthorized") {
                        cobisMessage.showMessagesError(response.messages);
                    }
                    logger.error("Error: " + response);
                }
            }

            function _generatePrimaryKeyMap(strKeys) {
                var pks = {}, entities, n, entity, attributePkList, divide, arrayPks, m;
                if (strKeys !== null) {
                    entities = strKeys.split(";"); // entidades
                    for (n = 0; n < entities.length; n = n + 1) {
                        entity = entities[n];
                        attributePkList = [];
                        divide = entity.split("="); // atributos
                        arrayPks = [];
                        if (divide.length == 1) { // es porque solo se recibe una entidad
                            arrayPks = divide[0].split("|"); // valores de atributos
                            pks["0"] = attributePkList;
                        } else {
                            arrayPks = divide[1].split("|"); // atributos
                            pks[divide[0]] = attributePkList;
                        }
                        for (m = 0; m < arrayPks.length; m = m + 1) {
                            attributePkList.push(arrayPks[m]);
                        }
                    }
                }
                return pks;
            }

            // ENT00100=76|45;ENT00101=75
            function _generatePrimaryKeyString(pks) {
                var keyStr = "", item, attributePkList, count, size, m;
                for (item in pks) {
                    if (Object.keys(pks).length > 1) { // numero de elementos
                        keyStr += item + "=";
                    }
                    attributePkList = pks[item];
                    count = 0;
                    size = attributePkList.length;
                    for (m = 0; m < attributePkList.length; m = m + 1) {
                        keyStr += attributePkList[m];
                        count = count + 1;
                        if (count < size) {
                            keyStr += "|";
                        }
                    }
                    if (Object.keys(pks).length > 1) {
                        keyStr += ";";
                    }
                }
                return keyStr;
            }

                /**
                 * Colecci&oacute;n de eventos de
                 * Personalizaci&oacute;n
                 *
                 * @class API
                 * @namespace commons
                 * @type Object
                 */
                var _API = (function () {
                    function API(vc) {
                        /**
                         * { Agrupaci&0acute;n de eventos de
										 * ViewContainer
										 *
										 * @attribute vc
                         * @type Array
                         */
                        var _vc = vc;

                    function _nextSeq(entity) {
                        return _vc.nextSeq(entity);
                    }

                        /*
                         * M&eacute;todo recursivo para cargar
                         * librer&iacute;as en forma
                         * sincronizada de acuerdo al orden
                         * enviado
                         *
                         * method _loadSyncLibraries param {int}
                         * length Longitud de librer&iacute;as a
                         * cargar param {Array} scriptPath
                         * Arreglo con las rutas de Scripts a
                         * cargar param {int} cont
                         * Posici&oacute;n actual de
                         * librer&iacute;a cargada param
                         * {promise} deferred Objeto Tipo
                         * Promesa para enlazar carga de
                         * librer&iacute;as example
                         * _loadSyncLibraries(that.scripts.length-1,that.scripts,1,
                         * deferred);
                         */
                        function _loadSyncLibraries(length,
                                                    scriptPath, cont, deferred) {
                            var promise = deferred;
                            if (length == 0) {
                                return function () {
                                    $rootScope
                                        .$apply(function () {
                                            promise
                                                .resolve();
                                        });
                                };

                        } else {
                            console.log("lib ==>" + "${contextPath}/cobis/web/views" + scriptPath[cont]);
                            return function () {
                                window.$script("${contextPath}/cobis/web/views" + scriptPath[cont], _loadSyncLibraries(length - 1, scriptPath, cont + 1, promise));
                            };
                        }
                    }

                    /*
                     * M&eacute;todo recursivo para cargar librer&iacute;as en forma
                     * as&iacute;ncrona sin importar el orden enviado
                     *
                     * method _loadAsyncLibraries param {int} length Longitud de
                     * librer&iacute;as a cargar param {Array} scriptPath Arreglo  con
                     * las rutas de Scripts a cargar param {int} cont
                     * Posici&oacute;n actual de librer&iacute;a cargada param
                     * {promise} deferred Objeto Tipo Promesa para enlazar carga de
                     * librer&iacute;as example
                     * _loadAsyncLibraries(that.scripts.length-1,that.scripts,1,
                     * deferred);
                     */
                    function _loadAsyncLibraries(length, scriptPath, cont, deferred) {
                        var promise = deferred;
                        if (length == 0) {
                            return function () {
                                $rootScope.$apply(function () {
                                    promise.resolve();
                                });
                            };

                        } else {
                            console.log("lib ==>" + "${contextPath}/cobis/web/views" + scriptPath[cont]);
                            return window.$script("${contextPath}/cobis/web/views" + scriptPath[cont], _loadAsyncLibraries(length - 1, scriptPath, cont + 1, promise));
                        }
                    }

                    function _setStyle(groupId, style, numErrors) {
                        switch (style) {
                            case _constants.styles.Success:
                                _vc.viewState[groupId].statusStyle.success = true;
                                _vc.viewState[groupId].statusStyle.fail = false;
                                _vc.viewState[groupId].statusStyle.none = false;
                                _vc.viewState[groupId].statusStyle.numErrors = undefined;
                                break;
                            case _constants.styles.Fail:
                                _vc.viewState[groupId].statusStyle.success = false;
                                _vc.viewState[groupId].statusStyle.fail = true;
                                _vc.viewState[groupId].statusStyle.none = false;
                                _vc.viewState[groupId].statusStyle.numErrors = numErrors;
                                break;
                            default:
                                _vc.viewState[groupId].statusStyle.success = false;
                                _vc.viewState[groupId].statusStyle.fail = false;
                                _vc.viewState[groupId].statusStyle.none = true;
                                _vc.viewState[groupId].statusStyle.numErrors = undefined;
                                break;
                        }
                    }

                    /**
                     * Permite obtener una instancia del API
                     * para manipular la pantalla (ViewContainer) padre
                     *
                     * @method parentApi
                     * @example var parentApi = args.commons.api.parentApi();
                     */
                    var _parentApi = function () {
                        if (angular.isDefined(_vc.parentVc)) {
                            return new API(_vc.parentVc);
                        }
                    };

                    /**
                     * Arreglo para manejo de eventos de Visualizaci&oacute;n de Controles
                     *
                     * @attribute viewState
                     * @type Object
                     */
                    var _viewState = {
                        /**
                         * Validar si el control referido est&aacute; deshabilitado
                         *
                         * @method isDisabled
                         * @param {String} id Identificador del control
                         * @return {Boolean} Estado True - deshabilitado / False -Habilitado
                         * @example viewState.isDisabled('ID_CTRL_1');
                         */
                        isDisabled: function (id) {
                            return _vc.viewState[id].disabled || _vc.viewState[id].disabledingroup;
                        },
                        /**
                         * Validar si el control referido est&aacute; visible
                         *
                         * @method isVisible
                         * @param {String} id Identificador del control
                         * @return {Boolean} Estado True - visible / False - no visible
                         * @example viewState.isVisible('ID_CTRL_1');
                         */
                        isVisible: function (id) {
                            return _vc.viewState[id].visible;
                        },
                        /**
                         * Validar si el control referido est&aacute; marcado como Solo Lectura
                         *
                         * @method isReadOnly
                         * @param {String} id Identificador del control
                         * @return {Boolean} Estado True - solo lectura / False - no solo lectura
                         * @example viewState.isReadOnly('ID_CTRL_1');
                         */
                        isReadOnly: function (id) {
                            return _vc.viewState[id].readonly;
                        },
                        /**
                         * Desactiva el control o un grupo de controles dentro de un
                         * contenedor, dependiendo si el id dado es de un control o
                         * contenedor
                         *
                         * @method disable
                         * @param {String} id Identificador del control
                         * @param {boolean} blockParent este boleano indica si el control padre debe quedar bloqueado
                         *                  aplica para pestanias, colapsables, acordiones. Si queda bloqueado
                         *                  no se puede ni abrir ni observar los controles internos del contenedor
                         * @example viewState.disable('ID_CTRL_1');
                         */
                        disable: function (id, blockParent) {
                            if (angular.isDefined(_vc.viewState[id]) && !this.isDisabled(id)) {
                                var params = {
                                    propertyType: 'disabled',
                                    property: 'disabled',
                                    id: id,
                                    blockParent: blockParent,
                                    vc: _vc
                                };
                                dsgnrUtils.setPropertyComponent(params);
                            } else {
                                console.log("Can not be disabled, component not found " + id);
                            }
                        },
                        /**
                         * Activa el control o un grupo de controles dentro de un contenedor, dependiendo si el id
                         * dado es de un control o contenedor.
                         *
                         * @method enable
                         * @param {String} id Identificador del control or contenedor
                         * @example viewState.enable('ID_CTRL_1');
                         */
                        enable: function (id) {
                            if (angular.isDefined(_vc.viewState[id])) {
                                var params = {
                                    propertyType: 'disabled',
                                    property: 'enable',
                                    id: id,
                                    vc: _vc
                                };
                                dsgnrUtils.setPropertyComponent(params);
                            } else {
                                console.log("Can not be enable, component not found " + id);
                            }
                        },

                        /**
                         * Oculta el control solicitado
                         *
                         * @method hide
                         * @param {String} id Identificador del control
                         * @example viewState.hide('ID_CTRL_1');
                         */
                        hide: function (id) {
                            if (angular.isDefined(_vc.viewState[id])) {
                                var params = {
                                    propertyType: 'visible',
                                    property: 'hide',
                                    id: id,
                                    vc: _vc
                                };
                                dsgnrUtils.setPropertyComponent(params);
                            } else {
                                console.log("Can not be visible, component not found " + id);
                            }
                        },
                        /**
                         * Visualiza el control solicitado
                         *
                         * @method show
                         * @param {String} id Identificador del control
                         * @example viewState.show('ID_CTRL_1');
                         */
                        show: function (id) {
							if (angular.isDefined(_vc.viewState[id])) {
                               var params = {
									propertyType: 'visible',
									property: 'show',
									id: id,
									vc: _vc
								};
                                dsgnrUtils.setPropertyComponent(params);
                            } else {
                                console.log("Can not be enable, component not found " + id);
                            }
                        },
                        /**
                         * Permite activar/desactivar el control como Solo Lectura
                         *
                         * @method readOnly
                         * @param {String} id Identificador del control
                         * @example viewState.readOnly('ID_CTRL_1',true); -- para activar
                         *          viewState.readOnly('ID_CTRL_1', false); --
                         *          para desactivar
                         */
                        readOnly: function (id, value) {
                            _vc.viewState[id].readonly = value;
                        },
                        /**
                         * Permite agregar un estilo al elemento solicitado
                         *
                         * @method addStyle
                         * @param {String} id Identificador del control
                         * @param {String} styleName Identificador del estilo
                         * @example viewState.addStyle('ID_CTRL_1','estilo1');
                         */
                        addStyle: function (id, styleName) {
                            var style = [], nStyleName = styleName, newValues = [];
                            if (angular.isDefined(_vc.viewState[id])) {
                                style = _vc.viewState[id].style;
                            }
                            if(!Array.isArray(style)){
                                if(angular.isDefined(style)){
                                    style = _vc.viewState[id].style.split(" ");
                                }else{
                                    style = [];
                               }
                            }
                            angular.forEach(style,
                                function (value) {
                                    if (value !== nStyleName) {
                                        this.push(value);
                                    }
                                }, newValues);
                            newValues[newValues.length] = styleName;
                            if (angular.isDefined(_vc.viewState[id])) {
                                _vc.viewState[id].style = newValues;
                            }
                        },
                        /**
                         * Permite remover un estilo al elemento solicitado
                         *
                         * @method removeStyle
                         * @param {String} id Identificador del control
                         * @param {String} styleName Identificador del estilo
                         * @example viewState.removeStyle('ID_CTRL_1', 'estilo1');
                         */
                        removeStyle: function (id, styleName) {
                            var values = _vc.viewState[id].style, nStyleName = styleName, newValues = [], idControl, inputControl, role;

                            angular.forEach(values, function (value) {
                                if (value !== nStyleName) {
                                    newValues.push(value);
                                }
                            }, newValues);
                            _vc.viewState[id].style = newValues;
                            idControl = "#" + id;
                            inputControl = $(idControl);
                            if (angular.isDefined(inputControl)) {
                                role = inputControl.data('role');
                                if (role === 'extcombobox') {
                                    inputControl = inputControl.data("kendoExtComboBox");
                                    if (angular.isDefined(inputControl)) {
                                        inputControl.input.removeClass(styleName);
                                    }

                                } else if (role === 'numerictextbox') {
                                    inputControl = inputControl.data("kendoNumericTextBox");
                                    if (angular.isDefined(inputControl)) {
                                        inputControl._text.removeClass(styleName);
                                    }
                                }

                            }
                        },
                        /**
                         * Permite cambiar la imagen de un imageButton
                         *
                         * @method changeImageStyle
                         * @param {String} id Identificador del control
                         * @param {String} styleName estilo de imagen
                         * @example viewState.changeImageStyle('VA_STAPRSONAS8904_0000920',
                         *          'glyphicon glyphicon-info-sign');
                         */
                        changeImageStyle: function (id, styleName) {
                            _vc.viewState[id].imageId = styleName;
                        },

                        /**
                         * Permite cambiar la imagen junto al label de un InputTextBox
                         *
                         * @method changeLabelImageStyle
                         * @param {String} id Identificador del control InputTextBox
                         * @param {String} styleName estilo de imagen
                         * @example viewState.changeLabelImageStyle('VA_STAPRSONAS8904_0000920',
                         *          'glyphicon glyphicon-exclamation-sign
                         *          text-danger');
                         */
                        changeLabelImageStyle: function (id, styleName) {
                            if (_vc.viewState[id].labelImageId) {
                                _vc.viewState[id].labelImageId = styleName;
                            }
                        },

                        /**
                         * Permite cambiar el Tooltip de un control
                         *
                         * @method changeTooltip
                         * @param {String} id Identificador del control
                         * @param {String} labelId Id de la etiqueta de ayuda
                         * @example viewState.changeTooltip('VA_STAPRSONAS8904_CEDU339',
                         *          'TSDEG.DLB_TSDEG_OROLATOIO_80972');
                         */
                        changeTooltip: function (id, labelId) {
                            _vc.viewState[id].tooltip = labelId;
                        },
                        /**
                         * Permite establecer que un control quede activo para su uso
                         *
                         * @method focus
                         * @param {String} id Identificador del control
                         * @example viewState.focus('ID_CTRL_1');
                         */
                        focus: function (id) {
                            dsgnrUtils.component.focusControl(id);
                        },

                        /**
                         * Permite cambiar de modo (Insert, Update, Query, etc)
                         * a la pantalla
                         *
                         * @method mode
                         * @param {Int} nuevo modo a utilizar
                         *            (args.commons.constants.mode)
                         * @example args.commons.api.viewState.mode(args.commons.constants.mode.Insert);
                         */
                        mode: function (mode) {
                            _vc.mode = mode;
                            _vc.args.mode = mode;
                        },
                        /**
                         * Permite obtener el valor traducido de una etiqueta
                         *
                         * @method translate
                         * @param {String} labelId Id de la etiqueta de ayuda
                         * @return {String} Valor traducido de una etiqueta
                         * @example viewState.translate('TSDEG.DLB_TSDEG_OROLATOIO_80972');
                         */
                        translate: function (labelId) {
                            return $filter('translate')(labelId);
                        },
                        /**
                         * Permite obtener o cambiar la etiqueta de un control.
                         *
                         * @method label
                         * @param {String} id identificador del VisualAttribute
                         * @param {String} label nueva etiqueta
                         * @param {Boolean} translate permite definir si la etiqueta se
                         *            traduce, por defecto SI traduce
                         * @param {Array} parameters arreglo de valores que requiere la
                         *            etiqueta. Ejemplo: LabelText: El campo {0}
                         *            debe ser mayor a {1}, LabelParameters:
                         *            ['Monto', 2000]
                         * @return {String} etiqueta actual. NO devuelve del Id de
                         *         la etiqueta, devuelve el texto traducido cuando
                         *         aplica.
                         * @example
                         *
                         * //Obtienen la etiqueta actual de un control var
                         * currentLabel = args.commons.api.viewState.label("VA_ID");
                         *
                         * //Define la nueva etiqueta de un control, el valor de la
                         * etiqueta debe ser el Id de una Etiqueta.
                         * args.commons.api.viewState.label("VA_ID", "LABEL_ID");
                         *
                         * //Define la nueva etiqueta de un control y el valor de la etiqueta
                         * no sera traducida
                         * args.commons.api.viewState.label("VA_ID", "Ejemplo
                         * Etiqueta sin traducir", false);
                         *
                         * //Define la nueva etiqueta de un control, la etiqueta
                         * requiere parametros.
                         * args.commons.api.viewState.label("VA_ID", "Ejemplo {0} y
                         * {1}", true, ['Valor1', 100]);
                         */
                        label: function (id, label, translate, parameters) {
                            var currentLabel, args = {}, i;
                            if (angular.isDefined(id) && angular.isDefined(_vc.viewState[id])) {
                                if (angular.isUndefined(translate)) {
                                    translate = true;
                                }
                                if (angular.isDefined(label)) {
                                    if (angular.isDefined(parameters) && angular.isArray(parameters)) {
                                        for (i = 0; i < parameters.length; i = i + 1) {
                                            args['p' + i] = parameters[i];
                                        }
                                        _vc.viewState[id].labelArgs = args;
                                    }
                                    _vc.viewState[id].label = label;
                                }
                                currentLabel = _vc.viewState[id].label;
                                if (translate === true) {
                                    currentLabel = $filter('translate')(_vc.viewState[id].label, _vc.viewState[id].labelArgs);
                                }
                            }
                            return currentLabel;
                        },
                        /**
                         * Permite cambiar el formato del control
                         *
                         * @method format
                         * @param {String} id Identificador del Control
                         * @param {String} mask Valor de mascara a cambiar
                         * @param {String} decimals Numero de decimales
                         * @param {String} prefix
                         * @param {String} suffix
                         * @return {String} Formato actual
                         * @example args.commons.api.viewState.format('VA_COMPONENT_1',
                         *          '####.##', 2);
                         */
                        format: function (id, format, decimals, prefix, suffix) {
                            var currentFormat, widget, numericTextBox, viewState, options = {}, value;
                            if (angular.isDefined(id)) {
                                viewState = _vc.viewState[id];
                                widget = $("#" + id);
                                if (angular.isDefined(viewState) && angular.isDefined(widget)) {
                                    numericTextBox = widget.data("kendoNumericTextBox");
                                    if (angular.isDefined(numericTextBox)) {
                                        if (angular.isDefined(format)) {
                                            viewState.format = format;
                                            options.format = format;
                                        }
                                        if (angular.isDefined(decimals)) {
                                            viewState.decimals = format;
                                            options.decimals = decimals;
                                        }
                                        if (Object.keys(options).length > 0) {
                                            numericTextBox.setOptions(options);
                                            value = numericTextBox.value();
                                            numericTextBox.value(value);
                                        }
                                        currentFormat = viewState.format;

                                        if (angular.isDefined(prefix)) {
                                            viewState.prefix = prefix;
                                        }
                                        if (angular.isDefined(suffix)) {
                                            viewState.suffix = suffix;
                                        }
                                    }
                                }
                            }
                            return currentFormat;
                        },
                        /**
                         * Permite cambiar la mascara del control
                         *
                         * @method mask
                         * @param {String} id Identificador del Control
                         * @param {String} mask Valor de mascara a cambiar
                         * @param {String} prefix
                         * @param {String} suffix
                         * @return {String} mascara del control actual
                         * @example args.commons.api.viewState.mask('VA_COMPONENT_1',
                         *          '####.##');
                         */
                        mask: function (id, mask, prefix, suffix) {
                            var currentMask, widget, maskedTextBox, viewState, options = {};
                            if (angular.isDefined(id)) {
                                viewState = _vc.viewState[id];
                                widget = $("#" + id);
                                if (angular.isDefined(viewState) && angular.isDefined(widget)) {
                                    maskedTextBox = widget.data("kendoExtMaskedTextBox");
                                    if (angular.isDefined(maskedTextBox)) {
                                        if (angular.isDefined(mask)) {
                                            viewState.mask = mask;
                                            options.mask = mask;
                                            maskedTextBox.setOptions(options);
                                        }
                                        currentMask = viewState.mask;

                                        if (angular.isDefined(prefix)) {
                                            viewState.prefix = prefix;
                                        }
                                        if (angular.isDefined(suffix)) {
                                            viewState.suffix = suffix;
                                        }
                                    }
                                }
                            }
                            return currentMask;
                        },
                        /**
                         * Permite cambiar el prefix de un control tipo TextInputBox
                         *
                         * @method prefix
                         * @param {String} id Identificador del Control
                         * @param {String} prefix prefijo
                         * @return {String} prefix actual del control tipo TextInputBox
                         * @example args.commons.api.viewState.prefix('VA_COMPONENT_1',
                         *          '$');
                         */
                        prefix: function (id, prefix) {
                            var currentPrefix, viewState;
                            if (angular.isDefined(id)) {
                                viewState = _vc.viewState[id];
                                if (angular.isDefined(viewState) && angular.isDefined(prefix)) {
                                    viewState.prefix = prefix;
                                }
                                currentPrefix = viewState.prefix;
                            }
                            return currentPrefix;
                        },
                        /**
                         * Permite cambiar el sufijo de un control tipo TextInputBox
                         *
                         * @method suffix
                         * @param {String} id Identificador del Control
                         * @param {String} suffix sufijo
                         * @example args.commons.api.viewState.suffix('VA_COMPONENT_1',
                         *          'USD');
                         */
                        suffix: function (id, suffix) {
                            var currentSuffix, viewState;
                            if (angular.isDefined(id)) {
                                viewState = _vc.viewState[id];
                                if (angular.isDefined(viewState) && angular.isDefined(suffix)) {
                                    viewState.suffix = suffix;
                                }
                                currentSuffix = viewState.suffix;
                            }
                            return currentSuffix;
                        },
                        /**
                         * Permite obtener el valor seleccionado del ComboBox o
                         * RadioButton
                         *
                         * @method selectedText
                         * @param {String} id Identificador del ComboBox o RadioButton
                         * @param {String} key Valor seleccionado
                         * @param {String} rowData Dato de la fila que que abrió el un detalle de grilla
                         * @return {String} valor seleccionado del ComboBox o RadioButton
                         * @example args.commons.api.viewState.selectedText('VA_COMPONENT_1',
                         *          '1');
                         * @example args.commons.api.viewState.selectedText('VA_COMPONENT_1',
                         *          '1', Args.rowData);
                         */
                        selectedText: function (id, key, rowData) {
                            var ds = _vc.catalogs[id], selectedText, data, queryId, query = false;
                            if (angular.isDefined(rowData)) {
                                ds = ds[rowData.uid];
                            }
                            if (angular.isUndefined(ds)) {
                                queryId = _vc.viewState[id].queryId;
                                ds = _vc.queries[queryId];
                                // si esta relacionado al id
                                // del query se suma el id
                                // del visual attribute
                                if (angular.isUndefined(ds)) {
                                    ds = _vc.queries[queryId + '_' + id];
                                }
                                query = true;
                            }
                            if (angular.isDefined(ds) && ds instanceof kendo.data.DataSource) {
                                data = ds.get(key);
                                if (angular.isDefined(data)) {
                                    if (!query) {
                                        selectedText = data.value;
                                    } else {
                                        selectedText = data[_vc.queryProperties[queryId].columnValueForList];
                                    }
                                }
                            }
                            return selectedText;
                        },
                        /**
                         * Permite refrescar el DataSource del ComboBox
                         *
                         * @method refreshData
                         * @param {String} id Identificador del ComboBox
                         * @example args.commons.api.viewState.refreshData('VA_COMPONENT_1');
                         */
                        refreshData: function (id) {
                            var ds = _vc.catalogs[id];

                            if (angular.isDefined(ds) && ds instanceof kendo.data.DataSource) {
                                ds.read();
                            }

                        },
                        /**
                         * Permite habilitar un validador dado el id del componente
                         * y el id del validador
                         *
                         * @method enableValidation
                         * @param {String} componentId Identificador del control
                         * @param {Number} validatorId Id del validador
                         * @example viewState.enableValidation('VA_STAPRSONAS8904_CEDU339',
                         *          VisualValidationTypeEnum.RangeValues);
                         */
                        enableValidation: function (componentId, validatorId) {
                            validatorId = Number(validatorId);
                            var validationCode = vc.viewState[componentId].validationCode;
                            if (!isNaN(validatorId)) {
                                vc.viewState[componentId].validationCode = (validationCode | validatorId);
                                $('#' + componentId + '_DIV').addClass('cb-required');
                            } else {
                                logger.error("wrong validatorId!!");
                            }
                        },

                        /**
                         * Permite deshabilitar un validador dado el id del
                         * componente y el id del validador
                         *
                         * @method disableValidation
                         * @param {String} componentId Identificador del control
                         * @param {Number} validatorId Id del validador
                         * @example viewState.disableValidation('VA_STAPRSONAS8904_CEDU339',
                         *          VisualValidationTypeEnum.RangeValues);
                         */
                        disableValidation: function (componentId, validatorId) {
                            validatorId = Number(validatorId);
                            var validationCode = vc.viewState[componentId].validationCode;
                            if (!isNaN(validatorId) && validationCode >= validatorId) {
                                vc.viewState[componentId].validationCode = validationCode - validatorId;
                                $('#' + componentId + '_DIV').removeClass('cb-required');
                            } else {
                                logger.error("wrong validatorId!!");
                            }
                        },

                        /**
                         * Permite bloquear un Contenedor dado el id del
                         * contenedor y opcional el tiempo que durará el bloqueo
                         *
                         * @method lockScreen
                         * @param {String} viewContainerId Identificador del contenedor
                         * @param {Number} time Tiempo en mili segundos que durará el bloqueo
                         * @example viewState.lockScreen('ViewContainerID', 5000);
                         *          viewState.lockScreen('ViewContainerID', null);
                         */
                        lockScreen: function (viewContainerId, time) {
                            logger.info("lockScreen: " + viewContainerId);
                            _lockUnlockScreen(time, 1);
                        },

                        /**
                         * Permite des-bloquear un Contenedor dado el id del contenedor
                         *
                         * @method unlockScreen
                         * @param {String} viewContainerId Identificador del contenedor
                         * @example viewState.unlockScreen('ViewContainerID');
                         */
                        unlockScreen: function (viewContainerId) {
                            logger.info("unlockScreen: " + viewContainerId);
                            _lockUnlockScreen(null, 2);
                        },

                        /**
                         * Permite definir la plantilla del contenido de las
                         * opciones del ComboBox
                         *
                         * @method template
                         * @param {String} componentId Identificador del control
                         * @param {String} template plantilla del contenido de las opciones del ComboBox
                         * @return {String} plantilla actual
                         * @example viewState.template('VA_ID', '<span>attr1</span><span>attr2</span>');
                         */
                        template: function (id, customTemplate) {
                            var currentTemplate,
                                viewState,
                                widget,
                                comboBox,
                                unregister,
                                changeTemplate = function (cmb, vs) {
                                    if (angular.isDefined(customTemplate)) {
                                        vs.template = customTemplate;
                                        cmb.setOptions({
                                            template: customTemplate
                                        });
                                        // validar que existe el dataSource porque si todavia el read no termina del combo se hace
                                        // un select sobre data vacia y se selecciona el primer registro
                                        if (angular.isDefined(cmb.dataSource) && cmb.dataSource.data().length > 0) {
                                            cmb.refresh();
                                        }
                                    }
                                };
                            if (angular.isDefined(id)) {
                                viewState = _vc.viewState[id];
                                widget = $("#" + id);
                                if (angular.isDefined(viewState) && angular.isDefined(widget)) {
                                    comboBox = widget.data("kendoExtComboBox") || widget.data("kendoExtDropDownList");
                                    if (angular.isDefined(comboBox)) {
                                        changeTemplate(comboBox, viewState);
                                        currentTemplate = viewState.template;
                                    } else if (angular.isDefined(widget.data('$kendoExtComboBoxController'))) {
                                        unregister = angular.element(widget).scope().$watch('comboBox.' + id, function (newValue, oldValue) {
                                            if (newValue !== oldValue) {
                                                unregister();
                                                comboBox = widget.data("kendoExtComboBox");
                                                if (angular.isDefined(comboBox)) {
                                                    changeTemplate(comboBox, viewState);
                                                }
                                            }
                                        });
                                    }
                                }
                            }
                            return currentTemplate;
                        },

                        /**
                         * Permite definir la plantilla del contenido de la cabecera de un DropDownList
                         *
                         * @method valueTemplate
                         * @param {String} componentId Identificador del control
                         * @param {String} template plantilla del contenido de la cabecera del DropDownList
                         * @return {String} plantilla actual
                         * @example viewState.valueTemplate('VA_ID', '<span>attr1</span><span>attr2</span>');
                         */
                        valueTemplate: function (id, customTemplate) {
                            var currentTemplate,
                                viewState,
                                widget,
                                dropDownList,
                                changeTemplate = function (dropDownWidget, vs) {
                                    if (angular.isDefined(customTemplate)) {
                                        vs.valueTemplate = customTemplate;
                                        dropDownWidget.setOptions({
                                            valueTemplate: customTemplate
                                        });
                                        // validar que existe el dataSource porque si todavia el read no termina del combo se hace
                                        // un select sobre data vacia y se selecciona el primer registro
                                        if (angular.isDefined(dropDownWidget.dataSource) && dropDownWidget.dataSource.data().length > 0) {
                                            dropDownWidget.refresh();
                                        }
                                    }
                                };
                            if (angular.isDefined(id)) {
                                viewState = _vc.viewState[id];
                                widget = $("#" + id);
                                if (angular.isDefined(viewState) && angular.isDefined(widget)) {
                                    dropDownList = widget.data("kendoExtDropDownList");
                                    if (angular.isDefined(dropDownList)) {
                                        changeTemplate(dropDownList, viewState);
                                        currentTemplate = viewState.template;
                                    }
                                }
                            }
                            return currentTemplate;
                        },

                        /**
                         * Permite obtener el componente de kendo dado el id de grupo.
                         * Este método aplica contenedores tipo Tab, Colapsables y Acordeón,
                         * caso contrario, devuelve null
                         *
                         *
                         * @method getKendoContainer
                         * @for dsgnrUtils
                         * @param {String} idGroup Identificador del contenedor
                         */
                        getKendoContainer: function (idGroup) {
                            return dsgnrUtils.container.getKendoContainer(idGroup);

                        },

                        /**
                         * Permite agregar placeholder (i18n) a un control
                         *
                         * @method setPlaceHolderLabel
                         * @for dsgnrUtils
                         * @param {String} controlId Identificador del control
                         * @param {string} label Id del label que se quiere agregar como placeholder
                         */
                        setPlaceHolderLabel: function (controlId, label) {
                            label = label || '';
                            var labelTranslated = this.translate(label.indexOf('.') > 4 ? label.substring(0, label.indexOf('.')) + '.'
                            + _constants.labelTypes.LABEL
                            + label.substring(label.indexOf('.')) : label);
                            $("#" + controlId).attr("placeholder", labelTranslated);
                        }
                    };
                    /**
                     * Arreglo para manejo de eventos del Grid (QueryView)
                     *
                     * @attribute grid
                     * @type Object
                     */
                    var _grid = {
                        /**
                         * M&eacute;todo para obtener las Claves Primarias de la
                         * fila indicada
                         *
                         * @method getPks
                         * @param {String} nameEntityGrid Identificador del grid
                         *            (queryView)
                         * @param {String} rowData Data de la primera fila
                         * @return {Object} selectedRows Claves Primarias de Filas
                         * @example var clavesPrimarias =
                         *          grid.getPks('QV_CTRL_1', datosFila);
                         */
                        getPks: function (nameEntityGrid, rowData) {
                            var entityMetadata = _vc.metadata.entities[nameEntityGrid],
                                entityPks = entityMetadata._pks,
                                entityPksMap = {}, i;
                            for (i = 0; i < entityPks.length; i = i + 1) {
                                entityPksMap[entityPks[i]] = rowData[entityPks[i]];
                            }
                            return entityPksMap;
                        },
                        /**
                         * M&eacute;todo para obtener las Claves Primarias de la
                         * fila indicada
                         *
                         * @method getSelectedRows
                         * @param {String} id Identificador del grid (queryView)
                         * @return {Array} selectedRows Filas Seleccionadas
                         * @example var filasSeleccionadas =
                         *          grid.getSelectedRows('QV_CTRL_1');
                         */
                        getSelectedRows: function (id) {
                            var selectedDataItems = [],
                                grid = $("#" + id).data("kendoGrid"), i, dataItem, selectedRows;
                            if (grid) {
                                selectedRows = grid.select();
                                if (selectedRows && selectedRows.length > 0) {
                                    for (i = 0; i < selectedRows.length; i = i + 1) {
                                        dataItem = grid.dataItem(selectedRows[i]);
                                        selectedDataItems.push(dataItem);
                                    }
                                }
                            }
                            return selectedDataItems;
                        },
                        /**
                         * M&eacute;todo para obtener una fila por el Identificador
                         * tipo DesignerId
                         *
                         * @method getRowByDsgnrId
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {String} dsgnrId
                         * @return {String} dsgnrId Identificador de la fila, propio
                         *         del Control gr&aacute;fico
                         * @example var filasPorIdentificador =
                         *          grid.getRowByDsgnrId('Customer','uuid-19374-28374-0091883');
                         */
                        getRowByDsgnrId: function (entity, dsgnrId) {
                            var ds = _vc.model[entity], dsData = ds.data(),
                                i, dsRow, dsRowDsgnrId;
                            if (dsgnrId && dsData.length > 0) {
                                for (i = 0; i < dsData.length; i = i + 1) {
                                    dsRow = dsData[i];
                                    dsRowDsgnrId = dsRow.get("dsgnrId");
                                    if (dsRowDsgnrId == dsgnrId) {
                                        return dsRow;
                                    }
                                }
                            }
                            return null;
                        },
                        /**
                         * M&eacute;todo para agregar una fila a la Grilla
                         *
                         * @method addRow
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {Object} data Instancia del Objeto a agregar
                         * @param {Boolean} autoSync indica si se ejecuta la
                         *            sincronización inmediatamente.
                         * @example var cliente = Cliente();<br/> cliente.cedula =
                         *          '1234567';<br/> cliente.nombres = 'Cliente 1';<br/>
                         *          grid.addRow('Customer', cliente);
                         */
                        addRow: function (entity, data, autoSync) {
                            var row = new _vc.types[entity](data);
                            _vc.model[entity].add(row);
                            if (typeof autoSync === "undefined") {
                                autoSync = true;
                            }
                            if (autoSync === true) {
                                _vc.model[entity].sync();
                            }
                        },
                        /**
                         * M&eacute;todo para actualizar una fila en la Grilla
                         *
                         * @method updateRow
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {Int} index N&uacute;mero de la fila a actualizar
                         * @param {Object} data Instancia del Objeto a actualizar
                         * @param {Object} autoSync
                         * @example var cliente = Cliente();<br/> cliente.cedula =
                         *          '1234567';<br/> cliente.nombres = 'Alberto';<br/>
                         *          grid.updateRow('Customer', 1, cliente);
                         */
                        updateRow: function (entity, index, data, autoSync) {
                            var row = _vc.model[entity].at(index), prop;
                            for (prop in data) {
                                if (!data.hasOwnProperty(prop)) {
                                    continue;
                                }
                                if (prop !== "uid" && prop !== "dirty" && prop.substring(0, 4) !== "org_") {
                                    row.set(prop, data[prop]);
                                }
                            }
                            if (typeof autoSync === "undefined") {
                                autoSync = true;
                            }
                            if (autoSync === true) {
                                _vc.model[entity].sync();
                            }
                        },
                        /**
                         * M&eacute;todo para actualizar una fila en la Grilla,
                         * usando el identificador asociado al objeto
                         *
                         * @method updateRowByDsgnrId
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {Object} data Instancia del Objeto a actualizar
                         * @param {Object} autoSync
                         * @example cliente.cedula = '1234568';<br/>
                         *          cliente.nombres = 'Alberto';<br/>
                         *          grid.updateRowByDsgnrId('Customer', cliente);
                         */
                        updateRowByDsgnrId: function (entity, data, autoSync) {
                            var dsgnrId = data.dsgnrId,
                                ds = _vc.model[entity],
                                dsRow = this.getRowByDsgnrId(entity, dsgnrId),
                                prop;
                            for (prop in data) {
                                if (!data.hasOwnProperty(prop)) {
                                    continue;
                                }
                                if (prop !== "uid" && prop !== "dirty" && prop.substring(0, 4) !== "org_") {
                                    if (cobis.utils.isRunOnLiferay()) {
                                        dsRow.set(prop, data[prop]);
                                    } else {
                                        dsRow[prop] = data[prop];
                                    }
                                }
                            }

                            if (typeof autoSync === "undefined") {
                                autoSync = true;
                            }
                            if (autoSync === true) {
                                ds.sync();
                            }
                        },
                        /**
                         * M&eacute;todo para actualizar el valor de una columna en
                         * la fila en la Grilla
                         *
                         * @method updateRowData
                         * @param {Object} rowData Instancia del Objeto a actualizar
                         * @param {String} attributeName Nombre del atributo a modificarse
                         * @param {String} attributeValue Valor del atributo a actualizarse
                         * @example grid.updateRowData(changedEventArgs.rowData,
                         *          'descripcion', 'Valor detallado');
                         */
                        updateRowData: function (rowData, attributeName, attributeValue) {
                            if (attributeName !== "uid" && attributeName !== "dirty" && attributeName.substring(0, 4) !== "org_") {
                                rowData.set(attributeName, attributeValue);
                            }
                        },
                        /**
                         * M&eacute;todo para eliminar una fila en la Grilla
                         *
                         * @method removeRow
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {Int} index N&uacute;mero de la fila a actualizar
                         * @example grid.removeRow('Customer', 1);
                         */
                        removeRow: function (entity, index) {
                            var row = _vc.model[entity].at(index);
                            _vc.model[entity].remove(row);
                            _vc.model[entity].sync();
                        },
                        /**
                         * M&eacute;todo para eliminar una fila en la Grilla con
                         * base en identificador interno
                         *
                         * @method removeRowByDsgnrId
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {Object} data Instancia del Objeto a actualizar
                         * @example grid.removeRowByDsgnrId('Customer', cliente);
                         */
                        removeRowByDsgnrId: function (entity, data) {
                            var dsgnrId = data.dsgnrId,
                                dsRow = this.getRowByDsgnrId(entity, dsgnrId),
                                ds = _vc.model[entity];
                            ds.remove(dsRow);
                            ds.sync();
                        },
                        /**
                         * M&eacute;todo para eliminar todos los registros de la Grilla
                         *
                         * @method removeAllRows
                         * @param {String} entity Identificador de la entidad asociada
                         * @example grid.removeAllRows('Customer');
                         */
                        removeAllRows: function (entity) {
                            var ds = _vc.model[entity],
                                size = ds.data().length;
                            if (size > 0) {
                                ds.data([]);
                                ds.sync();
                            }

                        },
                        /**
                         * M&eacute;todo para agregar todos los registros de la Grilla
                         *
                         * @method addAllRows
                         * @param {String} entity Identificador de la entidad asociada
                         * @param {Array} dataArray Conjunto de datos a agregar
                         * @param {Boolean} reset indica si se reemplazan los registros actuales
                         * @example var clientes = [];<br/> clientes[0] = Cliente();<br/>
                         *          clientes[0].cedula = '987393';<br/>
                         *          clientes[0].nombres = 'Jennifer';<br/>
                         *          grid.addAllRows('Customer', clientes);<br/>
                         */
                        addAllRows: function (entity, dataArray, reset) {
                            var i;
                            if (dataArray !== null && dataArray.length > 0) {
                                if (typeof reset === "undefined") {
                                    reset = false;
                                }
                                if (reset === true) {
                                    _vc.model[entity].data(dataArray);
                                } else {
                                    for (i = 0; i < dataArray.length; i = i + 1) {
                                        this.addRow(entity, dataArray[i], false);
                                    }
                                }
                                _vc.model[entity].sync();
                            }
                        },
                        /**
                         * M&eacute;todo para limpiar el Arreglo de datos y definir dsgnrId
                         * @method getDesignerData
                         * @param {Array} dataArray Conjunto de datos a limpiar y definir dsgnrId
                         *
                         */
                        getDesignerData: function (dataArray) {
                            if (angular.isDefined(dataArray[0]._reset)) {
                                return _vc.getDesignerData(dataArray);
                            } else {
                                var msg = $filter('translate')('DSGNR.SYS_DSGNR_MSGERRDTA_00049');
                                logger.warn(msg);
                            }
                        },
                        /**
                         * M&eacute;todo para ocultar una columna de la Grilla
                         *
                         * @method hideColumn
                         * @param {String} idGrid Identificadordel grid
                         * @param {String} idColumn Identificador de la columna (nombre
                         *            del atributo de la entidad) a ocultarse
                         * @example grid.hideColumn('QV_ID_CTL1', 'profesion');
                         */
                        hideColumn: function (idGrid, idColumn) {
                            var grid, kendoGrid, scope, unregister;

                            _vc.viewState[idGrid].column[idColumn].hidden = true;
                            grid = $("#" + idGrid);
                            if (grid.length > 0) {
                                kendoGrid = grid.data("kendoGrid");
                                if (angular.isDefined(kendoGrid) && kendoGrid !== null) {
                                    kendoGrid.hideColumn(idColumn);
                                } else {
                                    scope = angular.element(grid).scope();
                                    if (angular.isDefined(scope)) {
                                        unregister = scope.$watch('grids.' + idGrid, function (newGrid, oldGrid) {
                                            if (newGrid !== oldGrid) {
                                                newGrid.hideColumn(idColumn);
                                                unregister();
                                            }
                                        });
                                    }
                                }
                            }
                        },
                        /**
                         * M&eacute;todo para ocultar icono detalle de Grilla
                         *
                         * @method hideDetailIcon
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la fila
                         * @example grid.hideDetailIcon('QV_ID_CTL1', rowData);
                         */
                        hideDetailIcon: function (idGrid, rowData) {
                            var row = $("#" + idGrid + " tbody").find("tr[data-uid=" + rowData.uid + "]"), icon;
                            if (angular.isDefined(row)) {
                                icon = row.find('.k-hierarchy-cell a');
                                if (angular.isDefined(icon)) {
                                    icon.hide();
                                }
                            }
                        },
                        /**
                         * M&eacute;todo para mostrar icono detalle de Grilla
                         *
                         * @method showDetailIcon
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la fila
                         * @example grid.showDetailIcon('QV_ID_CTL1', rowData);
                         */
                        showDetailIcon: function (idGrid, rowData) {
                            var row = $("#" + idGrid + " tbody").find("tr[data-uid=" + rowData.uid + "]"), icon;
                            if (angular.isDefined(row)) {
                                icon = row.find('.k-hierarchy-cell a');
                                if (angular.isDefined(icon)) {
                                    icon.show();
                                }
                            }
                        },
                        /**
                         * M&eacute;todo para mostrar una
                         * columna de la Grilla
                         *
                         * @method showColumn
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna (nombre del atributo de la entidad) a ocultarse
                         * @example grid.showColumn('QV_ID_CTL1', 'profesion');
                         */
                        showColumn: function (idGrid, idColumn) {
                            var grid, kendoGrid, scope, unregister;

                            _vc.viewState[idGrid].column[idColumn].hidden = false;

                            grid = $("#" + idGrid);
                            if (grid.length > 0) {
                                kendoGrid = grid.data("kendoGrid");
                                if (angular.isDefined(kendoGrid) && kendoGrid !== null) {
                                    kendoGrid.showColumn(idColumn);
                                } else {
                                    scope = angular.element(grid).scope();
                                    if (angular.isDefined(scope)) {
                                        unregister = scope.$watch('grids.' + idGrid, function (newGrid, oldGrid) {
                                            if (newGrid !== oldGrid) {
                                                newGrid.showColumn(idColumn);
                                                unregister();
                                            }
                                        });
                                    }
                                }
                            }
                        },
                        /**
                         * M&eacute;todo para habilitar una columna de la Grilla
                         *
                         * @method enabledColumn
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna (nombre del atributo de la entidad) a ocultarse
                         * @example grid.enabledColumn('QV_ID_CTL1', 'profesion');
                         */
                        enabledColumn: function (idGrid, idColumn) {
                            _vc.viewState[idGrid].column[idColumn].enabled = true;
                            var componentId = _vc.viewState[idGrid].column[idColumn].componentId;
                            $timeout(function () {
                                dsgnrUtils.component.forceAttributeSetting(componentId, 'enabled', true);
                            });
                        },
                        /**
                         * M&eacute;todo para deshabilitar una columna de la Grilla
                         *
                         * @method disabledColumn
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna (nombre del atributo de la entidad) a ocultarse
                         * @example grid.disabledColumn('QV_ID_CTL1', 'profesion');
                         */
                        disabledColumn: function (idGrid, idColumn) {
                            _vc.viewState[idGrid].column[idColumn].enabled = false;
                            var componentId = _vc.viewState[idGrid].column[idColumn].componentId;
                            $timeout(function () {
                                dsgnrUtils.component.forceAttributeSetting(componentId, 'enabled', false);
                            });
                        },
                        /**
                         * M&eacute;todo para ocultar un botón del toolbar que representa un Query View Custom Event
                         *
                         * @method hideToolBarButton
                         * @param {String} idGrid Identificador del grid
                         * @param {String} id Identificador del custom Event
                         * @example grid.hideToolBarButton('QV_ID_CTL1', 'create');
                         */
                        hideToolBarButton: function (idGrid, id) {
                            _vc.viewState[idGrid].toolbar[id].visible = false;
                        },
                        /**
                         * M&eacute;todo para mostrar un botón del toolbar que representa un Query View Custom Event
                         *
                         * @method showToolBarButton
                         * @param {String} idGrid Identificador del grid
                         * @param {String} id Identificador del custom Event
                         * @example grid.showToolBarButton('QV_ID_CTL1', 'create');
                         */
                        showToolBarButton: function (idGrid, id) {
                            _vc.viewState[idGrid].toolbar[id].visible = true;
                        },
                        /**
                         * Permite agregar un estilo a la columna seleccionada
                         *
                         * @method addColumnStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna
                         * @param {String} styleName Identificador del estilo a aplicar
                         * @example grid.addColumnStyle('QV_ID_CTL1', 'profesion', 'estilo1');
                         */
                        addColumnStyle: function (idGrid, idColumn, styleName) {
                            var headerColumn, classNameHeader,
                                values = _vc.viewState[idGrid].column[idColumn].style,
                                nStyleName = styleName, newValues = [], index;
                            angular.forEach(values, function (value) {
                                if (value !== nStyleName) {
                                    this.push(value);
                                }
                            }, newValues);
                            newValues[newValues.length] = styleName;
                            _vc.viewState[idGrid].column[idColumn].style = newValues;

                            headerColumn = $("#" + idGrid + " th[data-field='" + idColumn + "']");
                            if (angular.isDefined(headerColumn) && angular.isDefined(headerColumn[0])) {
                                classNameHeader = headerColumn[0].className;
                                index = classNameHeader.indexOf(styleName);
                                if (index === (-1)) {
                                    headerColumn[0].className = (classNameHeader + " " + styleName).trim();
                                }
                            }
                        },
                        /**
                         * Permite remover un estilo a una columna
                         *
                         * @method removeColumnStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna
                         * @param {String} styleName Identificador del estilo a aplicar
                         * @example grid.removeColumnStyle('QV_ID_CTL1', 'profesion', 'estilo1');
                         */
                        removeColumnStyle: function (idGrid, idColumn, styleName) {
                            var headerColumn, classNameHeader,
                                values = _vc.viewState[idGrid].column[idColumn].style,
                                nStyleName = styleName, newValues = [], exp, re;

                            angular.forEach(values, function (value) {
                                if (value !== nStyleName) {
                                    this.push(value);
                                }
                            }, newValues);
                            _vc.viewState[idGrid].column[idColumn].style = newValues;
                            headerColumn = $("#" + idGrid + " th[data-field='" + idColumn + "']");
                            if (angular.isDefined(headerColumn) && angular.isDefined(headerColumn[0])) {
                                exp = "\\b(" + styleName + ")\\b";
                                re = new RegExp(exp, "g");
                                classNameHeader = headerColumn[0].className.replace(re, '');
                                classNameHeader = classNameHeader.replace(/\s\s/g, " ").trim();
                                headerColumn[0].className = classNameHeader;
                            }
                        },
                        /**
                         * Permite habilitar un validador dado el id del grid, id de columna y el id del validador
                         *
                         * @method enableValidation
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna del grid
                         * @param {Integer} validatorId Id del validador
                         * @return {boolean} resultado
                         * @example viewState.enableValidation('QV_ID_CTL1','profesion', 'VisualValidationTypeEnum.RangeValues);
                         */
                        enableValidation: function (idGrid, idColumn, validatorId) {
                            validatorId = Number(validatorId);
                            var result = false, validationCode = _vc.viewState[idGrid].column[idColumn].validationCode, componentId;
                            if (!isNaN(validatorId)) {
                                _vc.viewState[idGrid].column[idColumn].validationCode = (validationCode | validatorId);
                                result = true;
                                componentId = _vc.viewState[idGrid].column[idColumn].componentId;
                                if (angular.isDefined(componentId)) {
                                    $("#" + componentId).attr('data-validation-code', validationCode | validatorId);
                                }
                            } else {
                                logger.error("wrong validatorId!! ");
                            }
                            return result;
                        },

                        /**
                         * Permite deshabilitar un validador dado el id del grid, id de columna y el id del validador
                         *
                         * @method disableValidation
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna del grid
                         * @param {Integer} validatorId Id del validador
                         * @return {boolean} resultado
                         * @example disableValidation('QV_ID_CTL1','profesion' , 'VisualValidationTypeEnum.RangeValues);
                         */
                        disableValidation: function (idGrid, idColumn, validatorId) {
                            validatorId = Number(validatorId);
                            var result = false, validationCode = _vc.viewState[idGrid].column[idColumn].validationCode, componentId;
                            if (!isNaN(validatorId) && validationCode >= validatorId) {
                                _vc.viewState[idGrid].column[idColumn].validationCode = validationCode - validatorId;
                                componentId = _vc.viewState[idGrid].column[idColumn].componentId;
                                result = true;
                                if (angular.isDefined(componentId)) {
                                    $("#" + componentId).attr('data-validation-code', validationCode - validatorId);
                                }
                            } else {
                                logger.error("wrong validatorId!! ");
                            }
                            return result;
                        },
                        /**
                         * Permite agregar un estilo a la celda seleccionada
                         *
                         * @method addCellStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {Object} rowData Objeto que contiene el registro a aplicar estilos
                         * @param {String} idColumn Identificador de la columna
                         * @param {String} styleName Identificador del estilo a aplicar
                         * @param {boolean} hasDsgnrId true si se requiere utilizar "dsgnrId" como identificador de la fila
                         *
                         * @example grid.addCellStyle('QV_ID_CTL1', rowData, 'profesion', 'estilo1');
                         */
                        addCellStyle: function (idGrid, rowData, idColumn, styleName, hasDsgnrId) {
                            var uid = (angular.isDefined(hasDsgnrId) && hasDsgnrId === true) ? rowData.dsgnrId : rowData.uid;

                            if (typeof _vc.viewState[idGrid].column[idColumn].element[uid] === "undefined") {
                                _vc.viewState[idGrid].column[idColumn].element[uid] = {
                                    style: []
                                };
                            }
                            var values = _vc.viewState[idGrid].column[idColumn].element[uid].style, nStyleName = styleName, newValues = [];
                            angular.forEach(values, function (value) {
                                if (value !== nStyleName) {
                                    this.push(value);
                                }
                            }, newValues);
                            newValues[newValues.length] = styleName;
                            _vc.viewState[idGrid].column[idColumn].element[uid].style = newValues;
                        },
                        /**
                         * Permite remover un estilo a la celda seleccionada
                         *
                         * @method removeCellStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {Object} rowData Objeto que contiene el registro a aplicar estilos
                         * @param {String} idColumn Identificador de la columna
                         * @param {String} styleName Identificador del estilo a aplicar
                         * @example grid.removeCellStyle('QV_ID_CTL1', rowData, 'profesion', 'estilo1');
                         */
                        removeCellStyle: function (idGrid, rowData, idColumn, styleName) {
                            if (typeof _vc.viewState[idGrid].column[idColumn].element[rowData.uid] === "undefined") {
                                _vc.viewState[idGrid].column[idColumn].element[rowData.uid] = {
                                    style: []
                                };
                                return;
                            }
                            var values = _vc.viewState[idGrid].column[idColumn].element[rowData.uid].style, nStyleName = styleName, newValues = [];
                            angular.forEach(values, function (value) {
                                if (value !== nStyleName) {
                                    this.push(value);
                                }
                            }, newValues);
                            _vc.viewState[idGrid].column[idColumn].element[rowData.uid].style = newValues;
                        },
                        /**
                         * Permite ocultar un comando de fila de una grilla
                         *
                         * @method hideGridRowCommand
                         * @param {String} idGrid Identificador del grid
                         * @param {Object} rowData Objeto que contiene el registro a aplicar estilos
                         * @param {String} idVisualAttribute Identificador del comando
                         * @param {boolean} hasDsgnrId true si se requiere utilizar "dsgnrId" como identificador de la fila
                         * @example grid.hideGridRowCommand('QV_ID_CTL1', rowData, 'VA_ID');
                         */
                        hideGridRowCommand: function (idGrid, rowData, idVisualAttribute, hasDsgnrId) {
                            this.addCellStyle(idGrid, rowData, idVisualAttribute, 'invisible', hasDsgnrId);
                        },
                        /**
                         * Permite mostrar un comando de fila de una grilla
                         *
                         * @method showGridRowCommand
                         * @param {String} idGrid Identificador del grid
                         * @param {Object} rowData Objeto que contiene el registro a aplicar estilos
                         * @param {String} idVisualAttribute Identificador del comando
                         * @example grid.showGridRowCommand('QV_ID_CTL1', rowData, 'VA_ID');
                         */
                        showGridRowCommand: function (idGrid, rowData, idVisualAttribute) {
                            this.removeCellStyle(idGrid, rowData, idVisualAttribute, 'invisible');
                        },
                        /**
                         * Permite agregar un estilo a la fila seleccionada
                         *
                         * @method addRowStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {Object} rowData Objeto que contiene el registro a aplicar estilos
                         * @param {String} styleName Identificador del estilo a aplicar
                         * @example grid.addRowStyle('QV_ID_CTL1', rowData, 'estilo1');
                         */
                        addRowStyle: function (idGrid, rowData, styleName) {
                            var gridControl;
                            if (typeof _vc.viewState[idGrid].rows[rowData.uid] === "undefined") {
                                _vc.viewState[idGrid].rows[rowData.uid] = {
                                    style: []
                                };
                            }
                            gridControl = $("#" + idGrid + " tbody");
                            if (gridControl.find("tr[data-uid=" + rowData.uid + "]").hasClass(styleName) === false) {
                                gridControl.find("tr[data-uid=" + rowData.uid + "]").addClass(styleName);
                                _vc.viewState[idGrid].rows[rowData.uid].style.push(styleName);
                            }
                        },
                        /**
                         * Permite remover un estilo a la fila seleccionada
                         *
                         * @method removeRowStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {Object} rowData Objeto que contiene el registro a remover estilos
                         * @param {String} styleName Identificador del estilo a remover
                         * @example grid.removeRowStyle('QV_ID_CTL1', rowData, 'estilo1');
                         */
                        removeRowStyle: function (idGrid, rowData, styleName) {
                            if (typeof _vc.viewState[idGrid].rows[rowData.uid] === "undefined") {
                                _vc.viewState[idGrid].rows[rowData.uid] = {
                                    style: []
                                };
                            }

                            var gridControl = $("#" + idGrid + " tbody");
                            if (gridControl.find("tr[data-uid=" + rowData.uid + "]").hasClass(styleName) === true) {
                                gridControl.find("tr[data-uid=" + rowData.uid + "]").removeClass(styleName);
                                var index = _vc.viewState[idGrid].rows[rowData.uid].style.indexOf(styleName);
                                _vc.viewState[idGrid].rows[rowData.uid].style.splice(index, 1);
                            }
                        },
                        /**
                         * Permite cambiar el ancho de una columna en una grilla
                         *
                         * @method resizeGridColumn
                         * @param {String} gridId Identificador del grid
                         * @param {String} columnId Identificador de la columna
                         * @param {Integer} columnWith Id de la etiqueta de ayuda o Texto a colocar como Tooltip
                         * @example grid.resizeGridColumn('QV_ID', 'cedula', 200);
                         */
                        resizeGridColumn: function (gridId, columnId, columnWidth) {
                            if (angular.isDefined(_vc.viewState[gridId])) {
                                if (angular.isDefined(_vc.viewState[gridId].column[columnId])) {
                                    _vc.viewState[gridId].column[columnId].width = columnWidth;
                                    var gridControl = $("#" + gridId),
                                        th = gridControl.find(".k-grid-header-wrap").find("thead th[data-field='" + columnId + "']"),
                                        idx, tdheader, tdbody;
                                    th = th.length === 0 ? gridControl.find(".k-grid-header-wrap").find("thead th:last-child") : th;
                                    if (th.length) {
                                        idx = $.inArray(th[0], th.parent().children(":visible"));
                                        tdheader = gridControl.find(".k-grid-header-wrap").find("colgroup col").eq(idx);
                                        tdbody = gridControl.find(".k-grid-content").find("colgroup col").eq(idx);
                                        tdheader.css({
                                            width: columnWidth
                                        });
                                        tdbody.css({
                                            width: columnWidth
                                        });
                                    }
                                }
                            }
                        },

                        /**
                         * Permite cambiar el Tooltip de un control en la grilla
                         *
                         * @method changeTooltip
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna
                         * @param {String} labelId Id de la etiqueta de ayuda o Texto a colocar como Tooltip
                         * @example grid.changeTooltip('QV_ID', 'nombreAtributo', 'TSDEG.DLB_TSDEG_OROLATOIO_80972');
                         */
                        changeTooltip: function (idGrid, idColumn, labelId) {
                            if (angular.isDefined(_vc.viewState[idGrid])) {
                                if (angular.isDefined(_vc.viewState[idGrid].column[idColumn])) {
                                    _vc.viewState[idGrid].column[idColumn].tooltip = labelId;
                                }
                            }
                        },
                        /**
                         * Permite cambiar la imagen de un
                         * imageButton
                         *
                         * @method changeImageStyle
                         * @param {String} idGrid Identificador del grid
                         * @param {String} idColumn Identificador de la columna
                         * @param {String} styleName estilo de imagen
                         * @example grid.changeImageStyle('QV_ID', 'VA_STAPRSONAS8904_0000920', 'glyphicon glyphicon-info-sign');
                         */
                        changeImageStyle: function (idGrid, idColumn, styleName) {
                            if (angular.isDefined(_vc.viewState[idGrid])) {
                                if (angular.isDefined(_vc.viewState[idGrid].column[idColumn])) {
                                    _vc.viewState[idGrid].column[idColumn].imageId = styleName;
                                }
                            }
                        },
                        /**
                         * Permite activar el foco de un comando de la grilla. El parametro enqueue permite definir
                         * si se encola o no la peticion de activacion del foco cuando el comando no fue contrado.
                         * El evento dataBound de la grilla verifica si existe alguna peticion pendiente para activar un comando de la grilla.
                         *
                         * @method focusCommand
                         * @param {String} gridId Identificador del Grid
                         * @param {String} commandId Identificado del Comando del Grid
                         * @param {Boolean} enqueue True por defecto
                         */
                        focusCommand: function (gridId, commandId, enqueue) {
                            if (typeof enqueue === "undefined") {
                                enqueue = true;
                            }
                            var control = $("#" + commandId);
                            if (control.length > 0) {
                                dsgnrUtils.component.focusControl(commandId);
                            } else if (enqueue) {
                                if (!_vc.viewState[gridId]) {
                                    _vc.viewState[gridId] = {};
                                }
                                _vc.viewState[gridId].pendingFocus = commandId;
                            }
                        },

                        /**
                         * Permite obtener o cambiar la etiqueta de un control.
                         *
                         * @method title
                         * @param {String} gridId identificador del QueryView
                         * @param {String} columnId nombre del atributo de la entidad asociado a la columna
                         * @param {String} title nuevo titulo de la columna
                         * @param {Boolean} translate permite definir si el titulo se traduce, por defecto SI traduce
                         * @param {Array} parameters arreglo de valores que requiereel titulo. Ejemplo:
                         *             TitleText: Valor {0},
                         *            TitleParameters:
                         *            [2000]
                         * @return {String} titulo actual. NO devuelve del Id de la etiqueta, devuelve eltexto traducido cuando aplica.
                         * @example
                         *
                         * //Obtienen la etiqueta actual de
                         * un control var currentLabel =
                         * args.commons.api.grid.title("QV_ID", "nombreAtributo");
                         *
                         * //Define el nuevo titulo de la columna, el valor del titulo debe ser el Id de una Etiqueta.
                         * args.commons.api.grid.title("QV_ID", "nombreAtributo", "LABEL_ID");
                         *
                         * //Define el nuevo titulo de la columna y el valor del titulo no sera traducido
                         * args.commons.api.viewState.title("QV_ID", "nombreAtributo", "Ejemplo titulo sin traducir", false);
                         *
                         * //Define el nuevo titulo de la columna, la titulo requiere parametros.
                         * args.commons.api.viewState.title("QV_ID", "nombreAtributo", "Ejemplo {0} y {1}", true, ['Valor1', 100]);
                         */
                        title: function (gridId, columnId, title, translate, parameters) {
                            var currentTitle, args = {}, i;
                            if (angular.isDefined(gridId) && angular.isDefined(_vc.viewState[gridId]) && angular.isDefined(_vc.viewState[gridId].column) && angular.isDefined(_vc.viewState[gridId].column[columnId])) {
                                if (angular.isUndefined(translate)) {
                                    translate = true;
                                }
                                if (angular.isDefined(title)) {
                                    _vc.viewState[gridId].column[columnId].title = title;
                                    if (translate === true) {
                                        if (angular.isDefined(parameters) && angular.isArray(parameters)) {
                                            for (i = 0; i < parameters.length; i = i + 1) {
                                                args['p' + i] = parameters[i];
                                            }
                                            _vc.viewState[gridId].column[columnId].titleArgs = args;
                                        }
                                        currentTitle = $filter('translate')(_vc.viewState[gridId].column[columnId].title, _vc.viewState[gridId].column[columnId].titleArgs);
                                    }
                                }
                                if (translate === true && angular.isUndefined(currentTitle)) {
                                    currentTitle = $filter('translate')(_vc.viewState[gridId].column[columnId].title, _vc.viewState[gridId].titleArgs);
                                } else if (angular.isUndefined(currentTitle)) {
                                    currentTitle = _vc.viewState[gridId].column[columnId].title;
                                }
                            }
                            return currentTitle;
                        },
                        /**
                         * Permite cambiar el formato de toda una columna de la grilla
                         *
                         * @method format
                         * @param {String} id del Grid (QueryViewContainer)
                         * @param {String} columnId nombre del atributo asociado a la columna
                         * @param {String} format nuevo formato
                         * @param {Int} decimals numero de decimales
                         * @return {String} formato actual
                         * @example args.commons.api.grid.format('QV_ID','nombreAtributo', '####.##', 2);
                         */
                        format: function (gridId, columnId, format, decimals) {
                            var currentFormat, grid, column, widget;
                            if (angular.isDefined(gridId) && angular.isDefined(columnId)) {
                                grid = _vc.viewState[gridId];
                                if (angular.isDefined(grid)) {
                                    column = grid.column[columnId];
                                    if (angular.isDefined(column)) {
                                        if (angular.isDefined(format)) {
                                            column.format = format;
                                        }
                                        if (angular.isDefined(decimals)) {
                                            column.decimals = decimals;
                                        }
                                        if (angular.isDefined(format) || angular.isDefined(decimals)) {
                                            widget = $("#" + gridId).data("kendoGrid");
                                            if (angular.isDefined(widget)) {
                                                widget.refresh();
                                            }
                                        }
                                        currentFormat = column.format;
                                    }
                                }
                            }
                            return currentFormat;
                        },
                        /**
                         * Permite cambiar la mascara de toda una columna de la grilla
                         *
                         * @method mask
                         * @param {String} id del Grid (QueryViewContainer)
                         * @param {String} columnId nombre del atributo asociado a la columna
                         * @param {String} mask nueva mascara
                         * @return {String} mascara actual
                         * @example args.commons.api.grid.mask('QV_ID','nombreAtributo', '###-###');
                         */
                        mask: function (gridId, columnId, mask) {
                            var currentMask, grid, column;
                            if (angular.isDefined(gridId) && angular.isDefined(columnId)) {
                                grid = _vc.viewState[gridId];
                                if (angular.isDefined(grid)) {
                                    column = grid.column[columnId];
                                    if (angular.isDefined(column)) {
                                        if (angular.isDefined(mask)) {
                                            column.mask = mask;
                                        }
                                        currentMask = column.mask;
                                    }
                                }
                            }
                            return currentMask;
                        },
                        /**
                         * Cambio de prefijo de controles tipo InputTextBox en columnas de grilla
                         *
                         * @method columnPrefix
                         * @param {String} id del Grid (QueryViewContainer)
                         * @param {String} columnId nombre del atributo asociado a la columna
                         * @param {String} prefix nuevo prefijo
                         * @example args.commons.api.grid.columnPrefix('QV_ID','nombreAtributo', '$');
                         */
                        columnPrefix: function (gridId, columnId, prefix) {
                            var currentPrefix, grid, column;
                            if (angular.isDefined(gridId) && angular.isDefined(columnId)) {
                                grid = _vc.viewState[gridId];
                                if (angular.isDefined(grid)) {
                                    column = grid.column[columnId];
                                    if (angular.isDefined(column)) {
                                        if (angular.isDefined(prefix)) {
                                            column.prefix = prefix;
                                        }
                                        currentPrefix = column.prefix;
                                    }
                                }
                            }
                            return currentPrefix;
                        },
                        /**
                         * Cambio de prefijo de controles tipo InputTextBox en celdas de grilla
                         *
                         * @method cellPrefix
                         * @param {String} id del Grid (QueryViewContainer)
                         * @param {Object} rowData Objeto que contiene el registro con el InputTextBox para agregar prefijo
                         * @param {String} columnId nombre del atributo asociado a la columna
                         * @param {String} prefix nuevo prefijo
                         * @example args.commons.api.grid.cellPrefix('QV_ID', rowData, 'nombreAtributo', '$');
                         */
                        cellPrefix: function (gridId, rowData, columnId, prefix) {
                            var currentPrefix, grid, column, element;
                            if (angular.isDefined(gridId) && angular.isDefined(columnId)) {
                                grid = _vc.viewState[gridId];
                                if (angular.isDefined(grid)) {
                                    column = grid.column[columnId];
                                    if (angular.isDefined(column) && angular.isDefined(column.element) && angular.isDefined(rowData) && angular.isDefined(rowData.uid)) {
                                        element = column.element[rowData.uid];
                                        if (angular.isUndefined(element)) {
                                            element = {};
                                            column.element[rowData.uid] = element;
                                        }
                                        if (angular.isDefined(prefix)) {
                                            element.prefix = prefix;
                                        }
                                        currentPrefix = element.prefix;
                                    }
                                }
                            }
                            return currentPrefix;
                        },
                        /**
                         * Cambio de sufijo de controles tipo InputTextBox en columnas de grilla
                         *
                         * @method columnSuffix
                         * @param {String} id del Grid (QueryViewContainer)
                         * @param {String} columnId nombre del atributo asociado a la columna
                         * @param {String} suffix nuevo prefijo
                         * @example args.commons.api.grid.columnSuffix('QV_ID','nombreAtributo', 'USD');
                         */
                        columnSuffix: function (gridId, columnId, suffix) {
                            var currentSuffix, grid, column;
                            if (angular.isDefined(gridId) && angular.isDefined(columnId)) {
                                grid = _vc.viewState[gridId];
                                if (angular.isDefined(grid)) {
                                    column = grid.column[columnId];
                                    if (angular.isDefined(column)) {
                                        if (angular.isDefined(suffix)) {
                                            column.suffix = suffix;
                                        }
                                        currentSuffix = column.suffix;
                                    }
                                }
                            }
                            return currentSuffix;
                        },
                        /**
                         * Cambio de sufijo de controles tipo InputTextBox en celdas de grilla
                         *
                         * @method cellSuffix
                         * @param {String} id del Grid (QueryViewContainer)
                         * @param {Object} rowData Objeto que contiene el registro con el InputTextBox para agregar sufijo
                         * @param {String} columnId nombre del atributo asociado a la columna
                         * @param {String} suffix nuevo prefijo
                         * @example args.commons.api.grid.cellSuffix('QV_ID', rowData, 'nombreAtributo', 'USD');
                         */
                        cellSuffix: function (gridId, rowData, columnId, suffix) {
                            var currentSuffix, grid, column, element;
                            if (angular.isDefined(gridId) && angular.isDefined(columnId)) {
                                grid = _vc.viewState[gridId];
                                if (angular.isDefined(grid)) {
                                    column = grid.column[columnId];
                                    if (angular.isDefined(column) && angular.isDefined(column.element) && angular.isDefined(rowData) && angular.isDefined(rowData.uid)) {
                                        element = column.element[rowData.uid];
                                        if (angular.isUndefined(element)) {
                                            element = {};
                                            column.element[rowData.uid] = element;
                                        }
                                        if (angular.isDefined(suffix)) {
                                            element.suffix = suffix;
                                        }
                                        currentSuffix = element.suffix;
                                    }
                                }
                            }
                            return currentSuffix;
                        },
                        /**
                         * M&eacute;todo para indicar si la grilla est&aacute; siendo editada
                         *
                         * @method editing
                         * @param {String} idGrid Identificador del grid
                         * @return boolean
                         * @example editing('QV_ID_CTL1');
                         */
                        editing: function (idGrid) {
                            var grid = $("#" + idGrid).data("kendoGrid"),
                                rows, row, item, editing = false;
                            if (angular.isDefined(grid)) {
                                if (angular.isDefined(grid.tbody)) {
                                    rows = grid.tbody[0].rows;
                                    if (rows.length > 0) {
                                        for (item in rows) {
                                            row = rows[item];
                                            if ("ng-scope k-grid-edit-row" === row.className) {
                                                editing = true;
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                            return editing;
                        },
                        /**
                         * Permite definir la plantilla del contenido de las opciones del ComboBox de una grilla
                         *
                         * @method template
                         * @param {String} idGrid Identificador de la grilla
                         * @param {String} idColumn Identificador de la columna de una grilla que tiene un combo
                         * @param {String} template plantilla del contenido de las opciones del ComboBox
                         * @return {String} plantilla actual
                         * @example args.commons.api.grid.template('GRID_ID', 'COLUMN_ID''<span>attr1</span><span>attr2</span>');
                         */
                        template: function (idGrid, idColumn, template) {
                            var currentTemplate;
                            if (angular.isDefined(_vc.viewState[idGrid])) {
                                if (angular.isDefined(_vc.viewState[idGrid].column[idColumn])) {
                                    if (angular.isDefined(_vc.viewState[idGrid].column[idColumn].template)) {
                                        _vc.viewState[idGrid].column[idColumn].template = template;
                                        currentTemplate = template;
                                    }
                                }
                            }
                            return currentTemplate;
                        },
                        /**
                         * Permite definir la plantilla del contenido de la cabecera del DropDownList de una grilla
                         *
                         * @method template
                         * @param {String} idGrid Identificador de la grilla
                         * @param {String} idColumn Identificador de la columna de una grilla que tiene un DropDownList
                         * @param {String} template plantilla del contenido de las opciones del DropDownList
                         * @return {String} plantilla actual
                         * @example args.commons.api.grid.template('GRID_ID', 'COLUMN_ID''<span>attr1</span><span>attr2</span>');
                         */
                        valueTemplate: function (idGrid, idColumn, template) {
                            var currentTemplate;
                            if (angular.isDefined(_vc.viewState[idGrid])) {
                                if (angular.isDefined(_vc.viewState[idGrid].column[idColumn])) {
                                    if (angular.isDefined(_vc.viewState[idGrid].column[idColumn].valueTemplate)) {
                                        _vc.viewState[idGrid].column[idColumn].valueTemplate = template;
                                        currentTemplate = template;
                                    }
                                }
                            }
                            return currentTemplate;
                        },
                        /**
                         * Permite aplicar un filtro al Datasource
                         *
                         * @method filter
                         * @param {String} idGrid Identificador de la grilla
                         * @param {Array} filters filtros
                         * @example // Para asignar un filtro simple (un solo campo) se deben pasar en la siguiente estructura:
                         *
                         * a) Campo Texto => {field: "nombre", operator: "eq", value: "plato"}
                         * <br/>args.commons.api.grid.filter('GRID_ID', {field: "nombre", operator: "eq",  value: "plato"});
                         *
                         * b) Campo N&uacute;mero => {field: "stock", operator: "gte", value:  10}
                         * <br/>args.commons.api.grid.filter('GRID_ID', {field: "stock", operator: "gte", value: 10});
                         *
                         * c) Campo Fecha=> {field: "fecha",  operator: "eq", value: new  Date(2014, 10, 4)}
                         * <br/>args.commons.api.grid.filter('GRID_ID', {field: "fecha", operator: "eq",  value: new Date(2014, 10, 4)}); //
                         * Para asignar un filtro compuesto
                         * (varios campos) se deben pasar en
                         * la siguiente estructura:
                         *
                         * a) Alguna Opci&oacute;n =>
                         * {logic: 'or' , filters: [{field: "fechaCaducidad", operator: "gte", value: new Date(2014,12,31)},{field: "stock", operator: "lte", value: 20}]}
                         * <br/>args.commons.api.grid.filter('GRID_ID',
                         * {logic: 'or' , filters: [{field: "fechaCaducidad", operator: "gte", value: new Date(2014,12,31)},{field: "stock", operator: "lte", value: 20}]});
                         *
                         * b) Condici&oacute;n Anidada =>
                         * {logic: 'and' , filters: [{field: "fechaCaducidad", operator: "gte", value: new Date(2014,12,31)},{field: "stock", operator: "lte", value: 20}]}
                         * <br/>args.commons.api.grid.filter('GRID_ID',{logic: 'and' , filters: [{field: "fechaCaducidad", operator: "gte", value: new Date(2014,12,31)},{field: "stock", operator: "lte", value:
                             20}]}); // Para remover filtros
                         * no se debe pasar ninguno
                         * <br/>args.commons.api.grid.filter('GRID_ID');
                         */
                        filter: function (idGrid, filters) {
                            var grid, ds;
                            grid = $("#" + idGrid);
                            if (angular.isDefined(grid)) {
                                ds = grid.data("kendoGrid").dataSource;
                                if (angular.isUndefined(filters)) {
                                    ds.filter('');
                                } else {
                                    ds.filter(filters);
                                }
                            }
                        },
                        /**
                         * Permite expandir el detalle de registro de una grilla
                         *
                         * @method expandRow
                         * @param {String} gridId Identificador de la grilla
                         * @param {Object} registro actual de la grilla
                         * @example var grid = args.commons.api.grid, row = args.rowData; grid.expandRow('QV_ID', row);
                         */
                        expandRow: function (gridId, row) {
                            var grid = $('#' + gridId), kendoGrid = grid.data('kendoGrid');
                            if (angular.isDefined(kendoGrid) && angular.isDefined(row) && angular.isDefined(row.uid)) {
                                kendoGrid.expandRow($('[data-uid=\'' + row.uid + '\']'));
                            }
                        },
                        /**
                         * Permite colapsar el detalle de registro de una grilla
                         *
                         * @method collapseRow
                         * @param {String} gridId Identificador de la grilla
                         * @param {Object} registro actual de la grilla
                         * @param {Boolean} Indicar si se desea que se destruya el scope del detalle
                         * @example var grid = args.commons.api.grid, row = args.rowData; grid.collapseRow('QV_ID', row);
                         */
                        collapseRow: function (gridId, row, destroyScope) {
                            var grid = $('#' + gridId), kendoGrid = grid.data('kendoGrid');
                            if (angular.isDefined(kendoGrid) && angular.isDefined(row) && angular.isDefined(row.uid)) {
                                kendoGrid.collapseRow($('[data-uid=\'' + row.uid + '\']'));
                                if (angular.isDefined(destroyScope) && destroyScope) {
                                    var scope = angular.element($('tr[data-uid=' + row.uid + '] + tr.k-detail-row td.k-detail-cell > div')).scope();
                                    $('tr[data-uid=' + row.uid + '] + tr.k-detail-row').remove();
                                    if (angular.isDefined(scope)) {
                                        scope.$destroy();
                                    }
                                    _vc.removeChildVc(row.uid);
                                }

                            }
                        },
                        /**
                         * Permite llenar los parametros de busqueda del executeQuery
                         *
                         * @method fillFiltersQuery
                         * @param {String} queryId Identificador de la consulta
                         * @param {Object} arreglo con los parametros y sus valores
                         * @example args.commons.api.grid.fillFiltersQuery('Q_ID', {parametro:"valor"});
                         */
                        fillFiltersQuery: function (queryId, filters) {
                            if (angular.isDefined(_vc.request.qr)) {
                                _vc.request.qr[queryId].filters = filters;
                            } else {
                                var queryAux = queryId + "_filters";
                                _vc.queries[queryAux] = filters;
                            }
                        },
                        /**
                         * Verifica si el detalle de un registro de la grilla se encuentra abierto.
                         *
                         * @method isRowExpanded
                         * @param {String} queryViewId Identificador de la grilla
                         * @example args.commons.api.grid.isRowExpanded('Q_ID');
                         */
                        isRowExpanded: function (queryViewId) {
                            return $('#' + queryViewId).find('.k-detail-row').length > 0;
                        },
                        /**
                         * Permite refrescar los datos de una grilla Llama al executeQuery sin ejecutar El evento gridRowInserting
                         *
                         * @method refresh
                         * @param {String} queryViewIdId Identificador de la grilla
                         * @param {Object} arreglo con los parametros y sus valores
                         * @param {String} callback
                         * @example args.commons.api.grid.refresh('QV_ID');
                         * @example args.commons.api.grid.refresh('QV_ID', {parametro:"valor"});
                         */
                        refresh: function (queryViewId, filters, callback) {
                            var queryView = $("#" + queryViewId), queryViewObj, queryId;
                            if (queryView.length > 0) {
                                if (angular.isDefined(filters) && filters !== null) {
                                    queryViewObj = _vc.grids[queryViewId];
                                    if (angular.isDefined(queryViewObj)) {
                                        queryId = queryViewObj.queryId;
                                        this.fillFiltersQuery(queryId, filters);
                                    }
                                }
                                queryView.data('kendoGrid').dataSource.read({
                                    refresh: true
                                }).then(function () {
                                    if (angular.isDefined(callback)) {
                                        callback();
                                    }
                                });
                                queryView.data('kendoGrid').dataSource.page(1);
                            }
                        },
                        /**
                         * Permite refrescar los datos de una grilla y seleccionar un registro Primero llama a la
                         * funcion refresh y luego a la funcion selectRow.
                         *
                         * @method refreshAndSelect
                         * @param {String} queryViewIdId Identificador de la grilla
                         * @param {Object} filtros de busqueda para la consulta
                         * @param {Object} filtros de busqueda para la seleccion
                         * @example args.commons.api.grid.refreshAndSelect('QV_ID', {parameter: 'value1'},
                         *          {field: 'name', operator: 'eq', value: 'value1'});
                         */
                        refreshAndSelect: function (queryViewId, queryFilters, selectFilters) {
                            var that = this;
                            this.refresh(queryViewId, queryFilters, function () {
                                that.selectRow(queryViewId, selectFilters);
                            });
                        },
                        /**
                         * Permite seleccionar un regitro de la grilla de datos.
                         *
                         * @method selectRow
                         * @param {String} queryViewId Identificador de la consulta
                         * @param {Object} criteria arreglo con los parametros y sus valores
                         * @param {Integer} coincidence numero entero que identifica la coincidencia a ser seleccionada
                         * @example args.commons.api.grid.selectRow('Q_ID', {parametro:"valor"}, 2);
                         */
                        selectRow: function (queryViewId, criteria, coincidence) {
                            coincidence = coincidence || 1;
                            var grid = $('#' + queryViewId).data('kendoGrid'),
                                ds = grid.dataSource,
                                i,
                                page,
                                pageIndex = 1,
                                uidSelector,
                                row,
                                filteredData = kendo.data.Query.process(ds.data(), {
                                    filter: criteria
                                }).data,
                                dataPerPage = (parseInt(grid._data.length, 10) - 1),
                                firstResult = filteredData[0] ? filteredData[0].uid : '',
                                positionData = 0, y;
                            ds.page(1);
                            for (y = 0; y < grid._data.length; y = y + 1) {
                                if (grid._data[y].uid === firstResult) {
                                    positionData = y;
                                    break;
                                }
                            }

                            if ((filteredData.length > 0) && (coincidence > 0) && ((coincidence - 1) < filteredData.length)) {
                                for (i = 0; i < filteredData.length; i += 1) {
                                    uidSelector = '[data-uid="' + filteredData[i].uid + '"]';
                                    for (page = pageIndex; page <= ds.totalPages(); page += 1) {
                                        if (coincidence !== 1) {
                                            if (i === (dataPerPage - (positionData))) {
                                                pageIndex = page;
                                                ds.page(page);
                                            }
                                        } else {
                                            if (page !== pageIndex) {
                                                ds.page(page);
                                            }
                                        }

                                        row = $(uidSelector);
                                        if (row.length > 0) {
                                            if (i === (coincidence - 1)) {
                                                grid.select(row);
                                                return filteredData[i];
                                            }
                                        }

                                    }
                                }
                            } else {
                                cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFUP_00049');
                            }
                        },
                        /**
                         * Devuelve la última fila
                         *
                         * @method lastRow
                         * @param {String} queryViewID
                         * @return {Map} devuelve la última fila
                         */
                        lastRow: function (queryViewID) {
                            var grid = $('#' + queryViewID).data('kendoGrid'),
                                ds = grid.dataSource,
                                total = ds._data.length,
                                lastRow;
                            if ((total - 1) >= 0) {
                                lastRow = ds.data()[total - 1];
                            }
                            return lastRow;
                        },
                        /**
                         * Establece los parámetros para el evento Agregar Registros por paginación
                         * @method setAppendRecordsParams
                         * @param {String} queryViewID
                         * @param [String] columnsToPageOver
                         * @param {String} args
                         */
                        setAppendRecordsParams: function (queryViewId, columnsToPageOver, args) {
                            if (args.config && args.config.appendRecords && args.config.appendRecords === true) {
                                var lastRecord = this.lastRow(queryViewId);
                                if (lastRecord && angular.isArray(columnsToPageOver)) {
                                    angular.forEach(columnsToPageOver, function (col) {
                                        var value = lastRecord[col];
                                        if (angular.isDefined(value)) {
                                            if (typeof value === 'string') {
                                                value = value.trim();
                                            }
                                            args.parameters[col] = value;
                                        }
                                    });
                                }
                            }
                        },
                        /**
                         * Permite mover el toolbar de la posición por defecto a la parte inferior de la grilla
                         *
                         * @method moveToolbarToTheBottom
                         * @param {String} queryViewId Identificador de la grilla
                         *
                         * @example args.commons.api.grid.moveToolbarToTheBottom('QV_ID');
                         */

                        moveToolbarToTheBottom: function (queryViewId) {
                            var gridContentElement = $('#' + queryViewId + ' .k-grid-content');
                            if (gridContentElement.size() > 0) {
                                $('#' + queryViewId).find('.k-grid-toolbar').insertAfter(gridContentElement);
                            } else {
                                $('#' + queryViewId).find('.k-grid-toolbar').insertAfter($('#' + queryViewId + ' table'));
                            }
                        }
                    };
                    var _errors = {
                        /**
                         * Obtiene el numero de errores de un grupo
                         *
                         * @method getErrorsGroup
                         * @param {String} groupValidator
                         * @param {String} showErrors
                         * @return {Number} numero de errores del grupo
                         */
                        getErrorsGroup: function (groupValidator, showErrors) {
                            var numErrors = 0,
                                nameGroupValidator = "#" + groupValidator,
                                control = $(nameGroupValidator),
                                exists = false,
                                validator,
                                mensaje = "";

                            if (typeof control !== "undefined" && control !== null) {
                                validator = control.data("kendoValidator");
                                if (typeof validator !== "undefined" && validator !== null) {
                                    exists = true;
                                } else {
                                    nameGroupValidator += "_VAL";
                                    control = $(nameGroupValidator);
                                    if (control !== null && typeof control !== "undefined") {
                                        validator = control.data("kendoValidator");
                                        if (typeof validator !== "undefined" && validator !== null) {
                                            exists = true;
                                        }
                                    }
                                }
                                if (exists) {
                                    if (!validator.validate()) {
                                        numErrors = validator.errors().length;
                                        var elementError = dsgnrUtils.component.getElementFocusError(validator);
                                        if (elementError === null) {// los controles que presentan errores no estan visibles o habilitados
                                            return 0;
                                        }
                                        if (showErrors || showErrors === null) {
                                            dsgnrUtils.component.focusError(validator);
                                        } else {
                                            validator.hideMessages();
                                        }
                                    }
                                } else {
                                    mensaje = $filter('translate')('DSGNR.SYS_DSGNR_MSGERRGRP_00050');
                                    logger.warn(msg + groupValidator);
                                }
                            } else {
                                mensaje = $filter('translate')('DSGNR.SYS_DSGNR_MSGERRGRP_00051');
                                logger.warn(msg + groupValidator);
                            }

                            return numErrors;
                        },

                        /**
                         * Establece el número de errores de un grupo
                         *
                         * @method setErrorsGroup
                         * @param {String} groupId
                         * @param {Number} numErrors
                         */
                        setErrorsGroup: function (groupId, numErrors) {
                            if (typeof numErrors === "undefined" || numErrors == null) {
                                numErrors = -1; // eliminar cualquier texto
                            }
                            if (numErrors > 0) {
                                _setStyle(groupId, _constants.styles.Fail, numErrors);
                            } else if (numErrors == 0) {
                                _setStyle(groupId, _constants.styles.Success, numErrors);
                            } else {
                                _setStyle(groupId, _constants.styles.None, numErrors);
                            }
                        },
                        /**
                         * Permite validar un control especifico
                         *
                         * @method validateInput
                         * @param {String} controlId identificador del control
                         * @param {Boolean} showError define si se muestra el mensaje de error o no
                         * @return {Object} result
                         * @example args.commons.api.errors.validateInput('VA_ID', true);
                         */
                        validateInput: function (controlId, showError) {
                            var widget, validators, validator, id, result;
                            if (angular.isUndefined(controlId)) {
                                return undefined;
                            }
                            id = '#' + controlId;
                            widget = $(id);
                            if (widget.length === 0) {
                                return undefined;
                            }
                            validators = widget.parents('[kendo-validator]');
                            if (validators.length === 0) {
                                return undefined;
                            }
                            validator = validators.data('kendoValidator');
                            if (angular.isUndefined(validator)) {
                                return undefined;
                            }
                            result = validator.validateInput(widget);
                            if (result === false) {
                                if (angular.isUndefined(showError)) {
                                    showError = true;
                                }
                                if (showError === true) {
                                    dsgnrUtils.component.focusControl(controlId);
                                } else {
                                    validator.hideMessages();
                                }
                            }
                            return result;
                        }
                    };
                    /**
                     * Arreglo para manejo de eventos de Navegaci&oacute;n
                     *
                     * @attribute navigation
                     * @type Object
                     */
                    var _navigation = {
                        label: "",
                        address: {
                            moduleId: undefined,
                            subModuleId: undefined,
                            taskId: undefined,
                            taskVersion: undefined,
                            viewContainerId: undefined
                        },
                        customAddress: {
                            /**
                             * Variable con el Identificador de la Ventana a Abrir o
                             * Navegar
                             */
                            id: undefined,
                            /**
                             * URL de la p&aacute;gina a abrir o navegar
                             */
                            url: undefined,
                            /**
                             * Controlador a instanciar
                             *
                             */
                            controller: undefined,
                            /**
                             * flag que indica si una navegacion manual tiene archivos minificados
                             * para ser utilizados
                             */
                            useMinification: true
                        },
                        queryParameters: {
                            mode: undefined,
                            pk: undefined
                        },
                        modalProperties: {
                            height: undefined,
                            size: undefined,
                            callFromGrid: false
                        },
                        popoverProperties: {},
                        scripts: [],
                        loadSequentialMode: true,
                        dialogParameters: {},
                        openPageDesigner: false,

                        customDialogParameters: {},
                        detailProperties: {},
                        /**
                         * M&eacute;todo para navegar a una p&aacute;gina
                         * desarrollada con Designer
                         *
                         * @method navigate
                         * @param {String} controlId Identificador del control desde
                         *            donde se invocar&aacute; la p&aacute;gina
                         * @return {String} promesa
                         * @example navigation.navigate(gridExecuteCommandEventArgs.commons.controlId);
                         */
                        navigate: function (controlId) {
                            var that = this,
                                routes = $route.routes,
                                routePath = "/" + this.address.viewContainerId,
                                templateUrl,
                                customJs, controllerUrl, verifyRoutes, responseLR, controller,
                                typeNavigation, isLiferay = cobis.utils.isRunOnLiferay();

                            if (dsgnrUtils.task.isNewDesignerFrameworkVersion()) {
                                _lockUnlockScreen(null, 1);
                            }

                            verifyRoutes = !routes[routePath] && _vc.routeProvider ? true : false;

                            if(verifyRoutes) {
                                if (!isLiferay) {
                                    typeNavigation = _constants.typeNavigation.NORMAL;
                                } else if (isLiferay && "portletName" in this.address && "navigationInside" in this.address && this.address.navigationInside) {
                                    typeNavigation = _constants.typeNavigation.INPORTLET;
                                } else if (isLiferay && "portletName" in this.address && (!("navigationInside" in this.address) ||
                                    ("navigationInside" in this.address && !this.address.navigationInside))) {
                                    typeNavigation = _constants.typeNavigation.OUTPORTLET;
                                }

                                switch (typeNavigation) {
                                    case "inPortlet":
                                        responseLR = dsgnrExt.getDataToNavigate(this.address, true);
                                        templateUrl = responseLR.templateUrl;
                                        customJs = responseLR.customJs;
                                        controllerUrl = responseLR.controllerUrl;
                                        controller = this.address.viewContainerId + "_CTRL";
                                        break;
                                    case "outPortlet":
                                        responseLR = dsgnrExt.getDataToNavigate(this.address, false);
                                        this.address.pageURL = responseLR.portletUrl.url;
                                        break;
                                    case "normal":
                                        templateUrl = "${contextPath}/cobis/web/views/" + this.address.moduleId + "/" + this.address.subModuleId + "/" +
                                            this.address.taskId + "/" + this.address.taskVersion + "/" + this.address.viewContainerId;
                                        customJs = templateUrl + "_CUSTOM.js";
                                        controllerUrl = templateUrl + dsgnrUtils.minification.getMinificationExt() + ".js";
                                        controller = this.address.viewContainerId + "_CTRL";
                                        templateUrl = templateUrl + "_FORM.html";
                                        break;
                                    default:
                                        break;
                                }
                            }
                            this.dialogParameters.controlId = controlId;
                            _vc.dialogParameters = this.dialogParameters;
                            _vc.customDialogParameters = this.customDialogParameters;
                            try {
                                if (typeNavigation!=="outPortlet") {
                                    if (verifyRoutes) {
                                        _vc.routeProvider.when(routePath, {
                                            templateUrl: templateUrl,
                                            controller: controller,
                                            label: this.label,
                                            resolve: {
                                                dependencies: ["$q", "$rootScope",
                                                    function ($q, $rootScope) {
                                                        var deferred = $q.defer();
                                                        window.$script(controllerUrl, function () {
                                                            window.$script(customJs, function () {
                                                                $rootScope.$apply(function () {
                                                                    deferred.resolve();
                                                                });
                                                            });
                                                        });
                                                        return deferred.promise;
                                                    }],
                                                specificTranslations: ["$translatePartialLoader", "$translate", "asyncLoader",
                                                    function ($translatePartialLoader, $translate, asyncLoader) {
                                                        if (cobis.utils.isRunOnLiferay()) {
                                                            asyncLoader({
                                                                moduleId: that.address.moduleId,
                                                                contextPath: "assets-libs-" + that.address.moduleId + ".portlet"
                                                            });
                                                        } else {
                                                            $translatePartialLoader.addPart(that.address.moduleId);
                                                            if (angular.isDefined(that.scripts)) {
                                                                if (angular.isArray(that.scripts) && that.scripts.length > 0) {
                                                                    angular.forEach(that.scripts, function (script) {
                                                                        $translatePartialLoader
                                                                            .addPart(script.module);
                                                                    });
                                                                } else {
                                                                    if ($.trim(that.scripts.module).length > 0) {
                                                                        $translatePartialLoader
                                                                            .addPart(that.scripts.module);
                                                                    }
                                                                }
                                                            }
                                                            return $translate.refresh();
                                                        }
                                                    }]
                                            }
                                        });
                                    }
                                    _vc.url(this.address.viewContainerId, this.queryParameters);
                                } else {
                                    _vc.url(this.address.viewContainerId, this.queryParameters, this.address.pageURL);
                                }
                            } catch (err) {
                                logger.error(err.message);
                            }
                            this.dispatched = true;
                        },
                        /**
                         * M&eacute;todo para navegar a una p&aacute;gina
                         * desarrollada a mano, usando los valores especificados
                         * previamente
                         *
                         * @method customNavigate
                         * @return {Object} module-files
                         * @example navigation.customNavigate();
                         * @example navigation.customNavigate('cobis/web/xclddvws/');
                         */
                        customNavigate: function (appPath) {
                            var that = this,
                                routes = $route.routes,
                                routePath = "/" + this.customAddress.id,
                                templateUrl,
                                baseUrl,
                                i,
                                useMinification = this.customAddress.useMinification,
                                lengthUrl,
                                characterAux;
                            if (dsgnrUtils.task.isNewDesignerFrameworkVersion()) {
                                _lockUnlockScreen(null, 1);
                            }
                            if (!routes[routePath] && _vc.routeProvider) {
                                console.log("loading custom url: " + this.customAddress.url);
                                if (appPath) {
                                    baseUrl = "${contextPath}/" + appPath;
                                } else {
                                    baseUrl = "${contextPath}/cobis/web/views/";
                                }
                                lengthUrl = baseUrl.length;
                                if (lengthUrl > 0) {
                                    characterAux = baseUrl.charAt(lengthUrl - 1);
                                    if (characterAux !== '/' && characterAux !== '\\') {
                                        baseUrl = baseUrl + "/";
                                    }
                                }
                                templateUrl = baseUrl + this.customAddress.url;
                                console.log("loading templateUrl: " + templateUrl);
                                _vc.routeProvider.when(routePath, {
                                    templateUrl: templateUrl,
                                    controller: this.customAddress.controller,
                                    label: this.label,
                                    resolve: {
                                        dependencies: ["$ocLazyLoad", "$translatePartialLoader", "$translate",
                                            function ($ocLazyLoad, $translatePartialLoader, $translate) {

                                                var createLazyLoadObject = function (script) {
                                                    var files = [];
                                                    for (i = 0; i < script.files.length; i = i + 1) {
                                                        files.push(baseUrl + dsgnrUtils.minification.getCustomFilePath(script.files[i], useMinification));
                                                    }
                                                    return {
                                                        name: script.module,
                                                        files: files
                                                    };
                                                }, createAngularModule = function (name) {
                                                    var module = angular.module(name, []);
                                                    module.run(["$translatePartialLoader", "$translate",
                                                        function ($translatePartialLoader, $translate) {
                                                            $translatePartialLoader.addPart(name);
                                                            $translate.refresh();
                                                        }]);
                                                }, modules = [];

                                                if (angular.isArray(that.scripts)) {
                                                    for (i = 0; i < that.scripts.length; i = i + 1) {
                                                        createAngularModule(that.scripts[i].module);
                                                        modules.push(createLazyLoadObject(that.scripts[i]));
                                                    }
                                                } else {
                                                    createAngularModule(that.scripts.module);
                                                    modules.push(createLazyLoadObject(that.scripts));
                                                }

                                                return $ocLazyLoad.load(modules);
                                            }]
                                    }
                                });
                            }
                            _vc.customDialogParameters = this.customDialogParameters;
                            _vc.url(this.customAddress.id);
                            this.dispatched = true;
                        },
                        /**
                         * M&eacute;todo para abrir una p&aacute;gina desarrollada
                         * con Designer en una ventana modal, usando los valores
                         * especificados previamente
                         *
                         * @method openModalWindow
                         * @param {String} controlId Identificador del control desde
                         *            donde se invocar&aacute; la p&aacute;gina
                         * @param {String} modelRow [Opcional] Fila desde la cual se
                         *            invoco la ventana modal (solo para grillas)
                         * @example Para Grillas:<br/>
                         *          navigation.openModalWindow(id,
                         *          textInputButtonEventGridArgs.modelRow);<br/><br/>
                         *          Para Cabecera:<br/>
                         *          navigation.openModalWindow(id, null);
                         */
                        openModalWindow: function (controlId, modelRow) {
                            var that = this,
                                modalWindowHeight,
                                controllerUrl,
                                customJs,
                                modalScope = $rootScope.$new(),
                                templateUrl;

                            if (dsgnrUtils.task.isNewDesignerFrameworkVersion()) {
                                _lockUnlockScreen(null, 1);
                            }
                            console.log("opening ModalWindow: " + this.address.viewContainerId);

                            if (cobis.utils.isRunOnLiferay()) {
                                templateUrl = dsgnrExt.templateUrlOpenModal(this.address).templateUrl;
                                controllerUrl = dsgnrExt.templateUrlOpenModal(this.address).controllerUrl;
                                customJs = dsgnrExt.templateUrlOpenModal(this.address).customJs;
                            } else {
                                templateUrl = "${contextPath}/cobis/web/views/" + this.address.moduleId + "/" + this.address.subModuleId + "/" + this.address.taskId + "/" +
                                    this.address.taskVersion + "/" + this.address.viewContainerId;

                                customJs = templateUrl + "_CUSTOM.js";
                                controllerUrl = templateUrl + dsgnrUtils.minification.getMinificationExt() + ".js";
                                templateUrl = templateUrl + "_FORM.html";
                            }

                            if (angular.isDefined(this.queryParameters)) {
                                modalScope.queryParameters = this.queryParameters;
                            }

                            if (typeof this.modalProperties.height === 'number' && isFinite(this.modalProperties.height)) {
                                modalWindowHeight = "style='height:" + this.modalProperties.height + "px;'";
                            } else {
                                modalWindowHeight = "style='height:auto;'";
                            }

                            if (this.modalProperties.size === 'small') {
                                this.modalProperties.size = 'sm';
                            } else if (this.modalProperties.size === 'large') {
                                this.modalProperties.size = 'lg';
                            }
                            _vc.addChildVc(this.address.viewContainerId);
                            if (!_vc.dialogParameters.isModal) {
                                this.dialogParameters.controlId = controlId;
                                _vc.dialogParameters = this.dialogParameters;
                            }

                            this.openPageDesigner = true;
                            _vc.openPageDesigner = this.openPageDesigner;

                            _vc.customDialogParameters = this.customDialogParameters;
                            modalScope.customDialogParameters = this.customDialogParameters;
                            _vc.modalInstances[this.address.viewContainerId] = $modal
                                .open({
                                    template: "<div class='modal-header'>"
                                    + "<button type='button' class='close' data-dismiss='modal' ng-click='vc.dismissModal($dismiss)'>"
                                    + "<span aria-hidden='true'>&times;</span>"
                                    + "<span class='sr-only'>Close</span>"
                                    + "</button>"
                                    + "<h4 class='modal-title'>{{'"
                                    + this.label
                                    + "'|translate}}</h4>"
                                    + "</div>"
                                    + "<div kendo-validator='validator' k-options='validatorOptions' class='modal-body' "
                                    + modalWindowHeight
                                    + " ng-include src=\"'"
                                    + templateUrl
                                    + "'\" onload='runLifeCycle()'>"
                                    + "</div>",
                                    controller: this.address.viewContainerId
                                    + "_CTRL",
                                    scope: modalScope,
                                    keyboard: false,
                                    backdrop: 'static',
                                    closeButtonText: 'Close',
                                    size: this.modalProperties.size,
                                    resolve: {
                                        dependencies: ["$q", "$rootScope",
                                            function ($q, $rootScope) {
                                                var deferred = $q.defer();
                                                window.$script(controllerUrl, function () {
                                                    window.$script(customJs, function () {
                                                        $rootScope.$apply(function () {
                                                            deferred.resolve();
                                                        });
                                                    });
                                                });
                                                return deferred.promise;
                                            }],

                                        specificTranslations: [
                                            "$translatePartialLoader",
                                            "$translate",
                                            "asyncLoader",
                                            function ($translatePartialLoader, $translate, asyncLoader) {
                                                if (cobis.utils.isRunOnLiferay()) {
                                                    asyncLoader({
                                                        moduleId: that.address.moduleId,
                                                        contextPath: "assets-libs-" + that.address.moduleId + ".portlet"
                                                    });
                                                } else {
                                                    $translatePartialLoader.addPart(that.address.moduleId);
                                                    if (angular.isDefined(that.scripts)) {
                                                        if (angular.isArray(that.scripts) && that.scripts.length > 0) {
                                                            angular.forEach(that.scripts, function (script) {
                                                                $translatePartialLoader.addPart(script.module);
                                                            });
                                                        } else {
                                                            if ($.trim(that.scripts.module).length > 0) {
                                                                $translatePartialLoader.addPart(that.scripts.module);
                                                            }
                                                        }
                                                    }
                                                    return $translate.refresh();
                                                }
                                            }]
                                    }
                                });

                            _vc.modalInstances[this.address.viewContainerId].result.then(function (resultModal) {
                                    _vc.handlerCloseModal({
                                        controlId: controlId,
                                        viewContainerId: that.address.viewContainerId,
                                        modelRow: modelRow,
                                        resultModal: resultModal,
                                        callFromGrid: that.modalProperties.callFromGrid
                                    });
                                },
                                function (resultModal) {
                                    console.log('Modal dismissed at: ' + new Date());
                                    _vc.handlerCloseModal({
                                        controlId: controlId,
                                        viewContainerId: that.address.viewContainerId,
                                        modelRow: modelRow,
                                        resultModal: resultModal,
                                        callFromGrid: that.modalProperties.callFromGrid
                                    });
                                })['finally']
                            (function () {
                                _vc.modalInstances[that.address.viewContainerId] = undefined;
                                _vc.dialogParameters = {};
                            });
                        },
                        /**
                         * M&eacute;todo para abrir una p&aacute;gina desarrollada
                         * manualmente en una ventana modal,usando los valores
                         * especificados previamente
                         *
                         * @method openCustomModalWindow
                         * @param {String} controlId Identificador del control desde
                         *            donde se invocar&aacute; la p&aacute;gina
                         * @param {String} modelRow [Opcional] Fila desde la cual se
                         *            invoco la ventana modal (solo para grillas)
                         * @example <span class="comment">Para Grillas: </span><br/>
                         *          <span
                         *          class="code">navigation.openCustomModalWindow(id,
                         *          textInputButtonEventGridArgs.modelRow);</span>
                         *          <br/> <span class="comment">Para Cabecera:</span><br/>
                         *          <span
                         *          class="code">navigation.openCustomModalWindow(id,
                         *          null);</span>
                         */
                        openCustomModalWindow: function (controlId, modelRow) {
                            var that = this,
                                modalWindowHeight, templateUrl,
                                useMinification = this.customAddress.useMinification;

                            if (dsgnrUtils.task.isNewDesignerFrameworkVersion()) {
                                _lockUnlockScreen(null, 1);
                            }

                            if (cobis.utils.isRunOnLiferay()) {
                                dsgnrExt.openCustomModal(controlId, modelRow, _vc, that);
                            } else {
                                console.log("loading custom url: " + this.customAddress.url);
                                templateUrl = "${contextPath}/cobis/web/views/" + this.customAddress.url;

                                if (typeof this.modalProperties.height === 'number' && isFinite(this.modalProperties.height)) {
                                    modalWindowHeight = "style='height:" + this.modalProperties.height + "px;'";
                                } else {
                                    modalWindowHeight = "";
                                }

                                if (this.modalProperties.size === 'small') {
                                    this.modalProperties.size = 'sm';
                                } else if (this.modalProperties.size === 'large') {
                                    this.modalProperties.size = 'lg';
                                }

                                _vc.addChildVc(this.customAddress.id);
                                _vc.customDialogParameters = this.customDialogParameters;

                                if (this.customAddress.url !== undefined) {
                                    _vc.modalInstances[this.customAddress.id] = $modal.open({
                                        template: "<div class='modal-header'>"
                                        + "<button type='button' class='close' data-dismiss='modal' ng-click=\"$dismiss('close')\">"
                                        + "<span aria-hidden='true'>&times;</span>"
                                        + "<span class='sr-only'>Close</span>"
                                        + "</button>"
                                        + "<h4 class='modal-title'>"
                                        + this.label
                                        + "</h4>"
                                        + "</div>"
                                        + "<div class='modal-body' "
                                        + modalWindowHeight
                                        + "  ng-include src=\"'"
                                        + templateUrl
                                        + "'\" >"
                                        + "</div>",
                                        controller: this.customAddress.controller,
                                        keyboard: false,
                                        backdrop: 'static',
                                        closeButtonText: 'Close',
                                        size: this.modalProperties.size,
                                        resolve: {
                                            dependencies: ["$ocLazyLoad", "$translatePartialLoader", "$translate",
                                                function ($ocLazyLoad, $translatePartialLoader, $translate) {
                                                    var createLazyLoadObject = function (script) {
                                                        var files = [], i;
                                                        for (i = 0; i < script.files.length; i = i + 1) {
                                                            files.push("${contextPath}/cobis/web/views/" + dsgnrUtils.minification.getCustomFilePath(script.files[i], useMinification));
                                                        }
                                                        return {
                                                            name: script.module,
                                                            files: files
                                                        };
                                                    }, createAngularModule = function (name) {
                                                        var module = angular.module(name, []);
                                                        module.run(["$translatePartialLoader", "$translate",
                                                            function ($translatePartialLoader, $translate) {
                                                                $translatePartialLoader.addPart(name);
                                                                $translate.refresh();
                                                            }]);
                                                    }, modules = [], i;
                                                    if (angular.isArray(that.scripts)) {
                                                        for (i = 0; i < that.scripts.length; i = i + 1) {
                                                            createAngularModule(that.scripts[i].module);
                                                            modules.push(createLazyLoadObject(that.scripts[i]));
                                                        }
                                                    } else {
                                                        createAngularModule(that.scripts.module);
                                                        modules.push(createLazyLoadObject(that.scripts));
                                                    }

                                                    return $ocLazyLoad.load(modules);
                                                }]
                                        }
                                    });

                                    _vc.modalInstances[this.customAddress.id].result.then(function (resultModal) {
                                            _vc.handlerCloseModal({
                                                controlId: controlId,
                                                viewContainerId: that.customAddress.id,
                                                modelRow: modelRow,
                                                resultModal: resultModal,
                                                callFromGrid: that.modalProperties.callFromGrid
                                            });
                                        },
                                        function (resultModal) {
                                            if (resultModal === 'close') {
                                                resultModal = {
                                                    dialogCloseResult: 1,
                                                    dialogCloseType: 1
                                                };
                                            }
                                            _vc.handlerCloseModal({
                                                controlId: controlId,
                                                viewContainerId: that.customAddress.id,
                                                modelRow: modelRow,
                                                resultModal: resultModal,
                                                callFromGrid: that.modalProperties.callFromGrid
                                            });
                                        })['finally']
                                    (function () {
                                        _vc.modalInstances[this.customAddress.id] = undefined;
                                        _vc.dialogParameters = {};

                                    });
                                } else {
                                    logger.error('Error customAddress.url is undefined');
                                }
                            }
                        },
                        /**
                         * M&eacute;todo para abrir un detalle de una fila de una
                         * grilla con una pantalla hecha con designer
                         *
                         * @method openDetailTemplate
                         * @param {String} gridId Identificador de la grilla donde se debe presentar el detalle
                         * @param {Object} rowData Datos de la fila
                         * @example <span
                         *          class="code">navigation.openDetailTemplate(id,
                         *          gridInitDetailTemplateArgs.rowData);</span>
                         */
                        openDetailTemplate: function (gridId, rowData) {
                            var that = this,
                                controllerUrl,
                                customJs,
                                controllerName,
                                templateUrl,
                                urlLoad, extensionForm, extensionController,
                                scriptsFiles;

                            if (angular.isDefined(_vc.grids[gridId])) {
                                console.log("opening detailTemplate: " + this.address.viewContainerId);

                                if (cobis.utils.isRunOnLiferay()) {
                                    urlLoad = "/o/" + this.address.portletName + "/";
                                    extensionForm = "_FORM.jsp";
                                    extensionController = ".js";
                                } else {
                                    urlLoad = "${contextPath}/cobis/web/views/";
                                    extensionForm = "_FORM.html";
                                    extensionController = dsgnrUtils.minification.getMinificationExt() + ".js";
                                }
                                templateUrl = urlLoad + this.address.moduleId + "/" + this.address.subModuleId + "/" +
                                    this.address.taskId + "/" + this.address.taskVersion + "/" + this.address.viewContainerId;
                                customJs = templateUrl + "_CUSTOM.js";
                                controllerUrl = templateUrl + extensionController;
                                templateUrl = templateUrl + extensionForm;
                                controllerName = this.address.viewContainerId + "_CTRL";

                                this.dialogParameters.controlId = gridId;
                                _vc.dialogParameters = this.dialogParameters;
                                _vc.customDialogParameters = this.customDialogParameters;

                                scriptsFiles = {
                                    controllerJs: controllerUrl,
                                    fileJs: customJs
                                };

                                _vc.grids[gridId].view = {
                                    controller: controllerName,
                                    scripts: scriptsFiles,
                                    isCustom: false,
                                    moduleName: this.address.moduleId,
                                    viewContainerId: this.address.viewContainerId,
                                    templateUrl: templateUrl,
                                    queryParameters: that.queryParameters
                                };

                                delete _vc.grids[gridId].customView;
                            }
                        },

                        /**
                         * M&eacute;todo para abrir un template en cada fila de la
                         * grilla
                         *
                         * @method openCustomDetailTemplate
                         * @param {String}
                         *            gridId Identificador del grid al que se va
                         *            asociar la pagina
                         * @param {String} modelRow Datos de la fila donde se selecciono
                         *            el detalle
                         * @example <span
                         *          class="code">navigation.openCustomDetailTemplate(id,
                         *          gridInitDetailTemplateArgs.modelRow);</span>
                         */
                        openCustomDetailTemplate: function (gridId, modelRow) {
                            var that = this,
                                templateUrl = "${contextPath}/cobis/web/views/" + this.customAddress.url,
                                createLazyLoadObject,
                                files = [],
                                i,
                                module,
                                modules = [],
                                createAngularModule,
                                useMinification = this.customAddress.useMinification;

                            if (angular.isDefined(_vc.grids[gridId])) {
                                console.log("loading custom url: " + this.customAddress.url);
                                _vc.customDialogParameters = this.customDialogParameters;
                                createLazyLoadObject = function (script) {
                                    for (i = 0; i < script.files.length; i = i + 1) {
                                        files.push("${contextPath}/cobis/web/views/" + dsgnrUtils.minification.getCustomFilePath(script.files[i], useMinification));
                                    }
                                    return {
                                        name: script.module,
                                        files: files
                                    };
                                };
                                createAngularModule = function (name) {
                                    module = angular.module(name, []);
                                    module.run(["$translatePartialLoader", "$translate",
                                        function ($translatePartialLoader, $translate) {
                                            $translatePartialLoader.addPart(name);
                                            $translate.refresh();
                                        }]);
                                };
                                if (angular.isArray(that.scripts)) {
                                    for (i = 0; i < that.scripts.length; i = i + 1) {
                                        createAngularModule(that.scripts[i].module);
                                        modules.push(createLazyLoadObject(that.script.files[i]));
                                    }
                                } else {
                                    createAngularModule(that.scripts.module);
                                    modules.push(createLazyLoadObject(that.scripts));
                                }

                                _vc.grids[gridId].customView = {
                                    id: this.customAddress.id,
                                    templateUrl: templateUrl,
                                    scripts: modules
                                };
                                delete _vc.grids[gridId].view;
                            }
                        },
                        /**
                         * M&eacute;todo para registrar pagina a incluirse en grupo
                         *
                         * @method registerView
                         * @param {String} groupId Identificador del grupo al que se va
                         *            asociar la pagina
                         * @example <span
                         *          class="code">navigation.registerView(groupId);</span>
                         */
                        registerView: function (groupId) {
                            var groupStructure = _vc.viewState[groupId],
                                controllerUrl,
                                moduleJs,
                                moduleCss,
                                customJs,
                                controllerName,
                                templateUrl,
                                scriptsFiles;

                            if (angular.isDefined(groupStructure)) {
                                if (angular.isDefined(groupStructure.view)) {
                                    if (angular.isDefined(this.address) && angular.isDefined(this.address.viewContainerId)) {
                                        console.log("opening viewContainer: " + this.address.viewContainerId);
                                        templateUrl = "${contextPath}/cobis/web/views/" + this.address.moduleId + "/" + this.address.subModuleId + "/" +
                                            this.address.taskId + "/" + this.address.taskVersion + "/" + this.address.viewContainerId;

                                        moduleJs = "${contextPath}/cobis/web/views/" + this.address.moduleId + "/assets/scripts/" + this.address.moduleId + '.js';
                                        moduleCss = "${contextPath}/cobis/web/views/" + this.address.moduleId + "/assets/styles/" + this.address.moduleId + '.css';
                                        customJs = templateUrl + "_CUSTOM.js";
                                        controllerUrl = templateUrl + dsgnrUtils.minification.getMinificationExt() + ".js";
                                        templateUrl = templateUrl + "_FORM.html";

                                        this.dialogParameters.controlId = groupId;
                                        _vc.dialogParameters = this.dialogParameters;
                                        _vc.customDialogParameters = this.customDialogParameters;
                                        controllerName = this.address.viewContainerId + "_CTRL";

                                        scriptsFiles = {
                                            moduleJs: moduleJs,
                                            controllerJs: controllerUrl,
                                            fileJs: customJs
                                        };

                                        if (angular.isDefined(groupStructure.view) && angular.isDefined(groupStructure.view.viewContainerId) && (groupStructure.view.viewContainerId === this.address.viewContainerId)) {
                                            _vc.removeChildVc(groupStructure.view.viewContainerId);
                                        }
                                        if (angular.isDefined(groupStructure.customView) && angular.isDefined(groupStructure.customView.id) && (groupStructure.customView.id === this.address.viewContainerId)) {
                                            _vc.removeChildVc(groupStructure.customView.id);
                                        }

                                        _vc.addChildVc(this.address.viewContainerId);
                                        groupStructure.view = {
                                            controller: controllerName,
                                            scripts: scriptsFiles,
                                            styles: moduleCss,
                                            isCustom: false,
                                            moduleName: this.address.moduleId,
                                            viewContainerId: this.address.viewContainerId,
                                            queryParameters: this.queryParameters,
                                            templateUrl: templateUrl
                                        };

                                        groupStructure.customView = {};

                                    } else {
                                        // En el caso de que no exista VC definida
                                        // el grupo elimina el html interno
                                        // Ver directiva designerFormLoad
                                        groupStructure.view = {};
                                        groupStructure.customView = {};

                                    }

                                } else {
                                    console.log("GroupId " + groupId + " doesn't support a custom page");
                                }
                            } else {
                                console.log("GroupId " + groupId + " doesn't exist");
                            }
                        },
                        /**
                         * M&eacute;todo para registrar
                         * pagina a incluirse en grupo
                         *
                         * @method registerCustomView
                         * @param {String} groupId Identificador del grupo al que se va
                         *            asociar la pagina
                         * @example <span
                         *          class="code">navigation.registerCustomView(groupId);</span>
                         * @example <span
                         *          class="code">navigation.registerCustomView(groupId,''cobis/web/xclddvws/'');</span>
                         */
                        registerCustomView: function (groupId, appPath) {
                            var that = this,
                                groupStructure = _vc.viewState[groupId],
                                createLazyLoadObject,
                                createAngularModule,
                                modules = [],
                                i,
                                templateUrl,
                                baseUrl,
                                useMinification = this.customAddress.useMinification,
                                lengthUrl = 0,
                                characterAux;

                            if (angular.isDefined(groupStructure)) {
                                if (angular.isDefined(groupStructure.customView)) {

                                    if (angular.isDefined(this.customAddress) && angular.isDefined(this.customAddress.url)) {
                                        if (appPath) {
                                            baseUrl = "${contextPath}/" + appPath;
                                        } else {
                                            baseUrl = "${contextPath}/cobis/web/views/";
                                        }
                                        console.log("loading custom url: " + this.customAddress.url);
                                        lengthUrl = baseUrl.length;
                                        if (lengthUrl > 0) {
                                            characterAux = baseUrl.charAt(lengthUrl - 1);
                                            if (characterAux !== '/' && characterAux !== '\\') {
                                                baseUrl = baseUrl + "/";
                                            }
                                        }

                                        lengthUrl = this.customAddress.url.length;
                                        if (lengthUrl > 0) {
                                            characterAux = this.customAddress.url.charAt(0);
                                            if (characterAux == '/' || characterAux == '\\') {
                                                this.customAddress.url = this.customAddress.url.substr(1);
                                            }
                                        }

                                        templateUrl = baseUrl + this.customAddress.url;
                                        console.log("templateUrl: " + templateUrl);

                                        this.dialogParameters.controlId = groupId;
                                        _vc.dialogParameters = this.dialogParameters;
                                        _vc.customDialogParameters = this.customDialogParameters;

                                        createLazyLoadObject = function (script) {
                                            var files = [], i;
                                            for (i = 0; i < script.files.length; i = i + 1) {
                                                files.push(baseUrl + dsgnrUtils.minification.getCustomFilePath(script.files[i], useMinification));
                                            }
                                            return {
                                                name: script.module,
                                                files: files
                                            };
                                        };
                                        createAngularModule = function (name) {
                                            var module = angular.module(name, []);
                                            module.run(["$translatePartialLoader", "$translate",
                                                function ($translatePartialLoader, $translate) {
                                                    $translatePartialLoader.addPart(name);
                                                    $translate.refresh();
                                                }]);
                                        };

                                        if (angular.isArray(that.scripts)) {
                                            for (i = 0; i < that.scripts.length; i = i + 1) {
                                                createAngularModule(that.scripts[i].module);
                                                modules.push(createLazyLoadObject(that.scripts[i]));
                                            }
                                        } else {
                                            createAngularModule(that.scripts.module);
                                            modules.push(createLazyLoadObject(that.scripts));
                                        }

                                        if (angular.isDefined(groupStructure.view) && angular.isDefined(groupStructure.view.viewContainerId)) {
                                            _vc.removeChildVc(groupStructure.view.viewContainerId);
                                        }
                                        if (angular.isDefined(groupStructure.customView) && angular.isDefined(groupStructure.customView.id)) {
                                            _vc.removeChildVc(groupStructure.customView.id);
                                        }

                                        _vc.addChildVc(this.customAddress.id);
                                        groupStructure.customView = {
                                            id: this.customAddress.id,
                                            templateUrl: templateUrl,
                                            scripts: modules
                                        };

                                        groupStructure.view = {};
                                    } else {
                                        // En el caso de que no exista VC definida
                                        // el grupo elimina el html interno
                                        // Ver directiva designerFormLoad
                                        groupStructure.customView = {};
                                        groupStructure.view = {};

                                    }
                                } else {
                                    console.log("GroupId " + groupId + " doesn't support a custom page");
                                }
                            } else {
                                console.log("GroupId " + groupId + " doesn't exist");
                            }
                        },
                        /**
                         * M&eacute;todo que permite abrir ViewContainer como un
                         * Popover relacionado a un control
                         *
                         * @method openPopover
                         * @param {String} controlId Id del VisualAttribute en donde se
                         *            abrir&aacute; el Popover
                         * @example <span class="code"> var nav =
                         *          args.commons.api.navigation; nav.address = {
                         *          moduleId: 'MODULE_ID', subModuleId:
                         *          'SUB_MODULE_ID', taskId: 'TASK_ID', taskVersion:
                         *          'TASK_VERSION', viewContainerId:
                         *          'VIEW_CONTAINER_ID' };
                         *          nav.customDialogParameters = { param1:
                         *          "PARAM_VALUE1" }; nav.queryParameters = { mode:
                         *          args.commons.constants.mode.Insert };
                         *          nav.popoverProperties = { width: 300, height:
                         *          275, position: "right" };
                         *          nav.openPopover("VISUAL_ATTRIBUTE_ID"); </span>
                         */
                        openPopover: function (controlId) {
                            if (angular.isUndefined($designerPopover)) {
                                throw new Error('$designerPopover is not available.');
                            }

                            var that = this,
                                controllerUrl,
                                controllerName,
                                customJs,
                                popoverInstanceId = this.address.viewContainerId,
                                popoverInstance,
                                popoverScope = $rootScope.$new(),
                                popoverOptions,
                                element,
                                elementTagName,
                                urlLoad,
                                extensionForm,
                                extensionController,
                                templateUrl;

                            if (cobis.utils.isRunOnLiferay()) {
                                urlLoad = "/o/" + this.address.portletName + "/";
                                extensionForm = "_FORM.jsp";
                                extensionController = ".js";
                            } else {
                                urlLoad = "${contextPath}/cobis/web/views/";
                                extensionForm = "_FORM.html";
                                extensionController = dsgnrUtils.minification.getMinificationExt() + ".js";
                            }
                            templateUrl = urlLoad + this.address.moduleId + "/" + this.address.subModuleId + "/" +
                                this.address.taskId + "/" + this.address.taskVersion + "/" + this.address.viewContainerId;
                            customJs = templateUrl + "_CUSTOM.js";
                            controllerUrl = templateUrl + extensionController;
                            templateUrl = templateUrl + extensionForm;
                            controllerName = this.address.viewContainerId + "_CTRL";

                            if (angular.isDefined(this.queryParameters)) {
                                popoverScope.queryParameters = this.queryParameters;
                            }
                            _vc.addChildVc(this.address.viewContainerId);

                            this.dialogParameters.controlId = controlId;
                            _vc.dialogParameters = this.dialogParameters;
                            _vc.customDialogParameters = this.customDialogParameters;

                            popoverOptions = {
                                templateUrl: templateUrl,
                                controller: controllerName,
                                scope: popoverScope,
                                resolve: {
                                    dependencies: ["$q", "$rootScope", function ($q, $rootScope) {
                                        var deferred = $q.defer();
                                        window.$script(controllerUrl, function () {
                                            window.$script(customJs, function () {
                                                $rootScope.$apply(function () {
                                                    deferred.resolve();
                                                });
                                            });
                                        });
                                        return deferred.promise;
                                    }],

                                    specificTranslations: ["$translatePartialLoader", "$translate", "asyncLoader", function ($translatePartialLoader, $translate, asyncLoader) {

                                        if (cobis.utils.isRunOnLiferay()) {
                                            asyncLoader({
                                                moduleId: that.address.moduleId,
                                                contextPath: "assets-libs-" + that.address.moduleId + ".portlet"
                                            });
                                        } else {
                                            $translatePartialLoader.addPart(that.address.moduleId);
                                            if (angular.isDefined(that.scripts)) {
                                                if (angular.isArray(that.scripts) && that.scripts.length > 0) {
                                                    angular.forEach(that.scripts, function (script) {
                                                        $translatePartialLoader.addPart(script.module);
                                                    });
                                                } else {
                                                    if ($.trim(that.scripts.module).length > 0) {
                                                        $translatePartialLoader.addPart(that.scripts.module);
                                                    }
                                                }
                                            }
                                            return $translate.refresh();
                                        }
                                    }]
                                }
                            };

                            element = $("#" + controlId);
                            if (element.length > 0) {
                                elementTagName = element.prop("tagName");
                                if (elementTagName !== "A" && elementTagName !== 'BUTTON') {
                                    element = $("#" + controlId + "_DIV");
                                }

                                popoverOptions = angular.extend({}, popoverOptions, this.popoverProperties);
                                popoverInstance = $designerPopover.open(element, popoverOptions);
                                _vc.modalInstances[popoverInstanceId] = popoverInstance;

                                popoverInstance.result.then(function (result) {
                                        _vc.modalInstances[popoverInstanceId] = undefined;
                                        _vc.afterCloseModal(
                                            controlId,
                                            that.address.viewContainerId,
                                            result);
                                    },
                                    function () {
                                        _vc.modalInstances[popoverInstanceId] = undefined;
                                        console.log('Popover dismissed');
                                    })['finally']
                                (function () {
                                    // _vc.modalInstances[popoverInstanceId]
                                    // =
                                    // undefined;
                                });
                            } else {
                                throw new Error('Element "' + controlId + '" was not found.');
                            }
                        },
                        /**
                         * M&eacute;todo que permite abrir una pagina creada
                         * manualmente como un Popover
                         *
                         * @method openCustomPopover
                         * @param {String} controlId Id del VisualAttribute en donde se
                         *            abrir&aacute; el Popover
                         * @example <span class="code"> var nav =
                         *          args.commons.api.navigation; nav.customAddress = {
                         *          id: 'customHtml', url: '/custom/custom.html' };
                         *          nav.customDialogParameters = { param1:
                         *          "PARAM_VALUE1" }; nav.popoverProperties = {
                         *          width: 300, height: 275, position: "right" };
                         *          nav.openCustomPopover("VISUAL_ATTRIBUTE_ID");
                         *          </span>
                         */
                        openCustomPopover: function (controlId) {
                            if (angular.isUndefined($designerPopover)) {
                                throw new Error('$designerPopover is not available.');
                            }

                            var that = this,
                                popoverInstanceId = this.customAddress.id,
                                popoverInstance,
                                popoverScope = $rootScope.$new(),
                                popoverOptions,
                                element,
                                elementTagName,
                                templateUrl = "${contextPath}/cobis/web/views/" + this.customAddress.url,
                                controllerName = this.customAddress.controller,
                                useMinification = this.customAddress.useMinification;

                            if (angular.isDefined(this.queryParameters)) {
                                popoverScope.queryParameters = this.queryParameters;
                            }

                            _vc.addChildVc(this.customAddress.id);

                            this.dialogParameters.controlId = controlId;
                            _vc.dialogParameters = this.dialogParameters;
                            _vc.customDialogParameters = this.customDialogParameters;

                            popoverOptions = {
                                templateUrl: templateUrl,
                                controller: controllerName,
                                scope: popoverScope,
                                resolve: {
                                    dependencies: ["$q",
                                        function ($q) {
                                            var modules = [], i, createLazyLoadObject = function (script) {
                                                    var files = [], i;
                                                    for (i = 0; i < script.files.length; i = i + 1) {
                                                        files.push("${contextPath}/cobis/web/views/" + dsgnrUtils.minification.getCustomFilePath(script.files[i], useMinification));
                                                    }
                                                    return {
                                                        name: script.module,
                                                        files: files
                                                    };
                                                },
                                                createAngularModule = function (name) {
                                                    var module = angular.module(name, []);
                                                    module.run(["$translatePartialLoader", "$translate",
                                                        function ($translatePartialLoader, $translate) {
                                                            $translatePartialLoader.addPart(name);
                                                            $translate.refresh();
                                                        }]);
                                                };
                                            if (angular.isArray(that.scripts)) {
                                                for (i = 0; i < that.scripts.length; i = i + 1) {
                                                    createAngularModule(that.scripts[i].module);
                                                    modules.push(createLazyLoadObject(that.scripts[i]));
                                                }
                                            } else {
                                                createAngularModule(that.scripts.module);
                                                modules.push(createLazyLoadObject(that.scripts));
                                            }

                                            return $ocLazyLoad.load(modules);
                                        }]
                                }
                            };

                            element = $("#" + controlId);

                            if (element.length > 0) {

                                elementTagName = element.prop("tagName");
                                if (elementTagName !== "A" && elementTagName !== 'BUTTON') {
                                    element = $("#" + controlId + "_DIV");
                                }
                                popoverOptions = angular.extend({}, popoverOptions, this.popoverProperties);
                                popoverInstance = $designerPopover.open(element, popoverOptions);
                                popoverInstance.opened.then(function () {
                                    _vc.modalInstances[popoverInstanceId] = popoverInstance;
                                });
                                popoverInstance.result.then(function (result) {
                                    _vc.modalInstances[popoverInstanceId] = undefined;
                                    _vc.afterCloseModal(controlId, that.customAddress.id, result);
                                }, function () {
                                    _vc.modalInstances[popoverInstanceId] = undefined;
                                    console.log('Popover dismissed');
                                })['finally']
                                (function () {
                                    // _vc.modalInstances[popoverInstanceId]
                                    // =
                                    // undefined;
                                });

                            } else {
                                throw new Error('Element "' + controlId + '" was not found.');
                            }
                        },
                        /**
                         * M&eacute;todo que permite verificar si la ViewContainer
                         * actual es una ventana modal.
                         *
                         * @method isModal
                         * @for API
                         * @return {Boolean} estado True - ViewContainer actual es una ventana modal / False - ViewContainer actual no es una ventana modal
                         * @example <span class="code"> var nav =
                         *          args.commons.api.navigation; if (nav.isModal()) { }
                         *          </span>
                         */
                        isModal: function () {
                            return _vc.isModal();
                        },
                        /**
                         * M&eacute;todo que permite obtener los parametros enviados
                         * por el ViewContainer padre
                         *
                         * @method getCustomDialogParameters
                         * @example <span class="code"> var nav =
                         *          args.commons.api.navigation, params; params =
                         *          nav.getCustomDialogParameters(); </span>
                         */
                        getCustomDialogParameters: function () {
                            if (angular.isDefined(_vc.parentVc)) {
                                return _vc.parentVc.customDialogParameters;
                            } else {
                                return _vc.customDialogParameters;
                            }
                        },
                        /**
                         * M&eacute;todo que permite definir la respuesta que será
                         * enviada al ViewContainer padre
                         *
                         * @method setCustomDialogResponse
                         * @example <span class="code"> var nav =
                         *          args.commons.api.navigation;
                         *          nav.setCustomDialogResponse({response1:
                         *          "RESPONSE_VALUE1"}); </span>
                         */
                        setCustomDialogResponse: function (response) {
                            if (angular.isDefined(_vc.parentVc) && angular.isDefined(response)) {
                                _vc.parentVc.customDialogResponse = response;
                            }
                        },
                        /**
                         * M&eacute;todo que permite cerrar una ventana modal
                         *
                         * @method closeModal
                         * @param response
                         *            objeto de respuesta que ser&aacute; retornado
                         *            al ViewContainer padre.
                         * @example <span class="code"> var nav =
                         *          args.commons.api.navigation;
                         *          nav.closeModal({response1: "RESPONSE_VALUE1"});
                         *          </span>
                         */
                        closeModal: function (response) {
                            if (angular.isDefined(_vc.parentVc) && angular.isDefined(response)) {
                                _vc.parentVc.customDialogResponse = response;
                                _vc.closeModal(response);
                            }
                        },
                        dispatched: false
                    };

                    var _ext = {
                        http: $http,
                        resource: $resource,
                        timeout: $timeout,
                        q: $q
                    };

                    var _fileUpload = function (visualAttributeId, eventArgs, flgClose, that, event, argsGridRowCommand,execServer) {
                        var _visualAttributeId = visualAttributeId, _maxSizeInMB = _vc.uploaders[_visualAttributeId].maxSizeInMB,
                            _confirmUpload = _vc.uploaders[_visualAttributeId].confirmUpload,
                            _relativePath = _vc.uploaders[_visualAttributeId].relativePath,
                            _visualAttributeModel = _vc.uploaders[_visualAttributeId].visualAttributeModel,
                            _gridFieldName = _vc.uploaders[_visualAttributeId].gridFieldName,
                            _queryViewId = _vc.uploaders[_visualAttributeId].queryViewId, _fileUploaderSelector = '#',
                            _defaultFileUploadServiceUrl = '${contextPath}/cobis/web/cobis-designer-engine-web/actions/fileupload?',
                            _scope = null, _setParameters, _validateFile, _setIconSuccess, _onSelect, _setModel, _onUpload, _onSuccess, _removeFile, result;

                        if (_gridFieldName) {
                            _fileUploaderSelector += _visualAttributeId + '_gridUploader';
                        } else {
                            _fileUploaderSelector += 'fileUploader';
                        }
                        angular.element(_fileUploaderSelector).attr('visualAttributeId', _visualAttributeId);

                        _setParameters = function (maxSizeInMB, confirmUpload, relativePath) {
                            _maxSizeInMB = maxSizeInMB;
                            _confirmUpload = confirmUpload;
                            _relativePath = relativePath;
                            angular.element(_fileUploaderSelector).data("kendoUpload").options.async.saveUrl = _defaultFileUploadServiceUrl
                                + "maxFileSize"
                                + _maxSizeInMB
                                + "&relativePath="
                                + _relativePath;
                        };
                        _validateFile = function (e, file, scope) {
                            if ((_maxSizeInMB) && (file.size > (_maxSizeInMB * 1024000))) {
                                console.log('Error en archivo ' + file.name + ', supera el tamano maximo permitido.');
                                cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFUP_00045');
                                _setParameters(10, false, null);
                                e.preventDefault();
                                scope.$apply();
                            }
                        };
                        _setIconSuccess = function (scope) {
                            if (_gridFieldName) {
                                vc.viewState[_queryViewId].column[_gridFieldName].disabledUpload = true;
                                $rootScope.$apply();
                            } else {
                                scope.vc.viewState[_visualAttributeId].disableUpload = true;
                                scope.$apply();
                            }
                        };
                        _onSuccess = function (e) {
                            var scope;
                            if (execServer) {
                                if (event === 'executeCommand') {
                                    scope = e.sender.$angular_scope;
                                    scope.vc.executeEvent(event, visualAttributeId, scope.vc.model, eventArgs, flgClose, that);
                                } else {
                                    scope = angular.element("#" + visualAttributeId).scope();
                                    scope.vc.executeEventInGrid(event, visualAttributeId, scope.vc.model, eventArgs, argsGridRowCommand, scope.vc);
                                }
                            }
                        };
                        _onSelect = function (e) {
                            var scope = e.sender.$angular_scope;
                            $.map(e.files, function (file) {
                                if (_confirmUpload === true) {
                                    var confirmMsg = $filter('translate')('DSGNR.SYS_DSGNR_MSGCONFUP_00046');
                                    if (confirm(confirmMsg + ' ' + file.name + "'?") == true) {
                                        _validateFile(e, file, scope);
                                    } else {
                                        console.warn('Cancelado por el usuario');
                                        e.preventDefault();
                                    }
                                }
                            });
                        };
                        _setModel = function (scope, fileName) {
                            if (_gridFieldName) {
                                _visualAttributeModel.set(_gridFieldName, fileName);
                            } else {
                                var getter = $parse(_visualAttributeModel), setter = getter.assign;
                                setter(scope, fileName);
                                _scope = scope;
                            }
                        };
                        _onUpload = function (e, gridRowModel) {
                            var fileName = e.files[0].name;
                            if (gridRowModel) {
                                _visualAttributeModel = gridRowModel;
                            }
                            var scope = e.sender.$angular_scope;
                            if (e.XMLHttpRequest.upload && e.XMLHttpRequest.upload && keepAliveUtils) {
								var processId = new Date().getTime();
								keepAliveUtils.keepAliveController.start(processId);
								e.XMLHttpRequest.addEventListener('loadend', function(){
									keepAliveUtils.keepAliveController.stop(processId)
								});
                            }
                            e.XMLHttpRequest
                                .addEventListener(
                                    'readystatechange',
                                    function (e) {
                                        var uploadResponse = e.target, uploadMessage;
                                        if (uploadResponse.readyState === 4) {
                                            if (uploadResponse.status === 200) {
                                                uploadMessage = JSON.parse(uploadResponse.response);
                                                angular.element('#' + _visualAttributeId).val(fileName);
                                                _setModel(scope, fileName);
                                                if (uploadMessage.status && uploadMessage.status === 'OK') {
                                                    _setIconSuccess(scope);
                                                    _setParameters(10, false, null);
                                                } else {
                                                    cobisMessage.showTranslateMessagesError(uploadMessage.errorId);
                                                    scope.$apply();
                                                }
                                            } else {
                                                cobisMessage.showTranslateMessagesError('DSGNR.SYS_DSGNR_MSGERRFUP_00047');
                                                scope.$apply();
                                            }
                                        }
                                    });
                        };
                        _removeFile = function () {
                            if (_gridFieldName) {
                                _visualAttributeModel.set(
                                    _gridFieldName, '');
                                vc.viewState[_queryViewId].column[_gridFieldName].disabledUpload = false;
                            } else {
                                _vc.viewState[_visualAttributeId].disableUpload = false;
                                var getter = $parse(_visualAttributeModel), setter = getter.assign;
                                setter(_scope, '');
                                _scope = null;
                            }
                            angular.element('#' + _visualAttributeId).val('');
                            console.log("File deleted");
                        };
                        result = {
                            setParameters: _setParameters,
                            onUpload: _onUpload,
                            onSelect: _onSelect,
                            removeFile: _removeFile,
                            onSuccess: _onSuccess
                        };
                        _vc.uploaders[_visualAttributeId].fileUploadAPI = result;
                        return result;
                    };

                    return {
                        parentApi: _parentApi,
                        viewState: _viewState,
                        grid: _grid,
                        navigation: _navigation,
                        vc: _vc,
                        parentVc: _vc.parentVc,
                        nextSeq: _nextSeq,
                        errors: _errors,
                        ext: _ext,
                        fileUpload: _fileUpload
                    };
                }

                return API;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class eventArgs
             */
            var _eventArgs = {};
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class CommonArgs
             */
            _eventArgs.CommonArgs = (function () {
                function CommonArgs() {
                    /**
                     * @attribute {Object} messageHandler
                     *
                     */
                    this.messageHandler = null;
                    /**
                     * @attribute {String} controlId
                     *
                     */
                    this.controlId = null;
                    /**
                     * @attribute {API} api
                     *
                     */
                    this.api = null;
                    /**
                     * Variable para indicar si debe o no ejecutar la
                     * personalización a nivel de Servidor
                     *
                     * @attribute {boolean} execServer
                     *
                     */
                    this.execServer = true;
                    /**
                     *
                     * @attribute {Object} args
                     *
                     */
                    this.args = null;
                    /**
                     *
                     * @attribute {boolean} constants
                     *
                     */
                    this.constants = _constants;
                    /**
                     *
                     * @attribute {Object} serverParameters
                     *
                     */
                    this.serverParameters = {};
                }

                return CommonArgs;
            }());

            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ChangedGroupEventArgs
             */
            _eventArgs.ChangedGroupEventArgs = (function () {
                function ChangedGroupEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.commons.item = {
                        id: null,
                        isOpen: true
                    };
                }

                return ChangedGroupEventArgs;
            }());

            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ExecuteCommandEventArgs
             */
            _eventArgs.ExecuteCommandEventArgs = (function () {
                function ExecuteCommandEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    /**
                     * Nombre del Comando a Ejecutar
                     *
                     * @attribute {String} commandName
                     *
                     */
                    this.commandName = "";
                    /**
                     * Nombre del Evento a Ejecutar
                     *
                     * @attribute {String} eventName
                     *
                     */
                    this.eventName = "";
                }

                return ExecuteCommandEventArgs;
            }());

            _eventArgs.onTabClosingEventArgs = function () {
                this.commons = new _eventArgs.CommonArgs();
                /**
                 *
                 * @attribute {object} ViewContainer
                 *
                 */
                this.viewContainerId = null;
                /**
                 *
                 * @attribute {object} deferred
                 *
                 */
                this.deferred = null;
                /**
                 *
                 * @attribute {object} closingReason
                 *
                 */
                this.closingReason = "None";
            };
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class CallTransactionEventArgs
             */
            _eventArgs.CallTransactionEventArgs = (function () {
                function CallTransactionEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                }

                return CallTransactionEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ExecuteQueryEventArgs
             */
            _eventArgs.ExecuteQueryEventArgs = (function () {
                function ExecuteQueryEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.parameters = null;
                    this.model = null;
                    this.config = null;
                }

                return ExecuteQueryEventArgs;
            }());

            /**
             * Argumentos base para los eventos de inicializacion de detalles de
             * grid
             *
             * @class GridInitDetailTemplateArgs
             */
            _eventArgs.GridInitDetailTemplateArgs = (function () {
                function GridInitDetailTemplateArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.modelRow = null;
                }

                return GridInitDetailTemplateArgs;
            }());

            /**
             * Argumentos base para los eventos de inicializacion de template de columns de
             * grid
             *
             * @class GridInitColumnTemplateArgs
             */
            _eventArgs.GridInitColumnTemplateArgs = (function () {
                function GridInitColumnTemplateArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                }

                return GridInitColumnTemplateArgs;
            }());

            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class GridRowCommandEventArgs
             */
            _eventArgs.GridRowCommandEventArgs = (function () {
                function GridRowCommandEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.rowData = null;
                    this.rowIndex = null;
                    this.keys = null;
                    this.nameEntityGrid = null;
                    this.refresData = false;
                }

                return GridRowCommandEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class GridRowSelectingEventArgs
             */
            _eventArgs.GridRowSelectingEventArgs = (function () {
                function GridRowSelectingEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.rowData = null;
                    this.rowIndex = null;
                    this.nameEntityGrid = null;
                }

                return GridRowSelectingEventArgs;
            }());

            /**
             * Argumentos base para evento de personalización RenderGridRowEventArgs
             *
             * @class RenderGridRowEventArgs
             */
            _eventArgs.RenderGridRowEventArgs = (function () {
                function RenderGridRowEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.rowData = null;
                    this.rowIndex = null;
                    this.nameEntityGrid = null;
                }

                return RenderGridRowEventArgs;
            })();

            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class GridExecuteCommandEventArgs
             */
            _eventArgs.GridExecuteCommandEventArgs = (function () {
                function GridExecuteCommandEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.nameEntityGrid = null;

                }

                return GridExecuteCommandEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class GridRowActionEventArgs
             */
            _eventArgs.GridRowActionEventArgs = (function () {
                function GridRowActionEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.rowData = null;
                    this.cancel = false;
                }

                return GridRowActionEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class GridBeforeEnterInLineRowEventArgs
             */
            _eventArgs.GridBeforeEnterInLineRowEventArgs = (function () {
                function GridBeforeEnterInLineRowEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.cancel = false;
                    this.inlineWorkMode = null;
                    this.rowData = null;
                }

                return GridBeforeEnterInLineRowEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class GridAfterLeaveInLineRowEventArgs
             */
            _eventArgs.GridAfterLeaveInLineRowEventArgs = (function () {
                function GridAfterLeaveInLineRowEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.inlineWorkMode = null;
                }

                return GridAfterLeaveInLineRowEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ChangedEventArgs
             */
            _eventArgs.ChangedEventArgs = (function () {
                function ChangedEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.oldValue = null;
                    this.newValue = null;
                    this.focus = false;
                }

                return ChangedEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class TextInputButtonEventArgs
             */
            _eventArgs.TextInputButtonEventArgs = (function () {
                function TextInputButtonEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.model = null;
                    this.url = null;
                    this.cancel = false;
                }

                return TextInputButtonEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class TextInputButtonGridEventArgs
             */
            _eventArgs.TextInputButtonGridEventArgs = (function () {
                function TextInputButtonGridEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.modelRow = null;
                    this.url = null;
                    this.cancel = false;
                }

                return TextInputButtonGridEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class TextInputButtonCloseModalEventArgs
             */
            _eventArgs.TextInputButtonCloseModalEventArgs = (function () {
                function TextInputButtonCloseModalEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.modalResult = null;
                    this.vcId = null;
                    this.model = null;
                    this.visualAttributeIdIniCall = null;
                }

                return TextInputButtonCloseModalEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class TextInputButtonCloseModalGridEventArgs
             */
            _eventArgs.TextInputButtonCloseModalGridEventArgs = (function () {
                function TextInputButtonCloseModalGridEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.modalResult = null;
                    this.vcId = null;
                    this.modelRow = null;
                }

                return TextInputButtonCloseModalGridEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class CloseModalEventArgs
             */
            _eventArgs.CloseModalEventArgs = (function () {
                function CloseModalEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.model = null;
                    this.parentModel = null;
                    this.vcId = null;
                    this.result = null;
                    this.closedViewContainerId = null;
                    this.dialogCloseResult = null;
                    this.dialogCloseType = null;
                }

                return CloseModalEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class LoadCatalogEventArgs
             */
            _eventArgs.LoadCatalogEventArgs = (function () {
                function LoadCatalogEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.filters = null;
                    this.config = null;
                }

                return LoadCatalogEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ValidateTransactionEventArgs
             */
            _eventArgs.ValidateTransactionEventArgs = (function () {
                function ValidateTransactionEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                }

                return ValidateTransactionEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ShowResultEventArgs
             */
            _eventArgs.ShowResultEventArgs = (function () {
                function ShowResultEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.messages = {};
                    this.success = false;
                }

                return ShowResultEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class BeforeOpenGridDialogEventArgs
             */
            _eventArgs.BeforeOpenGridDialogEventArgs = (function () {
                function BeforeOpenGridDialogEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.dialogParameters = undefined;
                    this.cancel = false;
                }

                return BeforeOpenGridDialogEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class AfterCloseGridDialogEventArgs
             */
            _eventArgs.AfterCloseGridDialogEventArgs = (function () {
                function AfterCloseGridDialogEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.dialogParameters = undefined;
                    this.dialogResponse = undefined;
                    this.customDialogResponse = undefined;
                }

                return AfterCloseGridDialogEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class InitDataEventArgs
             */
            _eventArgs.InitDataEventArgs = (function () {
                function InitDataEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.hasData = false;
                }

                return InitDataEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class ChangeInitDataEventArgs
             */
            _eventArgs.ChangeInitDataEventArgs = (function () {
                function ChangeInitDataEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.hasData = false;
                }

                return ChangeInitDataEventArgs;
            }());
            /**
             * Argumentos base para los eventos de personalización JavaScript
             *
             * @class RenderEventArgs
             */
            _eventArgs.RenderEventArgs = (function () {
                function RenderEventArgs() {
                    /**
                     * @attribute {CommonArgs} commons
                     *
                     */
                    this.commons = new _eventArgs.CommonArgs();
                }

                return RenderEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "executeCrudCallback"
             *
             * @class ExecuteCrudCallbackEventArgs
             */
            _eventArgs.ExecuteCrudCallbackEventArgs = (function () {
                function ExecuteCrudCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return ExecuteCrudCallbackEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "executeCommandCallback"
             *
             * @class ExecuteCommandCallbackEventArgs
             */
            _eventArgs.ExecuteCommandCallbackEventArgs = (function () {
                function ExecuteCommandCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return ExecuteCommandCallbackEventArgs;
            }());
            /**
             * Argumentos que recibe el evento "gridRowActionCallback"
             *
             * @class GridRowActionCallbackEventArgs
             */
            _eventArgs.GridRowActionCallbackEventArgs = (function () {
                function GridRowActionCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return GridRowActionCallbackEventArgs;
            }());
            /**
             * Argumentos que recibe el evento "gridRowCommandCallback"
             *
             * @class GridRowCommandCallbackEventArgs
             */
            _eventArgs.GridRowCommandCallbackEventArgs = (function () {
                function GridRowCommandCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return GridRowCommandCallbackEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "gridCommandCallback"
             *
             * @class GridRowCommandCallbackEventArgs
             */
            _eventArgs.GridCommandCallbackEventArgs = (function () {
                function GridCommandCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return GridCommandCallbackEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "GridRowSelectingCallback"
             *
             * @class GridRowSelectingCallbackEventArgs
             */
            _eventArgs.GridRowSelectingCallbackEventArgs = (function () {
                function GridRowSelectingCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return GridRowSelectingCallbackEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "initDataCallback"
             *
             * @class InitDataCallbackEventArgs
             */
            _eventArgs.InitDataCallbackEventArgs = (function () {
                function InitDataCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                }

                return InitDataCallbackEventArgs;
            }());
            /**
             * Argumentos que recibe el evento "changeCallback"
             *
             * @class ChangeCallbackEventArgs
             */
            _eventArgs.ChangeCallbackEventArgs = (function () {
                function ChangeCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                    this.oldValue = undefined;
                    this.newValue = undefined;
                    this.rowData = undefined;
                }

                return ChangeCallbackEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "onCloseModalCallback"
             *
             * @class CloseModalCallBackEventArgs
             */
            _eventArgs.CloseModalCallbackEventArgs = (function () {
                function CloseModalCallbackEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.success = true;
                    this.vcId = null;
                    this.result = null;
                    this.closedViewContainerId = null;
                    this.dialogCloseResult = null;
                    this.dialogCloseType = null;
                }

                return CloseModalCallbackEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "customValidate"
             *
             * @class CustomValidateEventArgs
             */
            _eventArgs.CustomValidateEventArgs = (function () {
                function CustomValidateEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.errorMessage = null;
                    this.isValid = true;
                    this.currentValue = null;
                }

                return CustomValidateEventArgs;
            }());

            /**
             * Argumentos que recibe el evento "ExportColumnsEventArgs"
             *
             * @class ExportColumnsEventArgs
             */

            _eventArgs.ExportColumnsEventArgs =(function(){
                function ExportColumnsEventArgs() {
                    this.commons = new _eventArgs.CommonArgs();
                    this.exportColumnsToExcel = null;
                }

                return ExportColumnsEventArgs;

            }());

            // ******************** Metadata utils
            // ***************************

            var _metadata = {

                findEntityById: function (metadata, entityId) {
                    var entityName, entity;
                    for (entityName in metadata.entities) {
                        entity = metadata.entities[entityName];
                        if (entity._entityId == entityId) {
                            entity._entityName = entityName;
                            return entity;
                        }
                    }
                    return null;
                },

                findEntityNameById: function (metadata, entityId) {
                    var entityName, entity;
                    for (entityName in metadata.entities) {
                        entity = metadata.entities[entityName];
                        if (entity._entityId == entityId) {
                            return entityName;
                        }
                    }
                    return null;
                },

                findEntityNameByAttId: function (metadata, attId) {
                    var keyMetadata, attName;
                    for (keyMetadata in metadata.entities) {
                        for (attName in metadata.entities[keyMetadata]) {
                            if (metadata.entities[keyMetadata][attName] == attId) {
                                return keyMetadata;
                            }
                        }
                    }
                    return null;
                },

                findAttNameByAttId: function (entityMetadata, attId) {
                    var attName;
                    for (attName in entityMetadata) {
                        if (entityMetadata.hasOwnProperty(attName) && entityMetadata[attName] === attId) {
                            return attName;
                        }
                    }
                    return null;
                },

                findAPkIdByFkId: function (metadata, fkId) {
                    var m, n;
                    for (m = 0; m < metadata.relations.length; m = m + 1) {
                        for (n = 0; n < metadata.relations[m].relationAttributes.length; n = n + 1) {
                            if (metadata.relations[m].relationAttributes[n].attributeIdFk) {
                                return metadata.relations[m].relationAttributes[n].attributeIdPk;
                            }
                        }
                    }
                    return null;
                }
            };

            return {
                constants: _constants,
                enums: {
                    hasFlag: function (modes) {
                        var i;
                        for (i = 1; i < arguments.length; i = i + 1) {
                            if ((parseInt(modes, 10) & parseInt(
                                    arguments[i], 10)) !== 0) {
                                return true;
                            }
                        }
                        return false;
                    }
                },
                utils: {
                    createResource: _createResource,
                    focusError: dsgnrUtils.component.focusError,
                    uuid: _uuid,
                    errorCallback: _errorCallback,
                    http: {
                        generatePrimaryKeyMap: _generatePrimaryKeyMap,
                        generatePrimaryKeyString: _generatePrimaryKeyString
                    },
                    metadata: _metadata,
                    focusControl: dsgnrUtils.component.focusControl
                },
                eventArgs: _eventArgs,
                API: _API
            };
        }]);
    app.factory('dsgnrConfigPage', ['$http', '$q',
        function dsgnrConfigPage($http, $q) {
            var service = {
                width: "",
                getWidth: getWidth
            };
            return service;
            function getWidth() {
                var def = $q.defer(),
                    styleSheets = document.styleSheets,
                    nameJson = null,
                    stringHref,
                    lengthString, i;

                for (i = 0; i < styleSheets.length; i = i + 1) {
                    stringHref = styleSheets[i].cssRules[0].href;
                    if (angular.isDefined(stringHref) && stringHref !== null) {
                        lengthString = stringHref.length - 3;
                        nameJson = "${contextPath}/cobis/web/styles/" + stringHref.slice(0, lengthString) + 'json';
                        break;
                    }
                }
                if (nameJson !== null) {
                    $http.get(nameJson)
                        .success(function (data) {
                            service.width = data;
                            def.resolve(data);
                        })
                        .error(function () {
                            def.reject("Failed to get width");
                            cobis.logging.getLoggerManager().warn('No se pudo obtener la configuración Json');
                        });
                } else {
                    cobis.logging.getLoggerManager().warn('No se pudo obtener el archivo JSON para configuracion');
                }
                return def.promise;
            }
        }]);
    app.factory('myHttpInterceptor', ["$q", "$window", "$rootScope",
        function ($q, $window, $rootScope) {
            return {
                response: function (response) {
                        if ($rootScope.count && $rootScope.count > 0) {
                            $rootScope.count = $rootScope.count - 1;
                            if ($rootScope.count == 0) {
                                cobis.showMessageWindow.loading(false);
                            }
                        }
                    return response;
                },
                responseError: function (response) {
                    var workTab, arrayTabs, lengthArrTabs, hideLoader = function () {
                        if ($rootScope.count && $rootScope.count > 0) {
                            $rootScope.count = $rootScope.count - 1;
                            if ($rootScope.count == 0) {
                                cobis.showMessageWindow.loading(false);
                            }
                        }
                    };
                    hideLoader();
                    if (response.status === 500) { // error de servidor
                        if (cobis.containerScope) {
                            cobis.container.tabs.changeCurrentTab("TLSRVERROR", "${contextPath}/cobis/web/views/commons/Error500.html", "MNU_INTSERROR", false);
                        } else if ($rootScope.flagFromCENToDesigner) {
                            window.location = "${contextPath}/cobis/web/views/commons/Error500.html";
                        } else {
                            cobis.showMessageWindow.alertError(response.statusText);
                            $('[id^=messages-alert-close-]').remove();
                        }
                    } else if (response.status === 401) { // Expiró la sesión
                        if (cobis.containerScope) {
                            if (cobis.containerScope.shellTabs !== undefined && cobis.containerScope.shellTabs !== null) {
                                workTab = null;
                                arrayTabs = [];
                                cobis.containerScope.shellTabs.forEach(function (workTab) {
                                    arrayTabs.push(workTab);
                                });
                                lengthArrTabs = arrayTabs.length;
                                arrayTabs.forEach(function (workTab, index) {
                                    if (workTab.option !== undefined && workTab.option === 1) {
                                        if (lengthArrTabs === index + 1) {
                                            workTab.isFromDesigner = true;
                                        }
                                        cobis.container.tabs.removeTabObject(workTab);
                                    }
                                });
                            }
                            cobis.containerScope.lockScreen.setVisible();
                        } else {
                            cobis.showMessageWindow.alertError(response.statusText);
                        }
                    }
                    return $q.reject(response);
                }
            };
        }]);
    app.config(["$httpProvider",
        function ($httpProvider) {
            if (angular.isDefined($httpProvider.interceptors)) {
                $httpProvider.interceptors.push('myHttpInterceptor');
            }
        }]);
    })

);
