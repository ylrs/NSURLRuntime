//
//  NSURL+Runtime.m
//  NSURLRuntime
//
//  Created by YLRS on 2017/11/14.
//  Copyright © 2017年 YLRS. All rights reserved.
//

#import "NSURL+Runtime.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>
@implementation NSURL (Runtime)
+(void)load
{
    Class urlClass = [NSURL class];
    Method urlStringMethod = class_getClassMethod(urlClass, @selector(URLWithString:));
    Method safeURLMethod = class_getClassMethod(urlClass, @selector(Safe_URLWithString:));
    
    //交互方法
    method_exchangeImplementations(urlStringMethod, safeURLMethod);
    
}
+(instancetype)Safe_URLWithString:(NSString *)URLString
{
    if (URLString == nil) {
        return nil;
    }
    
    NSString *urlStr;
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 10.0) {
        urlStr = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else if(version >= 10.0) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];

        urlStr = [URLString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    }
    NSURL *url = [NSURL Safe_URLWithString:urlStr];
    return url;
}
@end
