import {ClockFaceComponent} from "./ClockFaceComponent"
import {ClockHandComponent} from "./ClockHandComponent"
import {TimePickerModel} from "./TimePickerModel"
@Entry
@Component
struct TimePickerComponent {
  private timePickerModel:TimePickerModel=new TimePickerModel()
  @State height:number=300
  @State width: number=300
  @State rot: number=0
//  clockRotation:number=this.rotation
//  aboutToAppear()
//  {
//    this.timePickerModel=new TimePickerModel()
//  }
  build()
  {

    Stack()
    {
      ClockFaceComponent({timePickerModel:this.timePickerModel})
      ClockHandComponent({timePickerModel:this.timePickerModel})
    }
    .height(this.height)
    .width(this.width)
    .alignContent(Alignment.Center)
  }
}