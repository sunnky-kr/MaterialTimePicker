# Time Picker
****
Time pickers help users select and set a specific time.
## Dependencies
****
For using Material_TimePicker in your app, add the below dependency in the entry/package.json  
```
"dependencies": {
    "@ohos/material_timepicker": "file:../Material_TimePicker"
  }
```
Add dependency command with
```
npm i @ohos/material_timepicker
```
## Usage instructions
****
Import these components and data types
```
import { MaterialTimePicker, TimeFormat, InputMethod } from "@ohos/material_timepicker"
```
## Screenshots
****

## How to use it
***
### Imports
Import the following components and data types
```
import { MaterialTimePicker, TimeFormat, InputMethod } from "@ohos/material_timepicker"
```
### Code
To pickup from the Time Picker
```
MaterialTimePicker({
		format: (12H or 24H clock Format: TimeFormat type)
		hour: (initial value of hour)
		minute: (initial value of minute)
		cancel: (function to call on clicking cancel button)
		confirm: (function to call on clicking OK button)
		keyboardSymbol: (resource for keyboard symbol)
		clockSymbol: (resource for clock symbol)
		clockFaceColor: (Clock Face Color)
		clockHandColor: (Clock Hand Color)
		inputMethod: (Input Method: Input Method Type)
		clockElementColor: (Clock Elements Color)
		title: (Time Picker Title)
		})
```

## Styling
****
You can style the viewer using these attributes :

| Attribute  | Description  |
| ------------ | ------------ |
| clockFaceColor  | sets the color of the clock's face  |
| clockHandColor   |  sets the color of clock's hand |
| keyboardSymbol  | Symbol for the keyboard icon |
| clockSymbol  | symbol for the clock icon  |
| format | sets the 12H or 24H format   |
| inputMethod | sets the initial Input Method   |
| clockElementColor | sets the color of clock's elements  |
| title | sets the title of the Time Picker  |

## Compatibility
****
Supports OpenHarmony API version 8
## Code Contribution
****
If you find any problems during usage, you can submit an [issue](https://github.com/Applib-OpenHarmony/MaterialTimePicker/issues) to us. Of course, we also welcome you to send us PR.
## Open source License
****
This project is based on [Apache License 2.0](./LICENSE), please enjoy and participate in open source freely.

