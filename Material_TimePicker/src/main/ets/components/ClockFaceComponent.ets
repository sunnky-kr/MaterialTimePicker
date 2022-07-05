import { TimePickerModel } from "./timepickermodel"
import { ClockHandComponent } from './clockhandcomponent'
import { InputMethod } from "./enums"

@Component
export struct ClockFaceComponent {
  @Link timePickerModel: TimePickerModel

  aboutToAppear() {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: this.timePickerModel.clockFaceDiameter, height: this.timePickerModel.clockFaceDiameter })
        .fill(this.timePickerModel.clockFaceColor)
      RadialContainer({ timePickerModel: $timePickerModel })
      ClockHandComponent({ timePickerModel: $timePickerModel })
    }
    .width(this.timePickerModel.clockWidth)
    .height(this.timePickerModel.clockHeight)
    .visibility(this.timePickerModel.inputMethod == InputMethod.ClockInputMethod ? Visibility.Visible : Visibility.None)
  }
}

@Component
export struct RadialContainer {
  @Link timePickerModel: TimePickerModel

  aboutToAppear() {
    this.timePickerModel.initialize()
  }

  build() {
    Flex() {
      ForEach(this.timePickerModel.elements, (element, idx) => {
        Column() {
          Text(element + "").fontSize(20).alignSelf(ItemAlign.Center).fontColor(this.timePickerModel.elementColor)
        }
        .height(this.timePickerModel.elementSize)
        .width(this.timePickerModel.elementSize)
        .position(this.timePickerModel.elementPositions[idx])
        .alignItems(HorizontalAlign.Center)
      })
    }
    .height(this.timePickerModel.clockHeight).width(this.timePickerModel.clockWidth)
  }
}