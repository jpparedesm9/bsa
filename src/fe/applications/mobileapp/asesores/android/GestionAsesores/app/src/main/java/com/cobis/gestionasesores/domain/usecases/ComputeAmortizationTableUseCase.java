package com.cobis.gestionasesores.domain.usecases;

import com.bayteq.libcore.util.NetworkUtils;
import com.cobis.gestionasesores.data.models.SimulationData;
import com.cobis.gestionasesores.data.models.SimulationResult;
import com.cobis.gestionasesores.data.source.SimulationDataSource;
import com.cobis.gestionasesores.domain.businesslogic.SimulationOperation;

import java.util.concurrent.Callable;

import io.reactivex.Observable;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by User on 09/08/2017.
 */

public class ComputeAmortizationTableUseCase extends UseCase<SimulationData, SimulationResult> {
    private SimulationDataSource mSimulationDataSource;

    public ComputeAmortizationTableUseCase(SimulationDataSource simulationDataSource) {
        super(Schedulers.io(), AndroidSchedulers.mainThread());
        mSimulationDataSource = simulationDataSource;
    }

    @Override
    protected Observable<SimulationResult> createObservableUseCase(final SimulationData parameter) {

        return Observable.fromCallable(new Callable<SimulationResult>() {
            @Override
            public SimulationResult call() throws Exception {
                SimulationResult result;
                if (parameter.isTryOnline() && NetworkUtils.isOnline()) {
                    result = mSimulationDataSource.simulate(parameter);
                } else {
                    result = new SimulationResult(true, parameter.getInterest(), new SimulationOperation().compute(parameter), null);
                }
                return result;
            }
        });
    }

}