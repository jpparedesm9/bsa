
package com.cobiscorp.ecobis.cobiscloudorchestration.rest.biocheck.dto;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class RespuestaSituacionRegistral {
 private String tipoSituacionRegistral;
 private String tipoReporteRoboExtravio = null;


 // Getter Methods 

 public String getTipoSituacionRegistral() {
  return tipoSituacionRegistral;
 }

 public String getTipoReporteRoboExtravio() {
  return tipoReporteRoboExtravio;
 }

 // Setter Methods 

 public void setTipoSituacionRegistral(String tipoSituacionRegistral) {
  this.tipoSituacionRegistral = tipoSituacionRegistral;
 }

 public void setTipoReporteRoboExtravio(String tipoReporteRoboExtravio) {
  this.tipoReporteRoboExtravio = tipoReporteRoboExtravio;
 }
}