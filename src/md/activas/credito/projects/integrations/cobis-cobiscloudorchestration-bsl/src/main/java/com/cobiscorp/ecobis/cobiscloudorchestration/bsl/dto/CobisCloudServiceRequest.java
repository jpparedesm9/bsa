/**
 * Archivo: public class CobisCloudServiceRequest 
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



public class CobisCloudServiceRequest {

  private Boolean online;

  public CobisCloudServiceRequest() {
    //Empty contructor in order to build basic DTO
  }

  public CobisCloudServiceRequest(Map objectMap) {
    
    Boolean wOnline = (Boolean)objectMap.get("online");
    setOnline(wOnline);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    Boolean wOnline = getOnline();
    objectMap.put("online", wOnline);
    return objectMap;
  }
  
	/** 
	* returns  online
	*/	
	public Boolean getOnline() {
    	return this.online;
    }

    public void setOnline( Boolean aOnline) {
    	this.online = aOnline;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
