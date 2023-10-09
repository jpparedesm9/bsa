
package com.cobiscorp.ecobis.ws.client.linkser;

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
@WebService(name = "IWSNet", targetNamespace = "http://tempuri.org/")
@XmlSeeAlso({
    ObjectFactory.class
})
public interface IWSNet {


    /**
     * 
     * @return
     *     returns com.cobiscorp.ecobis.ws.client.linkser.UserInfo
     */
    @WebMethod(operationName = "GetUserInformation", action = "http://tempuri.org/IWSNet/GetUserInformation")
    @WebResult(name = "GetUserInformationResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "GetUserInformation", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.GetUserInformation")
    @ResponseWrapper(localName = "GetUserInformationResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.GetUserInformationResponse")
    public UserInfo getUserInformation();

    /**
     * 
     * @param pDireccion
     * @param pCodigoCobis
     * @param pNombreTitular
     * @param pNroOperacion
     * @param pMonto
     * @param pMoneda
     * @param pIdTitular
     * @param pFechaAprobacion
     * @param pActividad
     * @param pEvaluador
     * @param pOficina
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "Linea_Aprobada", action = "http://tempuri.org/IWSNet/Linea_Aprobada")
    @WebResult(name = "Linea_AprobadaResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "Linea_Aprobada", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.LineaAprobada")
    @ResponseWrapper(localName = "Linea_AprobadaResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.LineaAprobadaResponse")
    public String lineaAprobada(
        @WebParam(name = "pNro_Operacion", targetNamespace = "http://tempuri.org/")
        String pNroOperacion,
        @WebParam(name = "pOficina", targetNamespace = "http://tempuri.org/")
        String pOficina,
        @WebParam(name = "pMoneda", targetNamespace = "http://tempuri.org/")
        String pMoneda,
        @WebParam(name = "pMonto", targetNamespace = "http://tempuri.org/")
        String pMonto,
        @WebParam(name = "pIdTitular", targetNamespace = "http://tempuri.org/")
        String pIdTitular,
        @WebParam(name = "pCodigoCobis", targetNamespace = "http://tempuri.org/")
        String pCodigoCobis,
        @WebParam(name = "pNombreTitular", targetNamespace = "http://tempuri.org/")
        String pNombreTitular,
        @WebParam(name = "pDireccion", targetNamespace = "http://tempuri.org/")
        String pDireccion,
        @WebParam(name = "pEvaluador", targetNamespace = "http://tempuri.org/")
        String pEvaluador,
        @WebParam(name = "pActividad", targetNamespace = "http://tempuri.org/")
        String pActividad,
        @WebParam(name = "pFechaAprobacion", targetNamespace = "http://tempuri.org/")
        String pFechaAprobacion);

    /**
     * 
     * @param pDireccion
     * @param pCodigoCobis
     * @param pNombreTitular
     * @param pNroOperacion
     * @param pMonto
     * @param pIdTitular
     * @param pFechaAprobacion
     * @param pActividad
     * @param pEvaluador
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "Aumento_cupo", action = "http://tempuri.org/IWSNet/Aumento_cupo")
    @WebResult(name = "Aumento_cupoResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "Aumento_cupo", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.AumentoCupo")
    @ResponseWrapper(localName = "Aumento_cupoResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.AumentoCupoResponse")
    public String aumentoCupo(
        @WebParam(name = "pNro_Operacion", targetNamespace = "http://tempuri.org/")
        String pNroOperacion,
        @WebParam(name = "pMonto", targetNamespace = "http://tempuri.org/")
        String pMonto,
        @WebParam(name = "pIdTitular", targetNamespace = "http://tempuri.org/")
        String pIdTitular,
        @WebParam(name = "pCodigoCobis", targetNamespace = "http://tempuri.org/")
        String pCodigoCobis,
        @WebParam(name = "pNombreTitular", targetNamespace = "http://tempuri.org/")
        String pNombreTitular,
        @WebParam(name = "pDireccion", targetNamespace = "http://tempuri.org/")
        String pDireccion,
        @WebParam(name = "pEvaluador", targetNamespace = "http://tempuri.org/")
        String pEvaluador,
        @WebParam(name = "pActividad", targetNamespace = "http://tempuri.org/")
        String pActividad,
        @WebParam(name = "pFechaAprobacion", targetNamespace = "http://tempuri.org/")
        String pFechaAprobacion);

    /**
     * 
     * @param pCodigoCliente
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "TarCred_Cliente", action = "http://tempuri.org/IWSNet/TarCred_Cliente")
    @WebResult(name = "TarCred_ClienteResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "TarCred_Cliente", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.TarCredCliente")
    @ResponseWrapper(localName = "TarCred_ClienteResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.TarCredClienteResponse")
    public String tarCredCliente(
        @WebParam(name = "pCodigoCliente", targetNamespace = "http://tempuri.org/")
        String pCodigoCliente);

    /**
     * 
     * @param pCocigoCliente
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "Consulta_Tarjetas_Cre", action = "http://tempuri.org/IWSNet/Consulta_Tarjetas_Cre")
    @WebResult(name = "Consulta_Tarjetas_CreResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "Consulta_Tarjetas_Cre", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.ConsultaTarjetasCre")
    @ResponseWrapper(localName = "Consulta_Tarjetas_CreResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.ConsultaTarjetasCreResponse")
    public String consultaTarjetasCre(
        @WebParam(name = "pCocigoCliente", targetNamespace = "http://tempuri.org/")
        String pCocigoCliente);

    /**
     * 
     * @param pIdMoneda
     * @param pIdFecha
     * @param pMonto
     * @param pIdLineaCreditoCobis
     * @param pIdDocumentoCliente
     * @param pIdClienteCobis
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "WSGETONLINEPAYMENT", action = "http://tempuri.org/IWSNet/WSGETONLINEPAYMENT")
    @WebResult(name = "WSGETONLINEPAYMENTResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "WSGETONLINEPAYMENT", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.WSGETONLINEPAYMENT")
    @ResponseWrapper(localName = "WSGETONLINEPAYMENTResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.WSGETONLINEPAYMENTResponse")
    public String wsgetonlinepayment(
        @WebParam(name = "pIdLineaCreditoCobis", targetNamespace = "http://tempuri.org/")
        String pIdLineaCreditoCobis,
        @WebParam(name = "pIdClienteCobis", targetNamespace = "http://tempuri.org/")
        String pIdClienteCobis,
        @WebParam(name = "pIdDocumentoCliente", targetNamespace = "http://tempuri.org/")
        String pIdDocumentoCliente,
        @WebParam(name = "pMonto", targetNamespace = "http://tempuri.org/")
        String pMonto,
        @WebParam(name = "pIdMoneda", targetNamespace = "http://tempuri.org/")
        String pIdMoneda,
        @WebParam(name = "pIdFecha", targetNamespace = "http://tempuri.org/")
        String pIdFecha);

    /**
     * 
     * @param pCodigoLinea
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "Detalle_Tarjeta", action = "http://tempuri.org/IWSNet/Detalle_Tarjeta")
    @WebResult(name = "Detalle_TarjetaResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "Detalle_Tarjeta", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.DetalleTarjeta")
    @ResponseWrapper(localName = "Detalle_TarjetaResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.DetalleTarjetaResponse")
    public String detalleTarjeta(
        @WebParam(name = "pCodigoLinea", targetNamespace = "http://tempuri.org/")
        String pCodigoLinea);

    /**
     * 
     * @param pCodigoCliente
     * @param pCodigoLinea
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "Estado_cta_tc", action = "http://tempuri.org/IWSNet/Estado_cta_tc")
    @WebResult(name = "Estado_cta_tcResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "Estado_cta_tc", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.EstadoCtaTc")
    @ResponseWrapper(localName = "Estado_cta_tcResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.EstadoCtaTcResponse")
    public String estadoCtaTc(
        @WebParam(name = "pCodigoCliente", targetNamespace = "http://tempuri.org/")
        String pCodigoCliente,
        @WebParam(name = "pCodigoLinea", targetNamespace = "http://tempuri.org/")
        String pCodigoLinea);

    /**
     * 
     * @param pNoMov
     * @param pFechaInicio
     * @param pCodigoCliente
     * @param pCodigoLinea
     * @param pFechaFin
     * @return
     *     returns java.lang.String
     */
    @WebMethod(operationName = "Consulta_mov", action = "http://tempuri.org/IWSNet/Consulta_mov")
    @WebResult(name = "Consulta_movResult", targetNamespace = "http://tempuri.org/")
    @RequestWrapper(localName = "Consulta_mov", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.ConsultaMov")
    @ResponseWrapper(localName = "Consulta_movResponse", targetNamespace = "http://tempuri.org/", className = "com.cobiscorp.ecobis.ws.client.linkser.ConsultaMovResponse")
    public String consultaMov(
        @WebParam(name = "pCodigoCliente", targetNamespace = "http://tempuri.org/")
        String pCodigoCliente,
        @WebParam(name = "pCodigoLinea", targetNamespace = "http://tempuri.org/")
        String pCodigoLinea,
        @WebParam(name = "pFechaInicio", targetNamespace = "http://tempuri.org/")
        String pFechaInicio,
        @WebParam(name = "pFechaFin", targetNamespace = "http://tempuri.org/")
        String pFechaFin,
        @WebParam(name = "pNo_mov", targetNamespace = "http://tempuri.org/")
        String pNoMov);

}