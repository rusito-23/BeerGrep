# Objective C

## Disclaimer

I'm not an expert in this field, this project is part of an introductory course for Objective C. It most likely has mistakes and needs to be polished.

## Intro

**Objective C** is an object-oriented programming language based in C and SmallTalk (mostly C, hence the name). It can incorporate C/C++ code blocks, which makes it very versatile.

I'ts mainly used to develop using the Apple stack: iOS, macOS, as it is the native language for Cocoa applications.


## Sample App (Beer Grep)

This project has a Sample App to play with, which applies some of the concepts in this file. It's a very simple single screen application that shows a mocked list of Beers. The project structure is as follows:

```
└── ObjectiveNoLoSe
    ├── AppDelegate
    ├── SceneDelegate
    ├── Support Files
    ├── Storyboards
    │   ├── LaunchScreen.storyboard
    │   └── Main.storyboard
    ├── Controller
    │   └── ViewController
    ├── Model
    │   └── BeerModel
    ├── Injector (Mini dependency repository with protocols)
    ├── BeerProvider
    │   ├── BeerProvider (protocol)
    │   └── BeerProviderMock (mock protocol implementation)
    ├── View
    │   └── BeerTableViewCell
    │       ├── BeerTableViewCell.xib (Interface Builder)
    │       └── BeerTableViewProvider (class)
    └── Categories
		 ├── NSTableView+Message
		 └── NSString+Localization
```

**ACKNOWLEDGEMENT**: the App's icon whas stolen from [this dude's dribble, awesome work.](https://dribbble.com/shots/5896277-Beer-Flat-IOS-Icon)

## NSFoundation, types and classes

As said before, ObjC allows us to use C/C++ blocks of code, but we can also interact with C/C++ types. It's important to understand the difference between native types and the types given by NSFoundation. **NSFoundation** is a base layer for Objective C classes. It provides us with several primitive objects with useful functions. NSFoundation uses NSObject as root class, to gain advantage from the Cocoa memory managment, and all our classes should inherit this class.

Let's see the difference between one and other:

```objc
char *some_string = "This a c string";
NSString *some_other_string = @"This is an Foundation string";
```

To use foundation primitive objects, we need to prepend the `@` keyword, to stand the difference with the C/C++ equivalent. Another example are arrays:

```objc
int some_array[] = {2, 3}:
NSArray *some_other_array = @[2, 3];
```

It's important to notice that primitive types given by NSFoundation, have several useful methods, for example NSString gives us:

- compare
- substring
- contains
- rangeOf
- etc

As in C, Objective C works with pointers. This can be easily seen when we initialize an object:

```objc
SomeClass *someObject = [[SomeClass alloc] init];
```

First, we need to allocate the memory for the class, then whe initialize it, and we do not save the class content, we save the pointer! Also, ObjC introduced a syntax sugar to initalize an object with no parameters (alloc & init at the same time):

```objc
SomeClass *someObject = [SomeClass new];
```

## Different types of personalities

Objective C has many kind of files and declarations that we can use for different purposes. These are:

- **Class**

	Defines a new class, with an unique name, the interface (*.h*) contains the attributes and methods publicly available and the ObjC file (*.m*) the implementation. The header has the following syntax:

	*header file*

	```objc
	@interface MyClass: NSObject <ProtocolIWantToImplement>
	@property PropertyClass *someProperty;
	- (void) someMethodWithParam:(ParameterClass*) parameter;
	@end
	```

	The objective c can extend this implementation, but It will not be publicly available, it's syntax is the following:
	
	*objective c file*

	```objc
	@interface MyClass ()
	@property PropertyClass *somePrivateProperty;
	@end

	@implementation MyClass
	- (void) someMethodWithParam:(ParameterClass*) parameter {
		NSLog(@"My implementation");
	}
	@end
	```

- **Category**

	Categories are use to add functionality to a pre-existing class. We need to define both the *interface* and the *implementation* in their corresponding *header* and *objective c* files. Categories must have a **significant name** to describe the new functionality. Their syntax is as follows:
	
	*interface (header file)*

	```objc
	@interface NSString (Localization)
	- (NSString *) localized;
	@end
	```
	
	*implementation (.m file)*
	
	```objc
	@implementation NSString (Localizable)
	- (NSString *) localized {
	  return NSLocalizedString(self, @"");
	}
	@end
	```
	
	And now, we can use them by importing our header and that's it:
	
	```objc
	#import "NSString+Localizable.h"
	...
	NSString *localizedString = @"SOME_STRING".localized;
	...
	```

- **Protocol**
	
	They allow us to describe the behaviors that an object should be able to do to conform to this protocol. This is very useful as it allows us to create a communication interface that doesn't relay on the implementation. Even if we have header files, this extra interface is very neat.
	
	*protocol header file*
	
	```objc
	@protocol BeerProvider <NSObject>
	@required
	- (void) fetchBeersWithCompletion:(void (^)(NSArray *, NSError *))completion;
	@end
	```
	
	And then we can use it as:
	
	```objc
	...
	@property (strong, nonatomic) id<BeerProvider> beerProvider;
	...
	[self.beerProvider fetchBeersWithCompletion:^(NSArray *beers, NSError *error){
	...
	}];
	```
	
- **Extension**

	Extensions are used to expand the visible and publicly available stuff of a pre-existing class. We cannot add functionalities, but we can access things that otherwise would be hidden. As a little disclaimer, it isn't more than another interface, like the one explained in the **classes** section, located in the objective c file.
	
	This can be useful to perform Unit Tests, if we need to check internal states from the class we are testing, we can define the extension and we'll be able to peak into these things.

## In Objective c, properties have properties

Ok this is weird, and one of the most difficult and ambigous part of learning Objective C. When a class declares a property, there are several functionalities we can define, so don't freak out if you see things like:

```objc
@property (weak, nonatomic, readonly, weird_stuff) NSString *some_string;
```

Some of the most important are:

- Storage properties

	- **strong** (default) a.k.a *Don't touch this object, it's mine!*
	- **weak** a.k.a *Do what you please, I don't mind...*
	- **assign** a.k.a *The one we use for primitive types* (so, no pointers here)
	- **copy** a.k.a *The pretty obvious one*

- Atomicity

	- **atomic** (default) a.k.a *I don't care if the access is slow, don't use it in more than one thread at a time.*
	- **nonatomic** a.k.a *The Fast and Furious*

- Access
	- **readwrite** (default)
	- **readonly**

## Blocks

Blocks are very useful as they define functions which we can use to perform callbacks, save a behavior in a property and much much more. The syntax can easily become a gross mess, but here is a quick cheatsheet: [http://fuckingblocksyntax.com]().

## TODO:

- Building the UI (storyboards, interface builders, programmaticaly)
- explaining an XCode project
- UIKit stuff


## USEFUL LINKS

- [Fuck*** Block Syntax](http://fuckingblocksyntax.com)
- [What if wanna try some stuff?](https://www.tutorialspoint.com/compile_objective-c_online.php)
- [WTFAutoLayout](https://www.wtfautolayout.com)

## SOURCES

- [Apple Oficial Docs](https://developer.apple.com/documentation/)
- [TutorialsPoint Introduction](https://www.tutorialspoint.com/objective_c/objective_c_foundation_framework.htm)
- [WikiBooks Docs](https://en.wikibooks.org/wiki/Cocoa_Programming/Objective-C_basics)
- [Medium Properties](https://medium.com/@dsrijan/objective-c-properties-901e8a1f82ac)
