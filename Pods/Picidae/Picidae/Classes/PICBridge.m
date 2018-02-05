//
//  PICBridge.m
//  Pods
//
//  Created by Neo on 2017/3/2.
//
//

#import "PICBridge.h"
#import "PICError.h"
@interface PICBridge()
@property(nonatomic,strong)NSMutableDictionary * handlers;
@end
@implementation PICBridge
-(NSMutableDictionary *)handlers{
    if (_handlers == nil) {
        _handlers = [NSMutableDictionary dictionary];
    }
    return _handlers;
}
-(void)callRouter:(JSValue *)requestObject callBack:(JSValue *)callBack{
    NSDictionary * dict = [requestObject toDictionary];
    NSString * methodName = [dict objectForKey:@"Method"];
    if (methodName != nil && methodName.length>0) {
        NSDictionary * params = [dict objectForKey:@"Data"];
        __weak PICBridge * weakSelf = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf callAction:methodName params:params success:^(NSDictionary *responseDict) {
                    if (responseDict != nil) {
                        NSString * result = [weakSelf responseStringWith:responseDict];
                        if (result) {
                            [callBack callWithArguments:@[@"null",result]];
                        }
                        else{
                            [callBack callWithArguments:@[@"null",@"null"]];
                        }
                    }
                    else{
                        [callBack callWithArguments:@[@"null",@"null"]];
                    }
            } failure:^(NSError *error) {
                    if (error) {
                        [callBack callWithArguments:@[[error description],@"null"]];
                    }
                    else{
                        [callBack callWithArguments:@[@"App Inner Error",@"null"]];
                    }
            }];
        });
    }
    else{
        
        [callBack callWithArguments:@[@NO,[PICError ErrorWithCode:PICUnkonwError].description]];
    }
    return;
}
-(void)addActionHandler:(NSString *)actionHandlerName forCallBack:(void(^)(NSDictionary * params,void(^errorCallBack)(NSError * error),void(^successCallBack)(NSDictionary * responseDict)))callBack{
    if (actionHandlerName.length>0 && callBack != nil) {
        [self.handlers setObject:callBack forKey:actionHandlerName];
    }
}
-(void)callAction:(NSString *)actionName params:(NSDictionary *)params success:(void(^)(NSDictionary * responseDict))success failure:(void(^)(NSError * error))failure{
    void(^callBack)(NSDictionary * params,void(^errorCallBack)(NSError * error),void(^successCallBack)(NSDictionary * responseDict)) = [self.handlers objectForKey:actionName];
    if (callBack != nil) {
        callBack(params,failure,success);
    }
}
-(NSString *)responseStringWith:(NSDictionary *)responseDict{
    if (responseDict) {
        NSDictionary * dict = @{@"result":responseDict};
        NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString * result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        return result;
    }
    else{
        return nil;
    }
}
@end
