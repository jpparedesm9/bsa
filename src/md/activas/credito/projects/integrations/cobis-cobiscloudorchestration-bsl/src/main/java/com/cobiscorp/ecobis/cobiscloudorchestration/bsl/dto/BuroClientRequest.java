/**
 * Archivo: public class BuroClientRequest 
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

import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerData;

public class BuroClientRequest {

	private Integer clientId;
	private CustomerData customerData;
	private Integer groupId;
	private Boolean isProspect;
	private Integer procedureNumber;
	private Integer instProc;
	private Integer channel;
	private Integer daysValidityBureau;

	public BuroClientRequest() {
		// Empty contructor in order to build basic DTO
	}

	public BuroClientRequest(Map objectMap) {

		Integer wClientId = (Integer) objectMap.get("clientId");
		setClientId(wClientId);

		CustomerData wCustomerData = (CustomerData) objectMap.get("customerData");
		setCustomerData(wCustomerData);

		Integer wGroupId = (Integer) objectMap.get("groupId");
		setGroupId(wGroupId);

		Boolean wIsProspect = (Boolean) objectMap.get("isProspect");
		setIsProspect(wIsProspect);

		Integer wChannel = (Integer) objectMap.get("channel");
		setChannel(wChannel);

		Integer wDaysValidityBureau = (Integer) objectMap.get("daysValidityBureau");
		setDaysValidityBureau(wDaysValidityBureau);
	}

	public Map toMap() {
		Map objectMap = new HashMap();

		Integer wClientId = getClientId();
		objectMap.put("clientId", wClientId);

		CustomerData wCustomerData = getCustomerData();
		objectMap.put("customerData", wCustomerData);

		Integer wGroupId = getGroupId();
		objectMap.put("groupId", wGroupId);

		Boolean wIsProspect = getIsProspect();
		objectMap.put("isProspect", wIsProspect);
		objectMap.put("procedureName", getProcedureNumber());
		objectMap.put("instProc", getInstProc());
		objectMap.put("channel", getChannel());
		objectMap.put("daysValidityBureau", getDaysValidityBureau());
		return objectMap;
	}

	/**
	 * returns clientId
	 */
	public Integer getClientId() {
		return this.clientId;
	}

	/**
	 * returns customerData
	 */
	public CustomerData getCustomerData() {
		return this.customerData;
	}

	/**
	 * returns groupId
	 */
	public Integer getGroupId() {
		return this.groupId;
	}

	/**
	 * returns isProspect
	 */
	public Boolean getIsProspect() {
		return this.isProspect;
	}

	public void setClientId(Integer aClientId) {
		this.clientId = aClientId;
	}

	public void setCustomerData(CustomerData aCustomerData) {
		this.customerData = aCustomerData;
	}

	public void setGroupId(Integer aGroupId) {
		this.groupId = aGroupId;
	}

	public void setIsProspect(Boolean aIsProspect) {
		this.isProspect = aIsProspect;
	}

	public Integer getProcedureNumber() {
		return procedureNumber;
	}

	public void setProcedureNumber(Integer procedureNumber) {
		this.procedureNumber = procedureNumber;
	}

	public Integer getInstProc() {
		return instProc;
	}

	public void setInstProc(Integer instProc) {
		this.instProc = instProc;
	}

	@Override
	public String toString() {
		return toMap().toString();
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

}
