import { TimePickerModel } from "./TimePickerModel"
import { ElementFormat, ClockPeriod, TimeFormat, InputMethod } from "./Enums"

@Component
export struct ChipTextInputComboComponent {
  @Link timePickerModel: TimePickerModel
  @State selectedPeriod: number= 0
  @State selectedInput: number= 0
  StateColors: (string | Color)[]= ["#ece0fd", "#e4e4e4"]
  borderColor: string | Color= "#a0a0a0"
  aboutToAppear(){
    if(this.timePickerModel.model.period==ClockPeriod.PM)
    this.selectedPeriod=1
  }
  build() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, alignContent: FlexAlign.Center }) {
      Text("").width(0).height(0)
      Column({ space: 0 }) {
        Button() {
          TextInput({ placeholder: (this.timePickerModel.model.formattedHour()) })
            .width('100%')
            .height('100%')
            .fontSize(50)
            .backgroundColor(this.StateColors[this.selectedInput])
            .enabled(this.timePickerModel.inputMethod == InputMethod.TextInputMethod)
            .borderColor(this.borderColor)
            .onChange((value: string) => {
              this.timePickerModel.model.setHour(Number(value))
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)
        .onClick(() => {
          console.log("clicked")
          this.timePickerModel.setFormat(ElementFormat.FORMAT_12H)
          this.selectedInput = 0
        })

        if (this.timePickerModel.inputMethod == InputMethod.TextInputMethod) {
          Text("Hour").fontSize(12).fontColor(Color.Gray)
        }
      }
      .width(96)
      .height(80)
      .alignItems(HorizontalAlign.Start)

      Text(":")
        .width(24)
        .height(80)
        .fontWeight(FontWeight.Bolder)
        .fontSize(60)
        .fontFamily("Calibri")
        .align(Alignment.Center)
      Column({ space: 0 }) {
        Button() {
          TextInput({ placeholder: (this.timePickerModel.model.formattedMinute()) })
            .width('100%')
            .height('100%')
            .fontSize(50)
            .backgroundColor(this.StateColors[1-this.selectedInput])
            .enabled(this.timePickerModel.inputMethod == InputMethod.TextInputMethod)
            .borderColor(this.borderColor)

            .onChange((value: string) => {
              this.timePickerModel.model.setMinute(Number(value))
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)
        .onClick(() => {
          this.selectedInput = 1
          this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
          console.log("state Changed")
        })

        if (this.timePickerModel.inputMethod == InputMethod.TextInputMethod) {
          Text("Minute").fontSize(12).fontColor(Color.Gray)
        }
      }
      .width(96)
      .height(80)
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text("AM")
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .backgroundColor(this.StateColors[this.selectedPeriod])
          .width(52)
          .height(40)
          .borderRadius(7)
          .onClick(() => {
            this.selectedPeriod = 0
            this.timePickerModel.model.setPeriod(ClockPeriod.AM)
          })
        Text("PM")
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .backgroundColor(this.StateColors[1-this.selectedPeriod])
          .width(52)
          .height(40)
          .borderRadius(7)
          .onClick(() => {
            this.selectedPeriod = 1
            this.timePickerModel.model.setPeriod(ClockPeriod.PM)
          })

      }
      .width(52)
      .height(80)
      .margin({ left: 12 })
      .visibility(this.timePickerModel.model.format == TimeFormat.CLOCK_12H ? Visibility.Visible : Visibility.Hidden)
    }
    .width(280)
    .height(80)

  }
}
