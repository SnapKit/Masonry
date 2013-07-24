Masonry
=======

Masonary is a light-weight layout framework which wraps AutoLayout with a nicer syntax. Masonary has its own layout DSL which provides a chainable way of describing your NSLayoutConstraints which results in layout code which is more concise and readable.

### Whats wrong with NSLayoutConstraints?

Imagine a simple example in which you want to have a view fill its superview but inset by 10 pixels on every side
```obj-c
UIView *superview = self;

UIView *view1 = [[UIView alloc] init];
view1.translatesAutoresizingMaskIntoConstraints = NO;
view1.backgroundColor = [UIColor greenColor];
[superview addSubview:view1];

int padding = 10;

[superview addConstraints:@[

    //view1 constraints
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:padding],

    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:padding],   
 
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:-padding],
 
    [NSLayoutConstraint constraintWithItem:view1
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:-padding],

 ]];
```
Even with such a simple example the code needed is quite verbose and quickly becomes unreadable when you have more than 2 or 3 views.

### Meet your Maker!

heres the same constraints created using MASConstraintMaker

```obj-c
[view1 makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(superview.top).with.offset(padding);
    make.left.equalTo(superview.left).with.offset(padding);
    make.bottom.equalTo(superview.bottom).with.offset(-padding);
    make.right.equalTo(superview.right).with.offset(-padding);
}];
```
or ever shorter
```obj-c
[view1 makeConstraints:^(MASConstraintMaker *make) {
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    make.edges.equalTo(superview).insets(paddingInsets);
}];
```

For more usage examples take a look at the MasonryExamples project in the Masonry workspace.

note all UIView additions are prefixed with 'mas_' to avoid conflicting with other UIView categories
if you want to use Masonry without the mas_ you need to add #define MAS_SHORTHAND to your prefix.pch

### Features
* No macro magic. Masonry won't pollute the global namespace with macros.
* Not string or dictionary based and hence you get compile time checking.

### TODO
* Better readme
* Better debugging help for complicated layouts
* Header comments/Documentation
* More tests and examples
