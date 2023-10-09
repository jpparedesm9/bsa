package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.CustomerManager;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.commons.events.ReferencesByCustomer;
import com.cobiscorp.cobis.cstmr.commons.parameters.Parameter;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.ScannedDocumentsDetail;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class UpdateCustomerExecuteCommandEvent extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateCustomerExecuteCommandEvent.class);

	public UpdateCustomerExecuteCommandEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs eventArgs) {
		Map<String, Object> result = new HashMap<String, Object>();

		CustomerManager customer = new CustomerManager(getServiceIntegration(), Parameter.MODECUSTOMER.TOTAL);
		ReferencesByCustomer searchReferences = new ReferencesByCustomer(getServiceIntegration());

		try {
			DataEntityList scannedDocumentsDetail = entities.getEntityList(ScannedDocumentsDetail.ENTITY_NAME);

			if (scannedDocumentsDetail != null && scannedDocumentsDetail.size() > 0) {
				for (DataEntity scannedDocument : scannedDocumentsDetail) {
					if (scannedDocument.get(ScannedDocumentsDetail.DOCUMENTID).equals("009") && !scannedDocument.get(ScannedDocumentsDetail.UPLOADED).equals("S")) {
						eventArgs.getMessageManager().showInfoMsg("CSTMR.MSG_CSTMR_ELDOCUMII_25334", null, 6000);// El documento ACTA DE NACIMIENTO no se ha subido
						eventArgs.setSuccess(false);
						return;
					}
				}
			}

			result = customer.updateTotalCustomer(entities);
			GeneralFunction.writeResult(result, eventArgs);
			Map<String, Object> outputResults = customer.updateComplementarDataCustomer(entities);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Inicio de busqueda de referencias al actualizar un cliente");
			}

			if (outputResults != null && outputResults.size() > 0) {
				DataEntity naturalPerson = entities.getEntity(NaturalPerson.ENTITY_NAME);
				naturalPerson.set(NaturalPerson.HASLISTBLACK,
						outputResults.get(Parameter.LISTBLACK) == null ? false : "N".equals(String.valueOf(outputResults.get(Parameter.LISTBLACK))) ? false : true);
			}
			//SRO. 155695 - Se eliminan referencias
			//searchReferences.searchReferencesByCustomer(entities, eventArgs);
			if (result.get(Parameter.MESSAGESERVERLIST) != null) {
				List<Message> lstmsg = (List<Message>) result.get(Parameter.MESSAGESERVERLIST);
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("PRO lstmsg: " + lstmsg);
				}
				if (lstmsg != null && !lstmsg.isEmpty()) {
					eventArgs.setSuccess(false);
				}
			}
		} catch (BusinessException bex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_CUSTOMER, bex, eventArgs, LOGGER);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_CUSTOMER, e, eventArgs, LOGGER);
		}
	}

}
