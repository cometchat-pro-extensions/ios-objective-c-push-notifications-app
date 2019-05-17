//
//  SendPushViewController.m
//  SampleApp-PushNotifications
//
//  Created by Budhabhooshan Patil on 04/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "SendPushViewController.h"

@interface SendPushViewController ()<UITextFieldDelegate , UITextViewDelegate>
@property (strong ,nonatomic) UIView                 *holderView;
@property (strong ,nonatomic) UITextField            *receiverTextField;
@property (strong ,nonatomic) UITextView             *textMessageView;
@property (strong ,nonatomic) UISegmentedControl     *segmentedControl;
@property (strong ,nonatomic) UIButton               *sendtextMessageButton;
@property (strong ,nonatomic) UIButton               *sendcustomMessageButton;
@property (nonatomic, strong) UILabel                *placeholderLabel;
@end

@implementation SendPushViewController
{
    NSString *subscriptionTopicForLoggedInUser , *subscriptionToipcForGroup;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.contentView addGestureRecognizer:tap];
    [self addKeyboardObserver];
    
    [self viewWillSetUpSubViews];
    [self ViewWillSetUpNavigationBar];

    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    
    /**
     * subscribe to FCM TOPICS
     * for logged in user   : APPID_user_"logged_in_uid"_ios
     * for groups           : APPID_group_"some_group_guid"_ios
     */
    subscriptionTopicForLoggedInUser    = [NSString stringWithFormat:@"%@_user_%@_ios",@APP_ID,uid];
    subscriptionToipcForGroup           = [NSString stringWithFormat:@"%@_group_%@_ios",@APP_ID,@"supergroup"];
    
    /**
     * subscribe to user topics
     */
    [[FIRMessaging messaging] subscribeToTopic:subscriptionTopicForLoggedInUser completion:nil];
    /**
     * subscribe to groups topics
     */
    [[FIRMessaging messaging] subscribeToTopic:subscriptionToipcForGroup];
}
-(void)addKeyboardObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
}
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, _textMessageView.frame.origin) ) {
        [self.scrollView scrollRectToVisible:_textMessageView.frame animated:YES];
    }
}
- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self dismissKeyboard];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = NO;
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    
    if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    else {
        _placeholderLabel.hidden = NO;
    }
}
-(void)viewWillSetUpSubViews{
    
    [self.contentView addSubview:self.holderView];
    [_holderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [_holderView setBackgroundColor:[UIColor whiteColor]];
    
    [_holderView addSubview:self.receiverTextField];
    [_holderView addSubview:self.textMessageView];
    [_holderView addSubview:self.sendtextMessageButton];
    [_holderView addSubview:self.sendcustomMessageButton];
    [_holderView addSubview:self.segmentedControl];
    
    [_receiverTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_textMessageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sendtextMessageButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_sendcustomMessageButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_textMessageView addSubview:self.placeholderLabel];
    [_placeholderLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints];
}
-(void)addConstraints
{
    
    CGFloat height = IS_IPAD?(self.view.frame.size.height)  * 73/100:self.view.frame.size.height;
    CGFloat width  = IS_IPAD?(self.view.frame.size.width)   * 69/100:self.view.frame.size.width;
    
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0f];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0f];
    
    NSLayoutConstraint *heightForView = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
    NSLayoutConstraint *widthForView = [NSLayoutConstraint constraintWithItem:_holderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
    
    [self.contentView addConstraints:@[centerX, centerY]];
    [self.contentView addConstraints:@[heightForView, widthForView]];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_receiverTextField,_textMessageView,_sendtextMessageButton,_sendcustomMessageButton,_segmentedControl,_placeholderLabel);
    
    
    CGFloat _Width = width - paddingX*4;
    CGFloat verticalSpacing;
    if ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationPortrait) {
        verticalSpacing = height * 25/100;
    }else{
        verticalSpacing = height * 25/100;
    }
    
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%f",_Width],@"_Width",[NSString stringWithFormat:@"%f",verticalSpacing],@"verticalSpacing",nil];
    
    NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(verticalSpacing)-[_receiverTextField]-(16)-[_textMessageView(60)]-(16)-[_segmentedControl(40)]-(16)-[_sendtextMessageButton(40)]-(16)-[_sendcustomMessageButton(40)]"  options:0 metrics:metrics views:views];
    
    
    NSArray *horizontalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_receiverTextField(_Width)]-(16)-|"  options:0 metrics:metrics views:views];
    NSArray *horizontalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_textMessageView(_Width)]-(16)-|"  options:0 metrics:metrics views:views];
    NSArray *horizontalConstraints3 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_sendtextMessageButton(_Width)]-(16)-|"  options:0 metrics:metrics views:views];
    NSArray *horizontalConstraints4 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_sendcustomMessageButton(_Width)]-(16)-|"  options:0 metrics:metrics views:views];
    NSArray *horizontalConstraints5 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_segmentedControl(_Width)]-(16)-|"  options:0 metrics:metrics views:views];
    
    [_holderView addConstraints:horizontalConstraints1];
    [_holderView addConstraints:horizontalConstraints2];
    [_holderView addConstraints:horizontalConstraints3];
    [_holderView addConstraints:horizontalConstraints4];
    [_holderView addConstraints:horizontalConstraints5];
    [_holderView addConstraints:verticalConstraints];
    
    NSArray *v1 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_placeholderLabel]-|"  options:0 metrics:metrics views:views];
    NSArray *h1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_placeholderLabel]-|"  options:0 metrics:metrics views:views];
    
    [_textMessageView addConstraints:v1];
    [_textMessageView addConstraints:h1];
}

