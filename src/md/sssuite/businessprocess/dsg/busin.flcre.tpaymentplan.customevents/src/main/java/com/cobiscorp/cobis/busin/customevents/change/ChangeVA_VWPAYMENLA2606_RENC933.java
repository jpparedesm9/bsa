package com.cobiscorp.cobis.busin.customevents.change;

import java.util.Calendar;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.CreditOtherData;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_VWPAYMENLA2606_RENC933 extends BaseEvent implements
		IChangedEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(ChangeVA_VWPAYMENLA2606_RENC933.class);

	public ChangeVA_VWPAYMENLA2606_RENC933(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs arg) {
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso ChangeVA_VWPAYMENLA2606_RENC933 - PaymentPlanHeader.currency");
			Calendar calendarDate = Calendar.getInstance();
			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity originalHeader = entities
					.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity officerAnalysis = entities
					.getEntity(OfficerAnalysis.ENTITY_NAME);
			DataEntity creditOtherData = entities
					.getEntity(CreditOtherData.ENTITY_NAME);

			LoanRequest loanRequestDTO = new LoanRequest();
			loanRequestDTO.setCode(paymentPlanHeader
					.get(PaymentPlanHeader.IDREQUESTED)); // @i_tramite
			loanRequestDTO.setCustomer(paymentPlanHeader
					.get(PaymentPlanHeader.CUSTOMERCODE)); // @i_cliente
			loanRequestDTO.setCustomerName(paymentPlanHeader
					.get(PaymentPlanHeader.CUSTOMERNAME)); // @i_nombre
			loanRequestDTO.setCurrency(paymentPlanHeader
					.get(PaymentPlanHeader.CURRENCY)); // @i_moneda
			loanRequestDTO.setSector(officerAnalysis.get(OfficerAnalysis.SECTOR)); // @i_sector
			loanRequestDTO.setOperationCode(paymentPlanHeader
					.get(PaymentPlanHeader.PRODUCTTYPE)); // @i_toperacion
			loanRequestDTO.setOffice(originalHeader.get(OriginalHeader.OFFICE)); // @i_oficina
			loanRequestDTO.setOfficer(Integer.parseInt(officerAnalysis
					.get(OfficerAnalysis.OFFICER))); // @i_oficial
			calendarDate.setTime(originalHeader.get(OriginalHeader.INITIALDATE)); // @i_fecha_ini
			loanRequestDTO.setInitDate(calendarDate);
			loanRequestDTO.setDisbursementAmount(paymentPlanHeader
					.get(PaymentPlanHeader.AMOUNT)); // @i_monto
			loanRequestDTO.setApprovedAmount(paymentPlanHeader
					.get(PaymentPlanHeader.AMOUNT)); // @i_monto_aprobado
			loanRequestDTO.setDestination(creditOtherData
					.get(CreditOtherData.CREDITDESTINATION)); // @i_destino
			loanRequestDTO.setCity(originalHeader.get(OriginalHeader.CITYCODE)); // @i_ciudad
			loanRequestDTO.setCityDestination(officerAnalysis
					.get(OfficerAnalysis.CITY)); // @i_ciudad_destino
			loanRequestDTO.setDateFormat(SessionContext.getFormatDate()); // Format.DATE--
																			// @i_formato_fecha
			loanRequestDTO.setNoBank('N'); // @i_no_banco
			loanRequestDTO.setFundingSource(creditOtherData
					.get(CreditOtherData.SOURCEOFFUNDING)); // @i_origen_fondo
			loanRequestDTO.setOwnFunding('S'); // @i_fondos_propios
			loanRequestDTO.setType('O'); // @i_tipo_tr
			// loanRequestDTO.setTerm(paymentPlanHeader.get(PaymentPlan.TERM));
			// @i_plazo
			// loanRequestDTO.setTermTime(paymentPlan.get(PaymentPlan.PAYMENTFREQUENCY));
			// @i_tplazo
			loanRequestDTO.setBank(paymentPlanHeader
					.get(PaymentPlanHeader.IDREQUESTED) + ""); // @i_numero_banco

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put("inLoanRequest", loanRequestDTO);

			ServiceResponse serviceResponse = execute(getServiceIntegration(),
					LOGGER,
					"Businessprocess.Creditmanagement.LoanMaintenance.CreateLoan",
					serviceRequestTO);

			if (serviceResponse.isResult()) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Tramite creado para - ");
				arg.getMessageManager().showSuccessMsg(
						"BUSIN.DLB_BUSIN_OPINCSATE_87941");
			} else {
				MessageManagement.show(serviceResponse, arg, new BehaviorOption(
						true));
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_APROVED, e, arg, LOGGER);
		}

	}

}
