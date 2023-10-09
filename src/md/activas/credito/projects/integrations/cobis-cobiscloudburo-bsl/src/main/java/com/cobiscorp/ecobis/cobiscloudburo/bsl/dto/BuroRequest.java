/**
 * Archivo: public class BuroRequest 
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

import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Name;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Residence;

public class BuroRequest {

	private Integer idCobis;
	private Name name;
	private Residence residence;
	private Integer procedureNumber;
	private Integer instProc;
	private Integer channel;
	private String productRequired;
	private Integer expirationDays;

	public BuroRequest() {
		// Empty contructor in order to build basic DTO
	}

	public BuroRequest(Map objectMap) {

		Integer wIdCobis = (Integer) objectMap.get("idCobis");
		setIdCobis(wIdCobis);

		Name wName = (Name) objectMap.get("name");
		setName(wName);

		Residence wResidence = (Residence) objectMap.get("residence");
		setResidence(wResidence);

		Integer wChannel = (Integer) objectMap.get("channel");
		setChannel(wChannel);

		Integer wExpirationDays = (Integer) objectMap.get("expirationDays");
		setExpirationDays(wExpirationDays);
	}

	public Map toMap() {
		Map objectMap = new HashMap();
		Integer wIdCobis = getIdCobis();
		objectMap.put("idCobis", wIdCobis);
		Name wName = getName();
		objectMap.put("name", wName);
		Residence wResidence = getResidence();
		objectMap.put("residence", wResidence);
		objectMap.put("procedureName", getProcedureNumber());
		objectMap.put("instProc", getInstProc());
		objectMap.put("channel", getChannel());
		objectMap.put("productReq", getProductRequired());
		objectMap.put("expirationDays", getExpirationDays());

		return objectMap;
	}

	/**
	 * returns idCobis
	 */
	public Integer getIdCobis() {
		return this.idCobis;
	}

	/**
	 * returns name
	 */
	public Name getName() {
		return this.name;
	}

	/**
	 * returns residence
	 */
	public Residence getResidence() {
		return this.residence;
	}

	public void setIdCobis(Integer aIdCobis) {
		this.idCobis = aIdCobis;
	}

	public void setName(Name aName) {
		this.name = aName;
	}

	public Integer getProcedureNumber() {
		return procedureNumber;
	}

	public void setProcedureNumber(Integer procedureNumber) {
		this.procedureNumber = procedureNumber;
	}

	public void setResidence(Residence aResidence) {
		this.residence = aResidence;
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

	public String getProductRequired() {
		return productRequired;
	}

	public void setProductRequired(String productRequired) {
		this.productRequired = productRequired;
	}

	public Integer getExpirationDays() {
		return expirationDays;
	}

	public void setExpirationDays(Integer expirationDays) {
		this.expirationDays = expirationDays;
	}

	@Override
	public String toString() {
		return toMap().toString();
	}

}
