/**
 * Archivo: public interface IOrchestrationClientValidationService 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

public interface IOrchestrationClientValidationService {
	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse validate(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest);
	
	OrchestrationClientValidationResponse blackListValidation(ValidationProspectServiceRequest aValidationRequestServiceRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse validateBuro(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse validateSantander(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse validateSantanderWithOutUpdate(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest);

	void getMatrixRulesInfoForGroup(ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest);

	void getSantanderInfoForGroup(ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest);

	java.util.List validateBuroClientGroup(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse validateBuroClientGroupRule(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aBuroClientRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse validateBuroClientIndividualRule(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse validateSantanderWithoutValidation(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest);

	ServiceResponseTO getMatrixRulesInfoForClient(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest)
			throws Exception;

	ServiceResponseTO validateAccountAndBucFromSantander(ServiceRequestTO serviceRequesTO) throws Exception;

	ServiceResponseTO validateBuroFromSantander(String processInstanceId) throws Exception;

	public abstract OrchestrationClientValidationResponse customerEvaluation(
			ValidationProspectServiceRequest aValidationRequestServiceRequest);

	com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse clientEvaluation(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest);
}
