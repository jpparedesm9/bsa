
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


public class LegalRelationship implements Serializable {
	private int customerCode;
	private String name;
	private String digitCheck;
	private String id;
	private String statusCode;
	private String status;
	private String code;

	public int getCustomerCode() {
		return this.customerCode;
	}

	public void setCustomerCode(int customerCode) {
		this.customerCode = customerCode;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDigitCheck() {
		return this.digitCheck;
	}

	public void setDigitCheck(String digitCheck) {
		this.digitCheck = digitCheck;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getStatusCode() {
		return this.statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}