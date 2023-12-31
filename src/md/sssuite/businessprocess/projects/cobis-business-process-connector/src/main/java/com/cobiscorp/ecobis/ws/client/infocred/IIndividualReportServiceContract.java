
package com.cobiscorp.ecobis.ws.client.infocred;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.1.6 in JDK 6
 * Generated source version: 2.1
 * 
 */
@WebService(name = "IIndividualReportServiceContract", targetNamespace = "http://tempuri.org/")
@XmlSeeAlso({
    ObjectFactory.class
})
public interface IIndividualReportServiceContract {


    /**
     * 
     * @param usuario
     * @param titular
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "GetIndividualReport", action = "http://tempuri.org/IIndividualReportServiceContract/GetIndividualReport")
    @WebResult(name = "GetIndividualReportResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "GetIndividualReport", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetIndividualReport")
    @ResponseWrapper(localName = "GetIndividualReportResponse", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetIndividualReportResponse")
    public String getIndividualReport(
        @WebParam(name = "titular", targetNamespace = "http://tempuri.org/")
        Titular titular,
        @WebParam(name = "usuario", targetNamespace = "http://tempuri.org/")
        Usuario usuario);

    /**
     * 
     * @param usuario
     * @param titular
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "GetIndividualReport2", action = "http://tempuri.org/IIndividualReportServiceContract/GetIndividualReport2")
    @WebResult(name = "GetIndividualReport2Result", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "GetIndividualReport2", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetIndividualReport2")
    @ResponseWrapper(localName = "GetIndividualReport2Response", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetIndividualReport2Response")
    public String getIndividualReport2(
        @WebParam(name = "titular", targetNamespace = "http://tempuri.org/")
        Titular titular,
        @WebParam(name = "usuario", targetNamespace = "http://tempuri.org/")
        Usuario usuario);

    /**
     * 
     * @param usuario
     * @param titular
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "GetIndividualReport3", action = "http://tempuri.org/IIndividualReportServiceContract/GetIndividualReport3")
    @WebResult(name = "GetIndividualReport3Result", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "GetIndividualReport3", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetIndividualReport3")
    @ResponseWrapper(localName = "GetIndividualReport3Response", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetIndividualReport3Response")
    public String getIndividualReport3(
        @WebParam(name = "titular", targetNamespace = "http://tempuri.org/")
        Titular titular,
        @WebParam(name = "usuario", targetNamespace = "http://tempuri.org/")
        Usuario usuario);

    /**
     * 
     * @param usuario
     * @param nombreCompleto
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "GetTitularListByName", action = "http://tempuri.org/IIndividualReportServiceContract/GetTitularListByName")
    @WebResult(name = "GetTitularListByNameResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "GetTitularListByName", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetTitularListByName")
    @ResponseWrapper(localName = "GetTitularListByNameResponse", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetTitularListByNameResponse")
    public String getTitularListByName(
        @WebParam(name = "usuario", targetNamespace = "http://tempuri.org/")
        Usuario usuario,
        @WebParam(name = "nombreCompleto", targetNamespace = "http://tempuri.org/")
        String nombreCompleto);

    /**
     * 
     * @param usuario
     * @param titular
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "GetBehaviorReport", action = "http://tempuri.org/IIndividualReportServiceContract/GetBehaviorReport")
    @WebResult(name = "GetBehaviorReportResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "GetBehaviorReport", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetBehaviorReport")
    @ResponseWrapper(localName = "GetBehaviorReportResponse", targetNamespace = "http://tempuri.org/", className = "org.tempuri.GetBehaviorReportResponse")
    public String getBehaviorReport(
        @WebParam(name = "titular", targetNamespace = "http://tempuri.org/")
        Titular titular,
        @WebParam(name = "usuario", targetNamespace = "http://tempuri.org/")
        Usuario usuario);

}
