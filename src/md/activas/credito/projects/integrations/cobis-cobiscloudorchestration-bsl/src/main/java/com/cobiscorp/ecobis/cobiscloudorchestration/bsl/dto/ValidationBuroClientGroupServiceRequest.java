/**
 * Archivo: public class ValidationBuroClientGroupServiceRequest 
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
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;


public class ValidationBuroClientGroupServiceRequest  extends CobisCloudServiceRequest {

  private BuroClientGroupRequest inBuroClientGroupRequest;
  
  public ValidationBuroClientGroupServiceRequest() {
    //Empty contructor in order to build basic DTO
  }

  public ValidationBuroClientGroupServiceRequest(Map objectMap) {
     super(objectMap); 
    Map wInBuroClientGroupRequestMap = (Map)objectMap.get("inBuroClientGroupRequest");
    if(wInBuroClientGroupRequestMap != null) {
      BuroClientGroupRequest wInBuroClientGroupRequest = new BuroClientGroupRequest(wInBuroClientGroupRequestMap);
      setInBuroClientGroupRequest(wInBuroClientGroupRequest);
    }
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
     Map objectMapSupper = super.toMap(); objectMap.putAll(objectMapSupper); 
    if (getInBuroClientGroupRequest() != null) {
      objectMap.put("inBuroClientGroupRequest", getInBuroClientGroupRequest().toMap());
    }
    return objectMap;
  }
  
	/** 
	* returns  inBuroClientGroupRequest
	*/	
	public BuroClientGroupRequest getInBuroClientGroupRequest() {
    	return this.inBuroClientGroupRequest;
    }

    public void setInBuroClientGroupRequest( BuroClientGroupRequest aInBuroClientGroupRequest) {
    	this.inBuroClientGroupRequest = aInBuroClientGroupRequest;
    }


@Override
  public String toString() {
		return toMap().toString();
  }
}
