//
//  CdeDownloads.h
//
//  Created by yuanfeixiong@letv.com on 2014-11-12.
//  Copyright (C) 2014 LeTV
//

#import <Foundation/Foundation.h>
#import "CdeDownloadItem.h"
#import "CdeService.h"

//
// CDE(Cloud Data Entry) Downloads
//
@interface CdeDownloads : NSObject <NSXMLParserDelegate>
{
    id callbackObject;
    NSString *callbackFunction;
    NSMutableArray *items;
}

@property (nonatomic, retain) NSMutableArray *items;

-(void)handleEventObject;
-(void)setDelegateObject:(id)cbobject setBackFunctionName:(NSString *)selectorName;
-(id)initWithService:(CdeService *)service apptag:(NSString *)apptag other:(NSString *)other;

-(void)startListener;
-(void)stopListener;

-(Boolean)add:(NSString *)url filePath:(NSString *)filePath fileDesc:(NSString *)fileDesc other:(NSString *)other;
-(Boolean)delete:(CdeDownloadItem *)item;
-(Boolean)pause:(CdeDownloadItem *)item;
-(Boolean)resume:(CdeDownloadItem *)item;
-(Boolean)prefer:(CdeDownloadItem *)item;
-(Boolean)up:(CdeDownloadItem *)item;
-(Boolean)down:(CdeDownloadItem *)item;
 
@end

