/**
 * Archivo: public class Name 
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



public class Name implements Cloneable { //a

  private String fatherLastName;

  private String firstName;
  
  private String secondName;

  private String motherLastName;

  private String rfc;
  
  private String dateOfBirth;

  public Name() {
    //Empty contructor in order to build basic DTO
  }

  public Name(Map objectMap) {
    
    String wFatherLastName = (String)objectMap.get("fatherLastName");
    setFatherLastName(wFatherLastName);

    String wFirstName = (String)objectMap.get("firstName");
    setFirstName(wFirstName);
    
    String wSecondName = (String)objectMap.get("secondName");
    setSecondName(wSecondName);

    String wMotherLastName = (String)objectMap.get("motherLastName");
    setMotherLastName(wMotherLastName);

    String wRfc = (String)objectMap.get("rfc");
    setRfc(wRfc);
    
    String wDateOfBirth = (String)objectMap.get("dateOfBirth");
    setDateOfBirth(wDateOfBirth);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wFatherLastName = getFatherLastName();
    objectMap.put("fatherLastName", wFatherLastName);

    String wFirstName = getFirstName();
    objectMap.put("firstName", wFirstName);
    
    String wSecondName = getSecondName();
    objectMap.put("secondName", wSecondName);

    String wMotherLastName = getMotherLastName();
    objectMap.put("motherLastName", wMotherLastName);

    String wRfc = getRfc();
    objectMap.put("rfc", wRfc);
    
    String wDateOfBirth = getDateOfBirth();
    objectMap.put("dateOfBirth", wDateOfBirth);
    return objectMap;
  }
  
	/** 
	* returns  fatherLastName
	*/	
	public String getFatherLastName() {
    	return this.fatherLastName;
    }

	/** 
	* returns  firstName
	*/	
	public String getFirstName() {
    	return this.firstName;
    }

	/** 
	* returns  secondName
	*/
	public String getSecondName() {
		return secondName;
	}

	/** 
	* returns  motherLastName
	*/	
	public String getMotherLastName() {
    	return this.motherLastName;
    }

	/** 
	* returns  rfc
	*/	
	public String getRfc() {
    	return this.rfc;
    }
	
	/** 
	* returns  dateOfBirth
	*/	
	public String getDateOfBirth() {
    	return this.dateOfBirth;
    }

    public void setFatherLastName( String aFatherLastName) {
    	this.fatherLastName = aFatherLastName;
    }

    public void setFirstName( String aFirstName) {
    	this.firstName = aFirstName;
    }

    public void setSecondName(String aSecondName) {
		this.secondName = aSecondName;
	}
    
    public void setMotherLastName( String aMotherLastName) {
    	this.motherLastName = aMotherLastName;
    }

    public void setRfc( String aRfc) {
    	this.rfc = aRfc;
    }
    
    public void setDateOfBirth( String aDateOfBirth) {
    	this.dateOfBirth = aDateOfBirth;
    }


    public Name clone()   {
    	Name clon = new Name();
    	clon.setFatherLastName(this.fatherLastName);
    	clon.setFirstName(this.firstName);
    	clon.setSecondName(this.secondName);
    	clon.setMotherLastName(this.motherLastName);
    	clon.setRfc(this.rfc);
    	clon.setDateOfBirth(this.dateOfBirth);
    	return clon;
    }

  @Override
  public String toString() {
		return toMap().toString();
  }
}
