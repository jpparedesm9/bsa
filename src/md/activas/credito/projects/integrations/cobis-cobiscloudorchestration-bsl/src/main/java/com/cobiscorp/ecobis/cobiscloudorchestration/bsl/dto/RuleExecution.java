/**
 * Archivo: public class RuleExecution 
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



public class RuleExecution {

  private String acronymRule;

  private java.util.Map variablesProcess;

  public RuleExecution() {
    //Empty contructor in order to build basic DTO
  }

  public RuleExecution(Map objectMap) {
    
    String wAcronymRule = (String)objectMap.get("acronymRule");
    setAcronymRule(wAcronymRule);

    java.util.Map wVariablesProcess = (java.util.Map)objectMap.get("variablesProcess");
    setVariablesProcess(wVariablesProcess);
  }


  public Map toMap() {
    Map objectMap = new HashMap(); 
    
    String wAcronymRule = getAcronymRule();
    objectMap.put("acronymRule", wAcronymRule);

    java.util.Map wVariablesProcess = getVariablesProcess();
    objectMap.put("variablesProcess", wVariablesProcess);
    return objectMap;
  }
  
	/** 
	* returns  acronymRule
	*/	
	public String getAcronymRule() {
    	return this.acronymRule;
    }

	/** 
	* returns  variablesProcess
	*/	
	public java.util.Map getVariablesProcess() {
    	return this.variablesProcess;
    }

    public void setAcronymRule( String aAcronymRule) {
    	this.acronymRule = aAcronymRule;
    }

    public void setVariablesProcess( java.util.Map aVariablesProcess) {
    	this.variablesProcess = aVariablesProcess;
    }


  @Override
  public String toString() {
		return toMap().toString();
  }
}
