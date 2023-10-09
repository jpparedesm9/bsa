/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cobis.gestionasesores.data.models.responses;

/**
 *
 * @author mnaunay
 */
public class GeneralDataResponse extends GenericResponse{
    private PersonalInformationData data;

    public PersonalInformationData getData() {
        return data;
    }

    public void setData(PersonalInformationData data) {
        this.data = data;
    }
}
