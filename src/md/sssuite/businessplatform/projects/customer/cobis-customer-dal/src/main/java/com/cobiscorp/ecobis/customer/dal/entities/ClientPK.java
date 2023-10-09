package com.cobiscorp.ecobis.customer.dal.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

public class ClientPK implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
    @Column(name="cl_cliente")
    private Integer client;
    
    @Id
    @Column(name="cl_det_producto")
	private Integer productDetail;

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public Integer getDetProduct() {
		return productDetail;
	}

	public void setDetProduct(Integer detProduct) {
		this.productDetail = detProduct;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result
				+ ((productDetail == null) ? 0 : productDetail.hashCode());
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
		ClientPK other = (ClientPK) obj;
		if (client == null) {
			if (other.client != null)
				return false;
		} else if (!client.equals(other.client))
			return false;
		if (productDetail == null) {
			if (other.productDetail != null)
				return false;
		} else if (!productDetail.equals(other.productDetail))
			return false;
		return true;
	}

	
    
}
