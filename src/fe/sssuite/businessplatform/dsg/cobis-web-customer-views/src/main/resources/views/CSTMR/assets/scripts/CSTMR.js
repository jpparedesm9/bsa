/*global designerEvents, console */
/*Se comenta por el momento porque da error al abrir la pantallas de direcciones y de mantenimiento de personas*/
/*(function () {
    "use strict";
    //se invoca este evento luego que se cierra el Modal que se abrió desde un botón de esta página
    task.closeModalEvent.MapView = function (args) {
        //recupera la longitud y latitud que se pasan al cerrar el modal del mapa
        var result = args.result;
        if (angular.isObject(result)) {
            args.model.PhysicalAddress.latitude=result.latitude;
            args.model.PhysicalAddress.longitude=result.longitude;
		}
    };
}());
*/
var LATFO = {
	
	COMMONS :{
		getCapitalizeCase : function (string){
			return string.replace(/[\w\u00D1\u00F1]+\S*/g, function(tStr){
				return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
			});
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
    CONVERT: {
		CURRENCY:{
			Format:function(stringValue,intPrecision){
				return stringValue.toFixed(parseInt(intPrecision)).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
			}
		}
    },
    UTILS: {
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
        },
        cuantasVecesAparece: function (cadena, caracter){
          var indices = [];
          for(var i = 0; i < cadena.length; i++) {
            if (cadena[i].toLowerCase() === caracter) indices.push(i);
          }
            return indices.length;
        },
        validarEmail: function (email) {
            var regex = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if(regex.test(email)){
                var inicio = email.indexOf('@');
                var newEmail = email.substring(inicio,email.length);
                var puntos = newEmail.split(".").length-1;
                var ext = null;
                var ext1 = null;
                var ext2 = null;
                if(puntos == 1){
                    ext = newEmail.substring(newEmail.indexOf('.') + 1, newEmail.length);
                    if((ext.length >= 2) && (ext.length <= 3)){
                        return true;
                    } else {
                        return false;
                    }
                } else if (puntos == 2){
                    ext = newEmail.substring(newEmail.indexOf('.') + 1, newEmail.length);
                    ext1 = ext.substring(0, ext.indexOf('.'));
                    ext2 = ext.substring(ext.indexOf('.') + 1, ext.length);
                    if((ext1.length >= 2) && (ext1.length <= 3) && (ext2.length >= 2) && (ext2.length <= 3)){
                        if(ext1 != ext2){
                            return true;
                        } else {
                            return false;
                        }
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        },
        validarTelefono: function (args) {
            var number = args.currentValue;
            if(number.length === 10){
                var part1 = number.substring(1,number.length);
                if(LATFO.UTILS.cuantasVecesAparece(part1, part1.substring(0,1)) === part1.length ){
                    args.isValid = false;
                    args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                    return;
                }
                var part2 = number.substring(0,number.length - 1);
                if(LATFO.UTILS.cuantasVecesAparece(part2, part2.substring(0,1)) === part2.length ){
                    args.isValid = false;
                    args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                    return;
                }
            } else {
                args.isValid = false;
                args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                return;
            }
            if((parseInt(number.substring(0,1)) == 1) && (parseInt(number.substring(1,2)) == 2)){
                for(var i = 0; i <= number.length -1; i++){
                    if(parseInt(number.substring(i,i +1)) == (parseInt(number.substring(i +1, i +2)) -1)){
                        if(i == 7){
                            args.isValid = false;
                            args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                        }
                    } else{
                        break;
                    }
                }
            } else if((parseInt(number.substring(0,1)) == 9) && (parseInt(number.substring(1,2)) == 8)){
                for(var i = 0; i <= number.length -1; i++){
                    if(parseInt(number.substring(i,i +1)) == (parseInt(number.substring(i +1, i +2)) +1)){
                        if(i == 7){
                            args.isValid = false;
                            args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                        }
                    } else{
                        break;
                    }
                }
            } else if((parseInt(number.substring(1,2)) == 1) && (parseInt(number.substring(2,3)) == 2)){
                for(var i = 0; i <= number.length -1; i++){
                    if (i >= 1){
                        if(parseInt(number.substring(i,i +1)) == (parseInt(number.substring(i +1, i +2)) -1)){
                            if(i == 8){
                                args.isValid = false;
                                args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                            }
                        } else{
                            break;
                        }
                    }
                }
            } else if((parseInt(number.substring(1,2)) == 9) && (parseInt(number.substring(2,3)) == 8)){
                for(var i = 0; i <= number.length -1; i++){
                    if (i >= 1){
                        if(parseInt(number.substring(i,i +1)) == ((parseInt(number.substring(i +1, i +2)) + 1))){
                            if(i == 8){
                                args.isValid = false;
                                args.errorMessage = "CSTMR.MSG_CSTMR_PORFAVORM_13632";
                            }
                        } else{
                            break;
                        }
                    }
                }
            }
        },
		validarMinMax: function (args, min, max, type, errorMessage) {
            var field = args.currentValue;
            var regEx = null;
            if ("A" == type){
                regEx = new RegExp("^([A-Za-z0-9]){"+min+","+max+"}$");
            }else if ("N" == type){
                regEx = new RegExp("^([0-9]){"+min+","+max+"}$");
            }
            
            if (regEx != null && regEx.test(field) == false) {
                args.isValid = false;
                args.errorMessage = errorMessage;
            } else{
                 args.isValid = true;
            }
        },
        disableFields: function (args, controls, disable) {
            if (disable){
                for (var i = 0; i < controls.length; i++) {
                    args.commons.api.viewState.disable(controls[i], disable);
                }
            }else{
                for (var i = 0; i < controls.length; i++) {
                    args.commons.api.viewState.enable(controls[i]);
                }
        }
	}
	}
};
var CSTMR = {
	CONSTANTS: {
    TypeRequest: { NORMAL:'NORMAL', COLECTIVOS:'COLECTIVOS'}
   }
};
document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');

var posDataModRequest = null;
