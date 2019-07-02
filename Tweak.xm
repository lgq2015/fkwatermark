

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



//皮皮搞笑
%hook ZYVideoDownloadManager

- (void)downloadWithMedia:(ZYMedia*)media loadingBlock:(id)block{
	NSArray* videoArr = [media videoURLArray];
	NSURL* noLogoVideoURL = videoArr[0];
	media.downloadURL = noLogoVideoURL;
	return %orig;
}
%end

// 抖音
%hook AWEVideoModel

- (id)endWatermarkDownloadURL{
	return [self playURL];
}
%end

// 皮皮虾

NSArray* noWatermarkUrlArr = nil;

%hook BDSFeedUserActionCollectionViewCellViewModel

-(void)shareAction:(id)arg2 {
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

	NSLog(@"xia0:%@", arg2);

	if (noWatermarkUrlArr)
	{
		return %orig(noWatermarkUrlArr);
	}

	
	return %orig;
}
%end


