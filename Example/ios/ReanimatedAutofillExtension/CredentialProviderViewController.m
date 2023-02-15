//
//  CredentialProviderViewController.m
//  ReanimatedAutofillExtension
//
//  Created by Alexander Tartmin on 15.02.2023.
//

#import "CredentialProviderViewController.h"

#import <React/RCTRootView.h>
#import <React/RCTBundleURLProvider.h>

#import "ReanimatedAutofillExtensionDelegate.h"

ReanimatedAutofillExtensionDelegate *autofillExtensionDelegate;
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
  
  autofillExtensionDelegate = [[ReanimatedAutofillExtensionDelegate alloc] initWithExtensionContext:self.extensionContext];

  bridge = [[RCTBridge alloc] initWithDelegate:autofillExtensionDelegate launchOptions:nil];

  rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:[ReanimatedAutofillExtensionDelegate moduleNameForBridge] initialProperties:appPropsFinal];

  self.view = rootView;
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
