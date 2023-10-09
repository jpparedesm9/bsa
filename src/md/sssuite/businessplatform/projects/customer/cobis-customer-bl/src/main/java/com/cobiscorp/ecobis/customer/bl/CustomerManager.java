package com.cobiscorp.ecobis.customer.bl;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;


public interface CustomerManager {
     public void open(String name, double initialValue);
     public void validateOpen(String name);
     public CustomerDataResponse getCustomerDataById(Integer id);
     public CustomerDataResponse searchCustomerDataById(Integer id);
     public IdSearchResponse getIdSearchByID(String docId);
     public CustomerDataResponse searchCustomerNameById(Integer id);
}
