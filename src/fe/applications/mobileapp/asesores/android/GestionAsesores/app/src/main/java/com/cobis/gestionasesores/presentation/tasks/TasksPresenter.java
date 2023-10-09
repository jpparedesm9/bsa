package com.cobis.gestionasesores.presentation.tasks;

import android.annotation.SuppressLint;
import android.support.annotation.NonNull;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.data.enums.SyncStatus;
import com.cobis.gestionasesores.data.enums.TaskType;
import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.domain.usecases.GetTasksUseCase;

import java.util.List;

import io.reactivex.observers.DisposableObserver;

public class TasksPresenter implements TasksContract.Presenter {

    private TasksContract.View mView;

    private GetTasksUseCase mGetTasksUseCase;
    private String mLastKeyword;
    @TaskType
    private String mLastTaskType = TaskType.UNKNOWN;

    public TasksPresenter(TasksContract.View view, GetTasksUseCase getTasksUseCase) {
        mView = view;
        mGetTasksUseCase = getTasksUseCase;

        mView.setPresenter(this);
    }

    @Override
    public void start() {
        mLastKeyword = "";
        mView.clearSearch();
        getTasks(mLastKeyword, mLastTaskType, false);
    }

    @Override
    public void onRefresh() {
        getTasks(mLastKeyword, mLastTaskType, StringUtils.isNotEmpty(mLastKeyword));
    }

    @Override
    public void onSearchChange(String keyword) {
        mLastKeyword = keyword;
        getTasks(mLastKeyword, mLastTaskType, true);
    }

    @Override
    public void loadTasks(String taskType) {
        mLastTaskType = taskType;
        getTasks(mLastKeyword, mLastTaskType, false);
    }

    @SuppressLint("WrongConstant")
    @Override
    public void onTaskSelected(Task task) {
        switch (task.getType()) {
            case TaskType.SOLIDARITY_PAYMENT:
                mView.startSolidarityPayment((SolidarityPayment) task);
                break;
            case TaskType.GROUP_VERIFICATION:
                mView.startVerification((Verification) task);
                break;
            case TaskType.INDIVIDUAL_VERIFICATION:
                mView.startVerification((Verification) task);
                break;
            default:
                throw new RuntimeException("Task type not supported: " + task.getType());
        }
    }

    private void getTasks(String keyword, String taskType, final boolean isSearch) {
        mView.showLoadingIndicator();
        mGetTasksUseCase.execute(new GetTasksUseCase.GetTasksRequest(keyword, taskType, SyncStatus.UNKNOWN),
                new DisposableObserver<List<Task>>() {
                    @Override
                    public void onNext(@NonNull List<Task> payments) {
                        if (payments.isEmpty()) {
                            if (isSearch) {
                                mView.showNoResultsFound();
                            } else {
                                mView.showTasksEmpty();
                            }
                        } else {
                            mView.showTasks(payments);
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        mView.showLoadTasksError();
                        mView.hideLoadingIndicator();
                    }

                    @Override
                    public void onComplete() {
                        mView.hideLoadingIndicator();
                    }
                });
    }
}