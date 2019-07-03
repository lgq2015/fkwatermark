#import "xia0.h"
#import <notify.h>

// 皮皮搞笑
@interface ZYMedia : NSObject

@property (retain, nonatomic) NSArray * videoURLArray;

@property (retain, nonatomic) NSURL* downloadURL;

@end

// 抖音
@interface AWEVideoModel : NSObject

@property (retain, nonatomic) id playURL;

@end

// 皮皮虾
@interface BDSFeedUserActionCollectionViewCellViewModel : NSObject

@property (retain, nonatomic) id heavyItem;

@end
@interface BDSHeavyItemEntity : NSObject

@property (retain, nonatomic) id video;

@end
@interface BDSItemVideoEntity : NSObject

@property (retain, nonatomic) id videoHigh;

@end
@interface BDSVideoEntity : NSObject

@property (retain, nonatomic) id urlList;

@end

@interface BDSVideoUrlEntity : NSObject

@property (retain, nonatomic) id url;

@end




BOOL enableTweak = true;

#define FKWATERMARK_NOTIFICATION_DISABLETWEAK "com.xia0.fkwatermarkPref/settingschanged"

static void disablewatermark() {
	//CFPreferencesAppSynchronize(CFSTR("com.xia0.fkwatermarkPref"));
 	//CFBooleanRef enabled = (CFBooleanRef)CFPreferencesCopyAppValue(CFSTR("disableWatermark"), CFSTR("com.xia0.fkwatermarkPref"));
 	GCD_AFTER_MAIN(2)
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.xia0.fkwatermarkPref.plist"];

	NSLog(@"xia0:%@", prefs);
 	enableTweak = [prefs[@"kisRmoveWatermark"] boolValue];
 	NSLog(@"xia0:%d", enableTweak);
 	GCD_END
}


bool isRmoveWatermark(){
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.xia0.fkwatermarkPref.plist"];

	NSLog(@"xia0:%@", prefs);
 	bool enable = [prefs[@"kisRmoveWatermark"] boolValue];

 	return enable;
}


%ctor{
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.xia0.fkwatermarkPref.plist"];

	NSLog(@"xia0:%@", prefs);
 	enableTweak = [prefs[@"kisRmoveWatermark"] boolValue];
 	NSLog(@"xia0:%d", enableTweak);


	CFNotificationCenterAddObserver(
    	CFNotificationCenterGetDarwinNotifyCenter(),
   		NULL,
    	(CFNotificationCallback)disablewatermark,
    	CFSTR(FKWATERMARK_NOTIFICATION_DISABLETWEAK),
    	NULL,
    	CFNotificationSuspensionBehaviorCoalesce
	);
}


//皮皮搞笑
%hook ZYVideoDownloadManager

- (void)downloadWithMedia:(ZYMedia*)media loadingBlock:(id)block{
	NSLog(@"xia0:step 1");

	NSLog(@"xia0:%d", enableTweak);
	if (!enableTweak)	
	{
		NSLog(@"xia0:step 2");
		NSLog(@"xia0:disableTweak");
		return %orig;
	}
	NSLog(@"xia0:step 3");
	NSLog(@"xia0:enableTweak");

	NSArray* videoArr = [media videoURLArray];
	NSURL* noLogoVideoURL = videoArr[0];
	media.downloadURL = noLogoVideoURL;
	return %orig;
}
%end

// 抖音
%hook AWEVideoModel

- (id)endWatermarkDownloadURL{
	NSLog(@"xia0:step 1");

	NSLog(@"xia0:%d", enableTweak);
	if (!enableTweak)	
	{
		NSLog(@"xia0:step 2");
		NSLog(@"xia0:disableTweak");
		return %orig;
	}
	NSLog(@"xia0:step 3");
	NSLog(@"xia0:enableTweak");

	return [self playURL];
}
%end

// 皮皮虾

NSArray* noWatermarkUrlArr = nil;

%hook BDSFeedUserActionCollectionViewCellViewModel

-(void)shareAction:(id)arg2 {
	NSLog(@"xia0:step 1");

	NSLog(@"xia0:%d", enableTweak);
	if (!enableTweak)	
	{
		NSLog(@"xia0:step 2");
		NSLog(@"xia0:disableTweak");
		return %orig;
	}
	NSLog(@"xia0:step 3");
	NSLog(@"xia0:enableTweak");

	NSArray* urlList = [(BDSVideoEntity*)[(BDSItemVideoEntity*)[(BDSHeavyItemEntity*)[self heavyItem] video] videoHigh] urlList];
	BDSVideoUrlEntity* urlEntity = urlList[0];
	NSString* noWatermarkUrl = [urlEntity url];
	noWatermarkUrlArr = @[noWatermarkUrl,noWatermarkUrl];

	NSLog(@"xia0:%@", urlList);

	%orig;
}

%end

%hook TTVideoDownloadContentItem

-(id)initWithDownloadURL:(NSArray*)arg2{
	NSLog(@"xia0:step 1");

	NSLog(@"xia0:%d", enableTweak);
	if (!enableTweak)	
	{
		NSLog(@"xia0:step 2");
		NSLog(@"xia0:disableTweak");
		return %orig;
	}
	NSLog(@"xia0:step 3");
	NSLog(@"xia0:enableTweak");

	NSLog(@"xia0:%@", arg2);

	if (noWatermarkUrlArr)
	{
		return %orig(noWatermarkUrlArr);
	}

	
	return %orig;
}
%end


