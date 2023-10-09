package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.TaskType;

/**
 * Created by bqtdesa02 on 8/14/2017.
 */

public class Task extends Synchronizable {

    private int id;
    private String name;
    private String type;

    public Task(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @TaskType
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
