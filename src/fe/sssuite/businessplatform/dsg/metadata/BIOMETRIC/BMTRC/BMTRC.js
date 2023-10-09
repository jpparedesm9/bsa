var LATFO = {

    COMMONS: {
        getCapitalizeCase: function(string) {
            return string.replace(/\w\S*/g, function(tStr) {
                return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
            });
        },
        getPercentage: function(amounts, porcent) {
            var sum = 0;
            amounts.forEach(function(amount) {
                sum += amount;
            });
            return (sum * porcent) / 100;
        }
    },

    INBOX: {

        addTaskHeader: function(taskHeader, title, value, rowNumber) {

            rowNumber = rowNumber === undefined ? 0 : rowNumber;

            if (title != null && value != null) {

                if (title == "title") {
                    taskHeader.title = LATFO.COMMONS.getCapitalizeCase(value);
                } else {

                    var update = false;
                    taskHeader.subtitle = taskHeader.subtitle == null ? [] : taskHeader.subtitle;
                    taskHeader.subtitle[rowNumber] = taskHeader.subtitle[rowNumber] == null ? [] : taskHeader.subtitle[rowNumber];

                    for (var i = 0; i < taskHeader.subtitle.length; i++) {
                        if (i == rowNumber) {
                            for (var j = 0; j < taskHeader.subtitle[i].length; j++) {
                                if (taskHeader.subtitle[i][j].title == title) {
                                    taskHeader.subtitle[i][j].value = value;
                                    update = true;
                                    break;
                                }
                            }
                            if (!update) {
                                taskHeader.subtitle[i].push({
                                    title: title,
                                    value: value
                                });
                            }
                            break;
                        }
                    }

                }
            }
        },

        updateTaskHeader: function(taskHeader, eventArgs, groupViewHeader) {
            eventArgs.commons.api.vc.removeChildVc('taskHeader');

            var nav = eventArgs.commons.api.navigation;

            nav.customAddress = {
                id: 'taskHeader',
                url: 'inbox/templates/header-task.html',
                useMinification: false
            };

            nav.scripts = [{
                module: cobis.modules.INBOX,
                files: ['/inbox/controllers/header-task-ctrl.js']
            }];

            nav.customDialogParameters = {
                taskHeader: taskHeader
            };

            nav.registerCustomView(groupViewHeader);
        }
    }
};

