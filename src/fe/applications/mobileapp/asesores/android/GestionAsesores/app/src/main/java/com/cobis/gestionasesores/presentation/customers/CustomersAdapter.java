package com.cobis.gestionasesores.presentation.customers;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Person;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by mnaunay on 06/06/2017.
 */

public class CustomersAdapter extends RecyclerView.Adapter<CustomersAdapter.ViewHolder> {
    private List<Person> mData;
    private OnItemClickListener mListener;
    private int[] mServerIds;
    private int[] mLocalIds;

    public CustomersAdapter(List<Person> data, OnItemClickListener listener) {
        mData = data;
        mListener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_customer, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position), mListener);
    }


    public void setSelectedIds(int[] serverIds, int[] localIds) {
        mServerIds = serverIds;
        mLocalIds = localIds;
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public void replace(List<Person> customers) {
        mData.clear();
        mData.addAll(customers);
        notifyDataSetChanged();
    }

    public void clear() {
        mData.clear();
        notifyDataSetChanged();
    }

    public interface OnItemClickListener {
        void onItemClick(Person item);
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.text_title)
        TextView mTextTitle;
        @BindView(R.id.text_description)
        TextView mTextDescription;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(final Person customer, final OnItemClickListener listener) {
            mTextTitle.setText(customer.getName());
            mTextDescription.setText(customer.getDocument());

            if (contains(mServerIds, customer.getServerId()) || contains(mLocalIds, customer.getId())) {
                mTextTitle.setEnabled(false);
                mTextDescription.setEnabled(false);
                itemView.setEnabled(false);
            } else {
                mTextTitle.setEnabled(true);
                mTextDescription.setEnabled(true);
                itemView.setEnabled(true);
            }

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(customer);
                }
            });
        }

        private boolean contains(int[] list, int value) {
            if (list != null && list.length > 0) {
                for (int listValue : list) {
                    if (listValue == value) {
                        return true;
                    }
                }
            }
            return false;
        }
    }
}
