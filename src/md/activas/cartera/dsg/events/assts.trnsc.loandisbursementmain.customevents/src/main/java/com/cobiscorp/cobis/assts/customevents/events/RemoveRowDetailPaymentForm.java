package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.DetailPaymentForm;
import com.cobiscorp.cobis.assts.model.DisbursementResult;
import com.cobiscorp.cobis.assts.model.LiquidateResult;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class RemoveRowDetailPaymentForm extends BaseEvent implements
		IGridRowDeleting {
	private static final ILogger logger = LogFactory
			.getLogger(RemoveRowDetailPaymentForm.class);

	public RemoveRowDetailPaymentForm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity entity, IGridRowActionEventArgs args) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		DynamicRequest entities = null;
		DataEntity detailPaymentForm = entity;
		DataEntity loan = args.getDynamicRequest().getEntity(Loan.ENTITY_NAME);

		String bankId = (String) loan.get(Loan.LOANBANKID);

		if (logger.isDebugEnabled()) {
			logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: Data="
					+ entity.getData());
		}

		Integer disbursementId = (Integer) detailPaymentForm
				.get(DetailPaymentForm.DISBURSEMENTID);
		Integer sequential = (Integer) detailPaymentForm
				.get(DetailPaymentForm.SEQUENTIAL);

		if (logger.isDebugEnabled()) {
			logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: disbursementId="
					+ disbursementId);
			logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: sequential="
					+ sequential);
			logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: bankId="
					+ bankId);
			logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: 1 Data="
					+ entity.getData());
		}
		if ((bankId != null) && (disbursementId != null)
				&& (sequential != null)) {
			ReadDisbursementFormRequest readDisbursementFormRequest = new ReadDisbursementFormRequest();
			readDisbursementFormRequest.setDisbursementSec(disbursementId
					.intValue());
			readDisbursementFormRequest.setOperation(Parameter.OPERATIOND.charAt(0));
			readDisbursementFormRequest
					.setFromCre(Parameter.PARAMETER_DISBURSEMENT);
			readDisbursementFormRequest.setSequential(sequential.intValue());
			readDisbursementFormRequest.setBankReal(bankId);
			readDisbursementFormRequest.setFictitiousBank(bankId);

			request.addValue("inReadDisbursementFormRequest",
					readDisbursementFormRequest);

			response = execute(getServiceIntegration(), logger,
					Parameter.REMOVE_DETAIL_PAY_FORM, request);
		}
		if ((response != null) && (response.isResult())) {
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: Antes de utilDist.loadDataGridDetailDisbursement(..)");
			}
			entities = args.getDynamicRequest();
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: entities= "
						+ entities.getData());
			}

			calculateTotalDisbursement(entity, entities, "-");

			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.rowAction(..) :: Despues de utilDist.loadDataGridDetailDisbursement(..)");
			}
		}

		GeneralFunction.handleResponse(args, response, null);
	}

	private void calculateTotalDisbursement(DataEntity entity,
			DynamicRequest entities, String operation) {
		DataEntity liquidateResult = entities
				.getEntity(LiquidateResult.ENTITY_NAME);
		DataEntity disbusemenetResult = entities
				.getEntity(DisbursementResult.ENTITY_NAME);
		DataEntity detailPaymentForm = entity;

		if (operation.equals("-")) {
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.calculateTotalDisbursement(..) :: RESTA");
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.calculateTotalDisbursement(..) :: SUMTOTAL= "
						+ disbusemenetResult.get(DisbursementResult.SUMTOTAL));
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.calculateTotalDisbursement(..) :: AMOUNT= "
						+ detailPaymentForm.get(DetailPaymentForm.AMOUNT));
			}
			disbusemenetResult.set(
					DisbursementResult.SUMTOTAL,
					disbusemenetResult.get(DisbursementResult.SUMTOTAL)
							.subtract(
									detailPaymentForm
											.get(DetailPaymentForm.AMOUNT)));
			disbusemenetResult.set(
					DisbursementResult.DIFFERENCE,
					liquidateResult.get(LiquidateResult.SUMTOTAL)
							.subtract(
									disbusemenetResult
											.get(DisbursementResult.SUMTOTAL)));

		} else if (operation.equals("+")) {
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.calculateTotalDisbursement(..) :: SUMA");
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.calculateTotalDisbursement(..) :: SUMTOTAL= "
						+ disbusemenetResult.get(DisbursementResult.SUMTOTAL));
				logger.logInfo("WATQ RemoveRowDetailPaymentForm.calculateTotalDisbursement(..) :: AMOUNT= "
						+ detailPaymentForm.get(DetailPaymentForm.AMOUNT));
			}
			disbusemenetResult.set(
					DisbursementResult.SUMTOTAL,
					disbusemenetResult.get(DisbursementResult.SUMTOTAL).add(
							detailPaymentForm.get(DetailPaymentForm.AMOUNT)));
		}

		entities.setEntity(DisbursementResult.ENTITY_NAME, disbusemenetResult);

	}
}
