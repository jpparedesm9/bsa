var LATFO = {
	
	COMMONS :{
		getCapitalizeCase : function (string){
			return string.replace(/\w\S*/g, function(tStr){
				return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
			});
		},
        getPercentage : function (amounts, porcent){
          var sum = 0;
          amounts.forEach(function(amount){
                    sum += amount;
          });   
          return (sum * porcent) / 100;         
        }
	},

	INBOX :{
	
		addTaskHeader : function(taskHeader, title, value, rowNumber) {
			
			rowNumber = rowNumber === undefined ? 0 : rowNumber;
		
			if (title != null && value != null) {
			
				if (title == "title") {
					taskHeader.title = LATFO.COMMONS.getCapitalizeCase(value);
				} else {

					var update = false;
					taskHeader.subtitle = taskHeader.subtitle == null ? [] : taskHeader.subtitle;
					taskHeader.subtitle[rowNumber] = taskHeader.subtitle[rowNumber] == null ? [] : taskHeader.subtitle[rowNumber];
					
					for (var i = 0; i < taskHeader.subtitle.length; i++) {
						if(i == rowNumber) {
							for (var j = 0; j < taskHeader.subtitle[i].length; j++) {
								if(taskHeader.subtitle[i][j].title == title){
								   taskHeader.subtitle[i][j].value = value;
								   update = true;
								   break;
								}
							}
							if(!update){
								taskHeader.subtitle[i].push({title: title, value : value });
							}
							break;
						}
					}				

				}
			}
		},
		
		updateTaskHeader : function(taskHeader, eventArgs, groupViewHeader) {
			eventArgs.commons.api.vc.removeChildVc('taskHeader');
			
			var nav = eventArgs.commons.api.navigation;
				
			nav.customAddress = {
				id : 'taskHeader',
				url : 'inbox/templates/header-task.html',
				useMinification: false
			};

			nav.scripts = [ {
				module : cobis.modules.INBOX,
				files : [ '/inbox/controllers/header-task-ctrl.js']
			} ];

			nav.customDialogParameters = {
				taskHeader : taskHeader
			};
				
			nav.registerCustomView(groupViewHeader);
		}
	},
	UTILS:{
		IsNull: function (parValue) {
            return (parValue === null || parValue === undefined);
        },
        IsNullOrEmpty: function (parValue) {
            return (LATFO.UTILS.IsNull(parValue) || parValue === '');
        },
        Char_convert: function (original) {
            var chars = ["\u00e1", "\u00e0", "\u00e9", "\u00e8", "\u00ed", "\u00ec", "\u00f3", "\u00f2", "\u00fa", "\u00f9", "\u00c1", "\u00c0", "\u00c9", "\u00c8", "\u00cd", "\u00cc", "\u00d3", "\u00d2", "\u00da", "\u00d9", "\u00f1", "\u00d1"];
            var codes = ["%e1", "%e1", "%e9", "%e9", "%ed", "%ed", "%f3", "%f3", "%fa", "%fa", "%c1", "%c1", "%c9", "%c9", "%cd", "%cd", "%d3", "%d3", "%da", "%da", "%f1", "%d1"];
            if (original !== null && original !== undefined && original.constructor === String) {
                for (var i = 0; i < chars.length; i++) {
                    original = original.replace(chars[i], codes[i]);
                }
            }
            return original;
        },
		generarReporte: function (reporte, argumentos, title) {
            var Crue = '?myValue=' + Math.random() + '&';
            var formaMapeo = document.createElement("form");
            formaMapeo.target = 'popup_window_' + reporte;
            formaMapeo.method = "POST"; // or "post" if appropriate

            if (LATFO.UTILS.IsNullOrEmpty(reporte))
                formaMapeo.action = "${contextPath}/cobis/web/reporting/actions/reportingService" + Crue;
            else
                formaMapeo.action = "${contextPath}/cobis/web/reports/" + reporte + "?";

            var param = "";
            for (var i = 0; i < argumentos.length; i++) {
                param = param + argumentos[i][0] + '=' + LATFO.UTILS.Char_convert(argumentos[i][1]) + '&'
            }
            param = param.substr(0, param.length - 1);
            var url = formaMapeo.action + param
            if (LATFO.UTILS.IsNullOrEmpty(title)) { title = 'Reporte'; }
            cobis.container.tabs.openNewTab('ctsConsole', url, title, true);
        }
	}
};

var LOANS = {
    CONSTANTS: {
        Stage : {INGRESO :'INGRESO', ELIMINAR : 'ELIMINAR', APROBAR : 'APROBAR'},
		TypeOrigin  : {FLUJO : 'FLUJO', INGRESO : 'INGRESO', CONSULTA : 'CONSULTA'}
    },
    CONVERT: {
		DATE : {
			FromStringMDY : function (strignValue) {
				return new Date(strignValue.substring(6,10),strignValue.substring(0,2)-1,strignValue.substring(3,5));
			}			
		},
		NUMBER:{
			Format:function (stringValue,stringAdd,finalLength){			
				for(i=stringValue.toString().length;i<parseInt(finalLength);i++){
					stringValue=stringAdd+stringValue;
				}
				return stringValue;
			}
		},
		CURRENCY:{
			Format:function(stringValue,intPrecision){
				return stringValue.toFixed(parseInt(intPrecision)).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
			}
		},
		getCapitalizeCase : function (string){
			return string.replace(/\w\S*/g, function(tStr){
				return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
			});
		}
	}
};
document.write('<script src="/CTSProxy/services/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');