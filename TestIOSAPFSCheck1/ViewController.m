#import "ViewController.h"


@implementation ViewController

/**
 
 
 Currently getting
 
 8192 on iOS Simulator
 4096 on iPhone 5 running iOS 10.3 beta 3
 
 need more data points or different method.. timestamp resolution?
 */
- (IBAction)runTestButtonPressed:(id)sender {
    
    static long long previousFree = 0;
    
    if ( previousFree == 0 ) {
        previousFree = [self getFreeDiskspace];
    }
    
    for ( int i=0; i < 100; i++ ) {
        [[NSFileManager defaultManager] removeItemAtPath: [self pathForIndex: i] error: nil];
    }
    
    char d[333]; // empty files could get optimized out to just file records, possibly replacing old file records "for free". also 333 < 512.

    for ( int i=0; i < 100; i++ ) {
        NSString *path = [self pathForIndex: i];
        
        NSData *data = [NSData dataWithBytes: d length: 333];
        [data writeToFile: path atomically: YES];
        
        
        long long space = [self getFreeDiskspace];
        long long diff = space - previousFree;
        
        previousFree = space;
        
        if ( diff != 0 ) {
        
            NSString *log = [NSString stringWithFormat: @"i: %003d %lld available: %lld (diff %lld)", i, (long long) ([NSDate timeIntervalSinceReferenceDate] * 1000 ), space, diff ];

            NSLog( @"%@", log );
            self.textView.text = [self.textView.text stringByAppendingString: [NSString stringWithFormat: @"%@\n", log]];
        }
    }
}


- (long long) getFreeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    } else {
    }
    
    return totalFreeSpace;
}


- (NSString*) pathForIndex: (int) i {
    
    NSString *filename = [NSString stringWithFormat: @"testX%d.txt", i];
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[ 0 ];
    NSString *path = [dir stringByAppendingPathComponent: filename];
    return path;
}

@end
