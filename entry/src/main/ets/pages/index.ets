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

import { MaterialTimePicker, TimeFormat, InputMethod } from "@ohos/material_timepicker"

@Entry
@Component
struct DemoScreen {
  build() {

    Flex({ direction: FlexDirection.Column, alignContent: FlexAlign.SpaceBetween }) {
      Column({ space: 25 }) {
        Text("Select Time").fontSize(20)
        TimePickerButton({ width: 280 })
      }
      .alignItems(HorizontalAlign.Start)

      Column({ space: 25 }) {
        Text("Select range").fontSize(20)
        Row({ space: 10 }) {
          Column({ space: 10 }) {
            Text("Start").fontSize(12)
            TimePickerButton({ width: 120 })
          }
          .width(170)
          .alignItems(HorizontalAlign.Start)

          Column({ space: 10 }) {
            Text("End").fontSize(12)
            TimePickerButton({ width: 120 })
          }
          .width(170)
          .alignItems(HorizontalAlign.Start)
        }

      }
      .alignItems(HorizontalAlign.Start)
      .width(350)
    }
    .width("40%")
    .height("100%")
    .padding({ top: 50, left: 20 })
  }
}

@Component
struct TimePickerButton {
  @State hour: string= new Date().getHours() + ""
  @State minute: string= new Date().getMinutes() + ""
  @State time: string= ""
  width: number= 100
  controller: CustomDialogController= new CustomDialogController({
    builder: MaterialTimePicker({
      //            timeFormat:TimeFormat.CLOCK_12H,
      //            hour:10,
      //            minute:30,
      cancel: this.cancel,
      confirm: (time: string) => this.submit2(time),
      //            keyboardSymbol: $r("app.media.keyboard"),
      //            clockSymbol:$r("app.media.clock"),
      //            clockFaceBackgroundColor:Color.Pink,
      //            clockHandColor:Color.Green,
      //            inputMethod:InputMethod.TextInputMethod,
      //            clockNumberTextColor:Color.Red,
      //            textInputTitle:"SELECT YOUR TIME",
      //            clockInputTitle:"Enter your Time",
      //            titleBackgroundColor:Color.Yellow,
      //            titleFontColor:Color.White
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
  }

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween }) {
      TextArea({ text: this.time }).width(this.width)
      Button({ type: ButtonType.Capsule }) {

        Image($r("app.media.clock")).width(30).height(30)
      }
      .backgroundColor(Color.White)
      .width(50)
      .height(40)
      .onClick(() => {
        this.controller.open()
      }
      )
    }
    .width("95%")
  }
}