-(UITextField *)receiverTextField{
    
    if (!_receiverTextField) {
        _receiverTextField = [UITextField new];
        _receiverTextField.delegate = self;
        _receiverTextField.layer.masksToBounds = YES;
        _receiverTextField.placeholder = @" Receiver id Here";
        _receiverTextField.textAlignment = NSTextAlignmentCenter;
        [_receiverTextField becomeFirstResponder];
        [_receiverTextField setBackground:[UIImage imageNamed:@"underline"]];
    }
    return _receiverTextField;
}
-(UITextView *)textMessageView{
    
    if (!_textMessageView) {
        _textMessageView = [UITextView new];
        _textMessageView.delegate = self;
        _textMessageView.returnKeyType = UIReturnKeySend;
        _textMessageView.layer.borderColor = [[UIColor grayColor] CGColor];
        _textMessageView.layer.borderWidth = 1.0;
        _textMessageView.layer.cornerRadius = 5.0;
        _textMessageView.font = [UIFont systemFontOfSize:20.0f];
    }
    return _textMessageView;
}
-(UISegmentedControl *)segmentedControl{
    
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"To User",@"To Group"]];
        [_segmentedControl setSelectedSegmentIndex:0];
    }
    return _segmentedControl;
}
-(UIButton *)sendtextMessageButton
{
    
    if (!_sendtextMessageButton) {
        _sendtextMessageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_sendtextMessageButton setTitle:@"SEND" forState:UIControlStateNormal];
        [_sendtextMessageButton.layer setCornerRadius:10.0f];
        [_sendtextMessageButton setBackgroundColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
        [_sendtextMessageButton setTintColor:[UIColor whiteColor]];
        [[_sendtextMessageButton titleLabel] setFont:[UIFont systemFontOfSize:17.0f weight:(UIFontWeightSemibold)]];
        [_sendtextMessageButton addTarget:self action:@selector(sendButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendtextMessageButton;
}
-(UIButton *)sendcustomMessageButton
{
    
    if (!_sendcustomMessageButton) {
        _sendcustomMessageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_sendcustomMessageButton setTitle:@"SEND CUSTOM MESSAGE" forState:UIControlStateNormal];
        [_sendcustomMessageButton.layer setCornerRadius:10.0f];
        [_sendcustomMessageButton setBackgroundColor:[UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
        [_sendcustomMessageButton setTintColor:[UIColor whiteColor]];
        [[_sendcustomMessageButton titleLabel] setFont:[UIFont systemFontOfSize:17.0f weight:(UIFontWeightSemibold)]];
        [_sendcustomMessageButton addTarget:self action:@selector(sendCustomMessge:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendcustomMessageButton;
}
-(UIView *)holderView{
    
    if (!_holderView) {
        _holderView = [UIView new];
    }
    return _holderView;
}
- (UILabel *) placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel new];
        _placeholderLabel.userInteractionEnabled = NO;
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:16.0];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.text = @"Write a messsage";
    }
    return _placeholderLabel;
}
- (void)sendButtonTouchUpInside:(id)sender
{
    NSString *reciverID = _receiverTextField.text;
    NSString *message   = _textMessageView.text;
    
    TextMessage *textMessage =  [[TextMessage alloc]initWithReceiverUid:reciverID text:message messageType:MessageTypeText receiverType:ReceiverTypeUser];
    
    switch (_segmentedControl.selectedSegmentIndex) {
            
        case 1:
        {
            textMessage = [[TextMessage alloc]initWithReceiverUid:_receiverTextField.text text:_textMessageView.text messageType:MessageTypeText receiverType:ReceiverTypeGroup];
        }
            break;
        default:
            break;
    }
    [self sendMessage:textMessage];
    [_textMessageView setText:@""];
    [_placeholderLabel setHidden:NO];
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    [UIView animateWithDuration:0.25 animations:^{
        [self.contentView removeConstraints:self.contentView.constraints];
        [self.holderView removeConstraints:self.holderView.constraints];
        [self addConstraints];
    }];
}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [_textMessageView addSubview:self.placeholderLabel];
}


/**************************************************************************************************************************************************************************/
/***********************************************************************   sending text message start  ********************************************************************/
/**************************************************************************************************************************************************************************/
-(void)sendMessage:(TextMessage *)textMessasge
{

    __weak __typeof__(self) weakSelf = self;
    /**
     * send push notification message to receiver
     */
    [CometChat sendTextMessageWithMessage:textMessasge onSuccess:^(TextMessage * _Nonnull sent_message) {

        dispatch_async(dispatch_get_main_queue(), ^{

            [weakSelf.view endEditing:YES];
            [weakSelf showAlertWithTitle:@"SUCCESS" andMessage:@"Message sent Successfuly..!"];

        });

    } onError:^(CometChatException * _Nullable error) {

        NSLog(@"ERROR %@",[error errorDescription]);

    }];
    
}

/**************************************************************************************************************************************************************************/
/*********************************************************************** sending text message end  ********************************************************************/
/**************************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************************/
/********************************************************************   sending custom message start  ********************************************************************/
/**************************************************************************************************************************************************************************/
-(void)sendCustomMessge:(id)sender
{
    NSString *reciverID = _receiverTextField.text;
    
    NSDictionary * message = [NSDictionary dictionaryWithObjectsAndKeys: @ "someRandomData", @ "someRandomKey", nil];
    
    CustomMessage * customMessage = [ [CustomMessage alloc] initWithReceiverUid: reciverID receiverType: ReceiverTypeUser customData: message ];
    
    switch (_segmentedControl.selectedSegmentIndex) {
            
        case 1:
        {
            customMessage = [ [CustomMessage alloc] initWithReceiverUid: reciverID receiverType: ReceiverTypeGroup customData: message ];
        }
            break;
        default:
            break;
    }
    
    // to display custom notification banner add this , "pushNotification" key not to change  //
    NSDictionary * customNotificationDisplayText = [NSDictionary dictionaryWithObjectsAndKeys: @ "NOTIFICATION_BANNER_TEXT_HERE", @ "pushNotification", nil];
    [customMessage setMetaData: customNotificationDisplayText];
    
    __weak __typeof__(self) weakSelf = self;
    
    [CometChat sendCustomMessageWithMessage:customMessage onSuccess:^(CustomMessage * _Nonnull sentMessage) {
        
        
        NSLog(@ "sentMessage %@", [sentMessage stringValue]);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.view endEditing:YES];
            [weakSelf showAlertWithTitle:@"SUCCESS" andMessage:@" Custom Message sent Successfuly..!"];
            
        });
        
    } onError:^(CometChatException * _Nullable error) {
        
        NSLog(@ "error sending custom message %@", [error errorDescription]);
        
    }];
    
}
/**************************************************************************************************************************************************************************/
/***********************************************************************   sending custom message end  ********************************************************************/
/**************************************************************************************************************************************************************************/

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:okAction];
    __weak __typeof__(self) weakSelf = self;
    [weakSelf presentViewController:alert animated:YES completion:nil];
}
-(void)ViewWillSetUpNavigationBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"logout" style:(UIBarButtonItemStylePlain) target:self action:@selector(logout)];
    [self.navigationItem setLeftBarButtonItem:item animated:YES];
    
}
-(void)logout
{
    /**
     * log out from `CometChatPro` and unsubscribe from `FCM` push notifications
     */
    [CometChat logoutOnSuccess:^(NSString * _Nonnull logoutSuccess) {
        
        [[FIRMessaging messaging] unsubscribeFromTopic:self->subscriptionTopicForLoggedInUser];
        [[FIRMessaging messaging] unsubscribeFromTopic:self->subscriptionToipcForGroup];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } onError:^(CometChatException * _Nonnull error) {
        
        NSLog(@"error in login %@",[error errorDescription]);
        
    }];
}
@end
