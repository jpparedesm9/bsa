package com.cobis.tuiiob2c.data.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Enrollment {

    @SerializedName("registryCode")
    @Expose
    private String registryCode;
    @SerializedName("nombres")
    @Expose
    private String nombres;
    @SerializedName("apellidos")
    @Expose
    private String apellidos;
    @SerializedName("numeroTramite")
    @Expose
    private String numeroTramite;
    @SerializedName("telefono")
    @Expose
    private String telefono;
    @SerializedName("idCliente")
    @Expose
    private String idCliente;
    @SerializedName("numeroCredito")
    @Expose
    private String numeroCredito;

    /**
     * No args constructor for use in serialization
     *
     */
    public Enrollment() {
    }

    /**
     *
     * @param nombres
     * @param apellidos
     * @param idCliente
     * @param telefono
     * @param numeroTramite
     * @param registryCode
     * @param numeroCredito
     */
    public Enrollment(String registryCode, String nombres, String apellidos, String numeroTramite, String telefono, String idCliente, String numeroCredito) {
        super();
        this.registryCode = registryCode;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.numeroTramite = numeroTramite;
        this.telefono = telefono;
        this.idCliente = idCliente;
        this.numeroCredito = numeroCredito;
    }

    private Enrollment(Builder builder) {
        registryCode = builder.registryCode;
        nombres = builder.nombres;
        apellidos = builder.apellidos;
        numeroTramite = builder.numeroTramite;
        telefono = builder.telefono;
        idCliente = builder.idCliente;
        numeroCredito = builder.numeroCredito;
    }

    public String getRegistryCode() {
        return registryCode;
    }

    public String getNombres() {
        return nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public String getNumeroTramite() {
        return numeroTramite;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getIdCliente() {
        return idCliente;
    }

    public String getNumeroCredito() {
        return numeroCredito;
    }

    public static class Builder {
        private String registryCode;
        private String nombres;
        private String apellidos;
        private String numeroTramite;
        private String telefono;
        private String idCliente;
        private String numeroCredito;

        public Builder addRegistryCode(String registryCode) {
            this.registryCode = registryCode;
            return this;
        }

        public Builder addNombres(String nombres) {
            this.nombres = nombres;
            return this;
        }

        public Builder addApellidos(String apellidos) {
            this.apellidos = apellidos;
            return this;
        }

        public Builder addNumeroTramite(String numeroTramite) {
            this.numeroTramite = numeroTramite;
            return this;
        }

        public Builder addTelefono(String telefono) {
            this.telefono = telefono;
            return this;
        }

        public Builder addIdCliente(String idCliente) {
            this.idCliente = idCliente;
            return this;
        }

        public Builder addNumeroCredito(String numeroCredito) {
            this.numeroCredito = numeroCredito;
            return this;
        }

        public Enrollment build() {
            return new Enrollment(this);
        }
    }
}