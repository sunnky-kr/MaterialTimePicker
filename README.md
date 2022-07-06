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
            timeFormat:TimeFormat.CLOCK_12H,
            hour:10,
            minute:30,
            cancel: this.cancel,
            confirm: (time: string) => this.submit2(time),
            keyboardSymbol: $r("app.media.keyboard"),
            clockSymbol:$r("app.media.clock"),
            clockFaceBackgroundColor:Color.Pink,
            clockHandColor:Color.Green,
            inputMethod:InputMethod.TextInputMethod,
            clockNumberTextColor:Color.Red,
            textInputTitle:"SELECT YOUR TIME",
            clockInputTitle:"Enter your Time",
            titleBackgroundColor:Color.Yellow,
            titleFontColor:Color.White
            })
```

## Styling
****
You can style the viewer using these attributes :

| Attribute  | Description  |
| ------------ | ------------ |
| timeFormat | sets the 12H or 24H format   |
| hour | sets the initial value of hour   |
| minute | sets the initial value of minute   |
| cancel | function to call on clicking cancel button   |
| confirm | function to call on clicking OK button   |
| keyboardSymbol  | Symbol for the keyboard icon |
| clockSymbol  | symbol for the clock icon  |
| clockFaceBackgroundColor  | sets the color of the background of clock's face  |
| clockHandColor   |  sets the color of clock's hand |
| inputMethod | sets the initial Input Method   |
| clockNumberTextColor | sets the color of clock's elements  |
| textInputTitle | sets the title of the Time Picker screen in Text Input Mode   |
| clockInputTitle | sets the title of the Time Picker screen in Clock Input Mode   |
| titleBackgroundColor | sets the background color of the title  |
| titleFontColor | sets the font color of the title  |

## Compatibility
****
Supports OpenHarmony API version 9
## Code Contribution
****
If you find any problems during usage, you can submit an [issue](https://github.com/Applib-OpenHarmony/MaterialTimePicker/issues) to us. Of course, we also welcome you to send us PR.
## Open source License
****
This project is based on [Apache License 2.0](./LICENSE), please enjoy and participate in open source freely.

