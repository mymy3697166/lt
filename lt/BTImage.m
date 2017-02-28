//
//  BTFile.m
//  lt
//
//  Created by zjz on 17/2/28.
//  Copyright © 2017年 zjz. All rights reserved.
//

#import "BTImage.h"

@implementation BTImage {
  
}
- (instancetype)init {
  self = [super init];
  
  return self;
}

- (instancetype)initWithUrl:(NSString *)url {
  self = [self init];
  _url = url;
  _name = _url.lastPathComponent;
  _length = 0;
  _isDataAvailable = NO;
  return self;
}

- (instancetype)initWithData:(NSData *)data {
  self = [self init];
  _data = data;
  _length = _data.length;
  _isDataAvailable = YES;
  UIImage *image = [UIImage imageWithData:data];
  _size = image.size;
  return self;
}

- (void)saveInBackground:(void(^)(NSError *))block {
  NSString *string = [[_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
  request.HTTPMethod = @"POST";
  request.HTTPShouldHandleCookies = NO;
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [request setValue:@"" forHTTPHeaderField:@"mtoken"];
  request.HTTPBody = [NSJSONSerialization dataWithJSONObject:@{@"images": @[string]} options:kNilOptions error:nil];
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (!error) {
      
    }
    block(error);
  }];
  [task resume];
}
@end
