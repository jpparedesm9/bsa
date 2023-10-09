package com.cobis.gestionasesores.presentation.comments;

import android.app.ProgressDialog;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TextInputEditText;
import android.support.design.widget.TextInputLayout;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.cobis.gestionasesores.R;

import butterknife.BindView;
import butterknife.ButterKnife;

public class CommentsFragment extends Fragment implements CommentsContract.View {

    CommentsContract.Presenter mPresenter;
    ProgressDialog mProgressDialog;

    @BindView(R.id.edit_text_comment)
    TextInputEditText mCommentText;

    @BindView(R.id.layout_comment_text_input)
    TextInputLayout mCommentInputLayout;

    public static CommentsFragment newInstance() {
        return new CommentsFragment();
    }

    @Override
    public void setPresenter(CommentsContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_comment,container,false);
        ButterKnife.bind(this,view);
        return view;

    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
        inflater.inflate(R.menu.comments,menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        mPresenter.sendCommentaries(mCommentText.getText().toString());
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void showSendComplete() {
        Toast.makeText(getContext(),getResources().getText(R.string.comments_send_ok), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showSendError() {
        Toast.makeText(getContext(),getResources().getText(R.string.comments_send_error), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showInputCommentariesError() {
        mCommentInputLayout.setError(getResources().getText(R.string.comments_input_invalid));
    }

    @Override
    public void clearAllErrors() {
        mCommentInputLayout.setErrorEnabled(false);
    }

    @Override
    public void showLoading() {
        mProgressDialog = new ProgressDialog(getContext());
        mProgressDialog.setMessage(getResources().getText(R.string.comments_sending));
        mProgressDialog.setCancelable(false);
        mProgressDialog.setCanceledOnTouchOutside(false);
        mProgressDialog.show();
    }

    @Override
    public void hideLoading() {
        if (mProgressDialog!=null && mProgressDialog.isShowing()){
            mProgressDialog.dismiss();
            mProgressDialog = null;
        }
    }

    @Override
    public void clearScreen() {
        mCommentText.getText().clear();
    }
}