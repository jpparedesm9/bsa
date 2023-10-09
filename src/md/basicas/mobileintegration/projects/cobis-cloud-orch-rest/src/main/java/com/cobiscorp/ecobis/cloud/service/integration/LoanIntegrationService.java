package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.util.DataTypeUtil.toDouble;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;

import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.LoanSimulationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.simulation.LoanSimulationResponse;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import cobiscorp.ecobis.assets.cloud.dto.LoanSimulatorRequest;
import cobiscorp.ecobis.assets.cloud.dto.LoanSimulatorResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.individualloan.dto.SimulationRequestDTO;
import cobiscorp.ecobis.individualloan.dto.SimulationResponseDTO;

public class LoanIntegrationService extends RestServiceBase {

	private ILogger LOGGER = LogFactory.getLogger(LoanIntegrationService.class);
	
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

    public LoanIntegrationService(ICTSServiceIntegration integration) {
        super(integration);
    }

    public LoanAmortizationTableResponse createAmortizationTable(LoanSimulatorRequest request) {
        ServiceRequestTO requestTo = new ServiceRequestTO();
        requestTo.addValue("inLoanSimulatorRequest", request);
        ServiceResponse response = execute("Loan.LoanMaintenance.LoanSimulatorServices", requestTo);
        if(response != null) {
            LoanAmortizationTableResponse resultData = new LoanAmortizationTableResponse();
            resultData.setRate(toDouble(extractOutputValue(response, "@o_tasa", String.class)));
            resultData.setEntries(extractValue(response, "returnLoanSimulatorResponse", LoanSimulatorResponse[].class));
            return resultData;
        }
        return null;
    }

	
	public LoanSimulationResponse simulate(LoanSimulationRequest simulationRequest) {
		LoanSimulationResponse object = new LoanSimulationResponse();
		ServiceRequestTO requestTo = new ServiceRequestTO();
		SimulationRequestDTO simulationRequestDto = new SimulationRequestDTO();
		LOGGER.logDebug(">>>>>>>>>>>metodo simulate ");
		LOGGER.logDebug(">>>>>>>>>>>metodo simulate -- llamar al servicio");
		simulationRequestDto.setAmount(simulationRequest.getAmount());
		simulationRequestDto.setClient(simulationRequest.getClient());
		simulationRequestDto.setCurrency(simulationRequest.getCurrency());
		simulationRequestDto.setIniDate(simulationRequest.getIniDate());
		simulationRequestDto.setOperationType(simulationRequest.getOperationType());
		simulationRequestDto.setPeriodicity(simulationRequest.getPeriodicity());
		simulationRequestDto.setRate(simulationRequest.getRate());
		simulationRequestDto.setTerm(simulationRequest.getTerm());
		simulationRequestDto.setChannel(simulationRequest.getChannel());
		simulationRequestDto.setPromotion(simulationRequest.getPromotion());
		requestTo.addValue("inSimulationRequestDTO", simulationRequestDto);
		ServiceResponse response = execute("IndividualLoan.OnBoarding.SimulationTableAmortization", requestTo);
		if (response != null) {			
			SimulationResponseDTO[] resulset = extractValue(response, "returnSimulationResponseDTO", SimulationResponseDTO[].class);			
			for (SimulationResponseDTO li: resulset) {				
				object.setAmountPay(li.getAmountPay());
				object.setCurrency(Double.valueOf(li.getCurrency()));
				object.setRate(li.getRate());				
			}
			return object;
		}
		return null;
	}
	
    public static class LoanAmortizationTableResponse {
        private Double rate;
        private LoanSimulatorResponse[] entries;

        public Double getRate() {
            return rate;
        }

        public void setRate(Double rate) {
            this.rate = rate;
        }

        public LoanSimulatorResponse[] getEntries() {
            return entries;
        }

        public void setEntries(LoanSimulatorResponse[] entries) {
            this.entries = entries;
        }
    }
}
