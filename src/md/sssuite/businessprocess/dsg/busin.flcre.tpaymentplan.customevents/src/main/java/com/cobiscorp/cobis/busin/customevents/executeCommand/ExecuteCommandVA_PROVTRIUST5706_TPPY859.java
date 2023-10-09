package com.cobiscorp.cobis.busin.customevents.executeCommand;

import java.util.ArrayList;
import java.util.Collections;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RatingApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RatingApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Format;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.InternalRatingCustomerManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.ItemsManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.ApprovalCriteriaQuestion;
import com.cobiscorp.cobis.busin.model.Category;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandVA_PROVTRIUST5706_TPPY859 extends BaseEvent
		implements IExecuteCommand {

	private static ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandVA_PROVTRIUST5706_TPPY859.class);

	public ExecuteCommandVA_PROVTRIUST5706_TPPY859(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {

		DataEntity paymentPlanHeader = entities
				.getEntity(PaymentPlanHeader.ENTITY_NAME);

		DataEntity approvalCriteriaQuestion = entities
				.getEntity(ApprovalCriteriaQuestion.ENTITY_NAME);

		int tramite = paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED);
		if (tramite > 0) {
			// InitDataPaymentPlan inidata = new
			// InitDataPaymentPlan(super.getServiceIntegration());
			DebtorManagement debManagement = new DebtorManagement(
					super.getServiceIntegration());
			DataEntityList debtors = debManagement.getDebtorsEntityList(
					tramite, null, new BehaviorOption(true));
			DataEntity debtorMaxQualification = this.getMaxQualification(
					approvalCriteriaQuestion, debtors);

			int idCliente = debtorMaxQualification
					.get(DebtorGeneral.CUSTOMERCODE);

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso ExecuteCommandVA_PROVTRIUST5706_TPPY859");

			try {
				RatingApplicationRequest ratingApplicationRequestDTO = new RatingApplicationRequest();
				ratingApplicationRequestDTO.setOperation(String
						.valueOf(Format.OPERATION_ITEMS_DETAIL_INSERT));
				// Preguntas
				ratingApplicationRequestDTO.setQuestionOne("01");
				ratingApplicationRequestDTO.setQuestionTwo("02");
				ratingApplicationRequestDTO.setQuestionThree("03");
				ratingApplicationRequestDTO.setQuestionFour("04");
				ratingApplicationRequestDTO.setQuestionFive("05");
				ratingApplicationRequestDTO.setQuestionSix("06");
				ratingApplicationRequestDTO.setIdEnte(idCliente);
				ratingApplicationRequestDTO
						.setAnswerOne(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.OTHERDEBTCICQUESTION));
				ratingApplicationRequestDTO
						.setAnswerTwo(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.SHAREDENTITYQUESTION));
				ratingApplicationRequestDTO
						.setAnswerThree(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.COMPAREDEXPLUSIVECUSTOMERQUESTION));
				ratingApplicationRequestDTO
						.setAnswerFour(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.CUSTOMERCPOPQUESTION));
				ratingApplicationRequestDTO
						.setAnswerFive(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.RECORDSMATCHINGQUESTION));
				ratingApplicationRequestDTO
						.setAnswerSix(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.CUSTOMERNOCPOPQUESTION));
				ratingApplicationRequestDTO
						.setQualification(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.CURRENTRATEFIE));
				ratingApplicationRequestDTO.setIdTramit(tramite);
				ratingApplicationRequestDTO.setFormat_date(SessionContext
						.getFormatDate());// Format.DATE
				ratingApplicationRequestDTO
						.setCalAnterior(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.PREVIOUSRATEFIE));
				ratingApplicationRequestDTO
						.setMaxDiscount(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.MAXIMUMDISCOUNTCUSTOMERTYPE));
				ratingApplicationRequestDTO
						.setApplyCrop(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.APPLYREBATECROP));
				if (approvalCriteriaQuestion
						.get(ApprovalCriteriaQuestion.REBATECUSTOMERTYPE) == null) {
					ratingApplicationRequestDTO.setRebateType(0);
				} else {
					ratingApplicationRequestDTO
							.setRebateType(approvalCriteriaQuestion
									.get(ApprovalCriteriaQuestion.REBATECUSTOMERTYPE));
				}
				ratingApplicationRequestDTO
						.setTariffRate(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.TARIFFRATE));
				ratingApplicationRequestDTO
						.setProposedRate(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.PROPOSEDRATE));
				ratingApplicationRequestDTO
						.setRebateRequest(approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.REBATEREQUEST));
				if (approvalCriteriaQuestion
						.get(ApprovalCriteriaQuestion.REBATE) == null) {
					ratingApplicationRequestDTO.setRebate(0);
				} else {
					ratingApplicationRequestDTO
							.setRebate(approvalCriteriaQuestion
									.get(ApprovalCriteriaQuestion.REBATE));
				}
				ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
				serviceRequestTO.getData().put("inRatingApplicationRequest",
						ratingApplicationRequestDTO);

				ServiceResponse serviceResponse = execute(
						getServiceIntegration(), LOGGER,
						ServiceId.SERVICEINSERTRATINGAPPLICATION,
						serviceRequestTO);

				if (serviceResponse.isResult()) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("Servicio Ejecutado Correctamente pra Insertar Preguntas: "
								+ ServiceId.SERVICEINSERTRATINGAPPLICATION);

					LOGGER.logDebug("Inicio de Servicio Buscar datos "
							+ ServiceId.SERVICEQUERYRATINGAPPLICATION);
					InternalRatingCustomerManagement intRatCustManagement = new InternalRatingCustomerManagement(
							super.getServiceIntegration());

					RatingApplicationResponse aplicationResponse = intRatCustManagement
							.getRatingApplicationResponseDTO(tramite,
									debtorMaxQualification
											.get(DebtorGeneral.CUSTOMERCODE),
									null, new BehaviorOption(true));

					approvalCriteriaQuestion.set(
							ApprovalCriteriaQuestion.INTERNALSCORE,
							aplicationResponse.getScoreCustomer());

					args.getMessageManager().showSuccessMsg(
							"BUSIN.DLB_BUSIN_IEJTAITMT_92625");
				} else {
					MessageManagement.show(serviceResponse, args,
							new BehaviorOption(false));
					args.setSuccess(false);
				}

				// ACTUALIZACION
				// Valor nuevo de la tasa referencial
				Double valor = approvalCriteriaQuestion
						.get(ApprovalCriteriaQuestion.PROPOSEDRATE);

				ItemsManagement itemsManagement = new ItemsManagement(
						super.getServiceIntegration());

				DataEntityList itemList = entities
						.getEntityList(Category.ENTITY_NAME);
				if (itemsManagement != null) {
					for (DataEntity item : itemList) {
						if (item.get(Category.CONCEPT).equals("INT")) {
							//if (logger.isDebugEnabled())
							//	logger.logDebug("Ingreso readItemsDetail para consultar Rubros");

							// RECUPERA RUBROS
							ItemsManagement.readItemsDetail(entities, args,
									"INT", super.getServiceIntegration(), item,
									null);

							//if (logger.isDebugEnabled())
							//	logger.logDebug("Ingreso saveItem para actualizar el RUBRO");
							// ACTUALIZA RUBROS
							item.set(Category.SIGN, "-");

							item.set(
									Category.SPREAD,
									approvalCriteriaQuestion
											.get(ApprovalCriteriaQuestion.REBATECUSTOMERTYPE));
							item.set(Category.VALUE, valor);
							itemsManagement.saveItem(entities, args, "INT",
									valor, item);
						}
					}
				}

			} catch (Exception e) {
				ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_EXECUTE_INSERTUPDATE, e, args, LOGGER);
			}
		}
	}

	public DataEntity getMaxQualification(DataEntity entity,
			DataEntityList debtors) {
		ArrayList<String> qualification = new ArrayList<String>();
		if (debtors != null) {
			for (DataEntity debtor : debtors) {
				qualification.add(debtor.get(DebtorGeneral.QUALIFICATION));
			}
		}
		Collections.sort(qualification);
		String qual = qualification.isEmpty() ? "" : qualification.get(0);
		entity.set(ApprovalCriteriaQuestion.PREVIOUSRATEFIE, qual);

		for (DataEntity debtor : debtors) {
			if (qual.equals(debtor.get(DebtorGeneral.QUALIFICATION))) {
				return debtor;
			}
		}
		return null;
	}

}