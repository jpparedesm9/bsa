package com.cobiscorp.ecobis.cobiscloudburo.util;

import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Domicilio;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Encabezado;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaRequest.Nombre;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Name;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Residence;

/**
 * @author Farid Saud
 * @date 7/3/2017
 */
public class BuroRequestDTOConverter {
    public static Domicilio convertResidence(Residence residence){
        Domicilio domicilio = new Domicilio();
        domicilio.setCiudad(residence.getCity());
        domicilio.setCodPais(residence.getCodCountry());
        domicilio.setColoniaPoblacion(residence.getColony());
        domicilio.setcP(residence.getCp());
        domicilio.setDelegacionMunicipio(residence.getMunicipality());
        domicilio.setDireccion1(residence.getAddress1());
        domicilio.setEstado(residence.getState());
        return domicilio;
    }

    public static Encabezado convertHeader(Header header){
        Encabezado encabezado = new Encabezado();
        encabezado.setClavePais(header.getCountryKey());
        encabezado.setClaveUnidadMonetaria(header.getUnitCurrencyKey());
        encabezado.setClaveUsuario(header.getUserKey());
        encabezado.setIdioma(header.getLanguage());
        encabezado.setImporteContrato(header.getContractAmount());
        encabezado.setNumeroReferenciaOperador(header.getOperatorReferenceNumber());
        encabezado.setPassword(header.getPassword());
        encabezado.setProductoRequerido(header.getRequiredProduct());
        encabezado.setTipoConsulta(header.getQueryType());
        encabezado.setTipoContrato(header.getContractType());
        encabezado.setTipoSalida(header.getOutputType());
        encabezado.setIdioma(header.getLanguage());
        encabezado.setVersion(header.getVersion());
        return encabezado;
    }

    public static Nombre convertName(Name name){
        Nombre nombre = new Nombre();
        nombre.setApellidoMaterno(name.getMotherLastName());
        nombre.setApellidoPaterno(name.getFatherLastName());
        nombre.setPrimerNombre(name.getFirstName());
        nombre.setSegundoNombre(name.getSecondName());
        nombre.setrFC(name.getRfc());
        nombre.setFechaNacimiento(name.getDateOfBirth());
        return nombre;
    }

}
