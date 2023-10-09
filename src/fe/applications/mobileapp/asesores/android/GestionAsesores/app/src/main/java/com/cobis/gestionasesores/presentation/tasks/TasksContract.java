package com.cobis.gestionasesores.presentation.tasks;

import com.cobis.gestionasesores.data.models.SolidarityPayment;
import com.cobis.gestionasesores.data.models.Task;
import com.cobis.gestionasesores.data.models.Verification;
import com.cobis.gestionasesores.presentation.BasePresenter;
import com.cobis.gestionasesores.presentation.BaseView;

import java.util.List;

public interface TasksContract {
    interface Presenter extends BasePresenter {
        void onRefresh();

        void onSearchChange(String query);

        void loadTasks(String taskType);

        void onTaskSelected(Task task);
    }

    interface View extends BaseView<Presenter> {
        void showTasks(List<Task> tasks);

        void showTasksEmpty();

        void showNoResultsFound();

        void showLoadTasksError();

        void showLoadingIndicator();

        void hideLoadingIndicator();

        void clearResults();

        void clearSearch();

        void startVerification(Verification verification);

        void startSolidarityPayment(SolidarityPayment solidarityPayment);
    }
}