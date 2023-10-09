package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentPrint;
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.PrintingPaymentInfo;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ModalListGrid extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(ModalListGrid.class);

	public ModalListGrid(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logInfo("-->ModalListGrid --> IInitDataEvent >>>executeDataEvent");
		}

		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		DataEntity loanSession = (DataEntity) AssetsSessionManager.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
		if (loanSession != null) {
			entities.setEntity(Loan.ENTITY_NAME, loanSession);
		}

		if (getServiceIntegration() == null && logger.isDebugEnabled()) {
			logger.logInfo("-->LoadQueries ServiceIntegration es nulo ");
		}
		DocumentsQuery(entities, arg1);
	}

	public void DocumentsQuery(DynamicRequest entities, IDataEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("detailRequest seteo IN");
		}
		ServiceRequestTO request = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		QueryReceiptPaymentRequest detailRequest = new QueryReceiptPaymentRequest();

		detailRequest.setBank(loan.get(Loan.LOANBANKID));
		detailRequest.setOperation("Q");
		request.addValue("inQueryReceiptPaymentRequest", detailRequest);
		ServiceResponse response = this.execute(logger, Parameter.PROCESSDOCUMENTPRINT,request);

		try {
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {
					QueryReceiptPaymentPrint[] itemsResponseArray = (QueryReceiptPaymentPrint[]) resultado.getValue("returnQueryReceiptPaymentPrint");

					DataEntityList dataEntityList = entities.getEntityList(PrintingPaymentInfo.ENTITY_NAME);
					for (QueryReceiptPaymentPrint itemsResponse : itemsResponseArray) {
						DataEntity item = new DataEntity();
						item.set(PrintingPaymentInfo.NUMRECEIPT,itemsResponse.getReceipt());
						item.set(PrintingPaymentInfo.SECUENTIALING,itemsResponse.getSecuentialIng());
						item.set(PrintingPaymentInfo.SECUENTIALPAG,itemsResponse.getSecuentialPag());
						item.set(PrintingPaymentInfo.STATUSPAG,itemsResponse.getStatus());
						item.set(PrintingPaymentInfo.PAYMENTDATE,itemsResponse.getPaymentDate());
						item.set(PrintingPaymentInfo.OFFICIAL,itemsResponse.getOfficial());
						dataEntityList.add(item);
					}
				}

				if (logger.isDebugEnabled()) {
					logger.logDebug("Response QueryReceiptPaymentPrint "+ resultado.toString() + "  --  ");
				}
			} else {
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);
				arg1.getMessageManager().showErrorMsg(mensaje);
			}
		} catch (Exception e) {
			logger.logError(e);
		}

	}

}
