import {TimePickerModel} from "./TimePickerModel"
import {ElementFormat,ClockPeriod,TimeFormat,InputMethod} from "./Enums"

@Component
export struct ChipTextInputComboComponent
{
//  @Link hour2:number
//  @Link minute2:number
  @Link model:TimePickerModel
  @State selectedPeriod:number=0
  @State selectedInput:number=0
  StateColors:(string|Color)[]=["#ece0fd","#e4e4e4"]
  borderColor:string|Color="#a0a0a0"
  aboutToAppear()
  {
//    this.model=new TimePickerModel()
  }
  build()
  {
    Flex({direction:FlexDirection.Row,alignItems:ItemAlign.Center,alignContent:FlexAlign.Center})
    {
//      Text("")
//      .width(0)
//      .height(0)
      TextInput({placeholder:(""+this.model.model.getHourForDisplay())})
        .width(96)
        .height(80)
        .fontSize(50)
        .backgroundColor(this.StateColors[this.selectedInput])
//        .borderRadius(4)
//        .borderWidth(1)
        .enabled(this.model.inputMethod==InputMethod.TextInputMethod)
        .borderColor(this.borderColor)
        .onClick(()=>
        {
          this.selectedInput=0
        })
      Text(":")
        .width(24)
        .height(80)
        .fontWeight(FontWeight.Bolder)
        .fontSize(60)
        .fontFamily("Calibri")
        .align(Alignment.Center)
      TextInput({placeholder:(""+this.model.model.getMinuteForDisplay())})
        .width(96)
        .height(80)
        .fontSize(50)
        .backgroundColor(this.StateColors[1-this.selectedInput])
//        .borderRadius(4)
//        .borderWidth(1)
        .enabled(this.model.inputMethod==InputMethod.TextInputMethod)
        .borderColor(this.borderColor)
        .onClick(()=>
        {
          this.selectedInput=1
          console.log("state Changed")
        })
//      .margin({right:12})
      Column()
      {
        Text("AM")
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .backgroundColor(this.StateColors[this.selectedPeriod])
          .width(52)
          .height(40)
          .borderRadius(7)
          .onClick(()=>
          {
            this.selectedPeriod=0
            this.model.model.setPeriod(ClockPeriod.AM)
          })
        Text("PM")
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .backgroundColor(this.StateColors[1-this.selectedPeriod])
          .width(52)
          .height(40)
          .borderRadius(7)
          .onClick(()=>
          {
            this.selectedPeriod=1
            this.model.model.setPeriod(ClockPeriod.PM)
          })

      }
      .width(52)
      .height(80)
      .margin({left:12})
      .visibility(this.model.model.format!=TimeFormat.CLOCK_12H?Visibility.Visible:Visibility.Hidden)
    }
    .width(280)
    .height(80)

  }
}
