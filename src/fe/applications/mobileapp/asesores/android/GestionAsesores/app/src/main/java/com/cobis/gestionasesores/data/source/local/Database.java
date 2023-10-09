package com.cobis.gestionasesores.data.source.local;

import com.bayteq.libcore.io.LibCoreIO;
import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.persistence.internal.PersistenceBase;

/**
 * Database entity to storage catalogs and parameters
 * Created by mnaunay on 06/06/2017.
 */

public abstract class Database extends PersistenceBase {
    private static final String DATABASE_NAME = "database.db";
    private static final int VERSION = 0;

    public Database() {
        super(LibCoreIO.getAppDirectory(),DATABASE_NAME,VERSION);
    }

    public void execute(String sql) {
        try {
            this.getPersistenceDAO().execSQL(sql);
        } catch (Exception ex) {
            Log.e("PersistenceCatalog::execute: ", ex);
        }
    }

    @Override
    protected void onUpgrade(int i, int i1) {
    }
}
