import {ClockFaceComponent,RadialContainer} from "./ClockFaceComponent"
import {ChipTextInputComboComponent} from "./ChipTextInputComboComponent"
import {TimePickerModel} from "./TimePickerModel"
import {TimeModel} from "./TimeModel"
import {TimePickerComponent} from "./TimePickerComponent"
import {ElementFormat,ClockPeriod,TimeFormat,InputMethod} from "./Enums"

//export class ElementPosition implements Position
//{
//  x:number;y:number;
//  ElementPosition(x:number,y:number)
//  {
//    this.x=x!=undefined?x:0;
//    this.y=y!=undefined?y:0;
//
//  }
//}
//@Entry
//@Component
@CustomDialog
export struct TimePickerDisplay {
  @State parentModel:TimePickerModel=undefined
  timeModel:TimeModel
  controller:CustomDialogController
  cancel:() => void
  confirm: (hour,minute)=> void
  inputSymbol:Resource[]=[$r("app.media.keyboard"),$r("app.media.clock")]
  aboutToAppear()
  {
    //        this.timeModel=new TimeModel()
    this.parentModel=new TimePickerModel(this.timeModel)
    //  @State Thour:number=new Date().getHours()
  }
  build()
  {
    Column({space:24})
    {
      Row() {
        Text("SELECT TIME")
          .fontSize(12)
          .fontColor(Color.Grey)
        //        .align(Alignment.BottomStart)
      }
      .alignItems(VerticalAlign.Bottom)
      .height(28)
      .width(280)
      //        .backgroundColor(Color.Brown)
      //        .margin({bottom:24})
      TimePickerComponent({timePickerModel:$parentModel})
      Row({space:118})
      {
        Button({type:ButtonType.Normal})
        {
          Image(this.parentModel.inputMethod==InputMethod.ClockInputMethod?this.inputSymbol[0]:this.inputSymbol[1]).width(24).height(24)
        }
        .height(44)
        .width(44)
        .backgroundColor(Color.White)
        Row({space:8})
        {
          Button("CANCEL")
            .fontSize(16)
            .type(ButtonType.Normal)
            .width(72)
            .height(36)
            .padding({ left:2 ,right:2,top:10,bottom:10})
            .backgroundColor(Color.White)
            .fontColor(Color.Gray)
            .onClick(()=>
            {
              this.cancel()
              this.controller.close()
            })
          Button("OK")
            .type(ButtonType.Normal)
            .width(64)
            .height(36)
            .backgroundColor(Color.White)
            .fontColor(Color.Gray)
            .onClick(()=>
            {
              this.confirm(this.parentModel.model.formattedHour(),this.parentModel.model.formattedMinute())
              this.controller.close()
            })
        }
        .width(144)
        .height(36)
      }
      .height(52)
      .width("100%")
      //      .margin({left:12})
      .padding({left:12,right:8})
      //      .backgroundColor(Color.Black)
    }
    .width(328)
    .padding(0)
    .alignItems(HorizontalAlign.Center)
  }
}