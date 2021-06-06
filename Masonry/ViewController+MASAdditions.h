//
//  ViewController+MASAdditions.h
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "MASUtilities.h"
#import "MASConstraintMaker.h"
#import "MASViewAttribute.h"

#ifdef MAS_VIEW_CONTROLLER

NS_ASSUME_NONNULL_BEGIN

@interface MAS_VIEW_CONTROLLER (MASAdditions)

/**
 *	following properties return a new MASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, readonly) MASViewAttribute *mas_topLayoutGuide API_DEPRECATED("Use view.mas_safeAreaLayoutGuideTop instead of mas_topLayoutGuide", ios(8.0, 11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_bottomLayoutGuide API_DEPRECATED("Use view.mas_safeAreaLayoutGuideBottom instead of mas_bottomLayoutGuide", ios(8.0, 11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_topLayoutGuideTop API_DEPRECATED("Use view.mas_top instead of mas_topLayoutGuideTop", ios(8.0, 11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_topLayoutGuideBottom API_DEPRECATED("Use view.mas_safeAreaLayoutGuideTop instead of mas_topLayoutGuideBottom", ios(8.0, 11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_bottomLayoutGuideTop API_DEPRECATED("Use view.mas_safeAreaLayoutGuideBottom instead of mas_bottomLayoutGuideTop", ios(8.0, 11.0));
@property (nonatomic, readonly) MASViewAttribute *mas_bottomLayoutGuideBottom API_DEPRECATED("Use view.mas_bottom instead of mas_bottomLayoutGuideBottom", ios(8.0, 11.0));

@end

NS_ASSUME_NONNULL_END

#endif
