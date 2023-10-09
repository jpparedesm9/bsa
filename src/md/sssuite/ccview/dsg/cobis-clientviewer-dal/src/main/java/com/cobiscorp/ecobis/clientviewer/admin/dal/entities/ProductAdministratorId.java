package com.cobiscorp.ecobis.clientviewer.admin.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "prd_id" and "pr_rol_id"
 * from the table: vcc_product_admin
 * @author bbuendia
 *
 */

@Embeddable
public class ProductAdministratorId {
	private Integer idRole;
	private Double idProduct;

	public Integer getIdRole() {
		return idRole;
	}

	public void setIdRole(Integer idRole) {
		this.idRole = idRole;
	}

	public Double getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(Double idProduct) {
		this.idProduct = idProduct;
	}

	public ProductAdministratorId() {
	}

	public ProductAdministratorId(Integer idRole, Double idProducto) {
		super();
		this.idRole = idRole;
		this.idProduct = idProducto;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((idProduct == null) ? 0 : idProduct.hashCode());
		result = prime * result + ((idRole == null) ? 0 : idRole.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductAdministratorId other = (ProductAdministratorId) obj;
		if (idProduct == null) {
			if (other.idProduct != null)
				return false;
		} else if (!idProduct.equals(other.idProduct))
			return false;
		if (idRole == null) {
			if (other.idRole != null)
				return false;
		} else if (!idRole.equals(other.idRole))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProductManagerId [idRole=" + idRole + ", idProducto="
				+ idProduct + "]";
	}

}
