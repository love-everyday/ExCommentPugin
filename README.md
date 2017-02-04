# ExCommentPugin

ExCommentPugin is plugin for Xcode8, which can comment codes and add the documents for functions.

## Requirements

- Xcode 8.0+
- Swift 3.0+

## Installation

1. Edit Scheme `CommentPlugin` ![EditScheme](Resources/EditScheme.png)
2. Run `CommentPlugin`, which will create a new gray Xcode, then you can find `CommentPlugin` in `Editor`. ![Editor](Resources/Editor.png)
3. Close the gray Xcode, Run the `ExCommentPugin`, then will create a **mac app**. ![macApp](Resources/macApp.png)
4. Close the normal Xcode, reopen the normal Xcode. Open a project, select a file. If yo find `CommentPlugin` in `Editor`, you can use the plugin now.
5. You can set the **hotkey** for `CommentPlugin`. ![hotkey](Resources/hotkey.png)

## UnInstallation
1. You can manager the Plugins in `System Perference`, for setting the plugins hidden or not.![SystemPerference](Resources/SystemPerference.png)
2. You can also open the folder **/Xcode/DerivedData**, and delete folder **ExCommentPugin**.![XcodePerference](Resources/XcodePerference.png)![DerivedData](Resources/DerivedData.png)

## Usage

1. `extComment` ![注释1](Resources/注释1.gif)
2. `extComments` ![注释2](Resources/注释2.gif)
3. `extDocument` ![注释3](Resources/注释3.gif)