/**
 * Archivo: public class DeviceRegistrationData 
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

package com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;



public class DeviceRegistrationData {

  private String alias;

  private String description;

  public DeviceRegistrationData() {
    //Empty contructor in order to build basic DTO
  }

  public DeviceRegistrationData(Map objectMap) {
    
    String wAlias = (String)objectMap.get("alias");
    setAlias(wAlias);

    String wDescription = (String)objectMap.get("description");
    setDescription(wDescription);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wAlias = getAlias();
    objectMap.put("alias", wAlias);

    String wDescription = getDescription();
    objectMap.put("description", wDescription);
    return objectMap;
  }
  
	/** 
	* returns  alias
	*/	
	public String getAlias() {
    	return this.alias;
    }

	/** 
	* returns  description
	*/	
	public String getDescription() {
    	return this.description;
    }

    public void setAlias( String aAlias) {
    	this.alias = aAlias;
    }

    public void setDescription( String aDescription) {
    	this.description = aDescription;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
