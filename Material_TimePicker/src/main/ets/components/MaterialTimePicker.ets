import { TimePickerModel } from "./TimePickerModel"
import { TimePickerComponent } from "./timepickercomponent"
import { TimeFormat, InputMethod } from "./enums"

@CustomDialog
export struct MaterialTimePicker {
  @State parentModel: TimePickerModel= undefined
  format: TimeFormat
  hour: number
  minute: number
  controller: CustomDialogController
  cancel: () => void
  confirm: (time: string) => void
  keyboardSymbol: Resource= $r("app.media.keyboard")
  clockSymbol: Resource= $r("app.media.clock")
  clockFaceColor: Color | string
  clockHandColor: Color | string
  clockElementColor: Color | string
  title: string= "SELECT TIME"
  inputMethod: InputMethod
  inputSymbol: Resource[]

  aboutToAppear() {
    this.format = this.format == undefined ? TimeFormat.CLOCK_12H : this.format
    if (this.parentModel == undefined) {
      this.parentModel = new TimePickerModel(new Date().getHours(), new Date().getMinutes(), this.format)
    }
    this.parentModel.setClockFormat(this.format)
    if (this.hour != undefined) {
      this.parentModel.model.setHour(this.hour)
    }
    if (this.minute != undefined) {
      this.parentModel.model.setMinute(this.minute)
    }
    this.inputSymbol = [this.keyboardSymbol, this.clockSymbol]
    if (this.inputMethod != undefined)
    this.parentModel.setInputMethod(this.inputMethod)
    if (this.clockFaceColor != undefined)
    this.parentModel.setClockFaceColor(this.clockFaceColor)
    if (this.clockHandColor != undefined)
    this.parentModel.setClockHandColor(this.clockHandColor)
    if (this.clockElementColor != undefined)
    this.parentModel.setClockElementColor(this.clockElementColor)
  }

  build() {
    Column({ space: 24 }) {
      Row() {
        Text(this.title)
          .fontSize(12)
          .fontColor("#717171")
      }
      .alignItems(VerticalAlign.Bottom)
      .height(28)
      .width(280)

      Stack() {
        TimePickerComponent({ timePickerModel: $parentModel, height: this.parentModel.chipHeight })
      }
      .displayPriority(2)

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
            .width(72)
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
            .width(64)
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
    .width(328)
    .height(this.parentModel.totalHeight)
    .padding(0)
    .alignItems(HorizontalAlign.Center)
  }
}