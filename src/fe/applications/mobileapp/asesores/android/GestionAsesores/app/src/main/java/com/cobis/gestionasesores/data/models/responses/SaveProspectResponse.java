/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.gestionasesores.data.models.responses;

/**
 * @author mnaunay
 */
public class SaveProspectResponse {
    private GeneralDataResponse prospect;
    private AddressResponse address;

    public GeneralDataResponse getProspect() {
        return prospect;
    }

    public void setProspect(GeneralDataResponse prospect) {
        this.prospect = prospect;
    }

    public AddressResponse getAddress() {
        return address;
    }

    public void setAddress(AddressResponse address) {
        this.address = address;
    }
}
