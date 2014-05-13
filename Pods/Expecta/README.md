# Expecta

A Matcher Framework for Objective-C/Cocoa

## NOTICE

Expecta 0.2.x has a new syntax that is slightly different from Expecta 0.1.x. For example `expect(x).toEqual(y)` should now be written as `expect(x).to.equal(y)`. You can do `#define EXP_OLD_SYNTAX` before importing `Expecta.h` to enable backward-compatiblity mode, but keep in mind that the old syntax is deprecated.

## INTRODUCTION

The main advantage of using Expecta over other matcher frameworks is that you do not have to specify the data types. Also, the syntax of Expecta matchers is much more readable and does not suffer from parenthesitis.

**OCHamcrest**

```objective-c
assertThat(@"foo", is(equalTo(@"foo")));
assertThatUnsignedInteger(foo, isNot(equalToUnsignedInteger(1)));
assertThatBool([bar isBar], is(equalToBool(YES)));
assertThatDouble(baz, is(equalToDouble(3.14159)));
```

vs.

**Expecta**

```objective-c
expect(@"foo").to.equal(@"foo"); // `to` is a syntatic sugar and can be safely omitted.
expect(foo).notTo.equal(1);
expect([bar isBar]).to.equal(YES);
expect(baz).to.equal(3.14159);
```

## SETUP

