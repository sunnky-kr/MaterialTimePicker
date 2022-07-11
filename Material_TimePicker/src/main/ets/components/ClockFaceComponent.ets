/*
 * Copyright (C) 2022 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { TimePickerModel } from "./timepickermodel"
import { ClockHandComponent } from './clockhandcomponent'
import { InputMethod } from "./Types"

@Component
export struct ClockFaceComponent {
  @Link timePickerModel: TimePickerModel

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: this.timePickerModel.clockFaceDiameter, height: this.timePickerModel.clockFaceDiameter })
        .fill(this.timePickerModel.clockFaceBackgroundColor)
      RadialContainer({ timePickerModel: $timePickerModel })
      ClockHandComponent({ timePickerModel: $timePickerModel })
    }
    .width(this.timePickerModel.clockWidth)
    .height(this.timePickerModel.clockHeight + "vp")
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
          Text(element + "")
            .fontSize('20fp')
            .alignSelf(ItemAlign.Center)
            .fontColor(this.timePickerModel.clockNumberTextColor)
        }
        .height(this.timePickerModel.elementSize + 'vp')
        .width(this.timePickerModel.elementSize + 'vp')
        .position(this.timePickerModel.elementPositions[idx])
        .alignItems(HorizontalAlign.Center)
      })
    }
    .height('100%').width('100%')
  }
}