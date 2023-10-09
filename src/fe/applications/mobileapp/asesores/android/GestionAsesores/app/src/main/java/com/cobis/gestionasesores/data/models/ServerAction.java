package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by bqtdesa02 on 9/4/2017.
 */

public class ServerAction implements Serializable{

    private String name;
    private String description;
    private boolean isRead;

    public ServerAction() {
    }

    public ServerAction(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean read) {
        isRead = read;
    }

    public String getFullDescription(){
        return name + " - " + description;
    }
}