Use [CocoaPods](https://github.com/CocoaPods/CocoaPods)

```ruby
target :MyApp do
  # your app dependencies
end

target :MyAppTests do
  pod 'Expecta',     '~> 0.2.3'   # expecta matchers
  # pod 'Specta',      '~> 0.1.11'  # specta bdd framework
end
```

or

1. Clone from Github.
2. Run `rake` in project root to build.
3. Copy and add all header files in `products` folder to the Spec/Test target in your Xcode project.
4. For **OS X projects**, copy and add `libExpecta-macosx.a` in `products` folder to the Spec/Test target in your Xcode project.
   For **iOS projects**, copy and add `libExpecta-ios-universal.a` in `products` folder to the Spec/Test target in your Xcode project.
5. Add `-ObjC` to the "Other Linker Flags" build setting for the Spec/Test target in your Xcode project.
6. Add the following to your test code.

```objective-c
// #define EXP_OLD_SYNTAX // enable backward-compatibility
#define EXP_SHORTHAND
#import "Expecta.h"
```

If `EXP_SHORTHAND` is not defined, expectations must be written with `EXP_expect` instead of `expect`.

Expecta is framework-agnostic. It works well with OCUnit (SenTestingKit) and OCUnit-compatible test frameworks such as [Specta](http://github.com/petejkim/specta/), [GHUnit](http://github.com/gabriel/gh-unit/) and [GTMUnit](http://code.google.com/p/google-toolbox-for-mac/). Expecta also supports [Cedar](http://pivotal.github.com/cedar/).

## BUILT-IN MATCHERS

>`expect(x).to.equal(y);` compares objects or primitives x and y and passes if they are identical (==) or equivalent (isEqual:).
>
>`expect(x).to.beIdenticalTo(y);` compares objects x and y and passes if they are identical and have the same memory address.
>
>`expect(x).to.beNil();` passes if x is nil.
>
>`expect(x).to.beTruthy();` passes if x evaluates to true (non-zero).
>
>`expect(x).to.beFalsy();` passes if x evaluates to false (zero).
>
>`expect(x).to.contain(y);` passes if an instance of NSArray, NSDictionary or NSString x contains y.
>
>`expect(x).to.haveCountOf(y);` passes if an instance of NSArray, NSSet, NSDictionary or NSString x has a count or length of y.
>
>`expect(x).to.beEmpty();` passes if an instance of NSArray, NSSet, NSDictionary or NSString x has a count or length of 0.
>
>`expect(x).to.beInstanceOf([Foo class]);` passes if x is an instance of a class Foo.
>
>`expect(x).to.beKindOf([Foo class]);` passes if x is an instance of a class Foo or if x is an instance of any class that inherits from the class Foo.
>
>`expect([Foo class]).to.beSubclassOf([Bar class]);` passes if the class Foo is a subclass of the class Bar or if it is identical to the class Bar. Use beKindOf() for class clusters.
>
>`expect(x).to.beLessThan(y);` passes if `x` is less than `y`.
>
>`expect(x).to.beLessThanOrEqualTo(y);` passes if `x` is less than or equal to `y`.
>
>`expect(x).to.beGreaterThan(y);` passes if `x` is greater than `y`.
>
>`expect(x).to.beGreaterThanOrEqualTo(y);` passes if `x` is greater than or equal to `y`.
>
>`expect(x).to.beInTheRangeOf(y,z);` passes if `x` is in the range of `y` and `z`.
>
>`expect(x).to.beCloseTo(y);` passes if `x` is close to `y`.
>
>`expect(x).to.beCloseToWithin(y, z);` passes if `x` is close to `y` within `z`.
>
>`expect(^{ /* code */ }).to.raise(@"ExceptionName");` passes if a given block of code raises an exception named `ExceptionName`.
>
>`expect(^{ /* code */ }).to.raiseAny();` passes if a given block of code raises any exception.

**Please contribute more matchers.**

## INVERTING MATCHERS

Every matcher's criteria can be inverted by prepending `.notTo` or `.toNot`:

>`expect(x).notTo.equal(y);` compares objects or primitives x and y and passes if they are *not* equivalent.

## ASYNCHRONOUS TESTING

Every matcher can be made to perform asynchronous testing by prepending `.will` or `.willNot`:

>`expect(x).will.beNil();` passes if x becomes nil before the timeout.
>
>`expect(x).willNot.beNil();` passes if x becomes non-nil before the timeout.

Default timeout is 1.0 second. This setting can be changed by calling `[Expecta setAsynchronousTestTimeout:x]`, where x is the desired timeout.

## WRITING NEW MATCHERS

Writing a new matcher is easy with special macros provided by Expecta. Take a look at how `.beKindOf()` matcher is defined:

`EXPMatchers+beKindOf.h`

```objective-c
#import "Expecta.h"

EXPMatcherInterface(beKindOf, (Class expected));
// 1st argument is the name of the matcher function
// 2nd argument is the list of arguments that may be passed in the function call.
// Multiple arguments are fine. (e.g. (int foo, float bar))

#define beAKindOf beKindOf
```

`EXPMatchers+beKindOf.m`

```objective-c
#import "EXPMatchers+beKindOf.h"

EXPMatcherImplementationBegin(beKindOf, (Class expected)) {
  BOOL actualIsNil = (actual == nil);
  BOOL expectedIsNil = (expected == nil);

  prerequisite(^BOOL{
    return !(actualIsNil || expectedIsNil);
    // Return `NO` if matcher should fail whether or not the result is inverted using `.Not`.
  });

  match(^BOOL{
    return [actual isKindOfClass:expected];
    // Return `YES` if the matcher should pass, `NO` if it should not.
    // The actual value/object is passed as `actual`.
    // Please note that primitive values will be wrapped in NSNumber/NSValue.
  });

  failureMessageForTo(^NSString *{
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: a kind of %@, "
                                       "got: an instance of %@, which is not a kind of %@",
                                       [expected class], [actual class], [expected class]];
    // Return the message to be displayed when the match function returns `YES`.
  });

  failureMessageForNotTo(^NSString *{
    if(actualIsNil) return @"the actual value is nil/null";
    if(expectedIsNil) return @"the expected value is nil/null";
    return [NSString stringWithFormat:@"expected: not a kind of %@, "
                                       "got: an instance of %@, which is a kind of %@",
                                       [expected class], [actual class], [expected class]];
    // Return the message to be displayed when the match function returns `NO`.
  });
}
EXPMatcherImplementationEnd
```

## DYNAMIC PREDICATE MATCHERS

It is possible to add predicate matchers by simply defining the matcher interface, with the matcher implementation being handled at runtime by delegating to the predicate method on your object.

For instance, if you have the following class:

```objc
@interface LightSwitch : NSObject
@property (nonatomic, assign, getter=isTurnedOn) BOOL turnedOn;
@end

@implementation LightSwitch
@synthesize turnedOn;
@end
```

The normal way to write an assertion that the switch is turned on would be:

```objc
expect([lightSwitch isTurnedOn]).to.beTruthy();
```

However, if we define a custom predicate matcher:

```objc
EXPMatcherInterface(isTurnedOn, (void));
```

(Note: we haven't defined the matcher implementation, just it's interface)

You can now write your assertion as follows:

```objc
expect(lightSwitch).isTurnedOn();
```

## CONTRIBUTION

You can find the public Tracker project [here](https://www.pivotaltracker.com/projects/323267).

### CONTRIBUTION GUIDELINES

* Please use only spaces and indent 2 spaces at a time.
* Please prefix instance variable names with a single underscore (`_`).
* Please prefix custom classes and functions defined in the global scope with `EXP`.

## CREDITS

Expecta is brought to you by [Peter Jihoon Kim](http://github.com/petejkim) and the [Specta team](https://github.com/specta?tab=members).

### CONTRIBUTORS

* [Alan Rogers](https://github.com/alanjrogers)
* [Andrew Kitchen](https://github.com/akitchen)
* [Blake Watters](https://github.com/blakewatters)
* [Christopher Pickslay](https://github.com/twobitlabs)
* [Chris Devereux](https://github.com/chrisdevereux)
* [David Hart](https://github.com/TrahDivad)
* [Jacob Gorban](https://github.com/apparentsoft)
* [Jon Cooper](https://github.com/joncooper)
* [Justin Spahr-Summers](https://github.com/jspahrsummers)
* [Kurtis Seebaldt](https://github.com/kseebaldt)
* [Luke Redpath](https://github.com/lukeredpath)
* [Nicholas Hutchinson](https://github.com/nickhutchinson)
* [Rob Rix](https://github.com/robrix)
* [Samuel Giddins](https://github.com/segiddins)
* [Zack Waugh](https://github.com/zachwaugh)

## LICENSE

Expecta is licensed under the [MIT License](http://github.com/petejkim/expecta/raw/master/LICENSE).
