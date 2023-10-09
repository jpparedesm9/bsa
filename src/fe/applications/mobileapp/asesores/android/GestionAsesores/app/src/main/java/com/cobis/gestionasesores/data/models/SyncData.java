package com.cobis.gestionasesores.data.models;

import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.enums.SyncItemType;
import com.cobis.gestionasesores.data.enums.SyncStatusAction;

import java.io.Serializable;

public class SyncData implements Serializable {
    private SyncStatusAction action;
    @SyncItemType
    private int item;
    @ResultType
    private int type;
    private Object[] formatArgs;
    private boolean copyLine;

    public SyncData(SyncStatusAction action, @ResultType int type, @SyncItemType int item, boolean copyLine, Object... formatArgs) {
        this.action = action;
        this.type = type;
        this.item = item;
        this.copyLine = copyLine;
        this.formatArgs = formatArgs;
    }

    public boolean isCopyLine() {
        return copyLine;
    }

    public int getType() {
        return type;
    }

    public SyncStatusAction getAction() {
        return action;
    }

    public int getItem() {
        return item;
    }

    public Object[] getFormatArgs() {
        return formatArgs;
    }
}
