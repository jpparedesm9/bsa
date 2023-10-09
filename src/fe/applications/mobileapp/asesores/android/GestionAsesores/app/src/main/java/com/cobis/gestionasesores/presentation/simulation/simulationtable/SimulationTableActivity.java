package com.cobis.gestionasesores.presentation.simulation.simulationtable;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.data.models.SimulationResult;
import com.cobis.gestionasesores.presentation.BaseActivity;

import java.io.Serializable;
import java.util.List;

/**
 * Created by JosueOrtiz on 02/08/2017.
 */

public class SimulationTableActivity extends BaseActivity {
    private static final String EXTRA_RESULT = "RESULT";

    public static Intent newIntent(Context context, SimulationResult simulationResult) {
        Intent intent = new Intent(context, SimulationTableActivity.class);
        intent.putExtra(EXTRA_RESULT, simulationResult);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_simulation_table);
        SimulationTableFragment fragment = (SimulationTableFragment) getSupportFragmentManager()
                .findFragmentById(R.id.fragment_container);
        if (fragment == null) {
            fragment = SimulationTableFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.fragment_container, fragment).commit();
        }

        new SimulationTablePresenter(fragment, (SimulationResult) getIntent().getSerializableExtra(EXTRA_RESULT));
    }
}
