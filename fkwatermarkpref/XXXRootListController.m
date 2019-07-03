#include "XXXRootListController.h"

@implementation XXXRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)gotoBlog {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://4ch12dy.site/aboutme/"]];
}


- (void)gotoGithub {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/4ch12dy/fkwatermark"]];
}

- (void)disable:(UISwitch*)sender {

    if([sender isOn]){

		NSLog(@"xia0:turn on");

	}else{

		NSLog(@"xia0:turned off");

	}
	NSLog(@"xia0:turned");
}

@end
