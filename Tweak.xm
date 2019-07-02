
@interface ZYMedia : NSObject

@property (retain, nonatomic) NSArray * videoURLArray;

@property (retain, nonatomic) NSURL* downloadURL;

@end

@interface AWEVideoModel : NSObject

@property (retain, nonatomic) id playURL;

@end

%hook ZYVideoDownloadManager

- (void)downloadWithMedia:(ZYMedia*)media loadingBlock:(id)block{
	NSArray* videoArr = [media videoURLArray];
	NSURL* noLogoVideoURL = videoArr[0];
	media.downloadURL = noLogoVideoURL;
	return %orig;
}
%end


%hook AWEVideoModel

- (id)endWatermarkDownloadURL{
	return [self playURL];
}
%end