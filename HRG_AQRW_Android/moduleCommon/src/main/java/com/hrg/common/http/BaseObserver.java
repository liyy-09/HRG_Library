package com.hrg.common.http;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.hrg.common.view.LoadingView;
import com.jwenfeng.library.pulltorefresh.PullToRefreshLayout;

import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

public abstract class BaseObserver<E> implements Observer<BaseEntity<E>> {
    private static final String TAG = "BaseObserver";

    private Context mContext;
    private LoadingView mDialog;
    private PullToRefreshLayout mRefreshLayout;

    private boolean mLogin;
    private boolean reLogin;
    public boolean mCheckURL;

    public void setReLogin(boolean reLogin) {
        this.reLogin = reLogin;
    }

    protected BaseObserver(Context context, LoadingView dialog, PullToRefreshLayout refreshLayout, boolean isLogin) {
        this.mContext = context; // context.getApplicationContext();
        mDialog = dialog;
        mRefreshLayout = refreshLayout;
        mLogin = isLogin;
    }

    @Override
    public void onSubscribe(Disposable d) {
        // 不管取消，和生命周期绑定，由RxLifecycle处理
    }

    @Override
    public void onNext(BaseEntity<E> value) {
        if (value.getEasyDarwin().getHeader().isSuccess()) {
            E e = value.getEasyDarwin().getBody();
            onHandleSuccess(e);
        } else {
            onHandlerError(value.getEasyDarwin().getHeader().getMsg(), value.getEasyDarwin().getHeader().getCode());
        }
    }

    @Override
    public void onError(Throwable error) {
        Log.e(TAG, "onError:" + error.toString());

        if (mCheckURL && error.toString().indexOf("com.google.gson.stream.MalformedJsonException") != -1) {
            onHandleSuccess(null);
        } else {
            onHandlerError(error.getMessage(), -1);
        }
    }

    @Override
    public void onComplete() {
        Log.d(TAG, "onComplete");
    }

    protected abstract void onHandleSuccess(E e);
    protected abstract void loginSuccess();

    /**
     * 对通用问题的统一拦截处理
     * */
    protected void onHandlerError(String msg, int code) {
        if (mDialog != null) {
            mDialog.cancel();
        }

        if (mRefreshLayout != null) {
            mRefreshLayout.finishLoadMore();
            mRefreshLayout.finishRefresh();
        }

        if (mLogin) {
            Toast.makeText(mContext, "用户名密码错误", Toast.LENGTH_SHORT).show();

            if (reLogin) {
//                Intent intent = new Intent(BaseApplication.getContext(), LoginActivity.class);
//                intent.putExtra("isTokenInvalid", true);
//                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//                mContext.startActivity(intent);
            }

            return;
        }

        // token没有失效
        if (msg != null && msg.indexOf("401") == -1) {
//            Toast.makeText(mContext, msg, Toast.LENGTH_SHORT).show();
            return;
        }

//        // 401 token失效
//        SharedHelper helper = new SharedHelper(NVRApplication.getContext());
//        Account account = helper.readAccount();
//        if (account.getUserName().equals("") || account.getPwd().equals("")) {
//            Intent intent = new Intent(NVRApplication.getContext(), LoginActivity.class);
//            intent.putExtra("isTokenInvalid", true);
//            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            mContext.startActivity(intent);
//        } else {
//            BaseObserver bo = new BaseObserver<User>(mContext, mDialog, null, true) {
//                @Override
//                protected void onHandleSuccess(User user) {
//                    SharedHelper helper = new SharedHelper(NVRApplication.getContext());
//                    Account account = helper.readAccount();
//                    account.setToken(user.getToken());
//                    helper.saveAccount(account);
//
//                    // 再次处理上一个请求
//                    loginSuccess();
//                }
//
//                @Override
//                protected void loginSuccess() {
//
//                }
//            };
//            bo.setReLogin(true);
//
//            Observable<BaseEntity<User>> observable = RetrofitFactory.getRetrofitService().login(account.getUserName(), account.md5Pwd());
//            observable.subscribeOn(Schedulers.io())
//                    .observeOn(AndroidSchedulers.mainThread())
//                    .subscribe(bo);
//        }
    }
}
