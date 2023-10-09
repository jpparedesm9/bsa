/*global designerEvents, console */
var CLCOL = {};
 
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('CLCOL',[], function () {
            return factory();
        });
    } else {
        factory();
    }
}(this, function () {
    "use strict";
    /*module.js*/
    //Your code here
    CLCOL = {
        fileLoadingPercent : function(percentage,idVisualAttribute){
			var processBar = $("#"+idVisualAttribute).data("kendoProgressBar");
            if(processBar){
				var onChange = function (percentage){
					processBar.progressStatus.text(percentage.value+"%");
				}
                processBar.value(percentage);
				processBar.bind("change",onChange);
            }else{
                $("#"+idVisualAttribute).kendoProgressBar({
                    min: 0,
                    max: 100,
                    value: percentage,
					showStatus:true,
                    type: "percent",
					enable: true,
                    change: function(e) {
                      this.progressStatus.text(percentage+"%");
                    }
                });
            }
        },
        hideOrShowDSGGridButtonByClass : function (className,hideOrShow){
            if(hideOrShow === 'hide'){
                $('.'+className).hide();
            }else if(hideOrShow === 'show'){
                $('.'+className).show();
            }
        },
        SYSTEM: {
            getIpServer : function() {return location.origin;},
            getParameterByName : function (name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            },
            importScript : function (fileName) {
                var oHead = document.getElementsByTagName('head')[0];
                var oScript = document.createElement('script');
                oScript.type = 'text/javascript';
                oScript.charset = 'utf-8';
                oScript.src = '${contextPath}/cobis/web/views/CLCOL/assets/scripts/'+fileName;
                oHead.appendChild(oScript);
            }
        },
        VALIDATE: {
            IsNull : function (parValue) {
                return (parValue===null || parValue===undefined);
            },
            IsNullOrEmpty : function (parValue) {
                return (CLCOL.VALIDATE.IsNull(parValue) || parValue==='');
            },
            IsGreaterThanZero : function(value, args, execServer, showMessage) {
                if(execServer===true  || execServer=== false ){args.commons.execServer = execServer;}
                if(CLCOL.VALIDATE.IsNull(value) || (value<=0)){
                    if(showMessage===true){args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IPAESOZEO_95873');}
                    return false;
                }
                return true;
            },
            IsGreaterOrEqualThanZero : function(value, args, execServer, showMessage) {
                if(execServer===true  || execServer=== false ){args.commons.execServer = execServer;}
                if(CLCOL.VALIDATE.IsNull(value) || (value<0)){
                    if(showMessage===true){args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LAIGDNRUO_68962');}
                    return false;
                }
                return true;
            },
            EmptyFieldValue : function(value,fieldLabel,args,execServer){
                if(CLCOL.VALIDATE.IsNullOrEmpty(value)){
                    var fielName = cobis.translate(fieldLabel);
                    args.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_DEBEESTAR_51364',[fielName],10000,false);
                    if( (execServer===true) && !CLCOL.VALIDATE.IsNull(args) ){
                        args.commons.execServer = false;
                    }
                    return false;
                }
                return true;
            }
        },	
        REPORT: {
            Open : function(name, reportArgs){
                //Arma la URL
                if(name === 'reportingService')
                    var url = CLCOL.SYSTEM.getIpServer() + '/CTSProxy/services/cobis/web/reporting/actions/' + name + '?';
                else
                    var url = CLCOL.SYSTEM.getIpServer() + '/CTSProxy/services/cobis/web/reports/' + name + '?';
    
                //Concatena los parametos
                if((reportArgs!=null)&&(reportArgs.length>0))
                    for (var i=0; i<reportArgs.length; i++)
                        url = url + reportArgs[i][0] + '=' + reportArgs[i][1] + '&'
                //Codifica la URL
                url = encodeURI(url);
                //Opciones de abrir ventana
                var params = ['height='+screen.height, 'width='+screen.width,'fullscreen=yes'].join(',');
                //Abre ventana del reporte
                var popup = window.open(url + '&flag=' + Math.random(), 'popup_window_' + name, params);
                popup.moveTo(0,0);
            },
             Char_convert:function(original){
                      var chars = ["\u00e1","\u00e0","\u00e9","\u00e8","\u00ed","\u00ec","\u00f3","\u00f2","\u00fa","\u00f9","\u00c1","\u00c0","\u00c9","\u00c8","\u00cd","\u00cc","\u00d3","\u00d2","\u00da","\u00d9","\u00f1","\u00d1"]; 
                      var codes = ["%e1","%e1","%e9","%e9","%ed","%ed","%f3","%f3","%fa","%fa","%c1","%c1","%c9","%c9","%cd","%cd","%d3","%d3","%da","%da","%f1","%d1"];
                    if(original !== null && original !== undefined && original.constructor === String){
                        for(var i=0; i<chars.length; i++){
                            original = original.replace(chars[i], codes[i]);
                        }
                    }
                    return original;
            },
            GenerarReporte : function(reporte, argumentos, title){
                var Crue = '?myValue=' + Math.random() + '&';
                var formaMapeo = document.createElement("form");
                formaMapeo.target = 'popup_window_'+reporte;
                formaMapeo.method = "POST"; // or "post" if appropriate
            
                formaMapeo.action = "${contextPath}/cobis/web/COLLECTIVE-CLIENT/" +reporte+"/"+ Crue;
                var param = "";
                for (var i=0; i < argumentos.length; i++) {
                    param = param + argumentos[i][0] + '=' + CLCOL.REPORT.Char_convert(argumentos[i][1]) + '&'
                }
                param =  param.substr(0, param.length-1);
                var url =  formaMapeo.action + param
                if (CLCOL.VALIDATE.IsNullOrEmpty(title)) {title='COMMONS.MENU.TIT_PRINT_REPORT';}
                cobis.container.tabs.openNewTab('ctsConsole', url ,title, true);
            }
        }


    };
    
}));