//
//  LoginModel.h
//  SHAREMEDICINE_SHOP_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "HRGBaseModel.h"

/**
 登录成功后的实体类
 */
@interface LoginModel : HRGBaseModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *idcard;
@property (nonatomic, copy) NSString *lastLoginTime;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *token;          // 用户票据编码
//@property (nonatomic, copy) NSString *businessCardUrl;
//@property (nonatomic, copy) NSString *companyPosition;
//@property (nonatomic, copy) NSString *email;
//@property (nonatomic, copy) NSString *memberPoint;  // 会员积分
//@property (nonatomic, copy) NSString *memberType;
//@property (nonatomic, copy) NSString *profilePhotoUrl;
//@property (nonatomic, copy) NSString *realname;

@property (nonatomic, copy) NSString *businessCardUrl;
@property (nonatomic, copy) NSString *businessScope;
@property (nonatomic, copy) NSString *companyCode;
@property (nonatomic, copy) NSString *companyDescription;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyLiscenseUrl;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *companyNature;
@property (nonatomic, copy) NSString *companyNatureCode;
@property (nonatomic, copy) NSString *companyPosition;
@property (nonatomic, copy) NSString *companyState;
@property (nonatomic, copy) NSString *companyTelephone;
@property (nonatomic, copy) NSString *customerDescription;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *foundingTime;
@property (nonatomic, copy) NSString *industryCategory;
@property (nonatomic, copy) NSString *industryCategoryCode;
@property (nonatomic, copy) NSString *legalPerson;
@property (nonatomic, copy) NSString *mainBusiness;
@property (nonatomic, copy) NSString *memberPoint;
@property (nonatomic, copy) NSString *memberState;
@property (nonatomic, copy) NSString *memberTelephone;
@property (nonatomic, copy) NSString *memberType;
@property (nonatomic, copy) NSString *profilePhotoUrl;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *registeredAddress;
@property (nonatomic, copy) NSString *registeredCapital;
@property (nonatomic, copy) NSString *wechatNumber;

- (NSString *)sexDesc;
- (NSString *) idcardDesc;

@end
