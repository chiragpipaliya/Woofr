
#import <UIKit/UIKit.h>

@protocol AsyncImageViewDelegate <NSObject>
@optional
- (void)parserDidFinishLoading:(NSString *)responseString;
- (void)parserDidFailWithError:(NSError*)error;
@end


@interface AsyncImageView : UIView {
    BOOL isActualSize;
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString; // key for image cache dictionary
	UILabel *plsWait;
    
	id <AsyncImageViewDelegate> delegate;
}

@property (retain) id delegate;
@property (nonatomic, retain) NSString *isShadow;

- (void)loadImageFromURL:(NSURL*)url imageName:(NSString*)defaultImageName;
- (void)loadImagewithActualSizeFromURL:(NSURL *)url;
- (UIImage *)scaleAndRotateImage:(UIImage *)imgPic ;
- (void)setCacheImage:(UIImage*)imageForAsyncImageView;
@end
