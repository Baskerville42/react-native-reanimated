//
//  ReanimatedAutofillExtensionDelegate.m
//  ReanimatedAutofillExtension
//
//  Created by Alexander Tartmin on 15.02.2023.
//

#import "ReanimatedAutofillExtensionDelegate.h"

@interface ReanimatedAutofillExtensionDelegate ()
@property (nonatomic, strong) NSArray *extraModules;
@end

@implementation ReanimatedAutofillExtensionDelegate
+ (NSString *)moduleNameForBridge
{
    return @"ReanimatedExample";
}

- (instancetype)initWithExtensionContext:(ASCredentialProviderExtensionContext *)extensionContext
{
    return self;
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge
{
    return _extraModules;
}

@end

