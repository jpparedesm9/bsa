package com.cobiscorp.cobis.loans.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.AmountManager;
import com.cobiscorp.cobis.loans.model.Amount;
import com.cobiscorp.cobis.loans.model.Credit;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class CreateAmount extends BaseEvent implements IExecuteCommand {
	private static final ILogger LOGGER = LogFactory.getLogger(CreateAmount.class);

	public CreateAmount(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		LOGGER.logDebug("----->>>Inicio ExecuteCommand - CreateAmount");
		try {
			DataEntityList amountList = entities.getEntityList(Amount.ENTITY_NAME);
			DataEntity group = entities.getEntity(Group.ENTITY_NAME);
			GroupLoanAmountRequest amountRequest = new GroupLoanAmountRequest();
			AmountManager amountManager = new AmountManager(getServiceIntegration());
			CatalogManagement catalogManagement = new CatalogManagement(getServiceIntegration());
			ParameterResponse parameterDto = catalogManagement.getParameter(4, "VAHVO", "CRE", args, new BehaviorOption(false, false));
			DataEntity credit = entities.getEntity(Credit.ENTITY_NAME);

			int idRequest = 0;

			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());

			double valorCompara = 0;
			int count = 0;

			if (parameterDto != null) {
				LOGGER.logDebug("----->>>ExecuteCommand - getParameterValue: " + parameterDto.getParameterValue());
				LOGGER.logDebug("----->>>ExecuteCommand - Antes de Guardar - Id Grupo: " + group.get(Group.CODE));
				valorCompara = Integer.parseInt(parameterDto.getParameterValue());

				if (amountList != null && amountList.size() > 0) {
					for (DataEntity amount : amountList) {

						LOGGER.logDebug("----->>>ExecuteCommand - Antes de Guardar - Id Integrante: " + amount.get(Amount.MEMBERID));
						idRequest = amount.get(Amount.CREDIT);
						amountRequest.setSolicitude(amount.get(Amount.CREDIT));
						amountRequest.setCustomerId(amount.get(Amount.MEMBERID));
						amountRequest.setGroupId(group.get(Group.CODE));
						amountRequest.setCycleParticipation(amount.get(Amount.CYCLEPARTICIPATION));
						amountRequest.setSafePackage(amount.get(Amount.SAFEPACKAGE) == null ? null : amount.get(Amount.SAFEPACKAGE).trim());

						// amount.get(Amount.AMOUNT) - solicitado -- se va con el tg_monto_aprobado
						// amount.get(Amount.AUTHORIZEDAMOUNT) - autorizado -- se va con el tg_monto
						if (amount.get(Amount.AMOUNT) != null) {
							amountRequest.setAmount(amount.get(Amount.AMOUNT).doubleValue());
						} else {
							amountRequest.setAmount(0.0);
						}
						if (amount.get(Amount.AUTHORIZEDAMOUNT) != null) {
							amountRequest.setAuthorizedAmount(amount.get(Amount.AUTHORIZEDAMOUNT).doubleValue());
						} else {
							amountRequest.setAuthorizedAmount(0);
						}
						if (amount.get(Amount.PROPOSEDMAXIMUMSAVING) != null) {
							amountRequest.setProposedMaximumSaving(amount.get(Amount.PROPOSEDMAXIMUMSAVING).doubleValue());
						} else {
							amountRequest.setProposedMaximumSaving(0);
						}

						if (amount.get(Amount.VOLUNTARYSAVINGS) != null) {
							if (amount.get(Amount.VOLUNTARYSAVINGS).doubleValue() < valorCompara) {
								LOGGER.logError("--->>Ahorro Voluntario es Menor al Parametrizado");
								// LBL_LOANS_AHORROVNN_99957 = Ahorro Voluntario es Menor al Parametrizado
								amount.set(Amount.VOLUNTARYSAVINGS, BigDecimal.valueOf(valorCompara));
								amountRequest.setVoluntarySavings(valorCompara);
								args.getMessageManager().showInfoMsg("LOANS.LBL_LOANS_AHORROVNN_99957");
							} else {
								amountRequest.setVoluntarySavings(amount.get(Amount.VOLUNTARYSAVINGS).doubleValue());
							}
						}
						String mensaje = amountManager.updateAmount(amountRequest, 2, args, new BehaviorOption(true));
						LOGGER.logDebug("<<<mensaje Modo 2:--" + mensaje + "--");

						if (mensaje != null) {
							LOGGER.logDebug("<<<mensaje Modo 2-A:--" + mensaje + "--");
							if (!mensaje.equals("0")) { // Devuelve 0 si no hay error - se puso cero por defecto en el SG
								count = 1;
								LOGGER.logDebug("<<<mensaje Modo 2-B:--" + mensaje + "--");
							}
						} else {
							count = 1;
						}
					}

					String mensaje2 = amountManager.updateAmount(amountRequest, 3, args, new BehaviorOption(true));
					LOGGER.logDebug("<<<mensaje del create2 " + mensaje2);
					/*
					 * if ((mensaje2==null) || (mensaje2.equals("--"))) {
					 * //LOGGER.logDebug("<<<mensaje del create2 "+ mensaje2); //
					 * LBL_LOANS_REGISTRDE_81762: REGISTRO ACTUALIZADO EXITOSAMENTE //
					 * DLB_BUSIN_IEJTAITMT_92625: Operacion Ejecutada Exitosamente
					 * args.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_IEJTAITMT_92625"); }
					 */

				}

			} else {
				// LBL_LOANS_PARMETRRN_32839: Voluntary Savings Parameter Does Not Exist
				LOGGER.logError("----->>>No hay informacion para el parametro-VAHVO");
				args.getMessageManager().showErrorMsg("LOANS.LBL_LOANS_PARMETRRN_32839");
			}

			LOGGER.logDebug("----->>>ExecuteCommand - idRequest: " + idRequest);
			ApplicationResponse creditApplication = transactionManagement.getApplication(idRequest, args, new BehaviorOption(true));
			credit.set(Credit.AMOUNTREQUESTED, creditApplication.getSumRequestedAmountGroup() == null ? null : creditApplication.getSumRequestedAmountGroup().doubleValue());
			credit.set(Credit.APPROVEDAMOUNT, creditApplication.getSumAmountGroup() == null ? null : creditApplication.getSumAmountGroup().doubleValue());

			LOGGER.logDebug("Si el valor es 1, existio error en multiplos:" + count + "--");
			if (count == 1) {
				args.setSuccess(false);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.CREATE_AMOUNT, e, args, LOGGER);
		}

	}
}
