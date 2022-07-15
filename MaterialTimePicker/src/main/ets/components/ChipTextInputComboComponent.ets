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

import { TimePickerModel } from "./timepickermodel"
import { ElementFormat, ClockPeriod, TimeFormat, InputMethod } from "./Types"

@Component
export struct ChipTextInputComboComponent {
  @Link timePickerModel: TimePickerModel
  @State selectedPeriod: number= 0
  @State hour:string=""
  @State minute: string=""
  hourButtonClickTime: Date
  minuteButtonClickTime: Date
  StateColors: ResourceColor[]= ["#ffd8ddff", "#e4e4e4"]
  TimeStateColors: ResourceColor[]= ["#ff5e00ff", "#ff282828"]
  periodBGColors: ResourceColor[]= ["#ffd8ddff", Color.White]
  periodStateColors: ResourceColor[]= ["#ff5e00ff", "#ffabaaad"]
  borderColor: ResourceColor= "#ffabaaad"

  aboutToAppear() {
    if (this.timePickerModel.model.period == ClockPeriod.PM) {
      this.selectedPeriod = 1
    }
    this.hour=this.timePickerModel.model.hourForDisplay
    this.minute=this.timePickerModel.model.minuteForDisplay
  }
  hourButtonClick(checkDoubleClick:boolean=true){
    this.timePickerModel.setFormat(this.timePickerModel.model.format == TimeFormat.CLOCK_12H ? ElementFormat.FORMAT_12H : ElementFormat.FORMAT_24H)
    if(checkDoubleClick) {
      if (this.hourButtonClickTime == undefined || this.hourButtonClickTime == null) {
        this.hourButtonClickTime = new Date()
      }
      else {
        var end = new Date()
        var delay: number = end.getTime() - this.hourButtonClickTime.getTime()
        if (delay < 300) {
          this.timePickerModel.setInputMethod(InputMethod.TextInputMethod)
        }
        this.hourButtonClickTime = end
      }
    }
  }
  minuteButtonClick(checkDoubleClick:boolean=true) {
    this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
    if(checkDoubleClick) {
      if (this.minuteButtonClickTime == undefined || this.minuteButtonClickTime == null) {
        this.minuteButtonClickTime = new Date()
      }
      else {
        var end = new Date()
        var delay: number = end.getTime() - this.minuteButtonClickTime.getTime()
        if (delay < 300) {
          this.timePickerModel.setInputMethod(InputMethod.TextInputMethod)
        }
        this.minuteButtonClickTime = end
      }
    }
  }
  build() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Start }) {
      Column({ space: '0vp' }) {
        Column() {
          TextInput({ text:this.hour})
            .width('100%')
            .height('100%')
            .caretColor(this.TimeStateColors[0])
            .fontSize('50fp')
            .maxLength(2)
            .align(Alignment.Center)
            .fontColor(this.TimeStateColors[this.timePickerModel.format == ElementFormat.FORMAT_MINUTE?1:0])
            .backgroundColor(this.StateColors[this.timePickerModel.format == ElementFormat.FORMAT_MINUTE?1:0])
            .enabled(this.timePickerModel.inputMethod == InputMethod.TextInputMethod)
            .onTouch(()=>{
              this.hourButtonClick(false)
            })
            .onChange((value: string) => {
              if (value.length > 0 && Number(value) > this.timePickerModel.maxValue) {
                this.hour = "0" + value[0]
              } else {
                this.hour = value
              }
              this.timePickerModel.model.setHour(Number(value))

            })
        }
        .width('100%')
        .height('80vp')
        .borderRadius('2vp')
        .borderWidth('2vp')
        .borderColor(this.timePickerModel.format != ElementFormat.FORMAT_MINUTE && this.timePickerModel.inputMethod == InputMethod.TextInputMethod ? "#ff5e00ff" : this.borderColor)
        .backgroundColor(this.StateColors[this.timePickerModel.format == ElementFormat.FORMAT_MINUTE?1:0])
        .onTouch((event) => {
          if(event.type==TouchType.Up) {
            this.hourButtonClick()
          }
        })


        Text("Hour")
          .fontSize('12fp')
          .fontColor(this.timePickerModel.labelColor)
          .padding({ top: '8vp' })
          .visibility(this.timePickerModel.inputMethod == InputMethod.TextInputMethod ? Visibility.Visible : Visibility.None)
      }
      .width('96vp')
      .height('100%')
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text(":")
          .fontWeight(FontWeight.Bolder)
          .fontSize('50fp')
          .fontFamily("Calibri")
          .height('90%')
      }
      .width('24vp')
      .height('80vp')
      .alignItems(HorizontalAlign.Center)
      .alignSelf(ItemAlign.Start)

      Column({ space: '0vp' }) {
        Column() {
          TextInput({ text:this.minute})
            .width('100%')
            .height('100%')
            .caretColor(this.TimeStateColors[0])
            .maxLength(2)
            .fontSize('50fp')
            .align(Alignment.Center)
            .fontColor(this.TimeStateColors[this.timePickerModel.format == ElementFormat.FORMAT_MINUTE?0:1])
            .backgroundColor(this.StateColors[this.timePickerModel.format == ElementFormat.FORMAT_MINUTE?0:1])
            .enabled(this.timePickerModel.inputMethod == InputMethod.TextInputMethod)
            .onTouch(()=>{
              this.minuteButtonClick(false)
            })
            .onChange((value: string) => {
              if (value.length > 0 && Number(value) > this.timePickerModel.maxValue) {
                this.minute = "0" + value[0]
              } else {
                this.minute = value
              }
              this.timePickerModel.model.setMinute(Number(value))
            })
        }
        .width('100%')
        .height('80vp')
        .borderRadius('2vp')
        .borderWidth('2vp')
        .borderColor(this.timePickerModel.format == ElementFormat.FORMAT_MINUTE && this.timePickerModel.inputMethod == InputMethod.TextInputMethod ? "#ff5e00ff" : this.borderColor)
        .backgroundColor(this.StateColors[this.timePickerModel.format == ElementFormat.FORMAT_MINUTE?0:1])
        .onTouch((event) => {
          if(event.type==TouchType.Up) {
            this.minuteButtonClick()
          }
        })

        Text("Minute")
          .fontSize('12fp')
          .fontColor(this.timePickerModel.labelColor)
          .padding({ top: '8vp' })
          .visibility(this.timePickerModel.inputMethod == InputMethod.TextInputMethod ? Visibility.Visible : Visibility.None)

      }
      .width('96vp')
      .height('100%')
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text("AM")
          .fontWeight(FontWeight.Bolder)
          .fontFamily('Calibri')
          .textAlign(TextAlign.Center)
          .fontSize('20fp')
          .fontColor(this.periodStateColors[this.selectedPeriod])
          .backgroundColor(this.periodBGColors[this.selectedPeriod])
          .width('95%')
          .height('46.5%')
          .clip(true)
          .margin('2vp')
          .onClick(() => {
            this.selectedPeriod = 0
            this.timePickerModel.model.setPeriod(ClockPeriod.AM)
          })
        Text("PM")
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Bolder)
          .fontFamily('Calibri')
          .fontSize('20fp')
          .fontColor(this.periodStateColors[1-this.selectedPeriod])
          .backgroundColor(this.periodBGColors[1-this.selectedPeriod])
          .width('95%')
          .height('46.5%')
          .clip(true)
          .margin({ bottom: '2vp', left: '2vp', right: '2vp' })
          .onClick(() => {
            this.selectedPeriod = 1
            this.timePickerModel.model.setPeriod(ClockPeriod.PM)
          })

      }
      .width('52vp')
      .height('80vp')
      .borderRadius('2vp')
      .borderColor(this.borderColor)
      .backgroundColor(this.borderColor)
      .margin({ left: '12vp' })
      .visibility(this.timePickerModel.model.format == TimeFormat.CLOCK_12H ? Visibility.Visible : Visibility.None)
    }
    .width(this.timePickerModel.model.format == TimeFormat.CLOCK_24H ? '228vp' : '280vp')
    .height(this.timePickerModel.inputMethod == InputMethod.TextInputMethod ? '100vp' : '80vp')
  }
}
