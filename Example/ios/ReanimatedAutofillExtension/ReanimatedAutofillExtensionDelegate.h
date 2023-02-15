//
//  ReanimatedAutofillExtensionDelegate.h
//  ReanimatedExample
//
//  Created by Alexander Tartmin on 15.02.2023.
//

#import <React/RCTBridgeDelegate.h>
#import <React/RCTBundleURLProvider.h>
#import <AuthenticationServices/AuthenticationServices.h>

@interface ReanimatedAutofillExtensionDelegate : NSObject <RCTBridgeDelegate>
+ (NSString *)moduleNameForBridge;
- (instancetype)initWithExtensionContext:(ASCredentialProviderExtensionContext *)extensionContext;
@end
