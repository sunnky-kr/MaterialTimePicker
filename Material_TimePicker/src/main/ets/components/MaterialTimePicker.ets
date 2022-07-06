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

import { TimePickerModel } from "./TimePickerModel"
import { TimeFormat, InputMethod } from "./enums"
import { ClockFaceComponent } from "./clockfacecomponent"
import { ChipTextInputComboComponent } from "./chiptextinputcombocomponent"

@CustomDialog
export struct MaterialTimePicker {
  @State parentModel: TimePickerModel= undefined
  timeFormat: TimeFormat
  hour: number
  minute: number
  controller: CustomDialogController
  cancel: () => void
  confirm: (time: string) => void
  keyboardSymbol: Resource= $r("app.media.keyboard")
  clockSymbol: Resource= $r("app.media.clock")
  clockFaceBackgroundColor: ResourceColor
  clockHandColor: ResourceColor
  clockNumberTextColor: ResourceColor
  clockInputTitle: string= "Select Time"
  textInputTitle: string="Enter Time"
  inputMethod: InputMethod
  inputSymbol: Resource[]
  titleBackgroundColor: ResourceColor="#5e00ff"
  titleFontColor: ResourceColor=Color.White

  aboutToAppear() {
    this.timeFormat = this.timeFormat == undefined ? TimeFormat.CLOCK_12H : this.timeFormat
    if (this.parentModel == undefined) {
      this.parentModel = new TimePickerModel(new Date().getHours(), new Date().getMinutes(), this.timeFormat)
    }
    this.parentModel.setClockFormat(this.timeFormat)
    if (this.hour != undefined) {
      this.parentModel.model.setHour(this.hour)
    }
    if (this.minute != undefined) {
      this.parentModel.model.setMinute(this.minute)
    }
    this.inputSymbol = [this.keyboardSymbol, this.clockSymbol]
    if (this.inputMethod != undefined)
    this.parentModel.setInputMethod(this.inputMethod)
    if (this.clockFaceBackgroundColor != undefined)
    this.parentModel.setClockFaceBackgroundColor(this.clockFaceBackgroundColor)
    if (this.clockHandColor != undefined)
    this.parentModel.setClockHandColor(this.clockHandColor)
    if (this.clockNumberTextColor != undefined)
    this.parentModel.setClockNumberTextColor(this.clockNumberTextColor)
  }

  build() {
    Column({ space: 0 }) {
        Row() {
          Row(){
            Text(this.parentModel.inputMethod == InputMethod.TextInputMethod ? this.textInputTitle : this.clockInputTitle)
              .fontColor(this.titleFontColor)
              .fontWeight(FontWeight.Bolder)
              .fontSize(12)
          }
          .width('95%')
          .height('100%')
          Row(){
            Text("x")
            .fontColor(this.titleFontColor)
            .fontSize(25)
            .onClick(() => {
              this.cancel()
              this.controller.close()
            })
          }
          .width('5%')
          .height('100%')
        }
        .alignItems(VerticalAlign.Bottom)
        .backgroundColor(this.titleBackgroundColor)
        .height(28)
        .width(280)
      Column({space:24}) {
        Column({ space: 36 }) {
          ChipTextInputComboComponent({ timePickerModel: $parentModel })
          ClockFaceComponent({ timePickerModel: $parentModel })
        }
        .height(this.parentModel.chipHeight)
        .width(280)

        Row({ space: 118 }) {
          Button({ type: ButtonType.Normal }) {
            Image(this.parentModel.inputMethod == InputMethod.ClockInputMethod ? this.inputSymbol[0] : this.inputSymbol[1])
              .width(24)
              .height(24)
          }
          .height(44)
          .width(44)
          .backgroundColor(Color.White)
          .onClick(() => {
            this.parentModel.setInputMethod(1 - this.parentModel.inputMethod)
          })

          Row({ space: 8 }) {
            Button("CANCEL")
              .fontSize(16)
              .type(ButtonType.Normal)
              .height(36)
              .padding({ left: 2, right: 2, top: 10, bottom: 10 })
              .backgroundColor(Color.White)
              .fontColor("#9d9d9d")
              .onClick(() => {
                this.cancel()
                this.controller.close()
              })
            Button("OK")
              .type(ButtonType.Normal)
              .height(36)
              .backgroundColor("#5e00ff")
              .fontColor(Color.White)
              .borderRadius(2)
              .onClick(() => {
                this.confirm(this.parentModel.model.getTimeForDisplay())
                this.controller.close()
              })
          }
          .width(144)
          .height(36)
        }
        .height(52)
        .width("100%")
        .padding({ left: 12, right: 8 })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .height(this.parentModel.totalHeight-28)
      .padding({top:24})
      .alignItems(HorizontalAlign.Center)
    }
    .clip(true)
    .borderRadius(24)
    .width('100%')
    .height(this.parentModel.totalHeight)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.titleBackgroundColor)
  }
}