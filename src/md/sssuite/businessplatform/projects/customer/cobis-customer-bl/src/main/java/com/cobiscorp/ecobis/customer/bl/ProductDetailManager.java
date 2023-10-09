package com.cobiscorp.ecobis.customer.bl;

import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public interface ProductDetailManager {
	/**
	 * Create a ProductDetail in database and return ProductDetailDTO with sequential code assign
	 *
	 */
	public ProductDetailDTO createProductDetail(ProductDetailDTO productDetail);
}
