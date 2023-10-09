/**
 * Archivo: public class ValidationProspectServiceRequest 
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
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;


public class ValidationProspectServiceRequest  extends CobisCloudServiceRequest {

  private ValidationProspectRequest inValidationProspectRequest;

  public ValidationProspectServiceRequest() {
	  inValidationProspectRequest = new ValidationProspectRequest();
    //Empty contructor in order to build basic DTO
  }

  public ValidationProspectServiceRequest(Map objectMap) {
     super(objectMap); 
    Map wInValidationProspectRequestMap = (Map)objectMap.get("inValidationProspectRequest");
    if(wInValidationProspectRequestMap != null) {
      ValidationProspectRequest wInValidationProspectRequest = new ValidationProspectRequest(wInValidationProspectRequestMap);
      setInValidationProspectRequest(wInValidationProspectRequest);
    }
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
     Map objectMapSupper = super.toMap(); objectMap.putAll(objectMapSupper); 
    if (getInValidationProspectRequest() != null) {
      objectMap.put("inValidationProspectRequest", getInValidationProspectRequest().toMap());
    }
    return objectMap;
  }

	/** 
	* returns  inValidationProspectRequest
	*/	
	public ValidationProspectRequest getInValidationProspectRequest() {
    	return this.inValidationProspectRequest;
    }

    public void setInValidationProspectRequest( ValidationProspectRequest aInValidationProspectRequest) {
    	this.inValidationProspectRequest = aInValidationProspectRequest;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
