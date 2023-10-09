package com.cobiscorp.cobis.assets.commons.events;

import java.text.SimpleDateFormat;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.OtherChargesGrid;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.OtherCharges;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class OtherChargesEvents extends BaseEvent {
	public OtherChargesEvents(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	private static final ILogger logger = LogFactory
			.getLogger(OtherCharges.class);

	@SuppressWarnings("unchecked")
	public DataEntityList loadData(DynamicRequest entities,
			ICommonEventArgs eventArgs) {
		try {
			DataEntity loanSession = null;
			DataEntity loanInstance = entities
					.getEntity(LoanInstancia.ENTITY_NAME);

			if (loanInstance != null) {
				if (loanInstance.get(LoanInstancia.IDINSTANCIA) != null) {
					loanSession = (DataEntity) AssetsSessionManager
							.getLoan(loanInstance
									.get(LoanInstancia.IDINSTANCIA));
				}

			} else {
				IExecuteQueryEventArgs executeQueryEvents = (IExecuteQueryEventArgs) eventArgs;
				Map<String, Object> customParameters = executeQueryEvents
						.getParameters().getCustomParameters();
				Map<String, Object> parameters = (Map<String, Object>) customParameters
						.get("parameters");
				Map<String, Object> maploanInstance = (Map<String, Object>) parameters
						.get("loanInstancia");
				if (maploanInstance != null) {
					loanSession = (DataEntity) AssetsSessionManager
							.getLoan((String) maploanInstance
									.get("idInstancia"));
				}
			}

			if (loanSession != null) {
				entities.setEntity(Loan.ENTITY_NAME, loanSession);
			}

			DataEntityList lista = new DataEntityList();
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

			ServiceRequestTO serviceRequest = new ServiceRequestTO();

			LoanRequest requestInLoanRequest = new LoanRequest();
			requestInLoanRequest.setDateFormat(103);
			requestInLoanRequest.setBank(loan.get(Loan.LOANBANKID));
			requestInLoanRequest.setOperation('O');
			serviceRequest.addValue("inLoanRequest", requestInLoanRequest);

			ServiceResponse response = this.execute(logger,
					Parameter.PROCESS_GRIDOTHERCHARGES, serviceRequest);
			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();
				if (resultado.isSuccess()) {
					OtherChargesGrid[] clResponseList = (OtherChargesGrid[]) resultado
							.getValue("returnOtherChargesGrid");
					SimpleDateFormat formatter = new SimpleDateFormat(
							"dd/MM/yyyy");
					for (OtherChargesGrid r : clResponseList) {
						DataEntity item = new DataEntity();
						item.set(OtherCharges.SEQUENTIAL, r.getSequential());
						item.set(OtherCharges.INIDIV, r.getIniDiv());
						item.set(OtherCharges.DIVUP, r.getDivUp());
						item.set(OtherCharges.DATE,
								formatter.parse(r.getDate()));
						item.set(OtherCharges.CONCEPT, r.getConcept());
						item.set(OtherCharges.VALUE, r.getValue());
						item.set(OtherCharges.COMMENTARY, r.getComentary());
						lista.add(item);
					}
				}
			} else {
				eventArgs.setSuccess(false);
				String mensaje = GeneralFunction.getMessageError(
						response.getMessages(), null);

				eventArgs.getMessageManager().showErrorMsg(mensaje);
			}

			return lista;
		} catch (Exception exception) {
			eventArgs.setSuccess(false);
			manageException(exception, logger);
			return null;
		}
	}
}
