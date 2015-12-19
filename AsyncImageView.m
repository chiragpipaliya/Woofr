
#import "AsyncImageView.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"
#import <QuartzCore/QuartzCore.h>
//
// Key's are URL strings.
// Value's are ImageCacheObject's
//
static ImageCache *imageCache = nil;

@implementation AsyncImageView
@synthesize delegate;
@synthesize isShadow;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
    [super dealloc];
}

-(void)loadImageFromURL:(NSURL*)url imageName:(NSString*)defaultImageName
{
    if (connection != nil) {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil) {
        [data release];
        data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
    
    [urlString release];
    urlString = [[url absoluteString] copy];
    UIImage *cachedImage = [imageCache imageForKey:urlString];

    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    
    if (cachedImage != nil) 
	{
        if ([[self subviews] count] > 0) 
		{
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        imageView.contentMode = UIViewContentModeScaleToFill;		
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if ([isShadow isEqualToString:@"Y"]) {
            [imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
            [imageView.layer setBorderWidth: 2.0];
            [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
            //            [imageView.layer setShadowRadius:3.0];
            [imageView.layer setShadowOpacity:0.5];
        }
        [self addSubview:imageView];
        imageView.frame = self.bounds;
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
		[delegate parserDidFinishLoading:@"done"];
        return;
	} 		
	// this shows a default place holder image if no cached image exists.
	else 
	{				
		// Use a default placeholder when no cached image is found
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[self scaleAndRotateImage:[UIImage imageNamed:defaultImageName]]] autorelease];
        if ([isShadow isEqualToString:@"Y"]) {
            [imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
            [imageView.layer setBorderWidth: 2.0];
            [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
            // [imageView.layer setShadowRadius:3.0];
            [imageView.layer setShadowOpacity:0.5];
        }
		CALayer *l = [imageView layer];
		l.masksToBounds = YES;
		// l.cornerRadius = 10.0;
		l.borderWidth = 1.0;
		l.borderColor = [[UIColor clearColor] CGColor];
		imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		[imageView setNeedsLayout];
		[self setNeedsLayout];		
	}    
	
#define SPINNY_TAG 5555 
    UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinny.tag = SPINNY_TAG;
    spinny.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [spinny startAnimating];
    [self addSubview:spinny];
    [spinny release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


-(void)loadImagewithActualSizeFromURL:(NSURL *)url
{
    isActualSize = YES;
    if (connection != nil) {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil) {
        [data release];
        data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:30*1024*1024];  // 2 MB Image cache
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [urlString release];
    urlString = [[url absoluteString] copy];
    UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil) {
        if ([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        imageView.backgroundColor = [UIColor clearColor];
        if ([isShadow isEqualToString:@"Y"]) {
            [imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
            [imageView.layer setBorderWidth: 2.0];
            [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
            // [imageView.layer setShadowRadius:3.0];
            [imageView.layer setShadowOpacity:0.5];
        }
        // imageView.contentMode = UIViewContentModeScaleAspectFit;
        // imageView.autoresizingMask = 
        // UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:imageView];
        imageView.frame = self.bounds;
        CGSize imageSize = [imageView.image size];
        self.backgroundColor = [UIColor clearColor];
        float ratioX = 0, ratioY = 0;
        BOOL isScallingX = NO;
        BOOL isScallingY = NO;
        NSLog(@"imageSize :%f------%f",imageSize.width,imageSize.height);
        if (imageSize.width < self.bounds.size.width) {
            float orignX = (self.bounds.size.width - imageSize.width)/2;
            imageView.frame = CGRectMake(orignX, imageView.frame.origin.y, imageSize.width, imageView.frame.size.height);
        }
        else {
            ratioX = imageSize.width/self.bounds.size.width;
            isScallingX = YES;
        }
        if (imageSize.height < self.bounds.size.height) {
            float origny = (self.bounds.size.height - imageSize.height)/2;
            imageView.frame = CGRectMake(imageView.frame.origin.x, origny, imageView.frame.size.width, imageSize.height);
        }
        else {
            ratioY = imageSize.height/self.bounds.size.height;
            isScallingY = YES;
        }
        
        if (isScallingX && isScallingY) {
            if (ratioX < ratioY) {
                float height = imageView.frame.size.height;
                float width = imageSize.width/ratioY;
                float originX = (self.bounds.size.width - width)/2;
                float originY = (self.bounds.size.height - height)/2;
                imageView.frame = CGRectMake(originX, originY, width, height);
            }
            else {
                float height = imageSize.height/ratioX;
                NSLog(@"%f---%f----%f",ratioX,height,imageSize.height);
                float width = imageView.frame.size.width;
                float originX = (self.bounds.size.width - width)/2;
                float originY = (self.bounds.size.height - height)/2;
                imageView.frame = CGRectMake(originX, originY, width, height);
            }
        }
        else if (isScallingY && !isScallingX) {
            float height = imageView.frame.size.height;
            float width = imageSize.width/ratioY;
            float originX = (self.bounds.size.width - width)/2;
            float originY = (self.bounds.size.height - height)/2;
            imageView.frame = CGRectMake(originX, originY, width, height);
        }
        else if (isScallingX && !isScallingY) {
            float height = imageSize.height/ratioX;
            float width = imageView.frame.size.width;
            float originX = (self.bounds.size.width - width)/2;
            float originY = (self.bounds.size.height - height)/2;
            imageView.frame = CGRectMake(originX, originY, width, height);
        }
        
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
        return;
    }
    
#define SPINNY_TAG 5555   
    
    UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinny.tag = SPINNY_TAG;
    spinny.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [spinny startAnimating];
    [self addSubview:spinny];
    [spinny release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    [connection release];
    connection = nil;
    
    if ([[self subviews] count] > 0) 
	{
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
	UIImage *image = [UIImage imageWithData:data];
    NSData *imgdata = [NSData dataWithData:UIImageJPEGRepresentation(image ,1)];
    if(imgdata.length != 0)
	{
		[imageCache insertImage:image withSize:[data length] forKey:urlString];    
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[self scaleAndRotateImage:image]] autorelease];
		imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if ([isShadow isEqualToString:@"Y"]) {
            [imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
            [imageView.layer setBorderWidth: 2.0];
            [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
//            [imageView.layer setShadowRadius:3.0];
            [imageView.layer setShadowOpacity:0.5];
        }
		[self addSubview:imageView];
        imageView.frame = self.bounds;
        if (isActualSize) {
            self.backgroundColor = [UIColor clearColor];
            CGSize imageSize = [imageView.image size];
            float ratioX = 0, ratioY = 0;
            BOOL isScallingX = NO;
            BOOL isScallingY = NO;
            NSLog(@"imageSize :%f------%f",imageSize.width,imageSize.height);
            if (imageSize.width < self.bounds.size.width) {
                float orignX = (self.bounds.size.width - imageSize.width)/2;
                imageView.frame = CGRectMake(orignX, imageView.frame.origin.y, imageSize.width, imageView.frame.size.height);
            }
            else {
                ratioX = imageSize.width/self.bounds.size.width;
                isScallingX = YES;
            }
            if (imageSize.height < self.bounds.size.height) {
                float origny = (self.bounds.size.height - imageSize.height)/2;
                imageView.frame = CGRectMake(imageView.frame.origin.x, origny, imageView.frame.size.width, imageSize.height);
            }
            else {
                ratioY = imageSize.height/self.bounds.size.height;
                isScallingY = YES;
            }
            
            if (isScallingX && isScallingY) {
                if (ratioX < ratioY) {
                    float height = imageView.frame.size.height;
                    float width = imageSize.width/ratioY;
                    float originX = (self.bounds.size.width - width)/2;
                    float originY = (self.bounds.size.height - height)/2;
                    imageView.frame = CGRectMake(originX, originY, width, height);
                }
                else {
                    float height = imageSize.height/ratioX;
                    NSLog(@"%f---%f----%f",ratioX,height,imageSize.height);
                    float width = imageView.frame.size.width;
                    float originX = (self.bounds.size.width - width)/2;
                    float originY = (self.bounds.size.height - height)/2;
                    imageView.frame = CGRectMake(originX, originY, width, height);
                }
            }
            else if (isScallingY && !isScallingX) {
                float height = imageView.frame.size.height;
                float width = imageSize.width/ratioY;
                float originX = (self.bounds.size.width - width)/2;
                float originY = (self.bounds.size.height - height)/2;
                imageView.frame = CGRectMake(originX, originY, width, height);
            }
            else if (isScallingX && !isScallingY) {
                float height = imageSize.height/ratioX;
                float width = imageView.frame.size.width;
                float originX = (self.bounds.size.width - width)/2;
                float originY = (self.bounds.size.height - height)/2;
                imageView.frame = CGRectMake(originX, originY, width, height);
            }
        }
		[imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
		[self setNeedsLayout];
		[delegate parserDidFinishLoading:@"done"];
	}
	else 
	{
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[self scaleAndRotateImage:image]] autorelease];
		imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if ([isShadow isEqualToString:@"Y"]) {
            [imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
            [imageView.layer setBorderWidth: 2.0];
            [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
            //            [imageView.layer setShadowRadius:3.0];
            [imageView.layer setShadowOpacity:0.5];
        }
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		[imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
		[self setNeedsLayout];		
	}

    [data release];
    data = nil;
}

- (UIImage *)scaleAndRotateImage:(UIImage *)imgPic 
{	
	int kMaxResolution = 640; // Or whatever	
    CGImageRef imgRef = imgPic.CGImage;	
    CGFloat width = CGImageGetWidth(imgRef);	
    CGFloat height = CGImageGetHeight(imgRef);	
    CGAffineTransform transform = CGAffineTransformIdentity;	
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) 
	{		
        CGFloat ratio = width/height;		
        if (ratio > 1) 
		{			
            bounds.size.width = kMaxResolution;			
            bounds.size.height = roundf(bounds.size.width / ratio);			
        }		
        else 
		{			
            bounds.size.height = kMaxResolution;			
            bounds.size.width = roundf(bounds.size.height * ratio);			
        }		
    }	
    CGFloat scaleRatio = bounds.size.width / width;	
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));	
    CGFloat boundHeight;	
    UIImageOrientation orient = imgPic.imageOrientation;	
    switch(orient) 
	{			
        case UIImageOrientationUp: //EXIF = 1			
            transform = CGAffineTransformIdentity;			
            break;			
			
        case UIImageOrientationUpMirrored: //EXIF = 2			
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);			
            transform = CGAffineTransformScale(transform, -1.0, 1.0);			
            break;			
			
        case UIImageOrientationDown: //EXIF = 3			
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);			
            transform = CGAffineTransformRotate(transform, M_PI);			
            break;			
			
        case UIImageOrientationDownMirrored: //EXIF = 4			
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);			
            transform = CGAffineTransformScale(transform, 1.0, -1.0);			
            break;
			
        case UIImageOrientationLeftMirrored: //EXIF = 5			
            boundHeight = bounds.size.height;			
            bounds.size.height = bounds.size.width;			
            bounds.size.width = boundHeight;			
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);			
            transform = CGAffineTransformScale(transform, -1.0, 1.0);			
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);			
            break;
			
        case UIImageOrientationLeft: //EXIF = 6			
            boundHeight = bounds.size.height;			
            bounds.size.height = bounds.size.width;			
            bounds.size.width = boundHeight;			
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);			
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);			
            break;
			
        case UIImageOrientationRightMirrored: //EXIF = 7			
            boundHeight = bounds.size.height;			
            bounds.size.height = bounds.size.width;			
            bounds.size.width = boundHeight;			
            transform = CGAffineTransformMakeScale(-1.0, 1.0);			
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);			
            break;
			
        case UIImageOrientationRight: //EXIF = 8			
            boundHeight = bounds.size.height;			
            bounds.size.height = bounds.size.width;			
            bounds.size.width = boundHeight;			
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);			
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);			
            break;			
        default:			
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];			
    }
	
    UIGraphicsBeginImageContext(bounds.size);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) 
	{		
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);		
        CGContextTranslateCTM(context, -height, 0);		
    }	
    else 
	{		
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);		
        CGContextTranslateCTM(context, 0, -height);		
    }
	
    CGContextConcatCTM(context, transform);	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);	
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();	
    UIGraphicsEndImageContext();	
    return imageCopy;	
}


-(void)setCacheImage:(UIImage*)imageForAsyncImageView
{
	UIImageView *imageView = [[[UIImageView alloc] 
							   initWithImage:[self scaleAndRotateImage:imageForAsyncImageView]] autorelease];
	imageView.contentMode = UIViewContentModeScaleToFill;
	imageView.autoresizingMask = 
	UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if ([isShadow isEqualToString:@"Y"]) {
        [imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
        [imageView.layer setBorderWidth: 2.0];
        [imageView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        //            [imageView.layer setShadowRadius:3.0];
        [imageView.layer setShadowOpacity:0.5];
    }
	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
	[self setNeedsLayout];
}

@end
