/**
 * Archivo: public class BuroClientGroupRequest 
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
import java.util.ArrayList;

public class BuroClientGroupRequest {

	private java.util.List clientIds;

	private Integer groupId;
	private Integer channel;

	public BuroClientGroupRequest() {
		// Empty contructor in order to build basic DTO
	}

	public BuroClientGroupRequest(Map objectMap) {

		Integer wGroupId = (Integer) objectMap.get("groupId");
		setGroupId(wGroupId);

		Integer wChannel = (Integer) objectMap.get("channel");
		setGroupId(wChannel);
	}

	public Map toMap() {
		Map objectMap = new HashMap();

		Integer wGroupId = getGroupId();
		objectMap.put("groupId", wGroupId);

		Integer wChannel = getChannel();
		objectMap.put("channel", wChannel);
		
		return objectMap;
	}

	/**
	 * returns clientIds
	 */
	public java.util.List getClientIds() {
		return this.clientIds;
	}

	/**
	 * returns groupId
	 */
	public Integer getGroupId() {
		return this.groupId;
	}

	public void setClientIds(java.util.List aClientIds) {
		this.clientIds = aClientIds;
	}

	public void setGroupId(Integer aGroupId) {
		this.groupId = aGroupId;
	}

	public Integer getChannel() {
		return channel;
	}

	public void setChannel(Integer channel) {
		this.channel = channel;
	}

	@Override
	public String toString() {
		return toMap().toString();
	}
}
