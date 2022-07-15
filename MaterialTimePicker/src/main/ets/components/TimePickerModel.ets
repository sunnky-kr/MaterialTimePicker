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

import { TimeModel } from "./timemodel"
import { ElementFormat, TimeFormat, InputMethod, TimePickerOptions } from "./Types"

export class ElementPosition implements Position {
  x: number;
  y: number;
  constructor(x?: number, y?: number) {
    this.x = x != undefined || x != null ? x : 0;
    this.y = y != undefined || y != null ? y : 0;
  }
}

export class TimePickerModel {
  private ElementOptions: (number | string)[][]= [
    [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22],
    ['00', '05', 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]]
  private LeastCountOptions: number[]= [30, 15, 6]
  private maxValueOptions: number[]=[12,23,59]
  private leastCount: number= 30
  maxValue: number=12
  format: ElementFormat= ElementFormat.FORMAT_12H
  rotation: number= 0
  clockHeight: number= 256
  clockWidth: number= 280
  handLength: number= 75
  handColor: ResourceColor= "#5e00ff"
  jointSize: string | number= '20vp'
  pointerDiameter: number= 50
  startPoint: number[]
  endPoint: number[]
  pointerPosition: ElementPosition= new ElementPosition()
  elementCoverPosition: ElementPosition= new ElementPosition()
  clockFaceDiameter: string | number= '256vp'
  clockFaceBackgroundColor: ResourceColor= "#e4e4e4"
  clockNumberTextColor: ResourceColor= Color.Black
  materialCircleRadius: number= 100
  elementSize: number= 25
  numberOfElements: number= 12
  elements: (number | string)[]= []
  elementPositions: ElementPosition[]= []
  inputMethod: InputMethod= InputMethod.ClockInputMethod
  labelColor: ResourceColor= "#717171"
  chipHeight: Length
  totalHeight: Length
  bodyHeight: Length
  model: TimeModel
  //MaterialTimePickerParameters
  onCancelListeners: (() => void)[]= []
  onPositiveButtonClickListeners: ((string) => void)[]= []
  onNegativeButtonClickListeners: (() => void)[]= []
  onDismissListeners: (() => void)[]= []
  clockInputTitle?: string= "Select Time"
  textInputTitle?: string= "Enter Time"
  titleBackgroundColor?: ResourceColor= "#5e00ff"
  titleFontColor?: ResourceColor= Color.White
  inputSymbol: Resource[]= [$r("app.media.keyboard"), $r("app.media.clock")]

  constructor(options: TimePickerOptions) {
    this.setDefault()
    if (options != undefined || options != null) {
      this.updateParams(options)
    }
    this.setRotation(this.getRotation())
    this.update()
  }

  setDefault() {
    this.model = new TimeModel(new Date().getHours(), new Date().getMinutes(), TimeFormat.CLOCK_12H)
  }

  updateParams(options: TimePickerOptions) {
    if (options.timeFormat != undefined || options.timeFormat != null) {
      this.setClockFormat(options.timeFormat)
    }
    if (options.hour != undefined || options.hour != null) {
      this.model.setHour(options.hour)
    }
    if (options.minute != undefined || options.minute != null) {
      this.model.setMinute(options.minute)
    }
    if (options.cancel != undefined || options.cancel != null) {
      this.addOnCancelListener(options.cancel)
    }
    if (options.onPositiveButtonClick != undefined || options.onPositiveButtonClick != null) {
      this.addOnPositiveButtonClickListener(options.onPositiveButtonClick)
    }
    if (options.onNegativeButtonClick != undefined || options.onNegativeButtonClick != null) {
      this.addOnNegativeButtonClickListener(options.onNegativeButtonClick)
    }
    if (options.dismiss != undefined || options.dismiss != null) {
      this.addOnDismissListener(options.dismiss)
    }
    if (options.keyboardSymbol != undefined || options.keyboardSymbol != null) {
      this.setKeyboardSymbol(options.keyboardSymbol)
    }
    if (options.clockSymbol != undefined || options.clockSymbol != null) {
      this.setClockSymbol(options.clockSymbol)
    }
    if (options.clockFaceBackgroundColor != undefined || options.clockFaceBackgroundColor != null) {
      this.setClockFaceBackgroundColor(options.clockFaceBackgroundColor)
    }
    if (options.clockHandColor != undefined || options.clockHandColor != null) {
      this.setClockHandColor(options.clockHandColor)
    }
    if (options.clockNumberTextColor != undefined || options.clockNumberTextColor != null) {
      this.setClockNumberTextColor(options.clockNumberTextColor)
    }
    if (options.clockInputTitle != undefined || options.clockInputTitle != null) {
      this.clockInputTitle = options.clockInputTitle
    }
    if (options.textInputTitle != undefined || options.textInputTitle != null) {
      this.textInputTitle = options.textInputTitle
    }
    if (options.inputMethod != undefined || options.inputMethod != null) {
      this.setInputMethod(options.inputMethod)
    }
    if (options.titleBackgroundColor != undefined || options.titleBackgroundColor != null) {
      this.titleBackgroundColor = options.titleBackgroundColor
    }
    if (options.titleFontColor != undefined || options.titleFontColor != null) {
      this.titleFontColor = options.titleFontColor
    }
    if (options.labelColor != undefined || options.labelColor != null) {
      this.labelColor = options.labelColor
    }
    if (options.materialCircleRadius != undefined || options.materialCircleRadius != null) {
      this.materialCircleRadius = options.materialCircleRadius
    }
    if (options.selectorSize != undefined || options.selectorSize != null) {
      this.pointerDiameter = options.selectorSize
    }

  }

