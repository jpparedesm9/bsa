package com.cobiscorp.ecobis.customer.dal.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.ecobis.customer.dal.ProductDetailDAO;
import com.cobiscorp.ecobis.customer.dal.entities.ProductDetail;
import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public class ProductDetailDAOImpl extends BaseDAOImpl implements
		ProductDetailDAO {

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public void createProductDetail(ProductDetailDTO productDetail) {
		ProductDetail productSave = new ProductDetail(productDetail.getCode(),
				productDetail.getSubsidiary(), productDetail.getOffice(),
				productDetail.getProduct(), productDetail.getType(),
				productDetail.getCurrency(), productDetail.getDate(),
				productDetail.getComment(), productDetail.getAmount(),
				productDetail.getTime(), productDetail.getAccount(),
				productDetail.getStatus(), productDetail.getAuthorizing(),
				productDetail.getAccountOfficer(), productDetail.getClient(),
				productDetail.getAddress(), productDetail.getDescription(),
				productDetail.getDateChange(), productDetail.getDateNextDue(),
				productDetail.getPoBox(), productDetail.getSubType());
		this.entityManager.persist(productSave);		
	}

	@Override
	public ProductDetailDTO getProductDetail(Integer code) {
		ProductDetail productDetailFound = this.entityManager.find(
				ProductDetail.class, code);
		if (productDetailFound!=null)
			return new ProductDetailDTO(productDetailFound.getCode(),
					productDetailFound.getSubsidiary(),
					productDetailFound.getOffice(),
					productDetailFound.getProduct(),
					productDetailFound.getType(),
					productDetailFound.getCurrency(),
					productDetailFound.getDate(),
					productDetailFound.getComment(),
					productDetailFound.getAmount(),
					productDetailFound.getTime(),
					productDetailFound.getAccount(),
					productDetailFound.getStatus(),
					productDetailFound.getAuthorizing(),
					productDetailFound.getAccountOfficer(),
					productDetailFound.getClient(),
					productDetailFound.getAddress(),
					productDetailFound.getDescription(),
					productDetailFound.getDateChange(),
					productDetailFound.getDateNextDue(),
					productDetailFound.getPoBox(),
					productDetailFound.getSubType());
		else
			return null;
	}

}
