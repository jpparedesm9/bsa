// (Button) 
    task.executeCommand.CM_RRCAI67UAR18 = function(entities, executeCommandEventArgs) {
       var operation = "U";
		entities.generalData.isNew = true;
        if (task.validateBeforeSave(entities, executeCommandEventArgs, operation)) {
            executeCommandEventArgs.commons.execServer = false;
        } else {
            executeCommandEventArgs.commons.execServer = false;
        }
        
    };



    //Callback guardar (actualizar)
    task.executeCommandCallback.CM_RRCAI67UAR18 = function (entities, executeCommandCallbackEventArgs) {
        updateWarranty = true;
        var typeWarranty = entities.WarrantyGeneral.warrantyType;
        if (executeCommandCallbackEventArgs.success) {
            if (typeWarranty == 'GARGPE') {
                var dataWarranty = task.addPersonalWarrantyList(executeCommandCallbackEventArgs, updateWarranty);
            } else {
                var dataWarranty = task.addOtherWarrantyList(executeCommandCallbackEventArgs, updateWarranty);
            }
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.vc.closeModal(dataWarranty);
        }
    };

 task.addPersonalWarrantyList = function (args, isUpdate) {
        //Buscar el id del cliente principal de la garantía
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        var customerId;
        for (var i = 0; i < customerList.length; i++) {
            if (customerList[i].Principal) {
                customerId = customerList[i].CustomerId;
                break;
            }
        }
        var guarantorDescription = args.commons.api.vc.model.WarrantyGeneral.guarantor;
        var indexBegin = guarantorDescription.indexOf("-");
        var indexEnd = guarantorDescription.length;
        var guarantorName = guarantorDescription.substring(indexBegin + 1, indexEnd);
        var personalGuarantorData = {
            CodeWarranty: args.commons.api.vc.model.WarrantyGeneral.externalCode,
            Type: args.commons.api.vc.model.WarrantyGeneral.warrantyType,
            Description: args.commons.api.vc.model.WarrantyGeneral.description,
            GuarantorPrimarySecondary: guarantorName, //cambiar por el nombre del garante
            ClassOpen: args.commons.api.vc.model.WarrantySituation.classWarranty,
            IdCustomer: customerId,
            State: args.commons.api.vc.model.WarrantyGeneral.status,
            DateCIC: null,
            isHeritage: "N", //obtener el valor
            CurrentValue: null,
            Currency: null
        };
        if (isUpdate) {
            return personalGuarantorData;
        } else {
            args.commons.api.parentApi().parentApi().grid.addRow("PersonalGuarantor", personalGuarantorData);
        }


    };

 task.addOtherWarrantyList = function (args, isUpdate) {
        //Buscar el id del cliente principal de la garantía
        var customerList = args.commons.api.vc.model.CustomerSearch.data();
        var customerId;
        var customerName;
        for (var i = 0; i < customerList.length; i++) {
            if (customerList[i].Principal) {
                customerId = customerList[i].CustomerId;
                customerName = customerList[i].Customer;
                break;
            }
        }
        var appraisalDate = "";
        if (args.commons.api.vc.model.WarrantyGeneral.appraisalDate != null) {
            appraisalDate = BUSIN.CONVERT.NUMBER.Format(args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getMonth() + 1), "0", 2) + "/" + args.commons.api.vc.model.WarrantyGeneral.appraisalDate.getFullYear();
        }
        var otherWarrantyData = {
            CodeWarranty: args.commons.api.vc.model.WarrantyGeneral.externalCode,
            Type: args.commons.api.vc.model.WarrantyGeneral.warrantyType,
            Description: args.commons.api.vc.model.WarrantyGeneral.description,
            InitialValue: args.commons.api.vc.model.WarrantyGeneral.initialValue,
            DateAppraisedValue: appraisalDate,
            ValueApportionment: 0,
            ClassOpen: args.commons.api.vc.model.WarrantySituation.classWarranty,
            ValueAvailable: args.commons.api.vc.model.WarrantyGeneral.fixedTermAmount,
            IdCustomer: customerId,
            NameGar: customerName,
            State: args.commons.api.vc.model.WarrantyGeneral.status,
            Flag: true,
            IsNew: true,
            ValueVNR: 0,
            RelationshipGuarantees: 0,
            isHeritage: "N", //obtener el valor
            relation: 0
        };
        if (isUpdate) {
            return otherWarrantyData;
        } else {
            args.commons.api.parentApi().parentApi().grid.addRow("OtherWarranty", otherWarrantyData);
        }

    };