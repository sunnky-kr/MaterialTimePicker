import { ClockFaceComponent } from "./ClockFaceComponent"
import { TimePickerModel } from "./TimePickerModel"
import {ChipTextInputComboComponent} from "./ChipTextInputComboComponent"
import {ElementFormat,ClockPeriod,TimeFormat,InputMethod} from "./Enums"

//@Entry
@Component
export struct TimePickerComponent {
  //  @State timePickerModel: TimePickerModel= new TimePickerModel()
  @Link timePickerModel: TimePickerModel
  @Link height: number
  @State width: number= 280

  build() {
    Column({space:36}) {
      ChipTextInputComboComponent({timePickerModel:$timePickerModel})
      ClockFaceComponent({ timePickerModel: $timePickerModel })
    }
    .height(this.height)
    .width(this.width)
    //    .backgroundColor(Color.Yellow)
  }
}