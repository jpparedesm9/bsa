
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de COBISCORP.                                */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de COBISCORP.                              */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor  y por las convenciones internacionales de    */
/*   propiedad intelectual.   Su  uso no autorizado dara    */
/*   derecho  a   COBISCORP   para  obtener  ordenes  de    */
/*   secuestro o retencion  y  para perseguir penalmente    */
/*   a los autores de cualquier infraccion.                 */
/************************************************************/
/*   This code was generated by CEN-SG.                     */
/*   Changes to this file may cause incorrect behavior      */
/*   and will be lost if the code is regenerated.           */
/************************************************************/

package cobiscorp.ecobis.ucsp.dto;
import java.util.ArrayList;

import java.io.Serializable;

import java.util.HashMap;


public class Features implements Serializable {
	private String featureCode;
	private String featureName;
	private String featureDescription;

	public String getFeatureCode() {
		return this.featureCode;
	}

	public void setFeatureCode(String featureCode) {
		this.featureCode = featureCode;
	}

	public String getFeatureName() {
		return this.featureName;
	}

	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}

	public String getFeatureDescription() {
		return this.featureDescription;
	}

	public void setFeatureDescription(String featureDescription) {
		this.featureDescription = featureDescription;
	}
}