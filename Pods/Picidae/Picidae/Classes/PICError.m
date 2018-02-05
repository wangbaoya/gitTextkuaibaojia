//
//  PICError.m
//  Pods
//
//  Created by Neo on 2017/3/4.
//
//

#import "PICError.h"

@implementation PICError
+(PICError *)ErrorWithCode:(NSInteger)code{
    PICError * error = [PICError errorWithDomain:@"AppErrorMsg" code:code userInfo:nil];
    return error;
}
-(NSString *)description{
    NSString * ErrorMsg = @"App call back error :";
    switch (self.code) {
        case PICNotFoundMethod:
            ErrorMsg = [ErrorMsg stringByAppendingString:@"not found method"];
            break;
        case PICParamaterDataInvalid:
            ErrorMsg = [ErrorMsg stringByAppendingString:@"paramater data invalid"];
            break;
        case PICUnkonwError:
            ErrorMsg = [ErrorMsg stringByAppendingString:@"unknow error"];
            break;
        default:
            ErrorMsg = [ErrorMsg stringByAppendingString:@"unknow error"];
            break;
    }
    return ErrorMsg;
}
@end
