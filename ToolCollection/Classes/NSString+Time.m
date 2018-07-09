//
//  NSString+Time.m
//  ScreenRecorder
//
//  Created by ljk on 2018/5/2.
//  Copyright © 2018年 flow. All rights reserved.
//

#import "NSString+Time.h"
#import <sys/stat.h>

@implementation NSString (Time)

- (nullable NSDate *)creationDate {
    
    struct stat statbuf;
    const char *cpath = [self fileSystemRepresentation];
    if (cpath && stat(cpath, &statbuf) == 0) {
//        NSNumber *fileSize = [NSNumber numberWithUnsignedLongLong:statbuf.st_size];
//        NSDate *modificationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_mtime];
        NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_ctime];
        // etc
        
        return creationDate;
    }
    return nil;
}

//+ (void)umeng {
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//
//    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
//}

@end
