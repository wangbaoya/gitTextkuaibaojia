//
//  DataModel.h
//  whm_project
//
//  Created by Stephy_xue on 16/12/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WwordsModel.h"
#import "WproModel.h"
#import "WAgengModel.h"
#import "AAwprosModel.h"
#import "Agent_infoModel.h"
#import "childModel.h"
#import "WmessageModel.h"
#import "WstatisticsMode.h"
#import "WBYtjrListModel.h"
#import "WBYMongo_rataModel.h"
#import "WBYInsured.h"
//#import "BFrateModel.h"
#import "AAinterestsModel.h"
#import "ComModel.h"
#import "WbyHonorModel.h"
#import "WBYProsModel.h"
#import "WwRelaModel.h"
#import "ScoreModel.h"
#import "WBYsecondModel.h"
#import "WBYtotalRataModel.h"
#import "WwwGroupsModel.h"
#import "WBYcolvModel.h"
#import "AttrsModel.h"

#import "Wpro_groupModel.h"

@protocol DataModel
@end
@interface DataModel : JSONModel

@property(nonatomic,strong)NSArray<Wpro_groupModel,Optional> * pro_group;


@property(nonatomic,strong)NSArray<WwordsModel,Optional> * words;
@property(nonatomic,strong)NSArray<WbyHonorModel,Optional> * honor;
@property(nonatomic,strong)NSArray<childModel,Optional> * child;
@property(nonatomic,strong)NSArray<WproModel,Optional> * pro;
@property(nonatomic,strong)NSArray<WAgengModel,Optional> * agent;
@property(nonatomic,strong)NSArray<ComModel,Optional> * com;
@property(nonatomic,strong)NSArray<WwRelaModel,Optional> * rela;
@property(nonatomic,strong)NSArray<WBYsecondModel,Optional> * second;
@property(nonatomic,strong)NSArray<WwwGroupsModel,Optional> * groups;

@property(nonatomic,strong)WstatisticsMode * statistics;
@property(nonatomic,strong)Agent_infoModel * agent_info;
@property(nonatomic,strong)ScoreModel * score_m;
@property(nonatomic,strong)NSString * hid;
@property(nonatomic,strong)NSString * count_m;

@property(nonatomic,strong)NSArray<AAwprosModel,Optional> * pros;
@property(nonatomic,strong)NSArray<WmessageModel,Optional> * messages;
@property(nonatomic,strong)NSArray<WBYInsured >* interets;
@property(nonatomic,strong)NSArray<WBYMongo_rataModel >* rate;
@property(nonatomic,strong)NSArray <AAinterestsModel > * interests;
@property(nonatomic,strong)NSArray<WBYtjrListModel >* invited;
@property(nonatomic,strong)NSArray<AttrsModel,Optional> * attrs;
@property(nonatomic,copy)NSString * plan;
@property(nonatomic,copy)NSString * header_img;
@property(nonatomic,copy)NSString * price;



@property(nonatomic,strong)WBYtotalRataModel<Optional>* total_rate;
@property(nonatomic,strong)WBYcolvModel * cov;
@property(nonatomic,strong)WBYcolvModel * hasnt;
@property(nonatomic,strong)WBYcolvModel * accident_insured;
@property(nonatomic,strong)WBYcolvModel * disease_insured;



@property(nonatomic,copy)NSString * rate_m;
@property(nonatomic,copy)NSString * rec_count;
@property(nonatomic,copy)NSString * img1;
@property(nonatomic,copy)NSString * yearly_income;
@property(nonatomic,copy)NSString * debt;



//debt website introduce type_id relation_name score yearly_income
@property(nonatomic,copy)NSString * limit_age_name;
@property(nonatomic,copy)NSString * relation_name;
@property(nonatomic,copy)NSString * score;

@property(nonatomic,copy)NSString * pro_type_code_name;
@property(nonatomic,copy)NSString * sale_status_name;
@property(nonatomic,copy)NSString * website;
@property(nonatomic,copy)NSString * mydescription;
@property(nonatomic,copy)NSString * cid;
@property(nonatomic,copy)NSString * rela_count;
@property(nonatomic,copy)NSString * introduce;
@property(nonatomic,copy)NSString * reply_statu;
@property(nonatomic,copy)NSString * city_name;
@property(nonatomic,copy)NSString * message;
@property(nonatomic,copy)NSString * create_time;
@property(nonatomic,copy)NSString * provn;
@property(nonatomic,copy)NSString * type_id;






@property(nonatomic,copy)NSString * thumbnail;
@property(nonatomic,copy)NSString * cate_name;
@property(nonatomic,copy)NSString * created_time;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * source;
@property(nonatomic,copy)NSString * is_collect;
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * birthday;
@property(nonatomic,copy)NSString * area_info;
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * status_name;
@property(nonatomic,copy)NSString * id_number;
@property(nonatomic,copy)NSString * specialize_in;

@property(nonatomic,copy)NSString * profession;
@property(nonatomic,copy)NSString * status;

@property(nonatomic,copy)NSString * org_name;
@property(nonatomic,copy)NSString * org_id;
@property(nonatomic,copy)NSString * company_type;
@property(nonatomic,copy)NSString * company_type_name;
//@property(nonatomic,copy)NSString * company;
@property(nonatomic,copy)NSString * company_id;
//@property(nonatomic,copy)NSString * company_type;
//@property(nonatomic,copy)NSString * company_type_name;

