package com.hrg.account.activity;

import android.os.Bundle;

import com.alibaba.android.arouter.facade.annotation.Route;
import com.hrg.account.R;
import com.hrg.common.base.BaseActivity;

/**
 * 登录页
 * */
@Route(path = "/account/login", group = "account")
public class LoginActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.account_activity_login);
    }
}
