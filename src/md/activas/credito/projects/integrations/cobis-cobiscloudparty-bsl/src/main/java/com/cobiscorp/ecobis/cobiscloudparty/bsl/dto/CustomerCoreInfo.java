/**
 * Archivo: public class CustomerCoreInfo 
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerCoreInfo {

	private String buc;
	private String customerAccountId;
	private String customerStdCode;
	private String status;

	private List<CustomerProduct> productList;

	public CustomerCoreInfo() {
		// Empty contructor in order to build basic DTO
	}

	public CustomerCoreInfo(Map objectMap) {

		String wBuc = (String) objectMap.get("buc");
		setBuc(wBuc);

		String wCustomerAccountId = (String) objectMap.get("customerAccountId");
		setCustomerAccountId(wCustomerAccountId);

		String wCustomerStdCode = (String) objectMap.get("customerStdCode");
		setCustomerStdCode(wCustomerStdCode);

		String wStatus = (String) objectMap.get("status");
		setStatus(wStatus);

		List<CustomerProduct> wProductList = (List<CustomerProduct>) objectMap.get("productList");
		setProductList(wProductList);
	}

	public Map toMap() {
		Map objectMap = new HashMap();

		String wBuc = getBuc();
		objectMap.put("buc", wBuc);

		String wCustomerAccountId = getCustomerAccountId();
		objectMap.put("customerAccountId", wCustomerAccountId);

		String wCustomerStdCode = getCustomerStdCode();
		objectMap.put("customerStdCode", wCustomerStdCode);

		String wStatus = getStatus();
		objectMap.put("status", wStatus);

		List<CustomerProduct> wProductList = getProductList();
		objectMap.put("productList", wProductList);
		return objectMap;
	}

	/**
	 * returns buc
	 */
	public String getBuc() {
		return this.buc;
	}

	/**
	 * returns customerAccountId
	 */
	public String getCustomerAccountId() {
		return this.customerAccountId;
	}

	/**
	 * returns customerStdCode
	 */
	public String getCustomerStdCode() {
		return this.customerStdCode;
	}

	/**
	 * returns status
	 */
	public String getStatus() {
		return this.status;
	}

	/**
	 * returns productList
	 */
	public List<CustomerProduct> getProductList() {
		return productList;
	}

	public void setBuc(String aBuc) {
		this.buc = aBuc;
	}

	public void setCustomerAccountId(String aCustomerAccountId) {
		this.customerAccountId = aCustomerAccountId;
	}

	public void setCustomerStdCode(String aCustomerStdCode) {
		this.customerStdCode = aCustomerStdCode;
	}

	public void setStatus(String aStatus) {
		this.status = aStatus;
	}

	public void setProductList(List<CustomerProduct> productList) {
		this.productList = productList;
	}

	@Override
	public String toString() {
		return toMap().toString();
	}
}