@property(nonatomic,copy)NSString * job_address;
@property(nonatomic,copy)NSString * mongo_id;
@property(nonatomic,copy)NSString * ins_item_code;
@property(nonatomic,copy)NSString <Optional > * ins_type;
@property(nonatomic,copy)NSString * prod_type_code_name;
@property(nonatomic,copy)NSString * prod_desi_code_name;
@property(nonatomic,copy)NSString * special_attri_name;
@property(nonatomic,copy)NSString * insurance_period_name;
@property(nonatomic,copy)NSString * pay_period_name;
//pay_period insurance_period
@property(nonatomic,copy)NSString * pay_period;
@property(nonatomic,copy)NSString * insurance_period;

@property(nonatomic,strong)NSString<Optional> * id;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * short_name;
//其他信息
@property(nonatomic,strong)NSString <Optional> * clause;
@property(nonatomic,strong)NSString <Optional> * cases;
@property(nonatomic,strong)NSString <Optional> * rights;
@property(nonatomic,strong)NSString <Optional> * rule;
@property(nonatomic,strong)NSString <Optional> * pdf_path;
@property(nonatomic,strong)NSString <Optional> * company_logo;
@property(nonatomic,strong)NSString <Optional> * company_short_name;
@property(nonatomic,strong)NSString <Optional> * ins_type_name;
@property(nonatomic,strong)NSString <Optional> * is_main;
//@property(nonatomic,strong)WHcompany <Optional> * company;

//@property(nonatomic,strong)NSString <Optional> * company;
//company
//@property(nonatomic,strong)WBYOneDataModel * data;
@property(nonatomic,copy)NSString  * dist;
@property(nonatomic,copy)NSString  * type;
//@property(nonatomic,strong)LocationModel * location;

//@property(nonatomic,copy)NSString  * address;
@property(nonatomic,copy)NSString  * distance;
@property(nonatomic,copy)NSString  * latitude;
@property(nonatomic,copy)NSString  * longitude;
@property(nonatomic,copy)NSString  * tel;
@property(nonatomic,copy)NSString  * province_name;
//type_name
@property(nonatomic,copy)NSString  * out_trade_no;
@property(nonatomic,copy)NSString  * remark;
@property(nonatomic,copy)NSString  * title;
@property(nonatomic,copy)NSString  * total_fee;
@property(nonatomic,copy)NSString  * type_name;
@property(nonatomic,copy)NSString  * discount;
@property(nonatomic,copy)NSString  * minus;

@property(nonatomic,copy)NSString  * imit_age_name;
@property(nonatomic,copy)NSString  * prod_type_code;
@property(nonatomic,copy)NSString  * img;
@property(nonatomic,copy)NSString  * logo;

@property(nonatomic,copy)NSString  * small_img;
@property(nonatomic,copy)NSString  * sign;
@property(nonatomic,copy)NSString  * p_id;
@property(nonatomic,copy)NSString  * area_id;
@property(nonatomic,copy)NSString  * area_name;

//@property(nonatomic,strong)NSArray<WBYAgentModel >* agent_info;
//@property(nonatomic,strong)NSArray *  message;

@property(nonatomic,copy)NSString  * money;
@property(nonatomic,copy)NSString  * coin;
//记录get_finance
@property(nonatomic,copy)NSString  * uid;
@property(nonatomic,copy)NSString  * company_name;
//获取提现信息
@property(nonatomic,copy)NSString * finance_id;
@property(nonatomic,copy)NSString * card_num;
@property(nonatomic,copy)NSString * bank;
//@property(nonatomic,copy)NSString * pdf_path;
@property(nonatomic,copy)NSString  * pid;
@property(nonatomic,copy)NSString  * bee_type;
@property(nonatomic,copy)NSString  * insured;
//@property(nonatomic,strong)NSArray <BFrateModel >* rate;
@property (nonatomic, strong) NSString<Optional> *rec_uid;
@property (nonatomic, strong) NSString<Optional> *rec_mobile;
@property (nonatomic, strong) NSString<Optional> *rec_name;
@property (nonatomic, strong) NSString<Optional> *city;
@property (nonatomic, strong) NSString<Optional> *key;

// guide": "//就诊指南      "info": "//医院信息  depa
@property(nonatomic,copy)NSString  * addr;
@property(nonatomic,copy)NSString  * point;
@property(nonatomic,copy)NSString  * level;
@property(nonatomic,copy)NSString  * desi;
@property(nonatomic,copy)NSString  * autho;
@property(nonatomic,copy)NSString  * ids;
@property(nonatomic,copy)NSString  * nature;

@property(nonatomic,copy)NSString  * guide;
@property(nonatomic,copy)NSString  * info;
@property(nonatomic,copy)NSString  * depa;

@property(nonatomic,copy)NSString  * shortn;
@property(nonatomic,copy)NSString  * r_addr;
@property(nonatomic,copy)NSString  * prin;
@property(nonatomic,copy)NSString  * ctype;
@property(nonatomic,copy)NSString  * cond;
@property(nonatomic,copy)NSString  * cate;
@property(nonatomic,copy)NSString  * b_date;
@property(nonatomic,copy)NSString  * biaoti;
@property(nonatomic,copy)NSString  * dizhi;
@property(nonatomic,copy)NSString  * is_has_rate;
@property(nonatomic,copy)NSString  * juli;
//ret_num  interests
@property(nonatomic,copy)NSString  * ret_num;


@property(nonatomic,copy)NSString  * oname;
@property(nonatomic,copy)NSString  * mobile;
@property(nonatomic,copy)NSString  * cname;
@property(nonatomic,copy)NSString  * lat;
@property(nonatomic,copy)NSString  * lng;
@property(nonatomic,copy)NSString  * mycount;





@end
