import {TimePickerModel } from "./TimePickerModel"
import {ClockHandComponent} from './ClockHandComponent'
import {InputMethod} from "./Enums"

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
    .width(this.timePickerModel.width)
    .height(this.timePickerModel.height)
    .visibility(this.timePickerModel.inputMethod==InputMethod.ClockInputMethod?Visibility.Visible:Visibility.None)
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
        Text(element + "")
          .fontSize(20)
          .position(this.timePickerModel.elementPositions[idx])
          .alignSelf(ItemAlign.Center)
          .onClick(() => {
            this.timePickerModel.elementStates[this.timePickerModel.selectedState] = 0
            this.timePickerModel.elementStates[idx] = 1
            this.timePickerModel.selectedState = idx
            this.timePickerModel.rotation = idx * (360 / this.timePickerModel.numberOfElements)
          })
      })
    }
    .height(this.timePickerModel.height).width(this.timePickerModel.width)
  }
}