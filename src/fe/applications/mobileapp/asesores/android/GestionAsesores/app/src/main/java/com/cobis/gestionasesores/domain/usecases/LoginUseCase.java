package com.cobis.gestionasesores.domain.usecases;

import com.bayteq.libcore.util.DeviceUtils;
import com.bayteq.libcore.util.SecurityUtils;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.BankAdvisorApp;
import com.cobis.gestionasesores.BuildConfig;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.data.enums.Parameters;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.models.Session;
import com.cobis.gestionasesores.data.models.requests.AuthRequest;
import com.cobis.gestionasesores.data.models.responses.AuthResponse;
import com.cobis.gestionasesores.data.source.AuthDataSource;
import com.cobis.gestionasesores.infrastructure.SessionManager;
import com.cobis.gestionasesores.utils.SecurityUtil;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by Miguel on 14/07/2017.
 */

public class LoginUseCase extends UseCase<LoginUseCase.Params, ResultData> {
    private AuthDataSource mAuthDataSource;

    public LoginUseCase(AuthDataSource authDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mAuthDataSource = authDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final LoginUseCase.Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                ResultData loginUseResponse;
                SessionManager sessionManager = SessionManager.getInstance();
                if (parameter.isOnline) {
                    String deviceId = BuildConfig.IMEI;
                    if (!BuildConfig.DEBUG || StringUtils.isEmpty(deviceId)) {
                        deviceId = DeviceUtils.getSerialID();
                    }

                    AuthRequest request = new AuthRequest(parameter.user, SecurityUtil.encryptWithPublicKey(BankAdvisorApp.getInstance().getPublicKey(), parameter.password), deviceId, Constants.CHANNEL);
                    AuthResponse response = mAuthDataSource.login(request);
                    if (response.isResult()) {
                        Session session = new Session.Builder()
                                .setOnline(true)
                                .setToken(response.getToken())
                                .setUserName(parameter.user)
                                .setOfficerName(response.getOfficerName())
                                .setInactivityTimeout(response.getIdleTimeout())
                                .build();
                        sessionManager.createSession(session);
                        boolean isRegistered = !response.isProceedToCompleteRegistration();
                        loginUseResponse = new ResultData(sessionManager.isSessionActive() ? ResultType.SUCCESS : ResultType.FAILURE, response.getFirstMessage(), isRegistered);
                    } else {
                        loginUseResponse = new ResultData(ResultType.FAILURE, response.getFirstMessage());
                        sessionManager.closeSession();
                        String removeUserCode = BankAdvisorApp.getInstance().getConfig().getString(Parameters.CODE_REMOVED_USER);
                        if (response.getFirstMessage().getCode().equals(removeUserCode)) {
                            sessionManager.removeLastUserData();
                        }
                    }
                } else {
                    if (sessionManager.validatePIN(parameter.user, SecurityUtils.encodeWithSHA256(parameter.password))) {
                        Session session = new Session.Builder().
                                setOnline(false).
                                setUserName(parameter.user)
                                .build();
                        //take last session online if exits
                        Session lastSession = SessionManager.getInstance().getSession();
                        if (lastSession != null && lastSession.isOnline() && lastSession.getUserName().equals(parameter.user)) {
                            session.setToken(lastSession.getToken());
                        }
                        sessionManager.createSession(session);
                        loginUseResponse = new ResultData(ResultType.SUCCESS, null);
                    } else {
                        loginUseResponse = new ResultData(ResultType.FAILURE, null);
                    }
                }
                return loginUseResponse;
            }
        });
    }

    public static class Params {
        private boolean isOnline;
        private String user;
        private String password;

        public Params(String user, String password, boolean isOnline) {
            this.user = user;
            this.password = password;
            this.isOnline = isOnline;
        }
    }
}
