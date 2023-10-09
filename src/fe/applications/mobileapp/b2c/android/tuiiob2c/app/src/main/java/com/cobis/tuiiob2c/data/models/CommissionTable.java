package com.cobis.tuiiob2c.data.models;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

public class CommissionTable {

    @SerializedName("porcentajeIva")
    @Expose
    private double porcentajeIva;
    @SerializedName("tablaComision")
    @Expose
    private List<Commission> tablaComision;
    @SerializedName("notificaciones")
    @Expose
    private List<Notification> notificaciones;

    /**
     * No args constructor for use in serialization
     *
     */
    public CommissionTable() {
    }

    /**
     *
     * @param porcentajeIva
     * @param tablaComision
     * @param notificaciones
     */
    public CommissionTable(double porcentajeIva, List<Commission> tablaComision, List<Notification> notificaciones) {
        this.porcentajeIva = porcentajeIva;
        this.tablaComision = tablaComision;
        this.notificaciones = notificaciones;
    }

    public double getPorcentajeIva() {
        return porcentajeIva;
    }

    public void setPorcentajeIva(double porcentajeIva) {
        this.porcentajeIva = porcentajeIva;
    }

    public List<Commission> getTablaComision() {
        return tablaComision;
    }

    public void setTablaComision(List<Commission> tablaComision) {
        this.tablaComision = tablaComision;
    }

    public List<Notification> getNotificaciones() {
        return notificaciones;
    }

    public void setNotificaciones(List<Notification> notificaciones) {
        this.notificaciones = notificaciones;
    }
}