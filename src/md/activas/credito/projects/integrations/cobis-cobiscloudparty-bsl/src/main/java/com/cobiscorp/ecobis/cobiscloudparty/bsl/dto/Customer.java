/**
 * Archivo: public class Customer 
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

package com.cobiscorp.ecobis.cobiscloudparty.bsl.dto;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Name;


public class Customer {

  private Name name;

  public Customer() {
    //Empty contructor in order to build basic DTO
  }

  public Customer(Map objectMap) {
    
    Map wNameMap = (Map)objectMap.get("name");
    if(wNameMap != null) {
      Name wName = new Name(wNameMap);
      setName(wName);
    }
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    if (getName() != null) {
      objectMap.put("name", getName().toMap());
    }
    return objectMap;
  }
  
	/** 
	* returns  name
	*/	
	public Name getName() {
    	return this.name;
    }

    public void setName( Name aName) {
    	this.name = aName;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
