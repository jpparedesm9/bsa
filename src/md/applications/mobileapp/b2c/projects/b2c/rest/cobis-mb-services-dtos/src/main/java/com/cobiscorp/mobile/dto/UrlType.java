//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.11 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2022.09.02 at 04:30:44 PM COT 
//


package com.cobiscorp.mobile.dto;

import java.math.BigDecimal;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for UrlType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="UrlType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="reference"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;minLength value="1"/&gt;
 *               &lt;maxLength value="40"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="amount"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}decimal"&gt;
 *               &lt;minExclusive value="0"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="moneda"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;enumeration value="MXN"/&gt;
 *               &lt;enumeration value="DLS"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="canal"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;enumeration value="W"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="omitir_notif_default" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="1"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="promociones" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="40"/&gt;
 *               &lt;pattern value="C|(C,)?([1-9][0-9]?)(,([1-9][0-9]?))*"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="st_correo" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="1"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="fh_vigencia" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;pattern value="\d{2}[/]\d{2}[/]\d{4}"/&gt;
 *               &lt;length value="10"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="mail_cliente" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="50"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="st_cr" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="1"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="datos_adicionales" type="{}DatosAdicionalesType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "UrlType", propOrder = {
    "reference",
    "amount",
    "moneda",
    "canal",
    "omitirNotifDefault",
    "promociones",
    "stCorreo",
    "fhVigencia",
    "mailCliente",
    "stCr",
    "datosAdicionales"
})
public class UrlType {

    @XmlElement(required = true)
    protected String reference;
    @XmlElement(required = true)
    protected BigDecimal amount;
    @XmlElement(required = true)
    protected String moneda;
    @XmlElement(required = true)
    protected String canal;
    @XmlElement(name = "omitir_notif_default", defaultValue = "")
    protected String omitirNotifDefault;
    protected String promociones;
    @XmlElement(name = "st_correo", defaultValue = "")
    protected String stCorreo;
    @XmlElement(name = "fh_vigencia")
    protected String fhVigencia;
    @XmlElement(name = "mail_cliente", defaultValue = "")
    protected String mailCliente;
    @XmlElement(name = "st_cr", defaultValue = "")
    protected String stCr;
    @XmlElement(name = "datos_adicionales")
    protected DatosAdicionalesType datosAdicionales;

    /**
     * Gets the value of the reference property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReference() {
        return reference;
    }

    /**
     * Sets the value of the reference property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReference(String value) {
        this.reference = value;
    }

    /**
     * Gets the value of the amount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setAmount(BigDecimal value) {
        this.amount = value;
    }

    /**
     * Gets the value of the moneda property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMoneda() {
        return moneda;
    }

    /**
     * Sets the value of the moneda property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMoneda(String value) {
        this.moneda = value;
    }

    /**
     * Gets the value of the canal property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCanal() {
        return canal;
    }

    /**
     * Sets the value of the canal property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCanal(String value) {
        this.canal = value;
    }

    /**
     * Gets the value of the omitirNotifDefault property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOmitirNotifDefault() {
        return omitirNotifDefault;
    }

    /**
     * Sets the value of the omitirNotifDefault property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOmitirNotifDefault(String value) {
        this.omitirNotifDefault = value;
    }

    /**
     * Gets the value of the promociones property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromociones() {
        return promociones;
    }

    /**
     * Sets the value of the promociones property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromociones(String value) {
        this.promociones = value;
    }

    /**
     * Gets the value of the stCorreo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStCorreo() {
        return stCorreo;
    }

    /**
     * Sets the value of the stCorreo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStCorreo(String value) {
        this.stCorreo = value;
    }

    /**
     * Gets the value of the fhVigencia property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFhVigencia() {
        return fhVigencia;
    }

    /**
     * Sets the value of the fhVigencia property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFhVigencia(String value) {
        this.fhVigencia = value;
    }

    /**
     * Gets the value of the mailCliente property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMailCliente() {
        return mailCliente;
    }

    /**
     * Sets the value of the mailCliente property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMailCliente(String value) {
        this.mailCliente = value;
    }

    /**
     * Gets the value of the stCr property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStCr() {
        return stCr;
    }

    /**
     * Sets the value of the stCr property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStCr(String value) {
        this.stCr = value;
    }

    /**
     * Gets the value of the datosAdicionales property.
     * 
     * @return
     *     possible object is
     *     {@link DatosAdicionalesType }
     *     
     */
    public DatosAdicionalesType getDatosAdicionales() {
        return datosAdicionales;
    }

    /**
     * Sets the value of the datosAdicionales property.
     * 
     * @param value
     *     allowed object is
     *     {@link DatosAdicionalesType }
     *     
     */
    public void setDatosAdicionales(DatosAdicionalesType value) {
        this.datosAdicionales = value;
    }

}