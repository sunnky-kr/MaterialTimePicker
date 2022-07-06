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
import { ElementFormat } from "./enums"

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
        .strokeWidth(4)
        .startPoint(this.timePickerModel.startPoint)
        .endPoint(this.timePickerModel.endPoint)
        .height(this.timePickerModel.clockHeight)
        .width(this.timePickerModel.clockWidth)

      Circle({ height: this.timePickerModel.jointSize, width: this.timePickerModel.jointSize })
        .fill(this.timePickerModel.handColor)
      Column() {
        Flex() {
          ForEach(this.timePickerModel.elements, (element, idx) => {
            Column() {
              Text(element + "").fontSize(20).alignSelf(ItemAlign.Center).fontColor(Color.White)
            }
            .height(this.timePickerModel.elementSize)
            .width(this.timePickerModel.elementSize)
            .position(this.timePickerModel.elementPositions[idx])
            .alignItems(HorizontalAlign.Center)
          })
        }
        .height(this.timePickerModel.clockHeight)
        .width(this.timePickerModel.clockWidth)
        .position(this.timePickerModel.elementCoverPosition)

      }
      .backgroundColor(this.timePickerModel.handColor)
      .clip(true)
      .position(this.timePickerModel.pointerPosition)
      .height(this.timePickerModel.pointerDiameter)
      .width(this.timePickerModel.pointerDiameter)
      .borderRadius(this.timePickerModel.pointerDiameter / 2)
    }
    .height(this.timePickerModel.clockHeight)
    .width(this.timePickerModel.clockWidth)
    .onTouch((event) => {
      if (event.type == TouchType.Up) {
        this.timePickerModel.setRotation((180 * Math.atan2(event.touches[0].x - this.timePickerModel.clockWidth / 2, -event.touches[0].y + this.timePickerModel.clockHeight / 2)) / Math.PI, true)
        this.timePickerModel.update()
        setTimeout
        (
        function changeInput(){
          this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
        }.bind(this),
          100
        );
      }
      else {
        this.timePickerModel.setRotation((180 * Math.atan2(event.touches[0].x - this.timePickerModel.clockWidth / 2, -event.touches[0].y + this.timePickerModel.clockHeight / 2)) / Math.PI)
        this.timePickerModel.update()
      }
    })
  }
}