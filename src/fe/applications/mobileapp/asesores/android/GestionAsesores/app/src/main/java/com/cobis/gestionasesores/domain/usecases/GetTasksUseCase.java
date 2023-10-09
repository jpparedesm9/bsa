package com.cobis.gestionasesores.domain.usecases;

import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.source.TaskDataSource;

import java.util.List;
import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 8/16/2017.
 */

public class GetTasksUseCase extends UseCase<GetTasksUseCase.GetTasksRequest, List<Task>> {

    private TaskDataSource mTaskDataSource;

    public GetTasksUseCase(TaskDataSource taskDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mTaskDataSource = taskDataSource;
    }

    @Override
    protected Observable<List<Task>> createObservableUseCase(final GetTasksRequest parameter) {
        return Observable.fromCallable(new Callable<List<Task>>() {
            @Override
            public List<Task> call() throws Exception {
                return mTaskDataSource.getAll(parameter.keyword,parameter.taskType,parameter.syncStatus);
            }
        });
    }

    public static class GetTasksRequest{
        @TaskType
        String taskType;
        @SyncStatus
        int syncStatus;
        String keyword;

        public GetTasksRequest(String keyword, @TaskType String taskType, @SyncStatus int syncStatus) {
            this.keyword = keyword;
            this.taskType = taskType;
            this.syncStatus = syncStatus;
        }
    }
}
