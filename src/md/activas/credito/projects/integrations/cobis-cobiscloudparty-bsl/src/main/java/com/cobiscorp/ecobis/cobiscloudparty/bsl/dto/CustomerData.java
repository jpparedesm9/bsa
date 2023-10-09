/**
 * Archivo: public class CustomerData 
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
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Residence;


public class CustomerData implements Cloneable{ //a

  private java.util.Date dateOfBirth;

  private Name name;

  private Residence residence;

  public CustomerData() {
    //Empty contructor in order to build basic DTO
  }

  public CustomerData(Map objectMap) {
    
    java.util.Date wDateOfBirth = (java.util.Date)objectMap.get("dateOfBirth");
    setDateOfBirth(wDateOfBirth);

    Map wNameMap = (Map)objectMap.get("name");
    if(wNameMap != null) {
      Name wName = new Name(wNameMap);
      setName(wName);
    }

    Map wResidenceMap = (Map)objectMap.get("residence");
    if(wResidenceMap != null) {
      Residence wResidence = new Residence(wResidenceMap);
      setResidence(wResidence);
    }
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    java.util.Date wDateOfBirth = getDateOfBirth();
    objectMap.put("dateOfBirth", wDateOfBirth);

    if (getName() != null) {
      objectMap.put("name", getName().toMap());
    }

    if (getResidence() != null) {
      objectMap.put("residence", getResidence().toMap());
    }
    return objectMap;
  }
  
	/** 
	* returns  dateOfBirth
	*/	
	public java.util.Date getDateOfBirth() {
    	return this.dateOfBirth;
    }

	/** 
	* returns  name
	*/	
	public Name getName() {
    	return this.name;
    }

	/** 
	* returns  residence
	*/	
	public Residence getResidence() {
    	return this.residence;
    }

    public void setDateOfBirth( java.util.Date aDateOfBirth) {
    	this.dateOfBirth = aDateOfBirth;
    }

    public void setName( Name aName) {
    	this.name = aName;
    }

    public void setResidence( Residence aResidence) {
    	this.residence = aResidence;
    }


    public CustomerData clone()   {
    	CustomerData clon = new CustomerData();
    	clon.setDateOfBirth(( java.util.Date)this.dateOfBirth.clone());
    	clon.setName(this.name.clone());
    	clon.setResidence(this.residence.clone());
    	return clon;
    }

  @Override
  public String toString() {
		return toMap().toString();
  }
}
