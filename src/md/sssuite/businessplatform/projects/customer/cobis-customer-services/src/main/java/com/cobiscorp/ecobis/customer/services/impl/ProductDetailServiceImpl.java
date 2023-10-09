package com.cobiscorp.ecobis.customer.services.impl;

import com.cobiscorp.ecobis.customer.bl.ProductDetailManager;
import com.cobiscorp.ecobis.customer.services.ProductDetailService;
import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public class ProductDetailServiceImpl implements ProductDetailService{
	private ProductDetailManager productDetailManager;
	

	public void setProductDetailManager(ProductDetailManager productDetailManager) {
		this.productDetailManager = productDetailManager;
	}


	@Override
	public ProductDetailDTO createProductDetail(ProductDetailDTO productDetail) {
		return productDetailManager.createProductDetail(productDetail);
	}

}
