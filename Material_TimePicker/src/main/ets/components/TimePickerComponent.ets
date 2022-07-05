import { ClockFaceComponent } from "./clockfacecomponent"
import { TimePickerModel } from "./timepickermodel"
import { ChipTextInputComboComponent } from "./chiptextinputcombocomponent"

@Component
export struct TimePickerComponent {
  @Link timePickerModel: TimePickerModel
  height: number
  @State width: number= 280

  build() {
    Column({ space: 36 }) {
      ChipTextInputComboComponent({ timePickerModel: $timePickerModel })
      ClockFaceComponent({ timePickerModel: $timePickerModel })
    }
    .height(this.height)
    .width(this.width)
  }
}