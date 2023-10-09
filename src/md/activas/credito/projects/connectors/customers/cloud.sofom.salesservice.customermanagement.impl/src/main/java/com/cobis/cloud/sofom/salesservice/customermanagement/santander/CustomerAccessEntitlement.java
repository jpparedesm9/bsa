package com.cobis.cloud.sofom.salesservice.customermanagement.santander;

import com.cobis.cloud.sofom.customers.utils.santander.RestServiceConnector;
import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.ICustomerAccessEntitlement;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.ProductsInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.dto.SearchProductsInfo;
import com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto.ProductsByBucRequest;
import com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto.ProductsByBucResponse;
import com.cobis.cloud.sofom.salesservice.customermanagement.santander.dto.ProductsInfoConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.ws.rs.core.Response;
import java.io.IOException;

/**
 * Created by pclavijo on 30/06/2017.
 */
public class CustomerAccessEntitlement implements ICustomerAccessEntitlement {
    private static ILogger logger = LogFactory.getLogger(CustomerAccessEntitlement.class);
    private static final String className = "[CustomerAccessEntitlement]";

    private static final String basePath = "/v1/AB_ISL00209_CLIENTES";

    public CustomerAccessEntitlement() {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[CustomerAccessEntitlement constructor]");
        }
    }

    @Override
    public ProductsInfo getProductsByBuc(SearchProductsInfo searchProductsInfo, ConnectionInfo connectionInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[getProductsByBuc]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("searchProductsInfo: " + searchProductsInfo.toString());
            logger.logTrace("connectionInfo: " + connectionInfo.toString());
        }

        if (searchProductsInfo == null) {
            throw new IllegalStateException("Invalid information to request");
        }
        try {
            Response response = makeRequest(searchProductsInfo, connectionInfo);
            String jsonResponse = RestServiceConnector.checkResponseStatus(response);
            if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                response = makeRequest(searchProductsInfo, connectionInfo);
                jsonResponse = RestServiceConnector.checkResponseStatus(response);
                if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                    throw new COBISInfrastructureRuntimeException("Unauthorized access to web service");
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            ProductsByBucResponse productsByBucResponse = mapper.readValue(jsonResponse, ProductsByBucResponse.class);

            ProductsInfo productsInfo = ProductsInfoConverter.toProductsInfo(productsByBucResponse);
            if (logger.isTraceEnabled()) {
                logger.logTrace("productsInfo: " + productsInfo.toString());
            }
            return productsInfo;
        } catch (Exception ex) {
            logger.logError(ex);
            throw new IllegalStateException(ex);
        }
    }

    private Response makeRequest(SearchProductsInfo request, ConnectionInfo connectionInfo) throws IOException {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[makeRequest]");
        }

        String url = createRestEndpointUrl(connectionInfo.getBaseUrl());

        String jsonBody = createJsonBody(request.getBuc());
        if (logger.isDebugEnabled()) {
            logger.logDebug("jsonBody: " + jsonBody);
        }

        return RestServiceConnector.callService(url, jsonBody, connectionInfo);
    }

    private String createRestEndpointUrl(String baseUrl) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[createRestEndpointUrl]");
        }

        String servicePath = "/product_nbd/get_by_person_number";

        if (baseUrl == null) {
            throw new IllegalStateException("Invalid baseUrl");
        }

        return String.format(
                "%s%s%s", baseUrl, basePath, servicePath);
    }

    private String createJsonBody(String buc) throws JsonProcessingException {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[createJsonBodyByBuc]");
        }

        if (buc == null || buc.isEmpty()) {
            throw new IllegalStateException("Invalid BUC information");
        }

        ProductsByBucRequest productsByBucRequest = new ProductsByBucRequest(buc, "N");
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(productsByBucRequest);
    }
}
