task.gridInitColumnTemplate.QV_7316_82692 = function (idColumn) {
    		    	if(idColumn === 'answer'){
		return  "<div class='cb-indicator cb-flex cb-column'>"+
                        "<div ng-show='{{dataItem.typeAnswer == \"F\"}}'>"+"<input name='answer#: idQuestion #' placeholder=\"dd/mm/aaaa\" kendo-ext-date-picker=\"\" ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\">"+"</div>"+  						
                        "<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"S\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" class=\"k-textbox text-uppercase\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"N\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" class=\"k-textbox text-uppercase\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"N\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" designer-restrict-input=\"numbers\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"S\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" designer-restrict-input=\"numbers\"></div>"+
						"</div>";
				}

    };