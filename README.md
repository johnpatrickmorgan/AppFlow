#AppFlow ~~>

![Swift](https://img.shields.io/badge/Swift-3.0-green.svg?style=flat)
![Version](https://img.shields.io/cocoapods/v/AppFlow.svg?style=flat)
![License](https://img.shields.io/cocoapods/l/AppFlow.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/AppFlow.svg?style=flat)

AppFlow provides a type-checked declarative DSL for defining your app's user and data flow. It makes it easy to adopt the flow coordinator/controller pattern. Here's an example:


    let flow = Flow(navigator: UINavigationController(), root: TimelineVC()) { timelineVC, stack in
        
        timelineVC.showMessage ~~> stack.push { MessageVC($0) }.configured { messageVC, stack in
            
            messageVC.backTapped ~~> stack.pop()
            messageVC.replyTapped ~~> stack.present { ComposeVC(replyingTo: $0) }.configured { composeVC, stack in
            
            	composeVC.cancelTapped ~~> stack.dismiss()
            	composeVC.messageSent ~~> stack.goBackTo(TimelineVC.self)
            }
        }
        
        timelineVC.composeTapped ~~> stack.present { ComposeVC() }.configured { composeVC, stack in
            
            	composeVC.cancelTapped ~~> stack.dismiss()
            	composeVC.messageSent ~~> stack.dismiss()
            }
        }
    }
  
At each stage, the `stack` object incorporates type information about each view controller in the stack and whether they have been presented/pushed, so your flow is type-checked at compile time. For example, the following actions will throw a compile-time error:

- Pushing on a stack with no navigation controller.
- Popping on a navigation stack only one view controller deep.
- Dismissing a stack that has never been presented.
- Going back to a view controller that is not in the stack. 

The flow object retains only its initial view controller, which can be used via `flow.rootViewController`:

	window.rootViewController = flow.rootViewController

This approach allows your view controllers to be completely agnostic about their context within your app. For example, `TimelineVC` might look like:

	class TimelineVC {
	
		var showMessage: ((Message) -> Void)?
		var composeTapped: (() -> Void)?
		
		var messages = [Message]()
		
		@IBAction func composeButtonTapped(sender: UIButton) {
			
			composeTapped?()
		}
		
		func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        	showMessage?(messages[indexPath.row])
    	}
	}

Flows are composable, so you can push or present one flow onto another flow, e.g., define your `loginFlow` once, and easily present it form various places in your app.

## Installation

AppFlow is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AppFlow"
```

## Author

johnpatrickmorgan, johnpatrickmorganuk@gmail.com

## License

Flow is available under the MIT license. See the LICENSE file for more info.
