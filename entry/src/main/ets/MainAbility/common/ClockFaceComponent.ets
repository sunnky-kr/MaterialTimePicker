import { ElementPosition, TimePickerModel } from "./TimePickerModel"
import {ClockHandComponent} from './ClockHandComponent'
//@Entry
@Component
export struct ClockFaceComponent {
  @Link timePickerModel: TimePickerModel//=new TimePickerModel()

  aboutToAppear() {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: this.timePickerModel.clockFaceDiameter, height: this.timePickerModel.clockFaceDiameter })
        .fill(this.timePickerModel.clockFaceColor)
      RadialContainer({ timePickerModel: $timePickerModel })
      ClockHandComponent({ timePickerModel: $timePickerModel })
    }.width(this.timePickerModel.width).height(this.timePickerModel.height)
  }
}

@Component
export struct RadialContainer {
  @Link timePickerModel: TimePickerModel

  aboutToAppear() {
    this.timePickerModel.initialize()
    console.log("initialized")
  }

  build() {
    Flex() {
      ForEach(this.timePickerModel.elements, (element, idx) => {
        Text(element + "")
          .fontSize(20)
          .position(this.timePickerModel.elementPositions[idx])
          .alignSelf(ItemAlign.Center)
            //          .fontColor(this.timePickerModel.elementColors[this.timePickerModel.elementStates[idx]])
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
