package com.cobiscorp.ecobis.customer.services;

import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public interface ProductDetailService {
	/**
	 * Create a ProductDetail in database and return ProductDetailDTO with sequential code assign
	 *
	 */
	public ProductDetailDTO createProductDetail(ProductDetailDTO productDetail);
}
