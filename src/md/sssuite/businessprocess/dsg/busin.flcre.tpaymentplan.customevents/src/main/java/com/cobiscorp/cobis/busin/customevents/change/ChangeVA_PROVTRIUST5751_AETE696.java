package com.cobiscorp.cobis.busin.customevents.change;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RatingApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RatingApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.InternalRatingCustomerManagement;
import com.cobiscorp.cobis.busin.model.ApprovalCriteriaQuestion;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_PROVTRIUST5751_AETE696 extends BaseEvent implements
		IChangedEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(ChangeVA_PROVTRIUST5751_AETE696.class);

	public ChangeVA_PROVTRIUST5751_AETE696(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest arg0, IChangedEventArgs arg1) {

		final double PUNCTUATION = 1.5;
		final String SCORE_B = "B";
		String resultDiscountRate;

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Entro a ChangeVA_PROVTRIUST5751_AETE696");

		try {

			LOGGER.logDebug("valor nuevo" + arg1.getNewValue());
			LOGGER.logDebug("valor viejo" + arg1.getOldValue());
			DataEntity paymentPlanHeader = arg0
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity approvalCriteriaQuestion = arg0
					.getEntity(ApprovalCriteriaQuestion.ENTITY_NAME);

			// InitDataPaymentPlan inidata = new
			// InitDataPaymentPlan(super.getServiceIntegration());

			int tramite = paymentPlanHeader.get(PaymentPlanHeader.IDREQUESTED);

			DebtorManagement debManagement = new DebtorManagement(
					super.getServiceIntegration());
			DataEntityList debtors = debManagement.getDebtorsEntityList(
					tramite, null, new BehaviorOption(true));

			DataEntity debtorMaxQualification = getMaxQualification(
					approvalCriteriaQuestion, debtors);

			InternalRatingCustomerManagement intRatCustManagement = new InternalRatingCustomerManagement(
					super.getServiceIntegration());
			RatingApplicationResponse aplicationResponse = intRatCustManagement
					.getRatingApplicationResponseDTO(tramite,
							debtorMaxQualification
									.get(DebtorGeneral.CUSTOMERCODE), null,
							new BehaviorOption(true));

			if (aplicationResponse != null) { // Si trae datos se ingresa sino
												// no se ejecuta las
												// validaciones

				RatingApplicationRequest ratingApplicationRequest = new RatingApplicationRequest();

				Double punctuation = aplicationResponse.getScoreCustomer();

				LOGGER.logDebug("valor nuevo1" + arg1.getNewValue());
				if (arg1.getNewValue().toString().equals("N")) {

					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("Puntuacion del cliente: "
								+ punctuation);

					if (punctuation <= PUNCTUATION) {

						ratingApplicationRequest.setQualification(SCORE_B);
						approvalCriteriaQuestion.set(
								ApprovalCriteriaQuestion.CURRENTRATEFIE,
								SCORE_B);
						LOGGER.logDebug("Calificacion del cliente: "
								+ ratingApplicationRequest.getQualification());
						resultDiscountRate = this
								.discountRate(ratingApplicationRequest
										.getQualification());
						approvalCriteriaQuestion
								.set(ApprovalCriteriaQuestion.MAXIMUMDISCOUNTCUSTOMERTYPE,
										Integer.parseInt(resultDiscountRate));

					} else {
						// Ejecucion de regla
						approvalCriteriaQuestion.set(
								ApprovalCriteriaQuestion.CURRENTRATEFIE,
								aplicationResponse.getQualification());
						String rating = approvalCriteriaQuestion
								.get(ApprovalCriteriaQuestion.CURRENTRATEFIE);

						ratingApplicationRequest.setQualification(rating);

						resultDiscountRate = this
								.discountRate(ratingApplicationRequest
										.getQualification());

						approvalCriteriaQuestion
								.set(ApprovalCriteriaQuestion.MAXIMUMDISCOUNTCUSTOMERTYPE,
										Integer.parseInt(resultDiscountRate));
						LOGGER.logDebug("Nuevo valor a rebajar-------> "
								+ approvalCriteriaQuestion
										.get(ApprovalCriteriaQuestion.MAXIMUMDISCOUNTCUSTOMERTYPE));
					}
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_696, e, arg1, LOGGER);
		}
	}

	public String discountRate(String score) {

		Rule rul = null;
		RuleVersion ruleVersion = null;
		LOGGER.logDebug("Entra ejecucion servicio-------> ");
		ServiceResponse serviceResponse = null;
		serviceResponse = this
				.execute(
						getServiceIntegration(),
						LOGGER,
						"Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym",
						new Object[] { "RBT" });
		if (serviceResponse != null && serviceResponse.isResult()) {
			List<RuleVersion> ruleList = (List<RuleVersion>) serviceResponse
					.getData();
			if (!ruleList.isEmpty()) {
				ruleVersion = ruleList.get(0);
			}
		}

		if (ruleVersion != null) {
			LOGGER.logDebug("Entra a ruleVersion -----------> ");
			VariableProcess variableProcess1 = new VariableProcess();
			Variable variable1 = new Variable();
			variable1.setNombreVariable("CALIFICACION_FIE");
			variableProcess1.setValue(score);// Id de la variable L-Moneda (si
												// es catalogo) else se envia
												// directamente el valor de la
												// variable a
												// evaluar
			variableProcess1.setVariable(variable1);

			List<VariableProcess> listVariableProcess = new ArrayList<VariableProcess>();
			listVariableProcess.add(variableProcess1);

			// Creación de mapa con la regla y la lista de variables proceso
			HashMap<RuleVersion, List<VariableProcess>> values = new HashMap<RuleVersion, List<VariableProcess>>();
			values.put(ruleVersion, listVariableProcess);

			// Ejecucion del servicio
			// ServiceResponse serviceResponse = null;
			serviceResponse = this.execute(getServiceIntegration(), LOGGER,
					"Bpl.Rules.Engine.RuleManager.Generate", new Object[] {
							values, 0, "", 3 });

			/*
			 * Donde: values: es le mapa creado 0: es el id del cliente cuando
			 * existen excepciones "": es el numero de la tarjeta de crédito
			 * cuando existen excepciones 3 : es el id del role que se logueo el
			 * usuario.
			 */

			if (serviceResponse != null && serviceResponse.isResult()) {
				List<RuleProcess> resultados = (List<RuleProcess>) serviceResponse
						.getData();
				for (RuleProcess iterador : resultados) {
					LOGGER.logDebug("Proceso------->" + iterador.getId());
					for (VariableProcess iterador2 : iterador
							.getVariableProcesses()) {
						LOGGER.logDebug("ResultadoVariable------>"
								+ iterador2.getVariable().getNombreVariable());
						LOGGER.logDebug("ResultadoValor---------> "
								+ iterador2.getValue());
						return iterador2.getValue();
					}
				}

			}

		}

		return null;
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
		String qual = qualification.isEmpty()?"":qualification.get(0);
		entity.set(ApprovalCriteriaQuestion.PREVIOUSRATEFIE, qual);

		for (DataEntity debtor : debtors) {
			if (qual.equals(debtor.get(DebtorGeneral.QUALIFICATION))) {
				return debtor;
			}
		}
		return null;
	}

}
