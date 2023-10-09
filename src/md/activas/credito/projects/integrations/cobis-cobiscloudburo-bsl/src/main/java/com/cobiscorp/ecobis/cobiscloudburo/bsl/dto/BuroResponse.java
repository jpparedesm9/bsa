/**
 * Archivo: public class BuroResponse 
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

package com.cobiscorp.ecobis.cobiscloudburo.bsl.dto;

import java.util.HashMap;
import java.util.Map;

public class BuroResponse {

	private String operationType;
	private Boolean problemConsultingBuro;
	private Boolean searchBuro; // Variable que indica si evalua o no las reglas

	// private String riskScore;

	public BuroResponse() {
		// Empty contructor in order to build basic DTO
	}

	public BuroResponse(Map objectMap) {

		String wOperationType = (String) objectMap.get("operationType");
		setOperationType(wOperationType);

		Boolean wProblemConsultingBuro = (Boolean) objectMap.get("problemConsultingBuro");
		setProblemConsultingBuro(wProblemConsultingBuro);

		Boolean wSearchBuro = (Boolean) objectMap.get("searchBuro");
		setProblemConsultingBuro(wSearchBuro);

		/*
		 * String wRiskScore = (String)objectMap.get("riskScore");
		 * setRiskScore(wRiskScore);
		 */
	}

	public Map toMap() {
		Map objectMap = new HashMap();

		String wOperationType = getOperationType();
		objectMap.put("operationType", wOperationType);

		/*
		 * String wRiskScore = getRiskScore(); objectMap.put("riskScore", wRiskScore);
		 */

		Boolean wProblemConsultingBuro = getProblemConsultingBuro();
		objectMap.put("problemConsultingBuro", wProblemConsultingBuro);

		Boolean wSearchBuro = getSearchBuro();
		objectMap.put("searchBuro", wSearchBuro);

		return objectMap;
	}

	/**
	 * returns operationType
	 */
	public String getOperationType() {
		return this.operationType;
	}

	/**
	 * returns riskScore
	 */
	/*
	 * public String getRiskScore() { return this.riskScore; }
	 */

	public void setOperationType(String aOperationType) {
		this.operationType = aOperationType;
	}

	/*
	 * public void setRiskScore( String aRiskScore) { this.riskScore = aRiskScore; }
	 */

	public Boolean getProblemConsultingBuro() {
		return problemConsultingBuro;
	}

	public void setProblemConsultingBuro(Boolean problemConsultingBuro) {
		this.problemConsultingBuro = problemConsultingBuro;
	}

	public Boolean getSearchBuro() {
		return searchBuro;
	}

	public void setSearchBuro(Boolean searchBuro) {
		this.searchBuro = searchBuro;
	}

	@Override
	public String toString() {
		return toMap().toString();
	}

}
