/*global designerEvents, console */
var BSSNS = {};

(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        define('BSSNS', [], function () {
            return factory();
        });
    } else {
        factory();
    }
}(this, function () {
    "use strict";
    BSSNS = {
        INBOX: {
            addTaskHeader: function (taskHeader, title, value, rowNumber) {

                rowNumber = rowNumber === undefined ? 0 : rowNumber;

                if (title != null && value != null) {

                    if (title == "title") {
                        taskHeader.title = BSSNS.COMMONS.getCapitalizeCase(value);
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

            updateTaskHeader: function (taskHeader, eventArgs, groupViewHeader) {
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
        },
        COMMONS: {
            getCapitalizeCase: function (string) {
                return string.replace(/\w\S*/g, function (tStr) {
                    return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
                });
            }
        }
    };
}));