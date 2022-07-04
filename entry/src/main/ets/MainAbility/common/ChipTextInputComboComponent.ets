import { TimePickerModel } from "./TimePickerModel"
import { ElementFormat, ClockPeriod, TimeFormat, InputMethod } from "./Enums"

@Component
export struct ChipTextInputComboComponent {
  @Link timePickerModel: TimePickerModel
  @State selectedPeriod: number= 0
  start1:Date
  start2:Date
  StateColors: (string | Color)[]= ["#ffd8ddff", "#e4e4e4"]
  TimeStateColors:(string | Color)[]= ["#ff5e00ff", "#ff282828"]
  periodBGColors:(string | Color)[]= ["#ffd8ddff", Color.White]
  periodStateColors:(string | Color)[]= [ "#ff5e00ff","#ffabaaad"]
  borderColor: string | Color= "#ffabaaad"
  aboutToAppear(){
    if(this.timePickerModel.model.period==ClockPeriod.PM)
    this.selectedPeriod=1
  }
  build() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, alignContent: FlexAlign.Center }) {
      Column({ space: 0 }) {
        Button() {
          TextInput({ placeholder: (this.timePickerModel.model.formattedHour()) })
            .width('100%')
            .height('100%')
            .fontSize(50)
            .fontColor(this.TimeStateColors[this.timePickerModel.format==ElementFormat.FORMAT_MINUTE?1:0])
            .backgroundColor(this.StateColors[this.timePickerModel.format==ElementFormat.FORMAT_MINUTE?1:0])
            .enabled(this.timePickerModel.inputMethod == InputMethod.TextInputMethod)
            .borderColor(this.borderColor)
            .borderWidth(2)
            .borderRadius(22)
            .onChange((value: string) => {
              this.timePickerModel.model.setHour(Number(value))
            })
        }
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .onClick(() => {
          this.timePickerModel.setFormat(ElementFormat.FORMAT_12H)
          if(this.start1==undefined)
          {
            this.start1=new Date()
          }
          else
          {
            var end=new Date()
            console.log(end.getTime()+"")
            var delay:number=end.getTime()-this.start1.getTime()
            if(delay<400)
              this.timePickerModel.setInputMethod(InputMethod.TextInputMethod)

            this.start1=end
          }
        })


        Text("Hour")
          .height(20)
          .fontSize(12)
          .fontColor("#717171")
          .padding({top:8})
          .visibility(this.timePickerModel.inputMethod == InputMethod.TextInputMethod?Visibility.Visible:Visibility.None)
      }
      .width(96)
      .height(this.timePickerModel.inputMethod == InputMethod.TextInputMethod?100:80)
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
            .fontColor(this.StateColors[this.timePickerModel.format==ElementFormat.FORMAT_MINUTE?0:1])
            .backgroundColor(this.StateColors[this.timePickerModel.format==ElementFormat.FORMAT_MINUTE?0:1])
            .enabled(this.timePickerModel.inputMethod == InputMethod.TextInputMethod)
            .borderColor(this.borderColor)
            .borderWidth(2)
            .borderRadius(22)
            .onChange((value: string) => {
              this.timePickerModel.model.setMinute(Number(value))
            })
        }
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .onClick(() => {
          this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
          if(this.start2==undefined)
          {
            this.start2=new Date()
          }
          else
          {
            var end=new Date()
            console.log(end.getTime()+"")
            var delay:number=end.getTime()-this.start2.getTime()
            if(delay<400)
            this.timePickerModel.setInputMethod(InputMethod.TextInputMethod)

            this.start2=end
          }
        })
        Text("Minute")
          .height(20)
          .fontSize(12)
          .fontColor("#717171")
          .padding({top:8})
          .visibility(this.timePickerModel.inputMethod == InputMethod.TextInputMethod?Visibility.Visible:Visibility.None)

      }
      .width(96)
      .height(this.timePickerModel.inputMethod == InputMethod.TextInputMethod?100:80)
      .alignItems(HorizontalAlign.Start)

      Column() {
        Text("AM")
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .fontColor(this.periodStateColors[this.selectedPeriod])
          .backgroundColor(this.periodBGColors[this.selectedPeriod])
          .width('95%')
          .height('46.5%')
          .clip(true)
          .margin(2)
//          .borderRadius(20)
          .onClick(() => {
            this.selectedPeriod = 0
            this.timePickerModel.model.setPeriod(ClockPeriod.AM)
          })
        Text("PM")
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .fontColor(this.periodStateColors[1-this.selectedPeriod])
          .backgroundColor(this.periodBGColors[1-this.selectedPeriod])
          .width('95%')
          .height('46.5%')
          .clip(true)
          .margin({ bottom:2,left :2,right:2})
//          .borderRadius(20)
          .onClick(() => {
            this.selectedPeriod = 1
            this.timePickerModel.model.setPeriod(ClockPeriod.PM)
          })

      }
      .width(52)
      .height(80)
      .borderRadius(2)
      .borderColor(this.borderColor)
      .backgroundColor(this.borderColor)
      .margin({ left: 12 })
      .visibility(this.timePickerModel.model.format == TimeFormat.CLOCK_12H ? Visibility.Visible : Visibility.None)
    }
    .width(this.timePickerModel.model.format==TimeFormat.CLOCK_24H?228:280)
    .height(80)
  }
}
