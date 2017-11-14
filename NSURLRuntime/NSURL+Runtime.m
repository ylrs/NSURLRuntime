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
    
    //若链接包含文字或空格,需要转义
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 10.0) {
        if ([self isChineseCharacter:URLString] || [URLString rangeOfString:@""].location != NSNotFound) {
            urlStr = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        else{
            urlStr = URLString;
        }
    }
    else if(version >= 10.0) {
        
        if ([self isChineseCharacter:URLString] || [URLString rangeOfString:@""].location != NSNotFound) {
            NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
            NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
            
            urlStr = [URLString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        }
        else{
            urlStr = URLString;
        }
    }
    NSURL *url = [NSURL Safe_URLWithString:urlStr];
    return url;
}

+(BOOL)isChineseCharacter:(NSString *)string {
    NSInteger len = string.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[string characterAtIndex:i];
        if(!((isalpha(a))||(isalnum(a))||((a >= 0x4e00 && a <= 0x9fa6))))
            return NO;
    }
    return YES;
}

@end

