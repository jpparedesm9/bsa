/*
 * Crédito en Línea
 * Servicios para aplicación de crédito en    
 *
 * OpenAPI spec version: 1.0.0
 * Contact: pablo.lopez@ndeveloper.com
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */

package com.cobiscorp.mobile.model;

/**
 * Phone
 */
public class RegistryCode {
    private String codigo = null;

    public RegistryCode codigo(String codigo) {
        this.codigo = codigo;
        return this;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((codigo == null) ? 0 : codigo.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        RegistryCode other = (RegistryCode) obj;
        if (codigo == null) {
            if (other.codigo != null)
                return false;
        } else if (!codigo.equals(other.codigo))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "RegistryCode [codigo=" + codigo + "]";
    }

}
