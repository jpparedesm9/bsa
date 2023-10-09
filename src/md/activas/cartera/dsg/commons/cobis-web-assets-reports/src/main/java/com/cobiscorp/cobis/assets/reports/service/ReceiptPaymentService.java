package com.cobiscorp.cobis.assets.reports.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentAccountant;
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentAmount;
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentHead;
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryReceiptPaymentWayToPay;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 * 
 */
public class ReceiptPaymentService extends BaseService {
	private static final ILogger logger = LogFactory
			.getLogger(ReceiptPaymentService.class);
	public static final Integer FORMAT_DATE = 101;

	/***
	 * Obtiene la informacion del reporte Recibo de pago
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public QueryReceiptPaymentHead queryReceiptPaymentAllInfo(
			QueryReceiptPaymentRequest queryReceiptPaymentRequest,
			ICTSServiceIntegration serviceIntegration,
			Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryReceiptPaymentAllInfo \nbank "
					+ queryReceiptPaymentRequest.getBank());
		}
		QueryReceiptPaymentHead queryReceiptPaymentHead = queryReceiptPayment(
				queryReceiptPaymentRequest, serviceIntegration);

		if (queryReceiptPaymentHead != null && queryReceiptPaymentHead.getAmountDescription() != null
				&& !queryReceiptPaymentHead.getAmountDescription().isEmpty()) {
				
				Integer secuencialReg = queryReceiptPaymentHead
					.getAmountDescription()
					.get(queryReceiptPaymentHead.getAmountDescription().size() - 1)
					.getSecuential();
				String user = queryReceiptPaymentHead
					.getAmountDescription()
					.get(queryReceiptPaymentHead.getAmountDescription().size() - 1)
					.getUser();
				Integer numRegs = queryReceiptPaymentHead.getAccountant();
				
				if (secuencialReg != null && user != null && numRegs != null
					&& numRegs > secuencialReg) {	
					queryReceiptPaymentRequest.setSecuential(secuencialReg);
					queryReceiptPaymentRequest.setUser(user);
					
					for (QueryReceiptPaymentAmount queryReceiptPaymentAmount : queryReceiptPaymentInfoAditional(
							queryReceiptPaymentRequest, serviceIntegration)) {
							queryReceiptPaymentHead.getAmountDescription().add(
								queryReceiptPaymentAmount);
					}
				}
		}
		if (queryReceiptPaymentHead != null){
			setInfoPayment(queryReceiptPaymentHead);
		    setInfoDisbursement(queryReceiptPaymentHead, params);
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****END queryReceiptPaymentAllInfo ");
		}
		return queryReceiptPaymentHead;
	}

	private void setInfoDisbursement(
			QueryReceiptPaymentHead queryReceiptPaymentHead,
			Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START setInfoDisbursement "
					+ queryReceiptPaymentHead.getDisbursement());
		}
		if (queryReceiptPaymentHead != null
				&& queryReceiptPaymentHead.getDisbursement() != null) {
			String disbursements[] = queryReceiptPaymentHead.getDisbursement()
					.split("&");
			if (disbursements != null && disbursements.length > 0) {
				params.put("numDate", 1);
				params.put("numDis", 1);
				for (int i = 0; i < disbursements.length; i++) {
					validateValue(disbursements[i], params);
				}
			}
		}
	}

	private void validateValue(String value, Map<String, Object> disbursementMap) {
		if (value == null || disbursementMap == null) {
			return;
		}
		String values[] = value.split(":");
		if (values == null || values.length <= 0) {
			return;
		}
		int numDate = (Integer) disbursementMap.get("numDate");
		int numDis = (Integer) disbursementMap.get("numDis");

		for (int i = 0; i < values.length; i++) {
			if (values[i] != null && values[i].contains("/")) {
				disbursementMap.put("Pdate" + numDate, values[i]);
				disbursementMap.put("numDate", numDate + 1);
				return;
			}
			if (values[i] != null) {
				try {
					BigDecimal disbursement = new BigDecimal(values[i].trim());
					disbursementMap.put("Pdisbursement" + numDis, disbursement
							.setScale(2, java.math.RoundingMode.HALF_UP));
					disbursementMap.put("numDis", numDis + 1);
					return;
				} catch (NumberFormatException e) {
					if (logger.isDebugEnabled())
						logger.logDebug(" *****no es numero " + values[i]);
				}
			}
		}
	}

	private void setInfoPayment(QueryReceiptPaymentHead queryReceiptPaymentHead) {
		if (queryReceiptPaymentHead != null
				&& queryReceiptPaymentHead.getWayToPay() != null) {
			if (queryReceiptPaymentHead.getAmountDescription() == null) {
				queryReceiptPaymentHead
						.setAmountDescription(new ArrayList<QueryReceiptPaymentAmount>());
			}

			for (QueryReceiptPaymentWayToPay paymentWayToPay : queryReceiptPaymentHead
					.getWayToPay()) {
				QueryReceiptPaymentAmount paymentAmount = new QueryReceiptPaymentAmount();
				paymentAmount.setIdentifies(paymentWayToPay.getAbdType());
				paymentAmount.setDescription(paymentWayToPay.getDescription());
				paymentAmount.setFee(paymentWayToPay.getAbdAccount());
				paymentAmount.setStartDate(paymentWayToPay.getAbDatePag());
				paymentAmount.setEndDate(paymentWayToPay.getAbdBeneficiary());
				paymentAmount.setRate(paymentWayToPay.getAbdQuotationMop());
				paymentAmount.setDays(paymentWayToPay.getAbdAmountMpg()
						.intValue());
				if (0 == queryReceiptPaymentHead.getCurrency()) {
					paymentAmount.setDays(0);
				} else {
					paymentAmount.setDays(paymentWayToPay.getAbdAmountMpg()
							.intValue());
				}
				paymentAmount.setAmount(paymentWayToPay.getAbdAmountMop());
				paymentAmount.setAmountMn(paymentWayToPay.getAbdAmount());

				queryReceiptPaymentHead.getAmountDescription().add(
						paymentAmount);
			}
		}
	}

	/***
	 * Obtiene la informacion del reporte Recibo de pago
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	private QueryReceiptPaymentHead queryReceiptPayment(
			QueryReceiptPaymentRequest queryReceiptPaymentRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryReceiptPayment \nbank "
					+ queryReceiptPaymentRequest.getBank());
		}
		if (queryReceiptPaymentRequest.getBank() == null) {
			return null;
		}

		ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_RECEIPT_PAYMENT);
		// Setea el objeto(Request) utilizado para la consulta del sp
		queryReceiptPaymentRequest.setOperation("C");
		queryReceiptPaymentRequest.setDateFormat(FORMAT_DATE);

		// Setea el ServiceRequestTO con el Objecto Request
		serviceReportRequestTO.getData().put(
				ConstantValue.IN_RECEIPT_PAYMENT_REQUEST,
				queryReceiptPaymentRequest);

		// Obtiene la respuesta del servicio
		ServiceResponseTO serviceResponseTo = serviceIntegration
				.getResponseFromCTS(serviceReportRequestTO);
		if (serviceResponseTo.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" *****SUCCESS SERVICE RECEIPT PAYMENT \n *****RESPONSE HEAD "
						+ (serviceResponseTo
								.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_HEAD))
						+ " \n *****RESPONSE ACCOUNTANT "
						+ (serviceResponseTo
								.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_ACCOUNTANT))
						+ " \n *****RESPONSE RETURN_RECEIPT_PAYMENT_AMOUNT "
						+ (serviceResponseTo
								.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_AMOUNT))
						+ " \n *****RESPONSE RETURN_RECEIPT_PAYMENT_WAYTOPAY "
						+ (serviceResponseTo
								.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_WAYTOPAY)));
			}
			// Si es exitosa la ejecucion se obtinene el objeto Response
			QueryReceiptPaymentHead queryReceiptPaymentHead = (QueryReceiptPaymentHead) (serviceResponseTo
					.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_HEAD));

			if (logger.isDebugEnabled()) {
				logger.logDebug(" *****START setInfoDisbursement inicial "
						+ queryReceiptPaymentHead.getDisbursement());
			}

			setReceiptPaymentHead(
					queryReceiptPaymentHead,
					(QueryReceiptPaymentAccountant) (serviceResponseTo
							.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_ACCOUNTANT)),
					(QueryReceiptPaymentAmount[]) (serviceResponseTo
							.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_AMOUNT)),
					(QueryReceiptPaymentWayToPay[]) (serviceResponseTo
							.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_WAYTOPAY)));

			return queryReceiptPaymentHead;
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug(" *****-- FALL SERVICE RECEIPT PAYMENT");
			util.error(serviceResponseTo);
			return null;
		}

	}

	private void setReceiptPaymentHead(
			QueryReceiptPaymentHead queryReceiptPaymentHead,
			QueryReceiptPaymentAccountant queryReceiptPaymentAccountant,
			QueryReceiptPaymentAmount[] receiptPaymentAmount,
			QueryReceiptPaymentWayToPay[] receiptPaymentWayToPay) {

		if (queryReceiptPaymentHead != null) {
			if (queryReceiptPaymentAccountant != null) {
				queryReceiptPaymentHead
						.setAccountant(queryReceiptPaymentAccountant
								.getAccounttantRegs());
			}

			if (receiptPaymentAmount != null) {
				queryReceiptPaymentHead
						.setAmountDescription(new ArrayList<QueryReceiptPaymentAmount>(
								Arrays.asList(receiptPaymentAmount)));
			}
			if (receiptPaymentWayToPay != null) {
				queryReceiptPaymentHead
						.setWayToPay(new ArrayList<QueryReceiptPaymentWayToPay>(
								Arrays.asList(receiptPaymentWayToPay)));
			}
		}
	}

	/***
	 * Obtiene la informacion del reporte Recibo de pago
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	private List<QueryReceiptPaymentAmount> queryReceiptPaymentInfoAditional(
			QueryReceiptPaymentRequest queryReceiptPaymentRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryReceiptPaymentInfoAditional \nbank "
					+ queryReceiptPaymentRequest.getBank());
		}
		if (queryReceiptPaymentRequest.getBank() == null) {
			return new ArrayList<QueryReceiptPaymentAmount>();
		}
		ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_RECEIPT_PAYMENT_INFO);
		// Setea el objeto(Request) utilizado para la consulta del sp
		queryReceiptPaymentRequest.setOperation("L");
		queryReceiptPaymentRequest.setDateFormat(FORMAT_DATE);

		// Setea el ServiceRequestTO con el Objecto Request
		serviceReportRequestTO.getData().put(
				ConstantValue.IN_RECEIPT_PAYMENT_REQUEST,
				queryReceiptPaymentRequest);
		// Obtiene la respuesta del servicio
		ServiceResponseTO serviceResponseTo = serviceIntegration
				.getResponseFromCTS(serviceReportRequestTO);
		if (serviceResponseTo.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" *****SUCCESS SERVICE RECEIPT PAYMENT"
						+ (serviceResponseTo
								.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_AMOUNT)));
			}
			// Si es exitosa la ejecucion se obtinene el objeto Response
			QueryReceiptPaymentAmount[] receiptPaymentAmount = (QueryReceiptPaymentAmount[]) (serviceResponseTo
					.getValue(ConstantValue.RETURN_RECEIPT_PAYMENT_AMOUNT));
			if (receiptPaymentAmount != null) {
				return new ArrayList<QueryReceiptPaymentAmount>(
						Arrays.asList(receiptPaymentAmount));
			}

		} else {
			if (logger.isDebugEnabled())
				logger.logDebug(" *****-- FALL SERVICE RECEIPT PAYMENT ADITIONAL");
			util.error(serviceResponseTo);
		}

		return new ArrayList<QueryReceiptPaymentAmount>();
	}

}
