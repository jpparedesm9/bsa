package com.cobis.cloud.sofom.salesservice.customermanagement;

import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.ProductsInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.SearchProductsInfo;

/**
 * Created by pclavijo on 30/06/2017.
 */
public interface ICustomerAccessEntitlement {
    ProductsInfo getProductsByBuc(SearchProductsInfo searchProductsInfo, ConnectionInfo connectionInfo);
}
