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
  @State time: string= this.hour + ":" + this.minute
  width: number= 100
  controller: CustomDialogController= new CustomDialogController({
    builder: MaterialTimePicker({
      //      format:TimeFormat.CLOCK_12H,
      //      hour:10,
      //      minute:30,
      cancel: this.cancel,
      confirm: (time: string) => this.submit2(time),
      //      keyboardSymbol: $r("app.media.icon"),
      //      clockSymbol:$r("app.media.clock"),
      //      clockFaceColor:Color.Pink,
      //      clockHandColor:Color.Green,
      //      inputMethod:InputMethod.TextInputMethod,
      //      clockElementColor:Color.Red,
      //      title:"SELECT YOUR TIME"
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
      .padding(0)
      .onClick(() => {
        this.controller.open()
      }
      )
    }
    .width("95%")
  }
}