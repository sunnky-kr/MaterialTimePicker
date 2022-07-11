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

import { TimePickerModel } from './timepickermodel';
import { ElementFormat } from "./Types"

@Component
export struct ClockHandComponent {
  @Link timePickerModel: TimePickerModel

  aboutToAppear() {
    this.timePickerModel.update()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Line()
        .stroke(this.timePickerModel.handColor)
        .strokeWidth('4vp')
        .startPoint(this.timePickerModel.startPoint)
        .endPoint(this.timePickerModel.endPoint)
        .height('100%')
        .width('100%')

      Circle({ height: this.timePickerModel.jointSize, width: this.timePickerModel.jointSize })
        .fill(this.timePickerModel.handColor)
      Column() {
        Flex() {
          ForEach(this.timePickerModel.elements, (element, idx) => {
            Column() {
              Text(element + "").fontSize('20fp').alignSelf(ItemAlign.Center).fontColor(Color.White)
            }
            .height(this.timePickerModel.elementSize + 'vp')
            .width(this.timePickerModel.elementSize + 'vp')
            .position(this.timePickerModel.elementPositions[idx])
            .alignItems(HorizontalAlign.Center)
          })
        }
        .height('100%')
        .width('100%')
        .position(this.timePickerModel.elementCoverPosition)

      }
      .backgroundColor(this.timePickerModel.handColor)
      .clip(true)
      .position(this.timePickerModel.pointerPosition)
      .height(this.timePickerModel.pointerDiameter + 'vp')
      .width(this.timePickerModel.pointerDiameter + 'vp')
      .borderRadius((this.timePickerModel.pointerDiameter / 2) + 'vp')
    }
    .height('100%')
    .width('100%')
    .onTouch((event) => {
      if (event.type == TouchType.Up) {
        console.log(event.touches[0].x + "   " + event.touches[0].y)
        var target: number = (180 * Math.atan2(event.touches[0].x - this.timePickerModel.clockWidth / 2, -event.touches[0].y + this.timePickerModel.clockHeight / 2)) / Math.PI
        this.timePickerModel.setRotation(target, true)
        this.timePickerModel.update()
        this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
      }
      else {
        this.timePickerModel.setRotation((180 * Math.atan2(event.touches[0].x - this.timePickerModel.clockWidth / 2, -event.touches[0].y + this.timePickerModel.clockHeight / 2)) / Math.PI)
        this.timePickerModel.update()
      }
    })
  }
}