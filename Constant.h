//
//  Constant.h
//  WOOFR
//
//  Created by dipen  narola on 17/11/15.
//  Copyright © 2015 dipen. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


//#define FIND_URL @"http://fuunly.com/admin-panel/win&loss/?";
#define FIND_URL @"http://admin.vasundharavision.com/woofr/api/?";

#define IS_IPAD    (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)

#define STORYBOARD_TYPE (IS_IPAD ? @"Main_iPad" : @"Main")

#define NAVBAR_BUTTON_BACK  @"Back"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define ViewHEight  ([UIScreen mainScreen].bounds.size.height)
#define ViewWIdth  ([UIScreen mainScreen].bounds.size.width)

#endif /* Constant_h */
