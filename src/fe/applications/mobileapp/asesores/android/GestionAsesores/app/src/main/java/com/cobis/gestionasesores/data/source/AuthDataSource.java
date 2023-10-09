package com.cobis.gestionasesores.data.source;

import com.cobis.gestionasesores.data.models.requests.AuthRequest;
import com.cobis.gestionasesores.data.models.responses.AuthResponse;

/**
 * Created by Miguel on 14/07/2017.
 */

public interface AuthDataSource {
    AuthResponse login(AuthRequest loginRequest) throws Exception;
}
