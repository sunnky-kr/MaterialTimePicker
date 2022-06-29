import { ClockFaceComponent } from "./ClockFaceComponent"
import { ClockFaceComponent2 } from "./ClockFaceComponent2"
import { TimePickerModel } from "./TimePickerModel"
import {ChipTextInputComboComponent} from "./ChipTextInputComboComponent"
import {test} from "./../pages/test"
//@Entry
@Component
export struct TimePickerComponent {
  //  @State timePickerModel: TimePickerModel= new TimePickerModel()
  @Link timePickerModel: TimePickerModel
  @State height: number= 372
  @State width: number= 280

  build() {
    Column({space:36}) {
      //      Row(){}
      //      .width(280)
      //      .height(80)
      //      .backgroundColor(Color.Gray)
      ChipTextInputComboComponent({timePickerModel:$timePickerModel})
      ClockFaceComponent({ timePickerModel: $timePickerModel })
      //      ClockFaceComponent2({ timePickerModel: $timePickerModel })
      //      test({comp:$height})
    }
    .height(this.height)
    .width(this.width)
    //    .backgroundColor(Color.Yellow)
  }
}