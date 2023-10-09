package com.cobiscorp.ecobis.customer.dal;

import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public interface ProductDetailDAO {
	/**
	 * Create a ProductDetail in database
	 *
	 */
	public void createProductDetail(ProductDetailDTO productDetail);
	/**
	 * Receive a code and return a ProductDetailDTO
	 *
	 */
	public ProductDetailDTO getProductDetail(Integer code);
}
