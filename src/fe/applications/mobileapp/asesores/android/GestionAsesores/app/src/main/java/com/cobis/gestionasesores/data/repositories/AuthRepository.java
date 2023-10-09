package com.cobis.gestionasesores.data.repositories;

import com.cobis.gestionasesores.data.models.requests.AuthRequest;
import com.cobis.gestionasesores.data.models.responses.AuthResponse;
import com.cobis.gestionasesores.data.source.AuthDataSource;
import com.cobis.gestionasesores.data.source.remote.AuthService;

/**
 * Created by Miguel on 14/07/2017.
 */

public class AuthRepository implements AuthDataSource {
    private static AuthRepository sInstance =  null;

    public static AuthRepository getInstance() {
        if(sInstance == null){
            sInstance = new AuthRepository();
        }
        return sInstance;
    }

    private AuthRepository() {
    }

    @Override
    public AuthResponse login(final AuthRequest loginRequest) throws Exception {
        return new AuthService().login(loginRequest);
    }
}
