//
//  PICBridge.h
//  Pods
//
//  Created by Neo on 2017/3/2.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol PICBridgeExport <JSExport>
JSExportAs(callRouter, -(void)callRouter:(JSValue *)requestObject callBack:(JSValue *)callBack);
@end
@interface PICBridge : NSObject<PICBridgeExport>
-(void)addActionHandler:(NSString *)actionHandlerName forCallBack:(void(^)(NSDictionary * params,void(^errorCallBack)(NSError * error),void(^successCallBack)(NSDictionary * responseDict)))callBack;
@end
