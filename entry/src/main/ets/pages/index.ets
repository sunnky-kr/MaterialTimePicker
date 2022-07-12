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
  @State hour: string= new Date().getHours() + ""
  @State minute: string= new Date().getMinutes() + ""
  @State time: string= ""
  width: Length= '100vp'
  controller: CustomDialogController= new CustomDialogController({
    builder: MaterialTimePicker({
                      options: {
//                        timeFormat: TimeFormat.CLOCK_24H,
//                        hour:10,
//                        minute:30,
                        cancel: [this.cancel],
                        onPositiveButtonClick: [(time: string) => this.submit2(time)],
                        onNegativeButtonClick:[this.cancel],
                        dismiss:[this.cancel],
//                        keyboardSymbol: $r("app.media.keyboard"),
//                        clockSymbol:$r("app.media.clock"),
//                        clockFaceBackgroundColor:Color.Pink,
//                        clockHandColor:Color.Green,
//                        inputMethod:InputMethod.TextInputMethod,
//                        clockNumberTextColor:Color.Red,
//                        textInputTitle:"SELECT YOUR TIME",
//                        clockInputTitle:"Enter your Time",
//                        titleBackgroundColor:Color.Yellow,
//                        titleFontColor:Color.White,
//                        labelColor=Color.Red,
//                        materialCircleRadius=200,
//                        selectorSize=60
                      }
    })
  })

  submit(hour: string, minute: string) {
    this.hour = hour
    this.minute = minute
  }

  submit2(time: string) {
    this.time = time
  }

  cancel() {
    console.log("cancelled")
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