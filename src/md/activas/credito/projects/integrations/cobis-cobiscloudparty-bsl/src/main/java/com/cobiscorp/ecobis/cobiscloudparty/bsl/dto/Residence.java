/**
 * Archivo: public class Residence 
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



public class Residence implements Cloneable {

  private String address1;

  private String city;

  private String codCountry;

  private String colony;

  private String cp;

  private String municipality;

  private String state;

  public Residence() {
    //Empty contructor in order to build basic DTO ---PNV
  }

  public Residence(Map objectMap) {
    
    String wAddress1 = (String)objectMap.get("address1");
    setAddress1(wAddress1);

    String wCity = (String)objectMap.get("city");
    setCity(wCity);

    String wCodCountry = (String)objectMap.get("codCountry");
    setCodCountry(wCodCountry);

    String wColony = (String)objectMap.get("colony");
    setColony(wColony);

    String wCp = (String)objectMap.get("cp");
    setCp(wCp);

    String wMunicipality = (String)objectMap.get("municipality");
    setMunicipality(wMunicipality);

    String wState = (String)objectMap.get("state");
    setState(wState);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wAddress1 = getAddress1();
    objectMap.put("address1", wAddress1);

    String wCity = getCity();
    objectMap.put("city", wCity);

    String wCodCountry = getCodCountry();
    objectMap.put("codCountry", wCodCountry);

    String wColony = getColony();
    objectMap.put("colony", wColony);

    String wCp = getCp();
    objectMap.put("cp", wCp);

    String wMunicipality = getMunicipality();
    objectMap.put("municipality", wMunicipality);

    String wState = getState();
    objectMap.put("state", wState);
    return objectMap;
  }
  
	/** 
	* returns  address1
	*/	
	public String getAddress1() {
    	return this.address1;
    }

	/** 
	* returns  city
	*/	
	public String getCity() {
    	return this.city;
    }

	/** 
	* returns  codCountry
	*/	
	public String getCodCountry() {
    	return this.codCountry;
    }

	/** 
	* returns  colony
	*/	
	public String getColony() {
    	return this.colony;
    }

	/** 
	* returns  cp
	*/	
	public String getCp() {
    	return this.cp;
    }

	/** 
	* returns  municipality
	*/	
	public String getMunicipality() {
    	return this.municipality;
    }

	/** 
	* returns  state
	*/	
	public String getState() {
    	return this.state;
    }

    public void setAddress1( String aAddress1) {
    	this.address1 = aAddress1;
    }

    public void setCity( String aCity) {
    	this.city = aCity;
    }

    public void setCodCountry( String aCodCountry) {
    	this.codCountry = aCodCountry;
    }

    public void setColony( String aColony) {
    	this.colony = aColony;
    }

    public void setCp( String aCp) {
    	this.cp = aCp;
    }

    public void setMunicipality( String aMunicipality) {
    	this.municipality = aMunicipality;
    }

    public void setState( String aState) {
    	this.state = aState;
    }

    public Residence clone()   {
    	Residence clon = new Residence();
    	clon.setAddress1(this.address1);
    	clon.setCity(this.city);
    	clon.setCodCountry(this.codCountry);
    	clon.setColony(this.colony);
    	clon.setCp(this.cp);
    	clon.setMunicipality(this.municipality);
    	clon.setState(this.state);
        return clon;
    }

  @Override
  public String toString() {
		return toMap().toString();
  }
}
