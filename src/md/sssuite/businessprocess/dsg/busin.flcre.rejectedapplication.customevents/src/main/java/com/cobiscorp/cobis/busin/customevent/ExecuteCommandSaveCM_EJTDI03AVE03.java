package com.cobiscorp.cobis.busin.customevent;

import java.util.Calendar;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.DebtorUtil;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandSaveCM_EJTDI03AVE03 extends BaseEvent implements
		IExecuteCommand {
	private static ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandSaveCM_EJTDI03AVE03.class);

	public ExecuteCommandSaveCM_EJTDI03AVE03(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		try{
			LOGGER.logError("---->Entra al ExecuteCommandSaveCM_EJTDI03AVE03");

			LOGGER.logError("---->Recupera entidades");
			DataEntity originalHeader = entities
					.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList debtors = entities
					.getEntityList(DebtorGeneral.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");

			LOGGER.logError("---->Set de la entidad de deudores");
			entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);

			LOGGER.logError("---->Busca deudor principal");
			DataEntity mainDebtor = DebtorUtil.getDebtorEntity(debtors, args,
					new BehaviorOption(true));
			if (mainDebtor == null) {
				args.setSuccess(false);
				return;
			}
			DebtorRequest debtorRequest = new DebtorRequest();
			debtorRequest.setDebtorCode(mainDebtor.get(DebtorGeneral.CUSTOMERCODE));

			LOGGER.logError("---->Crea request de tramite"
					+ originalHeader.get(OriginalHeader.CURRENCYREQUESTED));
			ApplicationRequest creditApplicationRequest = new ApplicationRequest();
			creditApplicationRequest.setIdrequested(Integer.parseInt(originalHeader
					.get(OriginalHeader.IDREQUESTED)));
			creditApplicationRequest.setProduct(Mnemonic.MODULECCA);
			creditApplicationRequest.setType(Mnemonic.ORIGINALREQUEST);
			creditApplicationRequest.setOpertationType(originalHeader
					.get(OriginalHeader.PRODUCTTYPE));
			creditApplicationRequest.setDisbursementAmount(originalHeader.get(
					OriginalHeader.AMOUNTAPROBED).doubleValue());
			creditApplicationRequest.setAmount(originalHeader.get(
					OriginalHeader.AMOUNTREQUESTED).doubleValue());
			creditApplicationRequest.setClient(mainDebtor
					.get(DebtorGeneral.CUSTOMERCODE));
			creditApplicationRequest.setMoney(Integer.parseInt(originalHeader
					.get(OriginalHeader.CURRENCYREQUESTED)));
			Calendar initalDate = Calendar.getInstance();
			initalDate.setTime(originalHeader.get(OriginalHeader.INITIALDATE));
			creditApplicationRequest.setStartDate(initalDate);

			LOGGER.logError("---->Set de campos para el recahzo");
			String reasonOne = "", reasonTwo = "";

			creditApplicationRequest.setReasonRejection(originalHeader.get(
					OriginalHeader.REJECTIONREASON).toString());
			if (originalHeader.get(OriginalHeader.REJECTIONEXCUSE) != null) {
				if (originalHeader.get(OriginalHeader.REJECTIONEXCUSE).length() > 250) {
					reasonOne = originalHeader.get(OriginalHeader.REJECTIONEXCUSE)
							.substring(0, 250);
					reasonTwo = originalHeader.get(OriginalHeader.REJECTIONEXCUSE)
							.substring(250);
				} else {
					reasonOne = originalHeader.get(OriginalHeader.REJECTIONEXCUSE);
				}
			}

			creditApplicationRequest.setReasonOne(reasonOne);
			creditApplicationRequest.setReasonTwo(reasonTwo);

			LOGGER.logError("---->Creacion de request de envio");
			ServiceRequestTO serviceRequestCreditTO = new ServiceRequestTO();
			ServiceResponseTO serviceResponseCreditTO = new ServiceResponseTO();
			ServiceResponse serviceCreditResponse = null;

			serviceRequestCreditTO.getData().put(RequestName.INAPPLICATIONREQUEST,
					creditApplicationRequest);
			serviceRequestCreditTO.getData().put(RequestName.INDEBTORREQUEST,
					debtorRequest);

			serviceCreditResponse = execute(getServiceIntegration(), LOGGER,
					ServiceId.SERVICEUPDATELOANAPPLICATION, serviceRequestCreditTO);

			if (serviceCreditResponse.isResult()) {
				serviceResponseCreditTO = (ServiceResponseTO) serviceCreditResponse
						.getData();
				if (serviceResponseCreditTO.isSuccess()) {
					args.getMessageManager().showSuccessMsg(
							"DSGNR.SYS_DSGNR_LBLEXECOK_00003");
					args.setSuccess(true);
					LOGGER.logDebug("Salida de ExecuteCommandSaveCM_EJTDI03AVE03");
					return;
				} else {
					LOGGER.logError("no devolvio el tramite");
					return;
				}
			} else {
				args.setSuccess(false);
				LOGGER.logInfo("fallo en el servicio Credit.Admin.CreditAdmin.UpdateLoanApplication");
				List<Message> errorMessage = serviceCreditResponse.getMessages();
				for (Message message : errorMessage) {
					args.getMessageManager().showErrorMsg(
							message.getMessage() + "/n");
				}
				return;
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REJECTED_EXECUTE_SAVEAPP, e, args, LOGGER);
		}
	}
}
