#import "HeligateContactPlugin.h"
#if __has_include(<heligate_contact/heligate_contact-Swift.h>)
#import <heligate_contact/heligate_contact-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "heligate_contact-Swift.h"
#endif

@implementation HeligateContactPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHeligateContactPlugin registerWithRegistrar:registrar];
}
@end
