package com.cobiscorp.ecobis.customer.dal.impl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.dal.CustomerDAO;
import com.cobiscorp.ecobis.customer.dal.entities.Customer;
import com.cobiscorp.ecobis.customer.dal.entities.CustomerAux;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;

public class CustomerDAOImpl extends BaseDAOImpl implements CustomerDAO {

	private static ILogger logger = LogFactory.getLogger(CustomerDAOImpl.class);

	public CustomerDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	private final int NOT_EXISTS_CUSTOMER = 0;

	@Override
	public void create() {
		throw new BusinessException(1, "Not implemented");
	}

	@Override
	public CustomerDataResponse getCustomerDataByID(Integer id) {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("id", id);
		CustomerDataResponse customerDTO = this.getSingleResult(
				"Customer.getDebtorCustomerData", parametersList,
				CustomerDataResponse.class);
		if (customerDTO == null) {
			customerDTO = new CustomerDataResponse();
			customerDTO.setCustomerID(NOT_EXISTS_CUSTOMER);
		}
		return customerDTO;
	}

	@Override
	public IdSearchResponse getIdSearchByID(String docId) {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("docId", docId);
		IdSearchRequest idSearchDTO = this.getSingleResult(
				"Customer.getIdSearch", parametersList, IdSearchRequest.class);
		IdSearchResponse idSearchResponse = new IdSearchResponse();
		if (idSearchDTO == null) {
			idSearchResponse.setResult(false);
			logger.logInfo(NOT_EXISTS_CUSTOMER);
		} else {
			idSearchResponse.setResult(true);
		}
		return idSearchResponse;
	}

	@Override
	public CustomerDataResponse getCustomerAllDataByID(Integer id) {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		parametersList.put("id", id);
		Customer customer = this.getSingleResult("Customer.getAllData",
				parametersList, Customer.class);
		CustomerAux customerAux = this.getSingleResult(
				"CustomerAux.getAllData", parametersList, CustomerAux.class);
		CustomerDataResponse customerData = new CustomerDataResponse(
				customer.getId(), customer.getTypeDocumentId(),
				customer.getDocumentId(), customer.getNameComplete(),
				customer.getName(), customer.getSubtype(),
				customer.getTypePersonId(), customer.getSector(),
				customer.getAssociated(), customer.getOffice(),
				customer.getCreationDate() == null ? "" : sdf.format(customer
						.getCreationDate()),
				customer.getUpdateDate() == null ? "" : sdf.format(customer
						.getUpdateDate()), customer.getnAddress(),
				customer.getnReferences(), customer.getnPobxs(),
				customer.getBalance(), customer.getGroup(),
				customer.getCountry(), customer.getExecutive(),
				customer.getActivity(), customer.getRetention(),
				customer.getBadReference(), customer.getSex(),
				customer.getBirthDate() == null ? "" : sdf.format(customer
						.getBirthDate()), customer.getProfesion(),
				customer.getMaritalStatus(), customer.getnDependents(),
				customer.getnChildren(), customer.getAssets(),
				customer.getLiabilities(), customer.getStudyLevel(),
				customer.getHousingType(), customer.getTypePersonId(),
				customer.getnJobs(), customer.getIssueDate() == null ? ""
						: sdf.format(customer.getIssueDate()),
				customer.getAssociated(), customer.getVinculation(),
				customer.getVinculationType(),
				customer.getSubstituteExecutive(), customer.getIsCustomer(),
				customer.getNationality(), customer.getIdTutor(),
				customer.getNomTutor(), customerAux.getCustomerReturn(),
				customerAux.getCodeRisk(), customer.getActivity(),
				customerAux.getRegistrant(),
				customerAux.getExceptionRegistrant(),
				customerAux.getBusinessline(),
				customerAux.getBusinessSegment(),
				customerAux.getValidateIdCheck(), customer.getExecutive(),
				customerAux.getBranchMangement(), customerAux.getUpdateKYC(),
				customerAux.getUpdateDateKYC() == null ? "" : sdf
						.format(customerAux.getUpdateDateKYC()),
				customerAux.getIsNotRequeridKYC(),
				customerAux.getUpdateTransProfile(),
				customerAux.getUpdateDateTransProfile() == null ? "" : sdf
						.format(customerAux.getUpdateDateTransProfile()),
				customerAux.getWithSalary(),
				customerAux.getWithSalaryDate() == null ? "" : sdf
						.format(customerAux.getWithSalaryDate()),
				customerAux.getWithoutSalaryDate() == null ? "" : sdf
						.format(customerAux.getWithoutSalaryDate()),
				customerAux.getCicUpdate(),
				customerAux.getCicUpdateDate() == null ? "" : sdf
						.format(customerAux.getCicUpdateDate()),
				customerAux.getCicException(), customerAux.getSourceIncome(),
				customerAux.getPrincipalActivity(),
				customerAux.getDolarizedActivity(),
				customerAux.getAmlCategory(),
				customerAux.getVinculationDate() == null ? "" : sdf
						.format(customerAux.getVinculationDate()),
				customerAux.getStatus(),

				customer.getLastName(), customer.getSecondLastName(),
				customer.getConstitutionDate() == null ? "" : sdf
						.format(customer.getConstitutionDate()),
				customer.getSocietyType(), customer.getAssets(),
				customer.getnStaff(), customer.getVerified(),
				customer.getVerificationDate() == null ? "" : sdf
						.format(customer.getVerificationDate()),
				customer.getMiddleName(), customer.getSocialReason());

		return customerData;
	}

	@Override
	public Customer read(int id) {
		return this.entityManager.find(Customer.class, id);
	}

	@Override
	public void update(Customer entity) {
	}

}