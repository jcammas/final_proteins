#import "ProteinsPlugin.h"
#if __has_include(<proteins/proteins-Swift.h>)
#import <proteins/proteins-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "proteins-Swift.h"
#endif

@implementation ProteinsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftProteinsPlugin registerWithRegistrar:registrar];
}
@end
