//
//  ViewController.m
//  Keyboard Test
//
//  Created by Mark Goody on 02/01/2014.
//  Copyright (c) 2014 GCD Technologies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSArray *keyboardNotificationNames;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithWhite:.9f alpha:1.f];
	self.textView.text = @"";
	
	self.keyboardNotificationNames = @[
									   UIKeyboardWillShowNotification,
									   UIKeyboardDidShowNotification,
									   UIKeyboardWillHideNotification,
									   UIKeyboardDidHideNotification,
									   UIKeyboardWillChangeFrameNotification,
									   UIKeyboardDidChangeFrameNotification
									   ];
	
	UITapGestureRecognizer *tappity = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTwinTap:)];
	tappity.numberOfTapsRequired = 2;
	tappity.numberOfTouchesRequired = 1;
	[self.view addGestureRecognizer:tappity];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self startObservingKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[self stopObservingKeyboardNotifications];
	
	[super viewWillDisappear:animated];
}

- (void)startObservingKeyboardNotifications
{
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
	for (NSString *name in self.keyboardNotificationNames) {
		[defaultCenter addObserver:self
						  selector:@selector(keyboardNotificationReceived:)
							  name:name
							object:nil];
	}
}

- (void)stopObservingKeyboardNotifications
{
	NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
	
	for (NSString *name in self.keyboardNotificationNames) {
		[defaultCenter removeObserver:self
								 name:name
							   object:nil];
	}
}

- (void)keyboardNotificationReceived:(NSNotification *)note
{
	NSString *logLine = [NSString stringWithFormat:@"[%@] %@\n", [NSDate date], note.name];
	
	self.textView.text = [self.textView.text stringByAppendingString:logLine];
}

- (IBAction)clear:(id)sender
{
	self.textView.text = @"";
}

- (void)doubleTwinTap:(id)sender
{
	self.textView.text = [self.textView.text stringByAppendingString:@"--------\n"];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	return NO;
}

@end
