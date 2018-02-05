//
//  PICError.h
//  Pods
//
//  Created by Neo on 2017/3/4.
//
//

#import <Foundation/Foundation.h>
NS_ENUM(NSInteger){
    PICNotFoundMethod = -30000,
    PICParamaterDataInvalid = -30001,
    PICUnkonwError = -30010
    };
@interface PICError : NSError
+(PICError *)ErrorWithCode:(NSInteger)code;
@end
