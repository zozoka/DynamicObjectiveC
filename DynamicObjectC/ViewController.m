//
//  ViewController.m
//  DynamicObjectC
//
//  Created by thanh tung on 11/14/15.
//  Copyright © 2015 thanh tung. All rights reserved.
//

#import "ViewController.h"

#pragma mark - Animals
@interface Cat: NSObject
@end

@implementation Cat
    - (void) say{
        NSLog(@"meo meo");
        
    }
-(NSString*) image{
    return @"cat";
}
@end

@interface Dog : NSObject

@end

@implementation Dog
-(void) say{
    NSLog(@"gau gau");
}
-(NSString*) image{
    return @"dog";
}
@end

@interface Mouse : NSObject

@end

@implementation Mouse

-(void) say{
    NSLog(@"chit chit");
}
-(NSString*) image{
    return @"mouse";
}
@end

#pragma mark - Protocols
@protocol Fly <NSObject>
-(void) fly;
@end

@protocol Swim <NSObject>
-(void) swim;
@end

@interface Turtle:NSObject<Swim>
@end
@implementation Turtle

-(void) swim{
    NSLog(@"i can swim");
}

@end



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtInput;
@property (weak, nonatomic) IBOutlet UIImageView *imageAnimals;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)onSearchTab:(id)sender {
    //NSArray* animals = @[@"Cat",@"Dog",@"Mouse",@"Elephant",@"Tiger"];
    //int index = arc4random_uniform((u_int32_t) animals.count);
    NSString* input = _txtInput.text;
    // uppercase the first letter in string input
    NSString* firstChar = [input substringToIndex:1];
    NSString* result = [[input stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstChar] capitalizedString];
    
    Class class = NSClassFromString(result);
    if (class == nil) {
        NSLog(@"Class not exitd");
        _imageAnimals.image = [UIImage imageNamed:@"notfound"];
        return;
    }
    else{
        id obj = [class new];
        SEL sayMenthor = @selector(say);
        SEL imageMethor = @selector(image);
        if([obj respondsToSelector:sayMenthor]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:sayMenthor];
            _imageAnimals.image = [UIImage imageNamed:[obj performSelector:imageMethor]];
#pragma clang diagnostic pop
        }
    }
}
- (IBAction)callMethodFromString:(id)sender {
    NSArray* methods = @[@"hello",@"name",@"rob bank"];
    int index = arc4random_uniform((u_int32_t)methods.count);
    SEL method = NSSelectorFromString(methods[index]);
    if ([self respondsToSelector:method]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:method];
#pragma clang diagnostic pop
    }else{
        NSLog(@"method is not exited.");
    }
}
- (IBAction)createProtocalFromString:(id)sender {
    NSArray* protocols = @[@"Fly",@"Swim"];
    Turtle *turtle = [Turtle new];
    for (NSString* protocolName in protocols) {
        Protocol* protocol = NSProtocolFromString(protocolName);
        if ([turtle conformsToProtocol:protocol]) {
            NSLog(@"turtle adopt %@ protocol", protocolName);
        }
    }
}

-(void) hello{
    NSLog(@"hello");
}
-(void) name{
    NSLog(@"my name Tung");
}
@end
