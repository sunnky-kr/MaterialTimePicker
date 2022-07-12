/*
 * Copyright (C) 2022 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { MaterialTimePicker, TimeFormat, InputMethod, TimePickerOptions } from "@ohos/material_timepicker"

@Entry
@Component
struct DemoScreen {
  build() {

    Flex({ direction: FlexDirection.Column, alignContent: FlexAlign.SpaceBetween }) {
      Column({ space: '25vp' }) {
        Text("Select Time").fontSize('20fp')
        TimePickerButton({ width: '280vp' })
      }
      .alignItems(HorizontalAlign.Start)

      Column({ space: '25vp' }) {
        Text("Select range").fontSize('20fp')
        Row({ space: '10vp' }) {
          Column({ space: '10vp' }) {
            Text("Start").fontSize('12fp')
            TimePickerButton({ width: '120vp' })
          }
          .width('170vp')
          .alignItems(HorizontalAlign.Start)

          Column({ space: '10vp' }) {
            Text("End").fontSize('12fp')
            TimePickerButton({ width: '120vp' })
          }
          .width('170vp')
          .alignItems(HorizontalAlign.Start)
        }

      }
      .alignItems(HorizontalAlign.Start)
      .width('350vp')
    }
    .width("40%")
    .height("100%")
    .padding({ top: '50vp', left: '20vp' })
  }
}

@Component
struct TimePickerButton {
  @State time: string= ""
  width: Length= '100vp'
  controller: CustomDialogController= new CustomDialogController({
    builder: MaterialTimePicker({
                      options: {
                        timeFormat: TimeFormat.CLOCK_12H,
                        hour:new Date().getHours(),
                        minute:new Date().getMinutes(),
                        cancel: [this.cancel],
                        onPositiveButtonClick: [(time:string)=>this.submit(time)],
                        onNegativeButtonClick:[this.cancel],
                        dismiss:[this.cancel],
                        keyboardSymbol: $r("app.media.keyboard"),
                        clockSymbol:$r("app.media.clock"),
                        clockFaceBackgroundColor:"#e4e4e4",
                        clockHandColor:"#5e00ff",
                        inputMethod:InputMethod.ClockInputMethod,
                        clockNumberTextColor: Color.Black,
                        textInputTitle:"Enter Time",
                        clockInputTitle:"Select Time",
                        titleBackgroundColor:"#5e00ff",
                        titleFontColor:Color.White,
                        labelColor:"#717171",
                        materialCircleRadius:100,
                        selectorSize:50
                      }
    })
  })

  submit(time: string) {
    this.time = time
  }

  cancel() {
  }

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      TextArea({ text: this.time }).width(this.width)
      Button({ type: ButtonType.Capsule }) {

        Image($r("app.media.clock")).width('30vp').height('30vp')
      }
      .backgroundColor(Color.White)
      .width('50vp')
      .height('40vp')
      .onClick(() => {
        this.controller.open()
      }
      )
    }
    .width("95%")
  }
}