var BMTRC = {
    CONSTANTS: {
        Stage: {
            INGRESO: 'INGRESO',
        },
        TypeOrigin: {
            FLUJO: 'FLUJO',
            INGRESO: 'INGRESO',
            CONSULTA: 'CONSULTA',
        },
        ValidationStatus: {
            SUCCESS: 'APROBADO',
            REJECTED: 'RECHAZADO',
            PENDING: 'PENDIENTE',
        },
        Codes: {
            APPROVED: 'OK0000',
            REJECTED: 'EVD05'
        }
    },
    CONVERT: {
        DATE: {
            FromStringMDY: function(strignValue) {
                return new Date(strignValue.substring(6, 10), strignValue.substring(0, 2) - 1, strignValue.substring(3, 5));
            }
        },
        NUMBER: {
            Format: function(stringValue, stringAdd, finalLength) {
                for (i = stringValue.toString().length; i < parseInt(finalLength); i++) {
                    stringValue = stringAdd + stringValue;
                }
                return stringValue;
            }
        },
        CURRENCY: {
            Format: function(stringValue, intPrecision) {
                return stringValue.toFixed(parseInt(intPrecision)).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
            }
        },
        getCapitalizeCase: function(string) {
            return string.replace(/\w\S*/g, function(tStr) {
                return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
            });
        }
    },
    SERVICES: {
        BIOCHECK: {
            validateBiocheck: function(args, environment, localIp, argsHijo) {
                var rowData = args.rowData;
                console.log('IP local: ' + localIp);
                var oficial = cobis.containerScope.userInfo.login;
                var clientInfo = {
                    "ipLocal": "127.0.0.1",
                    "idUsuario": "N000001",
                    "sesionSN": oficial,
                    "idAplicativo": "59",
                    "pAdicional": {
                        "userId": "N000001",
                        "buc": rowData.buc,
                        "numSuc": oficial,
                        "canal": "59",
                        "appId": "59",
                        "estPers": "NO ENROLADO",
                        "tipoOperacion": "VERIFICACION",
                        "tipoOpeApp": "01",
                    },
                };
                // la sucursal esta dando error
                // buc - 52121439
                cobis.showMessageWindow.loading(true);
                console.log(JSON.stringify(clientInfo));
                $.ajax({
                    url: '${contextPath}/resources/cobis/web/OrchestrationBiometricServiceRest/generateOpaqueToken', //token opaco
                    type: 'POST',
                    data: JSON.stringify(clientInfo),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    error: function(response) {
                        console.error(response);
                        cobis.showMessageWindow.loading(false);
                        //MSG:Se produjo un error, favor consultar con el Administrador
                        cobis.getMessageManager().showMessagesError('BMTRC.MSG_BMTRC_SEPRODUAD_14527', null, 6000, false);
                    },
                }).then(function(data) {
                    BMTRC.SERVICES.BIOCHECK.saveAndEvaluateBiocheckData(rowData, data, args, environment, argsHijo);
                });
            },
            saveAndEvaluateBiocheckData: function(rowData, response, args, environment, argsHijo) {                
                if (BMTRC.SERVICES.BIOCHECK.validateOpakeTokenResponse(response, args)) {
                    if (rowData.withoutFingerprintValue !== 'S') {
                        var dataBiocheck = JSON.stringify({
                            token: response.data.stokenGeneratorResponse.token

                        });
                        BMTRC.SERVICES.BIOCHECK.loadingBiometric(dataBiocheck, rowData, args, response, argsHijo);
                    } 
                } else {
                    cobis.showMessageWindow.loading(false);
                }
            },
            transformResponseBiocheck: function(response) {
                var resObj = response.replace(/\\"/g, "\"");
                resObj = resObj.replace(/"{/g, "{");
                resObj = resObj.replace(/}"/g, "}");
                resObj = resObj.replace('Respuesta:', "");
                resObj = resObj.replace('response ', "response");
                return JSON.parse(resObj);
            },
            validateOpakeTokenResponse: function(response, args) {
                var result = true;
                var error = response.data.errorMessage;
                if (angular.isDefined(error) && error != null) {
                    if (angular.isDefined(error.httpCode) && error.httpCode != null) {
                        result = false;
                        cobis.getMessageManager().showMessagesError('Error al generar el toquen Opaco', null, 1000, false);
                    }
                }
                return result;
            },
            getLocalIpAddress: function(onNewIP) {
                var ip_dups = {};

                var RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
                var useWebKit = !!window.webkitRTCPeerConnection;

                if (!RTCPeerConnection) {
                    var win = iframe.contentWindow;
                    RTCPeerConnection = win.RTCPeerConnection || win.mozRTCPeerConnection || win.webkitRTCPeerConnection;
                    useWebKit = !!win.webkitRTCPeerConnection;
                }

                var mediaConstraints = {
                    optional: [{
                        RtpDataChannels: true
                    }],
                };

                var servers = {
                    iceServers: [{
                        urls: 'stun:stun.l.google.com:19302'
                    }]
                };

                //construct a new RTCPeerConnection
                var pc = new RTCPeerConnection(servers, mediaConstraints);

                function handleCandidate(candidate) {
                    //match just the IP address
                    var ip_regex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/;
                    var ip_addr = ip_regex.exec(candidate);

                    //remove duplicates
                    if (ip_dups[ip_addr] === undefined) onNewIP(ip_addr);

                    ip_dups[ip_addr] = true;
                }

                //listen for candidate events
                pc.onicecandidate = function(ice) {
                    if (ice.candidate) handleCandidate(ice.candidate.candidate);
                };


                pc.createDataChannel('');

                pc.createOffer(
                    function(result) {
                        pc.setLocalDescription(
                            result,
                            function() {},
                            function() {}
                        );
                    },
                    function() {}
                );


                setTimeout(function() {
                    var lines = pc.localDescription.sdp.split('\n');
                    lines.forEach(function(line) {
                        if (line.indexOf('a=candidate:') === 0) handleCandidate(line);
                    });
                }, 1000);
            },
            loadingBiometric: function(data, rowData, args, response, argsHijo) {
                cobis.showMessageWindow.loading(false);
                try {
                    //url para cargar en el iframe
                    var iframeSource = 'https://secmgmt.pmi.authsrvc.biometric.mx.corp/biocheck/verify/#!/VentanillaINE';
                    var dataSend = {};

                    //carga del iframe
                    var element = document.getElementById('VC_BIOMETRINP_845409');
                    var bioFrame = document.createElement('iframe');
                    bioFrame.setAttribute('src', iframeSource);
                    bioFrame.setAttribute('id', 'bio_iframe');
                    bioFrame.style.width = '100%';
                    bioFrame.style.height = '600px';
                    //element.innerHTML = ifrm.innerHTML
                    element.appendChild(bioFrame);
                    iframeEl = document.getElementById('bio_iframe');
                    BMTRC.SERVICES.BIOCHECK.bindEvent(window, 'message', function(e) {
                        // Esta función es llamada cada que Biocheck se comunica con la página contenedora (canal)
                        if (e.data.event_id) {
                            // El "ping" enviado a Biocheck es contestado con el evento "my_cors_message" (como lo indica la documentación)
                            if (e.data.event_id === 'my_cors_message') {

                                // Se envía la cadena resultante (mensaje) a Biocheck para su procesamiento
                                iframeEl.contentWindow.postMessage(data, '*');
                            }
                        } else {
                            // Si no se recibe el evento "my_cors_message" desde Biocheck, quiere decir que Biocheck ya terminó su flujo, depositando la respuesta en la propiedad "e.data" para su posterior tratamiento por parte del canal
                            //var element = document.getElementById('VC_BIOMETRINP_845409');
                            //element.removeChild(iframeEl);

                            console.log(data);
                            console.log(e.data);
                            if (data) {
                                if (e.data) {
                                    var response = JSON.parse(e.data);
                                    if (response.code != BMTRC.CONSTANTS.Codes.APPROVED) {
                                        console.log("Error en respuesta de biocheck: " + response.code);
                                        BMTRC.SERVICES.BIOCHECK.biocheckErrorMessageManagement(response, rowData, args, argsHijo);
                                    } else {
                                        console.log("Se llama al servicio que guarda la información de biocheck");
                                        // Se realiza una prueba de guardado dentro de la pantalla
                                      /*  var jsonRespuesta = {
                                            "message": "VERIFICACION EXITOSA",
                                            "innerMessage": "df3a6e39a19efb4f49d0bb240c31d25db9b39b037b0ba9d331abfd98c5335134",
                                            "code": "OK0000",
                                            "response": true
                                        }*/
                                        //var jsonTransformado = JSON.parse(jsonRespuesta);
                                        dataSend.validateFingerPrint = null;
                                        dataSend.flag = rowData.withoutFingerprintValue;
                                        dataSend.amount = rowData.amount;
                                        dataSend.sequential = null;
                                        dataSend.instanceProcess = args.commons.api.parentVc.model.Task.processInstanceIdentifier;
                                        dataSend.status = response.code;                                        
                                        dataSend.hash = response.innerMessage
                                        
                                        BMTRC.SERVICES.BIOCHECK.saveBiometricInfo(dataSend, rowData, args, argsHijo);
                                    }
                                }
                            }
                            data = null;

                        }
                        //e.data = '';
                    });
                } catch (error) {
                    console.log(error);
                }
            },
            saveBiometricInfo(dataSend, rowData, args, argsHijo) {
                var api = args.commons.api;
                var apiOrig
                if(rowData.withoutFingerprintValue == "N"){
                   apiOrig = argsHijo.commons.api;
                }  
                $.ajax({
                    url: "${contextPath}/resources/cobis/web/OrchestrationBiocheckServiceRest/save/" + rowData.idCustomer, //guardar info biocheck
                    type: "POST",
                    data: JSON.stringify(dataSend),
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    error: function(response) {
                        cobis.showMessageWindow.loading(false);
                        //MSG:Se produjo un error, favor consultar con el Administrador
                        cobis.getMessageManager().showMessagesError("BMTRC.MSG_BMTRC_SEPRODUAD_14527", null, 6000, false);
                    }
                }).then(function(data) {
                    rowData.validationStatus = data.response;
                    if (api.parentVc.model.Task.bussinessInformationStringTwo == 'REVOLVENTE') {
                        api.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
                    }
                    api.vc.executeCommand('VA_VABUTTONVNZFJKQ_704515', 'Actualizar Grilla', validator, false, false, '', false);
                    //MSG:Lectura de huellas finalizada
                    cobis.getMessageManager().showMessagesSuccess("BMTRC.MSG_BMTRC_LECTURAAE_97366", null, 6000, false);     
                    if(rowData.withoutFingerprintValue == "N"){
                        apiOrig.vc.executeCommand('VA_VABUTTONRKQKGKO_888166', 'Salir', validator, false, false, '', false);
                    }               
                    
                    cobis.showMessageWindow.loading(false);
                    
                });
            },
            bindEvent(element, eventName, eventHandler) {
                if (element.addEventListener) {
                    element.addEventListener(eventName, eventHandler, false);
                } else if (element.attachEvent) {
                    element.attachEvent('on' + eventName, eventHandler);
                }
            },
            biocheckErrorMessageManagement(dataBiocheck, rowData, args, argsHijo) {
                var api = args.commons.api;
                var apiOrig = argsHijo.commons.api;

                var params = rowData.idCustomer + "/" + dataBiocheck.code + "/" + api.parentVc.model.Task.bussinessInformationIntegerTwo;

                $.ajax({
                    url: "${contextPath}/resources/cobis/web/OrchestrationBiocheckServiceRest/error/catalogo/" + params, //guardar info biocheck cuando da error
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    error: function(response) {
                        cobis.showMessageWindow.loading(false);
                        //MSG:Se produjo un error, favor consultar con el Administrador
                        cobis.getMessageManager().showMessagesError("BMTRC.MSG_BMTRC_SEPRODUAD_14527", null, 6000, false);
                    }
                }).then(function(data) {
                    cobis.getMessageManager().showMessagesError(data.response, null, 6000, false);
                    cobis.showMessageWindow.loading(false);
                    apiOrig.vc.executeCommand('VA_VABUTTONRKQKGKO_888166', 'Salir', validator, false, false, '', false);
                });


            }
        }
    }
};