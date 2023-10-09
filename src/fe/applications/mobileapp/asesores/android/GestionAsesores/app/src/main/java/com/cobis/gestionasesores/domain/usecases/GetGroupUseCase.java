package com.cobis.gestionasesores.domain.usecases;

import com.bayteq.libcore.logs.Log;
import com.cobis.gestionasesores.data.enums.ResultType;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.data.models.ResultData;
import com.cobis.gestionasesores.data.source.GroupDataSource;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 8/8/2017.
 */

public class GetGroupUseCase extends UseCase<GetGroupUseCase.Params, ResultData> {

    private GroupDataSource mGroupDataSource;

    public GetGroupUseCase(GroupDataSource groupDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mGroupDataSource = groupDataSource;
    }

    @Override
    protected Observable<ResultData> createObservableUseCase(final Params parameter) {
        return Observable.fromCallable(new Callable<ResultData>() {
            @Override
            public ResultData call() throws Exception {
                Group group = mGroupDataSource.getGroup(parameter.groupId);
                ResultData resultData = null;
                if (parameter.enabledValidate && group != null) {
                    try {
                        resultData = mGroupDataSource.save(group, false);
                    } catch (Exception ex) {
                        Log.e("GetGroupUseCase", ex);
                    }
                }
                if (resultData == null) {
                    resultData = new ResultData(ResultType.SUCCESS, null);
                }
                resultData.setData(group);
                return resultData;
            }
        });
    }

    public static class Params {
        private int groupId;
        private boolean enabledValidate;

        public Params(int groupId, boolean enabledValidate) {
            this.groupId = groupId;
            this.enabledValidate = enabledValidate;
        }
    }
}
