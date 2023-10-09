/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.gestionasesores.data.models.responses;

/**
 * @author mnaunay
 */
public class AddressResponse extends GenericResponse {
    private AddressDataResponse data;

    public AddressDataResponse getData() {
        return data;
    }

    public void setData(AddressDataResponse data) {
        this.data = data;
    }

}