  onPositiveButtonClick(time: string) {
    this.onPositiveButtonClickListeners.forEach(element => {
      element(time)
    })
  }

  onNegativeButtonClick() {
    this.onNegativeButtonClickListeners.forEach(element => element())
  }

  onCancel() {
    this.onCancelListeners.forEach(element => element())
  }

  onDismiss() {
    this.onDismissListeners.forEach(element => element())
  }

  addOnPositiveButtonClickListener(listener: ((string) => void)[]) {
    listener.forEach(element => this.onPositiveButtonClickListeners = this.onPositiveButtonClickListeners.concat(element))
  }

  addOnNegativeButtonClickListener(listener: (() => void)[]) {
    listener.forEach(element => this.onNegativeButtonClickListeners = this.onNegativeButtonClickListeners.concat(element))
  }

  addOnCancelListener(listener: (() => void)[]) {
    listener.forEach(element => this.onCancelListeners = this.onCancelListeners.concat(element))
  }

  addOnDismissListener(listener: (() => void)[]) {
    listener.forEach(element => this.onDismissListeners = this.onDismissListeners.concat(element))
  }

  setKeyboardSymbol(keyBoardSymbol: Resource) {
    this.inputSymbol[0] = keyBoardSymbol
  }

  setClockSymbol(clockSymbol: Resource) {
    this.inputSymbol[1] = clockSymbol
  }

  setInputMethod(method: InputMethod) {
    if (this.inputMethod != method) {
      this.inputMethod = method
      this.updateHeight()
    }
  }

  setClockFaceBackgroundColor(color: ResourceColor) {
    this.clockFaceBackgroundColor = color
  }

  setClockNumberTextColor(color: ResourceColor) {
    this.clockNumberTextColor = color
  }

  setClockHandColor(color: ResourceColor) {
    this.handColor = color
  }

  getRotation() {
    if (this.format != ElementFormat.FORMAT_MINUTE) {
      return this.model.getHourForDisplay() * this.leastCount
    }
    else {
      return this.model.getMinuteForDisplay() * this.leastCount
    }
  }

  updateStartPoint() {
    this.startPoint = [this.clockWidth / 2, this.clockHeight / 2]
  }

  updateEndPoint() {
    this.endPoint = [this.clockWidth / 2 + this.handLength * Math.sin((this.rotation * Math.PI) / 180), this.clockHeight / 2 - this.handLength * Math.cos((this.rotation * Math.PI) / 180)]
  }

  updatePointerPosition() {
    this.pointerPosition.x = this.endPoint[0] + this.pointerDiameter / 2 * (Math.sin((this.rotation * Math.PI) / 180) - 1)
    this.pointerPosition.y = this.endPoint[1] - this.pointerDiameter / 2 * (1 + Math.cos((this.rotation * Math.PI) / 180))
    this.elementCoverPosition.x = -this.pointerPosition.x
    this.elementCoverPosition.y = -this.pointerPosition.y
  }

  updateHeight() {
    this.chipHeight = this.inputMethod == InputMethod.TextInputMethod ? '100vp' : '372vp'
    this.totalHeight = this.inputMethod == InputMethod.TextInputMethod ? '250vp' : '522vp'
    this.bodyHeight = this.inputMethod == InputMethod.TextInputMethod ? '200vp' : '472vp'
  }

  update() {
    this.updateEndPoint()
    this.updateStartPoint()
    this.updatePointerPosition()
    this.updateHeight()
  }

  setClockFormat(format: TimeFormat) {
    this.model.format = format
    if (this.format != ElementFormat.FORMAT_MINUTE) {
      this.setFormat(format == TimeFormat.CLOCK_24H ? ElementFormat.FORMAT_24H : ElementFormat.FORMAT_12H)

    }
  }

  transit(from: number, to: number) {
    if (Math.abs((from - to) % 360) > 0) {
      setTimeout(
        () => {
          var target: number = (360 + to - from) % 360 <= 180 ? (from + 363) % 360 : (from + 357) % 360
          this.setRotation(target, false, false)
          this.update()
          this.transit(target, to)
        }
      )
    }

  }

  setFormat(format: ElementFormat) {
    if (this.format != format) {
      this.format = format
      this.elements = this.ElementOptions[format]
      this.leastCount = this.LeastCountOptions[format]
      this.maxValue=this.maxValueOptions[format]
      var target: number = this.getRotation()
      this.transit(this.rotation, target)
    }
  }

  setRotation(degrees: number, dropped: boolean=false, changeTime: boolean=true) {
    degrees %= 360
    if (degrees < 0) {
      degrees += 360
    }
    this.rotation = degrees
    if (dropped) {
      this.rotation = this.finalRotation(this.rotation)
    }
    if (!changeTime) {
      return
    }
    if (this.format != ElementFormat.FORMAT_MINUTE) {
      this.model.setHour(Math.round(degrees / this.leastCount))
    }
    else {
      this.model.setMinute(Math.round(degrees / this.leastCount))
    }
  }

  finalRotation(degrees: number) {
    return Math.round(degrees / this.leastCount) * this.leastCount
  }

  initialize() {
    this.elements = this.ElementOptions[this.format]
    this.leastCount = this.LeastCountOptions[this.format]
    this.updateElementPositions()
  }

  updateElementPositions() {
    this.elementPositions = Array(this.numberOfElements).fill(1).map((_, idx) => {
      var angle: number = (idx * 360 * Math.PI) / (180 * this.numberOfElements);
      var pos: ElementPosition = new ElementPosition(this.clockWidth / 2 + this.materialCircleRadius * Math.sin(angle) - this.elementSize / 2, this.clockHeight / 2 - this.materialCircleRadius * Math.cos(angle) - this.elementSize / 2);
      return pos
    })
  }
}