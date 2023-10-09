package com.cobiscorp.ecobis.customer.bl.impl;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.ProductDetailManager;
import com.cobiscorp.ecobis.customer.dal.ProductDetailDAO;
import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;
import com.cobiscorp.ecobis.admin.dto.SeqnosDTO;
import com.cobiscorp.ecobis.admin.service.SeqnosService;

public class ProductDetailManagerImpl implements ProductDetailManager {

	SeqnosService seqnosService;
	ProductDetailDAO productDetailDAO;
	
	public void setSeqnosService(SeqnosService seqnosService) {
		this.seqnosService = seqnosService;
	}

	public void setProductDetailDAO(ProductDetailDAO productDetailDAO) {
		this.productDetailDAO = productDetailDAO;
	}

	@Override
	public ProductDetailDTO createProductDetail(ProductDetailDTO productDetail) {
		SeqnosDTO seqnos=new SeqnosDTO();
		seqnos.setTable("cl_det_producto");
		seqnos=seqnosService.getSeqnos(seqnos);
		try{
			productDetail.setCode(seqnos.getNextValue());
			productDetailDAO.createProductDetail(productDetail);
			return productDetail;
		}
		catch(BusinessException ex){
			throw new BusinessException(100020, "ERROR TO SAVE PRODUCT DETAIL ");
		}		
	}

}
