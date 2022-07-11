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
import { InputMethod, TimePickerOptions } from "./Types"
import { ClockFaceComponent } from "./clockfacecomponent"
import { ChipTextInputComboComponent } from "./chiptextinputcombocomponent"

@CustomDialog
export struct MaterialTimePicker {
  @State parentModel: TimePickerModel= undefined
  private options: TimePickerOptions
  private controller: CustomDialogController

  aboutToAppear() {
    if (this.parentModel == undefined) {
      this.parentModel = new TimePickerModel(this.options)
    }
  }

  build() {
    Column({ space: '0vp' }) {
      Row() {
        Row() {
          Text(this.parentModel.inputMethod == InputMethod.TextInputMethod ? this.parentModel.textInputTitle : this.parentModel.clockInputTitle)
            .fontColor(this.parentModel.titleFontColor)
            .fontWeight(FontWeight.Bolder)
            .fontSize('12fp')
        }
        .width('95%')
        .height('100%')

        Row() {
          Text("x")
            .fontColor(this.parentModel.titleFontColor)
            .fontSize('25fp')
            .onClick(() => {
              this.parentModel.cancel()
              this.controller.close()
            })
        }
        .width('5%')
        .height('100%')
      }
      .alignItems(VerticalAlign.Bottom)
      .backgroundColor(this.parentModel.titleBackgroundColor)
      .height('28vp')
      .width('280vp')

      Column({ space: '24vp' }) {
        Column({ space: '36vp' }) {
          ChipTextInputComboComponent({ timePickerModel: $parentModel })
          ClockFaceComponent({ timePickerModel: $parentModel })
        }
        .height(this.parentModel.chipHeight)
        .width('280vp')

        Row({ space: '118vp' }) {
          Button({ type: ButtonType.Normal }) {
            Image(this.parentModel.inputMethod == InputMethod.ClockInputMethod ? this.parentModel.inputSymbol[0] : this.parentModel.inputSymbol[1])
              .width('24vp')
              .height('24vp')
          }
          .height('44vp')
          .width('44vp')
          .backgroundColor(Color.White)
          .onClick(() => {
            this.parentModel.setInputMethod(1 - this.parentModel.inputMethod)
          })

          Row({ space: '8vp' }) {
            Button("CANCEL")
              .fontSize('16fp')
              .type(ButtonType.Normal)
              .height('36vp')
              .padding({ left: '2vp', right: '2vp', top: '10vp', bottom: '10vp' })
              .backgroundColor(Color.White)
              .fontColor("#9d9d9d")
              .onClick(() => {
                this.parentModel.cancel()
                this.controller.close()
              })
            Button("OK")
              .type(ButtonType.Normal)
              .height('36vp')
              .backgroundColor("#5e00ff")
              .fontColor(Color.White)
              .borderRadius('2vp')
              .onClick(() => {
                this.parentModel.confirm(this.parentModel.model.getTimeForDisplay())
                this.controller.close()
              })
          }
          .width('144vp')
          .height('36vp')
        }
        .height('52vp')
        .width("100%")
        .padding({ left: '12vp', right: '8vp' })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .height(this.parentModel.bodyHeight)
      .padding({ top: '24vp' })
      .alignItems(HorizontalAlign.Center)
    }
    .clip(true)
    .borderRadius('24vp')
    .width('100%')
    .height(this.parentModel.totalHeight + "vp")
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.parentModel.titleBackgroundColor)
  }
}