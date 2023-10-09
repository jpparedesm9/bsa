/**
 * Archivo: public class BuroExecutionResponse 
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

package com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto;

import java.util.HashMap;
import java.util.Map;

public class BuroExecutionResponse {

	private Integer clientId;

	// private Integer riskScore;

	private String ruleExecutionResult;

	private String ruleIndividualRiskResult;

	private Integer listBlackCustomer;

	private Boolean problemConsultingBuro;

	private Integer validityDaysBureau;

	public BuroExecutionResponse() {
		// Empty contructor in order to build basic DTO
	}

	public BuroExecutionResponse(Map objectMap) {

		Integer wClientId = (Integer) objectMap.get("clientId");
		setClientId(wClientId);

		/*
		 * Integer wRiskScore = (Integer)objectMap.get("riskScore");
		 * setRiskScore(wRiskScore);
		 */

		String wRuleExecutionResult = (String) objectMap.get("ruleExecutionResult");
		setRuleExecutionResult(wRuleExecutionResult);

		String wruleIndividualRiskResult = (String) objectMap.get("ruleIndividualRiskResult");
		setRuleIndividualRiskResult(wruleIndividualRiskResult);

		Integer wListBlackCustomer = (Integer) objectMap.get("listBlackCustomer");
		setListBlackCustomer(wListBlackCustomer);

		Boolean wProblemConsultingBuro = (Boolean) objectMap.get("problemConsultingBuro");
		setProblemConsultingBuro(wProblemConsultingBuro);

		Integer wValidityDaysBureau = (Integer) objectMap.get("validityDaysBureau");
		setValidityDaysBureau(wValidityDaysBureau);
	}

	public Map toMap() {
		Map objectMap = new HashMap();

		Integer wClientId = getClientId();
		objectMap.put("clientId", wClientId);

		/*
		 * Integer wRiskScore = getRiskScore(); objectMap.put("riskScore", wRiskScore);
		 */

		String wRuleExecutionResult = getRuleExecutionResult();
		objectMap.put("ruleExecutionResult", wRuleExecutionResult);

		String wRuleIndividualRiskResult = getRuleIndividualRiskResult();
		objectMap.put("ruleIndividualRiskResult", wRuleIndividualRiskResult);

		Integer wListBlackCustomer = getListBlackCustomer();
		objectMap.put("listBlackCustomer", wListBlackCustomer);

		Boolean wProblemConsultingBuro = getProblemConsultingBuro();
		objectMap.put("problemConsultingBuro", wProblemConsultingBuro);

		Integer wValidityDaysBureau = getValidityDaysBureau();
		objectMap.put("wValidityDaysBureau", wValidityDaysBureau);

		return objectMap;
	}

	/**
	 * returns clientId
	 */
	public Integer getClientId() {
		return this.clientId;
	}

	/**
	 * returns riskScore
	 */
	/*
	 * public Integer getRiskScore() { return this.riskScore; }
	 */

	/**
	 * returns ruleExecutionResult
	 */
	public String getRuleExecutionResult() {
		return this.ruleExecutionResult;
	}

	/**
	 * returns ruleIndividualRiskResult
	 */
	public String getRuleIndividualRiskResult() {
		return this.ruleIndividualRiskResult;
	}

	public void setClientId(Integer aClientId) {
		this.clientId = aClientId;
	}

	/*
	 * public void setRiskScore( Integer aRiskScore) { this.riskScore = aRiskScore;
	 * }
	 */

	public void setRuleExecutionResult(String aRuleExecutionResult) {
		this.ruleExecutionResult = aRuleExecutionResult;
	}

	public void setRuleIndividualRiskResult(String aRuleIndividualRiskResult) {
		this.ruleIndividualRiskResult = aRuleIndividualRiskResult;
	}

	public Integer getListBlackCustomer() {
		return listBlackCustomer;
	}

	public void setListBlackCustomer(Integer listBlackCustomer) {
		this.listBlackCustomer = listBlackCustomer;
	}

	public Boolean getProblemConsultingBuro() {
		return problemConsultingBuro;
	}

	public void setProblemConsultingBuro(Boolean problemConsultingBuro) {
		this.problemConsultingBuro = problemConsultingBuro;
	}

	public Integer getValidityDaysBureau() {
		return validityDaysBureau;
	}

	public void setValidityDaysBureau(Integer validityDaysBureau) {
		this.validityDaysBureau = validityDaysBureau;
	}

	@Override
	public String toString() {
		return toMap().toString();
	}

}
