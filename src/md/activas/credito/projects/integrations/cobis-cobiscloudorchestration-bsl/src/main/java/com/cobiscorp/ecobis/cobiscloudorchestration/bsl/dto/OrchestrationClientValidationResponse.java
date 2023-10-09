/**
 * Archivo: public class OrchestrationClientValidationResponse 
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

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.math.BigDecimal;
import java.util.ArrayList;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;

import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;

public class OrchestrationClientValidationResponse {

	private BuroExecutionResponse buroResponse;
	private CustomerCoreInfo customerCoreInfo;
	private String checkRenapo;
	private String curp;
	private String evaluation;
	private String qualification;
	private Double amountApproved;
	private String blackList;
	private String riskLevel;
	private Boolean problemBuro;
	private Integer validDays;

	public OrchestrationClientValidationResponse() {
		// Empty contructor in order to build basic DTO
	}

	public OrchestrationClientValidationResponse(Map objectMap) {

		Map wBuroResponseMap = (Map) objectMap.get("buroResponse");
		if (wBuroResponseMap != null) {
			BuroExecutionResponse wBuroResponse = new BuroExecutionResponse(wBuroResponseMap);
			setBuroResponse(wBuroResponse);
		}

		CustomerCoreInfo wCustomerCoreInfo = (CustomerCoreInfo) objectMap.get("customerCoreInfo");
		setCustomerCoreInfo(wCustomerCoreInfo);
	}

	public Map toMap() {
		Map objectMap = new HashMap();

		if (getBuroResponse() != null) {
			objectMap.put("buroResponse", getBuroResponse().toMap());
		}

		CustomerCoreInfo wCustomerCoreInfo = getCustomerCoreInfo();
		objectMap.put("customerCoreInfo", wCustomerCoreInfo);
		return objectMap;
	}

	/**
	 * returns buroResponse
	 */
	public BuroExecutionResponse getBuroResponse() {
		return this.buroResponse;
	}

	/**
	 * returns customerCoreInfo
	 */
	public CustomerCoreInfo getCustomerCoreInfo() {
		return this.customerCoreInfo;
	}

	public void setBuroResponse(BuroExecutionResponse aBuroResponse) {
		this.buroResponse = aBuroResponse;
	}

	public void setCustomerCoreInfo(CustomerCoreInfo aCustomerCoreInfo) {
		this.customerCoreInfo = aCustomerCoreInfo;
	}

	@Override
	public String toString() {
		return toMap().toString();
	}

	public String getCheckRenapo() {
		return checkRenapo;
	}

	public void setCheckRenapo(String checkRenapo) {
		this.checkRenapo = checkRenapo;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public String getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(String evaluation) {
		this.evaluation = evaluation;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public Double getAmountApproved() {
		return amountApproved;
	}

	public void setAmountApproved(Double amountApproved) {
		this.amountApproved = amountApproved;
	}

	public String getBlackList() {
		return blackList;
	}

	public void setBlackList(String blackList) {
		this.blackList = blackList;
	}

	public String getRiskLevel() {
		return riskLevel;
	}

	public void setRiskLevel(String riskLevel) {
		this.riskLevel = riskLevel;
	}

	public Boolean getProblemBuro() {
		return problemBuro;
	}

	public void setProblemBuro(Boolean problemBuro) {
		this.problemBuro = problemBuro;
	}

	public Integer getValidDays() {
		return validDays;
	}

	public void setValidDays(Integer validDays) {
		this.validDays = validDays;
	}

}
