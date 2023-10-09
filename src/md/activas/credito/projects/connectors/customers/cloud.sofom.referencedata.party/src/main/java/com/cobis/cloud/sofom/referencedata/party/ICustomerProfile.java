package com.cobis.cloud.sofom.referencedata.party;

import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.referencedata.party.dto.CustomerInfo;
import com.cobis.cloud.sofom.referencedata.party.dto.SearchCustomerInfo;

/**
 * Created by pclavijo on 21/06/2017.
 */
public interface ICustomerProfile {
    CustomerInfo getCustomerByRfc(SearchCustomerInfo searchCustomerInfo, ConnectionInfo connectionInfo);

    CustomerInfo getCustomerByBuc(SearchCustomerInfo searchCustomerInfo, ConnectionInfo connectionInfo);

    CustomerInfo getCustomerByNameAndDateOfBirth (SearchCustomerInfo searchCustomerInfo, ConnectionInfo connectionInfo);
}
