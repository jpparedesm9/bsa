package com.cobiscorp.ecobis.cloud.service;

import com.cobiscorp.ecobis.cloud.service.dto.business.BusinessDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.ComplementaryDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerAddressDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.PaymentCapacityDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.client.ReferenceDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseAddressDataRequest;
import com.cobiscorp.ecobis.cloud.service.dto.spouse.SpouseDataRequest;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

/**
 * @author Cesar Loachamin
 */
public interface ClientService {

    Response readCustomer(int customerId);

    Response createCustomer(CustomerDataRequest data);

    Response updateCustomer(CustomerDataRequest data);

    Response readAddress(int customerI, int addressId, HttpServletRequest request);

    Response createAddress(int customerId, CustomerAddressDataRequest data);

    Response updateAddress(int customerId, CustomerAddressDataRequest data);

    Response readBusiness(int customerId, int businessId);

    Response createBusiness(int customerId, BusinessDataRequest data);

    Response updateBusiness(int customerId, BusinessDataRequest data);

    Response readReferences(int customerId);

    Response readReference(int customer, int referenceId);

    Response createReference(int customer, ReferenceDataRequest data);

    Response updateReference(int customer, ReferenceDataRequest data);

    Response readPaymentCapacity(int customer);

    Response createPaymentCapacity(int customer, PaymentCapacityDataRequest data);

    Response updatePaymentCapacity(int customer, PaymentCapacityDataRequest data);

    Response readSpouse(int customerId);

    Response createSpouse(int customer, SpouseDataRequest data);

    Response updateSpouse(int customer, SpouseDataRequest data);

    Response readSpouseAddress(int customerId, int addressId, HttpServletRequest request);

    Response createSpouseAddress(int customerId, SpouseAddressDataRequest data);

    Response updateSpouseAddress(int customerId, SpouseAddressDataRequest data);

    Response updateComplementaryData(ComplementaryDataRequest data);

    Response readComplementaryData(int customerId);


}
