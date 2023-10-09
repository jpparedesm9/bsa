package com.cobis.gestionasesores.presentation.simulation.simulationtable;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.MonthlyPayment;
import com.cobis.gestionasesores.widgets.amortizationtable.TableMainLayout;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by JosueOrtiz on 02/08/2017.
 */

public class SimulationTableFragment extends Fragment implements SimulationTableContract.SimulationTableView {
    @BindView(R.id.amoritzation_table)
    TableMainLayout mTableView;

    @BindView(R.id.text_interest_rate)
    TextView mInterestRateText;

    SimulationTableContract.SimulationTablePresenter mPresenter;

    public static SimulationTableFragment newInstance() {
        return new SimulationTableFragment();
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_simulator_table, container, false);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onResume() {
        super.onResume();
        mPresenter.start();
    }

    @Override
    public void setPresenter(SimulationTableContract.SimulationTablePresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void setContent(List<MonthlyPayment> monthlyPayments) {
        String[] headers = getActivity().getResources().getStringArray(R.array.simulation_headers);
        mTableView.setContent(monthlyPayments);
        mTableView.setHeaders(headers);
        mTableView.revalueHeaderCellsWidth();
    }

    @Override
    public void showInterestRate(double rate) {
        mInterestRateText.setText(getString(R.string.simulation_table_interest_rate_format, rate));
    }

    @Override
    public void renderTable() {
        mTableView.init();
    }
}