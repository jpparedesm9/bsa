package com.cobis.gestionasesores.presentation.member;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.Spinner;

import com.bayteq.libcore.logs.Log;
import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.enums.Catalog;
import com.cobis.gestionasesores.data.models.CatalogItem;
import com.cobis.gestionasesores.data.models.Member;
import com.cobis.gestionasesores.data.models.MemberRelation;
import com.cobis.gestionasesores.data.repositories.CatalogRepository;
import com.cobis.gestionasesores.presentation.sections.CatalogItemAdapter;
import com.cobis.gestionasesores.widgets.searchablespinner.SearchableSpinner;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.observers.DisposableObserver;
import io.reactivex.schedulers.Schedulers;

/**
 * Created by bqtdesa02 on 9/26/2017.
 */

public class MemberRelationshipDialog extends DialogFragment {

    private static final String ARG_CURRENT_MEMBERS = "arg_current_members";

    private MemberRelationListener mListener;

    private Spinner mRelationshipTypeSpinner;

    private CatalogItemAdapter mRelationshipTypeAdapter;
    private RelatedMemberAdapter mRelationshipMemberAdapter;
    private List<Member> mCurrentMembers;
    private SearchableSpinner mMemberSpinner;

    public static MemberRelationshipDialog newInstance(@NonNull List<Member> currentMembers) {
        Bundle args = new Bundle();
        args.putSerializable(ARG_CURRENT_MEMBERS, (Serializable) currentMembers);
        MemberRelationshipDialog fragment = new MemberRelationshipDialog();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mCurrentMembers = (List<Member>) getArguments().getSerializable(ARG_CURRENT_MEMBERS);
    }

    @NonNull
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        View view = LayoutInflater.from(getContext()).inflate(R.layout.dialog_member_relation, null, false);

        mMemberSpinner = view.findViewById(R.id.spinner_rfc_relationship);
        mRelationshipTypeSpinner = view.findViewById(R.id.spinner_relationship);

        mMemberSpinner.setTitle(getString(R.string.member_select_related_member_title));
        mMemberSpinner.setPositiveButton(getString(R.string.action_cancel));

        mRelationshipTypeAdapter = new CatalogItemAdapter(getContext(), new ArrayList<CatalogItem>(), R.string.member_hint_relationship);
        mRelationshipMemberAdapter = new RelatedMemberAdapter(getContext(), mCurrentMembers, R.string.member_hint_rfc_relationship);

        loadCatalogs();

        mRelationshipTypeSpinner.setAdapter(mRelationshipTypeAdapter);
        mMemberSpinner.setAdapter(mRelationshipMemberAdapter);

        return new AlertDialog.Builder(getContext())
                .setTitle(R.string.member_relationship_title)
                .setView(view)
                .setPositiveButton(R.string.action_accept, mOnAcceptRelation)
                .setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        dismiss();
                    }
                })
                .create();
    }


    //This is a workaround to handle dismissing dialog on positive btn click
    //With the normal listener dialog is dismissed automatically
    @Override
    public void onResume() {
        super.onResume();
        final AlertDialog d = (AlertDialog) getDialog();
        if (d != null) {
            Button positiveButton = d.getButton(Dialog.BUTTON_POSITIVE);
            positiveButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    MemberRelation memberRelation = new MemberRelation.Builder()
                            .setCustomerId(mRelationshipMemberAdapter.getItem(mMemberSpinner.getSelectedItemPosition()).getServerId())
                            .setName(mRelationshipMemberAdapter.getItem(mMemberSpinner.getSelectedItemPosition()).getName())
                            .setRelationName(mRelationshipTypeAdapter.getItemValue(mRelationshipTypeSpinner.getSelectedItemPosition()))
                            .setRelationTypeCode(mRelationshipTypeAdapter.getItemCode(mRelationshipTypeSpinner.getSelectedItemPosition()))
                            .build();
                    if (validate(memberRelation)) {
                        mListener.onSelected(memberRelation);
                        d.dismiss();
                    }
                }
            });
        }
    }

    public void setListener(MemberRelationListener listener) {
        mListener = listener;
    }

    private boolean validate(MemberRelation memberRelation) {
        boolean isValid = true;
        mRelationshipTypeAdapter.clearError();
        mRelationshipMemberAdapter.clearError();

        if (memberRelation.getCustomerId() <= 0) {
            mRelationshipMemberAdapter.showError(R.string.val_field_required);
            isValid = false;
        }

        if (StringUtils.isEmpty(memberRelation.getRelationTypeCode())) {
            mRelationshipTypeAdapter.showError(R.string.val_field_required);
            isValid = false;
        }

        return isValid;
    }

    private void loadCatalogs() {
        @Catalog int[] catalogs = new int[]{Catalog.CAT_FAMILY_RELATIONSHIP};
        CatalogRepository.getInstance().getCatalogItemsByCodes(catalogs)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(new DisposableObserver<Map<Integer, List<CatalogItem>>>() {
                    @Override
                    public void onNext(@NonNull Map<Integer, List<CatalogItem>> integerListMap) {
                        for (Map.Entry<Integer, List<CatalogItem>> entry : integerListMap.entrySet()) {
                            handleCatalogItems(entry.getKey(), entry.getValue());
                        }
                    }

                    @Override
                    public void onError(@NonNull Throwable e) {
                        Log.e("MemberPresenter: Error getCatalogItemsByCodes! ", e);
                    }

                    @Override
                    public void onComplete() {
                    }
                });
    }

    private void handleCatalogItems(int code, List<CatalogItem> catalogItems) {
        switch (code) {
            case Catalog.CAT_FAMILY_RELATIONSHIP:
                mRelationshipTypeAdapter.setCatalogItems(catalogItems);
                break;
        }
    }

    //Look at workaround in onResume
    private DialogInterface.OnClickListener mOnAcceptRelation = new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialogInterface, int i) {
        }
    };

    public interface MemberRelationListener {
        void onSelected(MemberRelation relation);
    }
}
