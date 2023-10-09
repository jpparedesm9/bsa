/**
 * Archivo: public class SearchCustomerInfo 
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



public class SearchCustomerInfo  extends Customer {

  private java.util.Date dateOfBirth;

  public SearchCustomerInfo() {
    //Empty contructor in order to build basic DTO
  }

  public SearchCustomerInfo(Map objectMap) {
     super(objectMap); 
    java.util.Date wDateOfBirth = (java.util.Date)objectMap.get("dateOfBirth");
    setDateOfBirth(wDateOfBirth);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
     Map objectMapSupper = super.toMap(); objectMap.putAll(objectMapSupper); 
    java.util.Date wDateOfBirth = getDateOfBirth();
    objectMap.put("dateOfBirth", wDateOfBirth);
    return objectMap;
  }
  
	/** 
	* returns  dateOfBirth
	*/	
	public java.util.Date getDateOfBirth() {
    	return this.dateOfBirth;
    }

    public void setDateOfBirth( java.util.Date aDateOfBirth) {
    	this.dateOfBirth = aDateOfBirth;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
