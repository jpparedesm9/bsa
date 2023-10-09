task.gridInitColumnTemplate.QV_7463_28553 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'uploaded'){
            var template = "<span";
            template +=  "#if(uploaded == 'N'){# class=\"fa fa-times\" #}#"
			template +=  "#if(uploaded == 'S'){# class=\"fa fa-check\" #}#"
			template +=  "#if(uploaded == null){# class=\"fa fa-times\" #}#"
			template +=  "></span>"
         return template;
        }
    
};