package com.cobis.cloud.sofom.operationsexecution.payments.service;

import com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto.Event;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * Created by pclavijo on 24/07/2017.
 */
public interface IFinancialGateway {
    Response receivePaymentEvent(Event event, String authString, HttpServletRequest requestContext);
}
