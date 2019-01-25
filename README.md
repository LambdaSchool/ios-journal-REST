# Journal

## Introduction

Journal is a simple journaling app that will allow you to implement each part of CRUD when working with a REST API.

This project is meant to help you solidify concepts you've been learning throughout this Sprint. You also have the whole day to work on it. As such, don't feel like you need to rush through the project.

Please look at the screen recording below to know what the finished project should look like:

![](https://user-images.githubusercontent.com/16965587/43887099-03638784-9b7b-11e8-9556-1c02ffffc32e.gif)

## Instructions

Please fork and clone this repository. This repository does not have a starter project, so create one inside of the cloned repository folder.

### Part 1 - Firebase Setup

This project uses Firebase as the API. In order to have an environment where you are free to experiment with your network requests, and also be able to see what your requests are doing on the API's side.

1. Go to console.firebase.google.com. You may need to sign in with a google account if you aren't already signed in on your browser.
2. Click the square "Add project"  button on that page, and you will be presented with a view that looks like this:

![](https://user-images.githubusercontent.com/16965587/43877558-d9c48dba-9b57-11e8-9eba-ee67fee01935.png)

3. Give your project a name such as "Journal", "YourNameHereJournal", etc. Once you add the project name, under the "Project ID" section, this will change to the name of your project, and potentially a few characters after it to make the identifier unique if someone else has named their project the same as yours.
4. Accept the terms by checking the boxes below, then click "Create Project", You will then be taken to a dashboard screen that looks like this:

![](https://user-images.githubusercontent.com/16965587/43877756-d2b5de88-9b58-11e8-8844-7cf6b67bc851.png)

5. Click the "Database" tab on the left menu. A page will show up that will let you choose whether to make a "Cloud Firestore" beta database, or if you scroll down it will say "Or choose Realtime Database". Choose the Realtime Database.
6. A popup will appear asking you if you want to start in locked or test mode. Select test mode. This will allow you to immediately begin making requests to the API. If the database is in locked mode, you have to authenticate through Firebase in order to access the API at all.
7. At this point, you should be presented with a blank database page like this:

![](https://user-images.githubusercontent.com/16965587/43877941-abe791e2-9b59-11e8-8823-9ca4e626fc82.png)

Your Firebase API is now ready!

### Part 2 - Storyboard Layout

This application will implement the Master-Detail pattern that you're surely familiar with by now.

#### EntriesTableViewController and EntryTableViewCell

1. Delete the view controller scene that comes with the Main.storyboard
2. Add a `UITableViewController` scene, then embed it in a navigation controller. Set the navigation controller as the initial view controller. 
3. Add a `UIViewController` scene as well. Leave it blank for now.
4. On the table view controller scene, change its navigation item's title to "Journal".
5. Add a bar button item on the right side of the navigation bar. Change its "System Item" to "Add". 
6. Create a segue from the bar button item to the blank `UIViewController` scene. This segue will be used to create new entries. Give it an appropriate identifier.
7. Create a second segue from the table view's prototype cell. This segue will be used to view existing entries. Give it an appropriate identifier as well.
8. Create a Cocoa Touch subclass of `UITableViewController` called `EntriesTableViewController`. Set this table view controller scene's class to it.
8. This prototype cell will be a custom cell. Add three labels. One for the entry's title, timestamp, and body text.
9. Create a Cocoa Touch subclass of `UITableViewCell` called `EntryTableViewCell`. Set this cell's class to it.
10. Create outlets for the three labels in the `EntryTableViewCell` class.

#### EntryDetailViewController

1. In the `UIViewController` scene, add a `UITextField`. Set its placeholder text to "Enter a title:"
2. Add a `UITextView`. Remove the Lorem Ipsum text from it. Constrain the text field right below the navigation bar, and the text view below that.
3. Add a navigation item to the view controller, then add a bar button item on the right side of the navigation bar. Change its "System Item" to "Save".
4. Create a Cocoa Touch subclass of `UIViewController` called `EntryDetailViewController`. Set this scene's class to the newly created subclass in the Identity Inspector.
5. Create an outlet from the text field and one from the text view. Also, create an action from the bar button item.

### Part 3 - Entry and EntryController Setup

#### Entry

You will be using a model object called `Entry`. An `Entry` as you may have guessed will represent a single journal entry.

1. Create a new Swift file called "Entry.swift" and make a struct called `Entry` in it.
2. Add the following properties to the `Entry`:
    - A `title` string.
    - A `bodyText` string.
    - A `timestamp` `Date`.
    - An `identifier` string.

You will implement functionality to update these `Entry` objects. Think about which of these properties should be variable(s) and which should be constant(s).

3. Create a memberwise initializer that gives default values to the `timestamp` (the current time upon initialization), and `identifier` properties.
4. Adopt the `Equatable` and `Codable` protocols.

#### EntryController

1. Create a Swift file called "EntryController.swift". Make a class called `EntryController`.
2. Create a `entries: [Entries] = []` variable to be used as the data source for the application.
3. Create a `baseURL: URL` property. Go to your Firebase Database and take the database's URL for the value. 
    - You can find the URL on the Database here: 
![](https://user-images.githubusercontent.com/16965587/43879967-ba0f9120-9b63-11e8-924c-db68ac1774ef.png)
4. Create a function called `put`. It should take in an instance of `Entry` as a parameter and have an escaping completion closure that returns an optional `Error`. In this function:
    - Create a URL that appends the `Entry` parameter's `identifier` to create a unique URL for this `Entry` to be stored on the API. Also append the `"json"` path extension at the end of the URL.
    - Create a `URLRequest`. Its `httpMethod` should be `"PUT"`. Using a do-try-catch block, encode the entry into `Data` (and handle errors in the catch statement). Use this encoded entry as the value of the `URLRequest`'s `httpBody`.
    - Perform a `URLSessionDataTask` with the request you just made. Handle any errors. 
    - Remember to call `completion` to finish the function, and call `resume()` on the data task!

5. The function you just created will PUT an existing entry, however you still need a "Create" CRUD method to initialize `Entry` objects in the first place. Create a function called `createEntry` that takes in the necessary parameters to initialize an `Entry`. It should also have a completion closure that returns an optional `Error`. 
    - Initialize a new `Entry` object.
    - Call the `put` method you just created, passing in the newly initialized entry. Where the `put` method requires a completion closure parameter, put the `completion` of this `createEntry` method there. This will essentially forward the `completion` closure of the `put` method to the caller of `createEntry` so the potential error can be handled there.

Take a minute to test this function out; it will be helpful to have some entries in the database to look at when you make the function to fetch them. You can just create an instance of `EntryController` in either the `viewDidLoad()` of the `ViewController` class file that comes with the Xcode project, or in the `applicationDidFinishLaunchingWithOptions` method in the `AppDelegate` and call this function with some mock strings for the `title` and `bodyText` that you manually pass into the function. Check the Firebase Database to make sure the entry was PUT there correctly.

6. You will also need a method to update an existing `Entry`.
    - Create a function called `update`, that takes in an `Entry` object, a `title` string, and `bodyText` string as parameters. It should also include a completion closure that returns an optional `Error`.
    - Implement the method as you would with any other `Update` CRUD method. At the end of the method, to persist the change on the API, call the `put` method. Again passing in the newly updated `Entry` object and passing this `update` method's `completion` parameter as the `put` method's parameters.

7. Create a function called `fetchEntries`. It should have an escaping completion closure that returns an optional `Error`. This function should:
    - Create a URL that appends the `"json"` path extension to the `baseURL`.
    - Perform a GET request to the URL using a `URLSessionDataTask`.
    - In the completion closure of the data task, handle the potential error.
    - Unwrap the data and decode the data into the correct type that the JSON is returned as. Check the Firebase Database to make sure that you are decoding the into right type. Create a constant for the decoded entries.
    - Sort the decoded entries ascending or descending chronologically.
    - Set the decoded entries in the `EntryController`'s `entries` property.

### Part 4 - View and View Controller Implementation

In the `EntryTableViewCell` class:

1. Add an `entry: Entry?` variable.
2. Create an `updateViews()` function that takes the values from the `entry` variable and places them in the outlets.
3. Add a `didSet` property observer to the `entry` variable. Call `updateViews()` in it.

In the `EntryDetailViewController`:

1. Add an `entry: Entry?` variable.
2. Add an `entryController: EntryController?` variable.

In the `EntryTableViewController`:

1. Add an `entryController` constant whose value is a new instance of `EntryController`.
2. Implement the `numberOfRows` method. It should return the amount of entries in the `entryController`.
3. Implement the `cellForRowAt` method. Remember to cast the call as `EntryTableViewCell`, then pass an `Entry` to the cell's `entry` property in order for it to call the `updateViews()` method to fill in the information for the cell's labels.
4. Add the `viewWillAppear` method. Call the `entryController`'s `fetchEntries` method. In the completion, reload the table view on the main queue.

Assuming you haven't deleted the test entries that you made earlier, now would be a good time to run the app in the simulator or on a device to make sure that your table view is set up correctly. 

5. Implement the `commit editingStyle` `UITableViewDataSource` method to allow the user to swipe to delete entries. You don't have to handle the `editingStyle` being `.insert`, just `.delete`. **HINT:** since the "Delete" method in the entry controller is asynchronous, make sure to delete the table view cell inside of the completion closure of the "Delete" function, or you will create a race condition that will potentially cause the app to crash due to the cell being deleted before the `Entry` is removed from the data source (`entryController.entries`) of the table view.
6. Implement the `prepare(for segue: ...)` method. If the segue's identifier shows that the user is trying to create an entry, you will only need to pass the `entryController` to the destination view controller. If the identifier shows that they want to view an entry (by tapping a cell), pass the `entryController` and also the `Entry` that corresponds with the cell they tapped.

Back in the `EntryDetailViewController`:

1. Add an `updateViews()` method. Inside of it:
    - Make sure the view is loaded.
    - Set the view controller's title to the title of the `entry` if one was passed to this view controller, or "Create Entry" if not. 
    - This method should also fill in the text field and text view's `text` to the `title` and `bodyText` of the `entry` respectively.
2. Add a `didSet` to the `entry` variable, and call `updateViews()` in it. Also call `updateViews()` in the `viewDidLoad`.
3. In the bar button item's action:
    - Unwrap the text from both the text field and text view.
    - Unwrap the `entry` property separately. If there is an entry, call the `update` method in the `entryController`. If not, call the `createEntry` method in the `entryController` instead. In the completion closure of both methods, pop the view controller on the main queue.

## Go Further

Before you attempt these, please commit your changes so that you can always revert to a working version of the project for your own reference later.

- Change the `put` method to POST the `entries` array instead of PUT them. This will break the `fetchEntries` method, as the JSON is now different. Fix the `fetchEntries` method so that it will fetch the POSTed entries.
- Add a `Journal` data type that has an array of `Entry` objects. Create a table view controller called `JournalListTableViewController` to show/create these journals. This new table view controller should be the first view controller. The flow would be:

```
Navigation Controller Scene -> JournalListTableViewController -> EntriesListTableViewController -> EntryDetailViewController.
```

