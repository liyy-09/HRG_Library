package com.hrg.rec.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hrg.common.base.BaseFragment;
import com.hrg.rec.R;

/**
 * 充值fragment
 * */
public class RechargeFragment extends BaseFragment {

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @return A new instance of fragment GirlsFragment.
     */
    public static RechargeFragment newInstance() {
        return new RechargeFragment();
    }

    public RechargeFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.rec_fragment_recharge, container, false);
    }
}
