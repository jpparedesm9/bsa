/**
 * Archivo: public class ValidationProspectRequest 
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

public class ValidationProspectRequest {

	private Integer customerId;
	private Integer procedureNumber;
	private String checkRenapo;
	private Integer instProc;
	private Integer channel;
	private Integer daysValidityBureau;
	private String reqProdNumber;
	private Integer validDays;

	public ValidationProspectRequest() {

	}

	public ValidationProspectRequest(Map objectMap) {

		Integer wCustomerId = (Integer) objectMap.get("customerId");
		setCustomerId(wCustomerId);

		Integer wChannel = (Integer) objectMap.get("channel");
		setChannel(wChannel);

		Integer wDaysValidityBureau = (Integer) objectMap.get("daysValidityBureau");
		setDaysValidityBureau(wDaysValidityBureau);
	}

	public Map toMap() {
		Map objectMap = new HashMap();
		Integer wCustomerId = getCustomerId();
		objectMap.put("customerId", wCustomerId);
		objectMap.put("procedureNumber", getProcedureNumber());
		objectMap.put("instProc", getInstProc());
		objectMap.put("channel", getChannel());
		objectMap.put("daysValidityBureau", getDaysValidityBureau());
		return objectMap;
	}

	/**
	 * returns customerId
	 */
	public Integer getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(Integer aCustomerId) {
		this.customerId = aCustomerId;
	}

	public Integer getProcedureNumber() {
		return procedureNumber;
	}

	public void setProcedureNumber(Integer procedureNumber) {
		this.procedureNumber = procedureNumber;
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

	public Integer getInstProc() {
		return instProc;
	}

	public void setInstProc(Integer instProc) {
		this.instProc = instProc;
	}

	public Integer getChannel() {
		return channel;
	}

	public void setChannel(Integer channel) {
		this.channel = channel;
	}

	public Integer getDaysValidityBureau() {
		return daysValidityBureau;
	}

	public void setDaysValidityBureau(Integer daysValidityBureau) {
		this.daysValidityBureau = daysValidityBureau;
	}

	public String getReqProdNumber() {
		return reqProdNumber;
	}

	public void setReqProdNumber(String reqProdNumber) {
		this.reqProdNumber = reqProdNumber;
	}

	public Integer getValidDays() {
		return validDays;
	}

	public void setValidDays(Integer validDays) {
		this.validDays = validDays;
	}

}
