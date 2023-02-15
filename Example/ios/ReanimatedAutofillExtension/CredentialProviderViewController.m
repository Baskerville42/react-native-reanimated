//
//  CredentialProviderViewController.m
//  ReanimatedAutofillExtension
//
//  Created by Alexander Tartmin on 15.02.2023.
//

#import "CredentialProviderViewController.h"

#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

RCTBridge *bridge;
RCTRootView *rootView;

@implementation CredentialProviderViewController

- (void) viewWillDisappear:(BOOL)animated
{
    if (bridge != nil) {
        [bridge invalidate];
    }
}

- (void)loadReactNativeUI:(NSDictionary *) appProps
{
  NSMutableDictionary *appPropsFinal = [appProps mutableCopy];
  [appPropsFinal setValue:@true forKey:@"isAutofillExtensionContext"];

  bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];

  rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"ReanimatedExample" initialProperties:appPropsFinal];

  self.view = rootView;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

- (void)prepareCredentialListForServiceIdentifiers:(NSArray<ASCredentialServiceIdentifier *> *)serviceIdentifiers
{
  NSMutableArray *identifiers = [[NSMutableArray alloc] init];

  for (id serviceIdentifier in serviceIdentifiers) {
    [identifiers addObject:[serviceIdentifier identifier]];
  }

  NSDictionary *initialProps = [NSDictionary dictionaryWithObject: identifiers forKey:@"serviceIdentifiers"];
  [self loadReactNativeUI: initialProps];
}

- (IBAction)cancel:(id)sender
{
    [self.extensionContext cancelRequestWithError:[NSError errorWithDomain:ASExtensionErrorDomain code:ASExtensionErrorCodeUserCanceled userInfo:nil]];
}

- (IBAction)passwordSelected:(id)sender
{
    ASPasswordCredential *credential = [[ASPasswordCredential alloc] initWithUser:@"j_appleseed" password:@"apple1234"];
    [self.extensionContext completeRequestWithSelectedCredential:credential completionHandler:nil];
}

@end
