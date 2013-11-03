v0.3.0
=======

* added `- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *))block` which will update existing constraints if possible, otherwise it will add them.  This makes it easier to use Masonry within the `UIView` `- (void)updateConstraints` method which is the recommended place for adding/updating constraints by apple.
* Updated examples for iOS7, added a few new examples.
* Added -isEqual: and -hash to MASViewAttribute [CraigSiemens].
