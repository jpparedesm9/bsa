
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


public class BplView2 implements Serializable {
	private int id;
	private int idParent;
	private int labelId;
	private int productId;
	private String nameDescription;
	private String status;
	private int order;
	private int isGroup;
	private String typeView;
	private int anPageView;

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdParent() {
		return this.idParent;
	}

	public void setIdParent(int idParent) {
		this.idParent = idParent;
	}

	public int getLabelId() {
		return this.labelId;
	}

	public void setLabelId(int labelId) {
		this.labelId = labelId;
	}

	public int getProductId() {
		return this.productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getNameDescription() {
		return this.nameDescription;
	}

	public void setNameDescription(String nameDescription) {
		this.nameDescription = nameDescription;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getOrder() {
		return this.order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public int getIsGroup() {
		return this.isGroup;
	}

	public void setIsGroup(int isGroup) {
		this.isGroup = isGroup;
	}

	public String getTypeView() {
		return this.typeView;
	}

	public void setTypeView(String typeView) {
		this.typeView = typeView;
	}

	public int getAnPageView() {
		return this.anPageView;
	}

	public void setAnPageView(int anPageView) {
		this.anPageView = anPageView;
	}
}
