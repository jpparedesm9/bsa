package com.cobis.cloud.sofom.referencedata.party.santander;

import com.cobis.cloud.sofom.customers.utils.santander.RestServiceConnector;
import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobis.cloud.sofom.referencedata.party.ICustomerProfile;
import com.cobis.cloud.sofom.referencedata.party.dto.CustomerInfo;
import com.cobis.cloud.sofom.referencedata.party.dto.SearchCustomerInfo;
import com.cobis.cloud.sofom.referencedata.party.santander.dto.CustomerByBucRequest;
import com.cobis.cloud.sofom.referencedata.party.santander.dto.CustomerByBucResponse;
import com.cobis.cloud.sofom.referencedata.party.santander.dto.CustomerByNameAndDateOfBirthRequest;
import com.cobis.cloud.sofom.referencedata.party.santander.dto.CustomerByNameAndDateOfBirthResponse;
import com.cobis.cloud.sofom.referencedata.party.santander.dto.CustomerByRfcRequest;
import com.cobis.cloud.sofom.referencedata.party.santander.dto.CustomerByRfcResponse;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.ws.rs.core.Response;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by pclavijo on 19/06/2017.
 */
public class CustomerProfile implements ICustomerProfile {
    private static ILogger logger = LogFactory.getLogger(CustomerProfile.class);
    private static final String className = "[CustomerProfile]";

    private static final String basePath = "/v1/AB_ISL00209_CLIENTES";
    private static final String dateFormat = "yyyy-MM-dd";

    private enum TypeRequest {
        BUC,
        NAME_AND_DOB,
        RFC
    }

