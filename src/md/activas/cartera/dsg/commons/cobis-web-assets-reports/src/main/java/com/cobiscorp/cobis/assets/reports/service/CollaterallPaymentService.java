package com.cobiscorp.cobis.assets.reports.service;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.dto.CollateralResponseDTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.GroupInfoResponse;
import cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.PaymentDetGarResponse;
import cobiscorp.ecobis.assets.cloud.dto.ReferenceResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class CollaterallPaymentService extends BaseService {

	private static final ILogger logger = LogFactory.getLogger(CollaterallPaymentService.class);

	public List<CollateralResponseDTO> queryCollateralPayment(GroupPaymentRequest groupPaymentRequest, ICTSServiceIntegration serviceIntegration) {
		GroupInfoResponse[] groupInfoResponse = null;
		ReferenceResponse[] referencesResponse = null;
		PaymentDetGarResponse[] paymentDetGraResponse = null;
		ServiceResponseTO serviceResponseTo = null;
		List<CollateralResponseDTO> collateralResponse = new ArrayList<CollateralResponseDTO>();

		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_READ_LIQUID_COLLATERAL);
			serviceReportRequestTO.getData().put(ConstantValue.IN_GROUP_PAYMENT_REQUEST, groupPaymentRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					groupInfoResponse = (GroupInfoResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_GROUP_INFO_RESPONSE);
					referencesResponse = (ReferenceResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_REFERENCE_RESPONSE);
					paymentDetGraResponse = (PaymentDetGarResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_PAYMENT_DET_GAR_RESPONSE);
					for (GroupInfoResponse groupInfo : groupInfoResponse) {
						List<ReferenceResponse> references = new ArrayList<ReferenceResponse>();
						for (ReferenceResponse reference : referencesResponse) {
							logger.logDebug("Group id: " + groupInfo.getGroupId());
							logger.logDebug("Client id: " + reference.getClientid());
							if (groupInfo.getGroupId() != null && reference.getClientid() != null && groupInfo.getGroupId().intValue() == reference.getClientid().intValue()) {
								logger.logDebug(reference.getInstitution() + "-" + reference.getReferenceString());
								references.add(reference);
							}
						}
						logger.logDebug("Inicia detalle de pagos ");
						List<PaymentDetGarResponse> listPaymentsGar = new ArrayList<PaymentDetGarResponse>();
						for (PaymentDetGarResponse paymentGar : paymentDetGraResponse) {
							logger.logDebug("Group id: " + groupInfo.getGroupId());
							logger.logDebug("payment id: " + paymentGar.getGroupId());
							if (groupInfo.getGroupId() != null && paymentGar.getGroupId() != null && groupInfo.getGroupId().intValue() == paymentGar.getGroupId().intValue()) {
								logger.logDebug(paymentGar.getCustumerName() + "-" + paymentGar.getSafeAmount() + "-" + paymentGar.getMedicalAssitanceAmount() + "-"
										+ paymentGar.getGuaranteeAmount());
								listPaymentsGar.add(paymentGar);
							}
						}
						collateralResponse.add(new CollateralResponseDTO(groupInfo, references, listPaymentsGar));
					}

				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Error ejecucion servicio queryCollateralPayment");
					}
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled()) {
				logger.logError("Error en queryCollateralPayment: " + ex);

			}
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza queryCollateralPayment");
			}
		}
		return collateralResponse;
	}
}
