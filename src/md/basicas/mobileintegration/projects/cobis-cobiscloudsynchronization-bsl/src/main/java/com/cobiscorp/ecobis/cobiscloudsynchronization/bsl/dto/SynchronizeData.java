/**
 * Archivo: public class SynchronizeData
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.dto;

import java.util.Map;
import java.util.HashMap;


public class SynchronizeData {

    private String date;

    private String entity;

    private Integer entityId;

    private Integer idSync;

    private Integer registersNumber;

    private String state;

    private String user;

    public SynchronizeData() {
        //Empty contructor in order to build basic DTO
    }

    public SynchronizeData(Map objectMap) {

        String wDate = (String) objectMap.get("date");
        setDate(wDate);

        String wEntity = (String) objectMap.get("entity");
        setEntity(wEntity);

        Integer wIdSync = (Integer) objectMap.get("idSync");
        setIdSync(wIdSync);

        Integer wEntityId = (Integer) objectMap.get("entityId");
        setEntityId(wEntityId);

        Integer wRegistersNumber = (Integer) objectMap.get("registersNumber");
        setRegistersNumber(wRegistersNumber);

        String wState = (String) objectMap.get("state");
        setState(wState);

        String wUser = (String) objectMap.get("user");
        setUser(wUser);
    }


    public Map toMap() {
        Map objectMap = new HashMap();

        String wDate = getDate();
        objectMap.put("date", wDate);

        String wEntity = getEntity();
        objectMap.put("entity", wEntity);

        Integer wIdSync = getIdSync();
        objectMap.put("idSync", wIdSync);

        Integer wEntityId = getEntityId();
        objectMap.put("entityId", wEntityId);

        Integer wRegistersNumber = getRegistersNumber();
        objectMap.put("registersNumber", wRegistersNumber);

        String wState = getState();
        objectMap.put("state", wState);

        String wUser = getUser();
        objectMap.put("user", wUser);
        return objectMap;
    }

    /**
     * returns  date
     */
    public String getDate() {
        return this.date;
    }

    /**
     * returns  entity
     */
    public String getEntity() {
        return this.entity;
    }

    /**
     * returns  idSync
     */
    public Integer getIdSync() {
        return this.idSync;
    }

    /**
     * returns  registersNumber
     */
    public Integer getRegistersNumber() {
        return this.registersNumber;
    }

    /**
     * returns  state
     */
    public String getState() {
        return this.state;
    }

    /**
     * returns  user
     */
    public String getUser() {
        return this.user;
    }

    public void setDate(String aDate) {
        this.date = aDate;
    }

    public void setEntity(String aEntity) {
        this.entity = aEntity;
    }

    public void setIdSync(Integer aIdSync) {
        this.idSync = aIdSync;
    }

    public void setRegistersNumber(Integer aRegistersNumber) {
        this.registersNumber = aRegistersNumber;
    }

    public void setState(String aState) {
        this.state = aState;
    }

    public void setUser(String aUser) {
        this.user = aUser;
    }

    public Integer getEntityId() {
        return entityId;
    }

    public void setEntityId(Integer entityId) {
        this.entityId = entityId;
    }

    @Override
    public String toString() {
        return toMap().toString();
    }
}
