package com.cobis.gestionasesores.data.source.local;

import com.bayteq.libcore.io.LibCoreIO;
import com.bayteq.libcore.persistence.internal.PersistenceBase;
import com.cobis.gestionasesores.infrastructure.KManager;

/**
 * Encrypted database to store business data
 * Created by mnaunay on 28/06/2017.
 */

public abstract class EncryptedDatabase extends PersistenceBase {
    private static final int VERSION = 2;
    static final String DATABASE_NAME = "advisorstore_%s.db";
    static final String FIELD_ID = "id";
    static final String FIELD_SERVER_ID = "server_id";
    static final String FIELD_DATA = "data";
    static final String FIELD_STATUS = "status";
    static final String FIELD_TIMESTAMP = "timestamp";

    public EncryptedDatabase() {
        super(LibCoreIO.getAppDirectory(), String.format(DATABASE_NAME, KManager.getInstance().getUserKey()),
                KManager.getInstance().getDatabaseKey(),
                VERSION);
    }

    @Override
    protected void onUpgrade(int oldVersion, int newVersion) {
    }
}