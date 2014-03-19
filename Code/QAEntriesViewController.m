//
//  QAEntriesViewController.m
//  Q&A
//
//  Created by Boris Bügling on 19/03/14.
//  Copyright (c) 2014 Boris Bügling. All rights reserved.
//

#import <ContentfulDeliveryAPI/ContentfulDeliveryAPI.h>

#import "QAEntriesViewController.h"
#import "QAInlineFieldsViewController.h"
#import "UIApplication+QA.h"

@interface QAEntriesViewController () <CDAEntriesViewControllerDelegate>

@end

#pragma mark -

@implementation QAEntriesViewController

-(id)init {
    self = [super initWithCellMapping:nil];
    if (self) {
        self.client = [UIApplication sharedApplication].client;
    }
    return self;
}

#pragma mark - CDAEntriesViewControllerDelegate

-(void)entriesViewController:(CDAEntriesViewController *)entriesViewController
       didSelectRowWithEntry:(CDAEntry *)entry {
    QAInlineFieldsViewController* inlineFieldsVC = [[QAInlineFieldsViewController alloc]
                                                    initWithEntry:entry];
    [self.navigationController pushViewController:inlineFieldsVC animated:YES];
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDAEntry* entry = self.items[indexPath.row];
    
    UITableViewCell* cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = entry.fields[entry.contentType.displayField];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:NSLocalizedString(@"Found %d results", nil), self.items.count];
}

@end