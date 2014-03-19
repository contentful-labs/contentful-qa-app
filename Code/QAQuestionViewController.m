//
//  QAQuestionViewController.m
//  Q&A
//
//  Created by Boris Bügling on 19/03/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import "QAEntriesViewController.h"
#import "QAQuestionViewController.h"

@interface QAQuestionViewController () <UITextFieldDelegate>

@property (nonatomic) UITextField* textField;

@end

#pragma mark -

@implementation QAQuestionViewController

-(id)init {
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.title = NSLocalizedString(@"Header Text", nil);
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [self.textField becomeFirstResponder];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 50.0, self.view.frame.size.width - 20.0, 44.0)];
    questionLabel.text = NSLocalizedString(@"Ask a question by typing below!", nil);
    questionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:questionLabel];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, CGRectGetMaxY(questionLabel.frame) + 10.0, questionLabel.frame.size.width, questionLabel.frame.size.height)];
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.clearsOnBeginEditing = YES;
    self.textField.delegate = self;
    self.textField.enablesReturnKeyAutomatically = YES;
    self.textField.returnKeyType = UIReturnKeySearch;
    [self.view addSubview:self.textField];
    
    UIButton* doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(10.0, CGRectGetMaxY(self.textField.frame) + 10.0, questionLabel.frame.size.width, questionLabel.frame.size.height);
    
    [doneButton addTarget:self action:@selector(doneTapped) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [self.view addSubview:doneButton];
}

#pragma mark - Actions

-(void)doneTapped {
    QAEntriesViewController* entriesVC = [QAEntriesViewController new];
    entriesVC.query = @{ @"query": self.textField.text };
    [self.navigationController pushViewController:entriesVC animated:YES];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doneTapped];
    return NO;
}

@end