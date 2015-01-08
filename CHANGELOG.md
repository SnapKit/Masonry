v0.6.0
======

#### - Improved support of iOS 8

As of iOS 8 there is `active` property of `NSLayoutConstraint` available, which allows to (de)activate constraint without searching closest common superview.

#### - Added support of iPhone 6 and iPhone 6+ to test project

v0.5.3
======

#### - Fixed compilation errors on xcode6 beta

https://github.com/Masonry/Masonry/pull/84


v0.5.2
======

#### - Fixed compilation warning with Shorthand view Additions

https://github.com/cloudkite/Masonry/issues/71

v0.5.1
======

#### - Fixed compilation error when using objective-c++ ([nickynick](https://github.com/nickynick))

https://github.com/cloudkite/Masonry/pull/69

v0.5.0
======

#### - Fixed bug in `mas_updateConstraints` ([Rolken](https://github.com/Rolken))

Was not checking that the constraint relation was equivalent
https://github.com/cloudkite/Masonry/pull/65

#### - Added `mas_remakeConstraints` ([nickynick](https://github.com/nickynick))

Similar to `mas_updateConstraints` however instead of trying to update existing constraints it Removes all constraints previously defined and installed for the view, allowing you to provide replacements without hassle.

https://github.com/cloudkite/Masonry/pull/63

#### - Added Autoboxing for scalar/struct attribute values ([nickynick](https://github.com/nickynick))

Autoboxing allows you to write equality relations and offsets by passing primitive values and structs
```obj-c
make.top.mas_equalTo(42);
make.height.mas_equalTo(20);
make.size.mas_equalTo(CGSizeMake(50, 100));
make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 10, 0));
make.left.mas_equalTo(view).mas_offset(UIEdgeInsetsMake(10, 0, 10, 0));
```
by default these autoboxing macros are prefix with `mas_`
If you want the unprefixed version you need to add `MAS_SHORTHAND_GLOBALS` before importing Masonry.h (ie in your Prefix.pch)

https://github.com/cloudkite/Masonry/pull/62

#### - Added ability to chain view attributes

Composites are great for defining multiple attributes at once. The following example makes top, left, bottom, right equal to `superview`.

```obj-c
make.edges.equalTo(superview).insets(padding);
```

However if only three of the sides are equal to `superview` then we need to repeat quite a bit of code
```obj-c
make.left.equalTo(superview).insets(padding);
make.right.equalTo(superview).insets(padding);
make.bottom.equalTo(superview).insets(padding);
// top needs to be equal to `otherView`
make.top.equalTo(otherView).insets(padding);
```

This change makes it possible to chain view attributes to improve readability
```obj-c
make.left.right.and.bottom.equalTo(superview).insets(padding);
make.top.equalTo(otherView).insets(padding);
```

https://github.com/cloudkite/Masonry/pull/56

v0.4.0
=======

#### - Fixed Xcode auto-complete support ([nickynick](https://github.com/nickynick))

***Breaking Changes***

If you are holding onto any instances of masonry constraints ie
```obj-c
// in public/private interface
@property (nonatomic, strong) id<MASConstraint> topConstraint;
```

You will need to change this to
```obj-c
// in public/private interface
@property (nonatomic, strong) MASConstraint *topConstraint;
```

Instead of using protocols Masonry now uses an abstract base class for constraints in order to get Xcode auto-complete support see http://stackoverflow.com/questions/14534223/

v0.3.2
=======

#### - Added support for Mac OSX animator proxy ([pfandrade](https://github.com/pfandrade))

```objective-c
self.leftConstraint.animator.offset(20);
```

#### - Added setter methods for NSLayoutConstraint constant proxies like `offset`, `centerOffset`, `insets`, `sizeOffset`.
now you can update these values using more natural syntax

```objective-c
self.edgesConstraint.insets(UIEdgeInsetsMake(20, 10, 15, 5));
```

can now be written as:

```objective-c
self.edgesConstraint.insets = UIEdgeInsetsMake(20, 10, 15, 5);
```


v0.3.1
=======

#### - Added way to specify the same set of constraints to multiple views in an array ([danielrhammond](https://github.com/danielrhammond))

```objective-c
[@[view1, view2, view3] mas_makeConstraints:^(MASConstraintMaker *make) {
    make.baseline.equalTo(superView.mas_centerY);
    make.width.equalTo(@100);
}];
```

v0.3.0
=======

#### - Added `- (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *))block`
which will update existing constraints if possible, otherwise it will add them.  This makes it easier to use Masonry within the `UIView` `- (void)updateConstraints` method which is the recommended place for adding/updating constraints by apple.
#### - Updated examples for iOS7, added a few new examples.
#### - Added -isEqual: and -hash to MASViewAttribute [CraigSiemens].