    public CustomerProfile() {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[CustomerProfile constructor]");
        }
    }

    @Override
    public CustomerInfo getCustomerByBuc(SearchCustomerInfo searchCustomerInfo, ConnectionInfo connectionInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[getCustomerByBuc]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("searchCustomerInfo: " + searchCustomerInfo.toString());
            logger.logTrace("connectionInfo: " + connectionInfo.toString());
        }

        if (searchCustomerInfo == null) {
            throw new IllegalStateException("Invalid information to request");
        }
        try {
            Response response = makeRequest(TypeRequest.BUC, searchCustomerInfo, connectionInfo);
            String jsonResponse = RestServiceConnector.checkResponseStatus(response);
            if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                response = makeRequest(TypeRequest.BUC, searchCustomerInfo, connectionInfo);
                jsonResponse = RestServiceConnector.checkResponseStatus(response);
                if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                    throw new COBISInfrastructureRuntimeException("Unauthorized access to web service");
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            CustomerByBucResponse customerByBucResponse = mapper.readValue(jsonResponse, CustomerByBucResponse.class);

            CustomerInfo customerInfo = new CustomerInfo(customerByBucResponse.getBuc(), customerByBucResponse.getCondicionPersona());
            if (logger.isTraceEnabled()) {
                logger.logTrace("customerInfo: " + customerInfo.toString());
            }
            return customerInfo;
        } catch (Exception ex) {
            logger.logError(ex);
            throw new IllegalStateException(ex);
        }
    }

    @Override
    public CustomerInfo getCustomerByNameAndDateOfBirth(SearchCustomerInfo searchCustomerInfo, ConnectionInfo connectionInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[getCustomerByNameAndDateOfBirth]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("searchCustomerInfo: " + searchCustomerInfo.toString());
            logger.logTrace("connectionInfo: " + connectionInfo.toString());
        }

        if (searchCustomerInfo == null) {
            throw new IllegalStateException("Invalid information to request");
        }
        try {
            Response response = makeRequest(TypeRequest.NAME_AND_DOB, searchCustomerInfo, connectionInfo);
            String jsonResponse = RestServiceConnector.checkResponseStatus(response);
            if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                response = makeRequest(TypeRequest.NAME_AND_DOB, searchCustomerInfo, connectionInfo);
                jsonResponse = RestServiceConnector.checkResponseStatus(response);
                if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                    throw new COBISInfrastructureRuntimeException("Unauthorized access to web service");
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            CustomerByNameAndDateOfBirthResponse customerByNameAndDateOfBirthResponse = mapper.readValue(jsonResponse, CustomerByNameAndDateOfBirthResponse.class);

            CustomerInfo customerInfo = new CustomerInfo(customerByNameAndDateOfBirthResponse.getNumeroPersona(), customerByNameAndDateOfBirthResponse.getCondicionPersona());
            if (logger.isTraceEnabled()) {
                logger.logTrace("customerInfo: " + customerInfo.toString());
            }
            return customerInfo;
        } catch (Exception ex) {
            logger.logError(ex);
            throw new IllegalStateException(ex);
        }
    }

    @Override
    public CustomerInfo getCustomerByRfc(SearchCustomerInfo searchCustomerInfo, ConnectionInfo connectionInfo) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[getCustomerByRfc]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("searchCustomerInfo: " + searchCustomerInfo.toString());
            logger.logTrace("connectionInfo: " + connectionInfo.toString());
        }

        if (searchCustomerInfo == null) {
            throw new IllegalStateException("Invalid information to request");
        }
        try {
            Response response = makeRequest(TypeRequest.RFC, searchCustomerInfo, connectionInfo);
            String jsonResponse = RestServiceConnector.checkResponseStatus(response);
            if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                response = makeRequest(TypeRequest.RFC, searchCustomerInfo, connectionInfo);
                jsonResponse = RestServiceConnector.checkResponseStatus(response);
                if (jsonResponse.contentEquals(RestServiceConnector.UNAUTHORIZED)) {
                    throw new COBISInfrastructureRuntimeException("Unauthorized access to web service");
                }
            }

            ObjectMapper mapper = new ObjectMapper();
            CustomerByRfcResponse customerByRfcResponse = mapper.readValue(jsonResponse, CustomerByRfcResponse.class);

            CustomerInfo customerInfo = new CustomerInfo(customerByRfcResponse.getNumeroPersona(), null);
            if (logger.isTraceEnabled()) {
                logger.logTrace("customerInfo: " + customerInfo.toString());
            }
            return customerInfo;
        } catch (Exception ex) {
            logger.logError(ex);
            throw new IllegalStateException(ex);
        }
    }

    private Response makeRequest(TypeRequest typeRequest, SearchCustomerInfo request, ConnectionInfo connectionInfo) throws IOException {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[makeRequest]");
        }

        String url = createRestEndpointUrl(typeRequest, connectionInfo.getBaseUrl());

        String jsonBody = null;
        switch (typeRequest) {
            case BUC:
                jsonBody = createJsonBodyByBuc(request.getBuc());
                break;
            case NAME_AND_DOB:
                jsonBody = createJsonBodyByNameAndDateOfBirth(request.getName(), request.getFirstLastName(), request.getSecondLastName(), request.getDateOfBirth());
                break;
            case RFC:
                jsonBody = createJsonBodyByRfc(request.getRfc());
                break;
        }
        if (logger.isDebugEnabled()) {
            logger.logDebug("jsonBody: " + jsonBody);
        }

        return RestServiceConnector.callService(url, jsonBody, connectionInfo);
    }

    private String createRestEndpointUrl(TypeRequest typeRequest, String baseUrl) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[createRestEndpointUrl]");
        }

        String servicePath = null;

        switch (typeRequest) {
            case BUC:
                servicePath = "/customer_pn/get_by_person_number";
                break;
            case NAME_AND_DOB:
                servicePath = "/customer_nbd/get_by_name_birth_date";
                break;
            case RFC:
                servicePath = "/customer_r/get_by_rfc";
                break;
        }

        if (baseUrl == null) {
            throw new IllegalStateException("Invalid baseUrl");
        }

        return String.format(
                "%s%s%s", baseUrl, basePath, servicePath);
    }

    private String createJsonBodyByBuc(String buc) throws JsonProcessingException {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[createJsonBodyByBuc]");
        }

        if (buc == null || buc.isEmpty()) {
            throw new IllegalStateException("Invalid BUC information");
        }

        CustomerByBucRequest customerByBucRequest = new CustomerByBucRequest(buc);
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(customerByBucRequest);
    }

    private String createJsonBodyByNameAndDateOfBirth(String name, String firstLastName, String secondLastName, Date dateOfBirth) throws UnsupportedEncodingException, JsonProcessingException {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[createJsonBodyByNameAndDateOfBirth]");
        }

        if (name == null || name.isEmpty()) {
            throw new IllegalStateException("Invalid NAME information");
        }

        if (firstLastName == null || firstLastName.isEmpty()) {
            throw new IllegalStateException("Invalid FIRST LAST NAME information");
        }

        String dateOfBirthParameter;
        if (dateOfBirth == null) {
            throw new IllegalStateException("Invalid DATE OF BIRTH information");
        } else {
            DateFormat df = new SimpleDateFormat(dateFormat);
            dateOfBirthParameter = df.format(dateOfBirth);
        }

        CustomerByNameAndDateOfBirthRequest customerByNameAndDateOfBirthRequest = new CustomerByNameAndDateOfBirthRequest();
        customerByNameAndDateOfBirthRequest.setFechaNacimiento(dateOfBirthParameter);
        customerByNameAndDateOfBirthRequest.setNombrePersona(name);
        customerByNameAndDateOfBirthRequest.setPrimerApellido(firstLastName);
        if (secondLastName != null) {
            customerByNameAndDateOfBirthRequest.setSegundoApellido(secondLastName);
        }

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(customerByNameAndDateOfBirthRequest);
    }

    private String createJsonBodyByRfc(String rfc) throws JsonProcessingException {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[createJsonBodyByRfc]");
        }

        if (rfc == null || rfc.isEmpty()) {
            throw new IllegalStateException("Invalid RFC information");
        }

        CustomerByRfcRequest customerByRfcRequest = new CustomerByRfcRequest(rfc, "N");

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(customerByRfcRequest);
    }
}
