package com.hrg.account.fragment;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.hrg.account.R;
import com.hrg.common.base.BaseFragment;

public class PwdFragment extends BaseFragment {

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @return A new instance of fragment GirlsFragment.
     */
    public static PwdFragment newInstance() {
        return new PwdFragment();
    }


    public PwdFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.account_fragment_pwd, container, false);
    }


}
