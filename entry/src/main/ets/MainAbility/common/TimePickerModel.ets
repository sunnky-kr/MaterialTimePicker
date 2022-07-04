import { TimeModel } from "./TimeModel"
import { ElementFormat, TimeFormat, InputMethod } from "./Enums"

export class ElementPosition implements Position {
  x: number;
  y: number;

  ElementPosition(x: number, y: number) {
    this.x = x != undefined ? x : 0;
    this.y = y != undefined ? y : 0;
  }
}

export class TimePickerModel {
  ElementOptions: number[][]= [
    [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
    [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22],
    [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]]
  LeastCountOptions: number[]= [30, 15, 6]
  leastCount: number= 30
  format: ElementFormat= ElementFormat.FORMAT_12H
  rotation: number= 0
  height: number= 256
  width: number= 280
  handLength: number= 75
  handColor: string | Color= "#5e00ff"
  jointSize: number= 10
  pointerDiameter: number= 50
  startPoint: number[]
  endPoint: number[]
  pointerPosition: ElementPosition= new ElementPosition()
  clockFaceDiameter: number= 256
  clockFaceColor: string | Color= "#e4e4e4"
  elementPositionRadius: number= 100
  elementRadius: number= 50
  numberOfElements: number= 12
  selectedElementColor: string | Color= Color.White
  unselectedElementColor: string | Color= Color.Black
  elements: number[]= []
  elementPositions: ElementPosition[]= []
  elementStates: number[]= []
  selectedState: number= 0
  elementColors: (string | Color)[]
  inputMethod: InputMethod= InputMethod.ClockInputMethod
  chipHeight: number
  totalHeight: number
  model: TimeModel

  constructor(hour: number=new Date().getHours(), minute: number=new Date().getMinutes(), format: TimeFormat=TimeFormat.CLOCK_24H) {
    this.model = new TimeModel(hour, minute, format)
    this.setRotation(this.getRotation())
    this.update()
  }

  setInputMethod(method: InputMethod) {
    if (this.inputMethod != method) {
      this.inputMethod = method
      this.updateHeight()
    }
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
    this.startPoint = [this.width / 2, this.height / 2]
  }

  updateEndPoint() {
    this.endPoint = [this.width / 2 + this.handLength * Math.sin((this.rotation * Math.PI) / 180), this.height / 2 - this.handLength * Math.cos((this.rotation * Math.PI) / 180)]
  }

  updatePointerPosition() {
    this.pointerPosition.x = this.endPoint[0] + this.pointerDiameter / 2 * (Math.sin((this.rotation * Math.PI) / 180) - 1)
    this.pointerPosition.y = this.endPoint[1] - this.pointerDiameter / 2 * (1 + Math.cos((this.rotation * Math.PI) / 180))
  }

  updateHeight() {
    this.chipHeight = this.inputMethod == InputMethod.TextInputMethod ? 100 : 372
    this.totalHeight = this.inputMethod == InputMethod.TextInputMethod ? 228 : 500
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

  setFormat(format: ElementFormat) {
    if (this.format != format) {
      this.format = format
      this.elements = this.ElementOptions[format]
      this.leastCount = this.LeastCountOptions[format]
      this.setRotation(this.getRotation())
      this.update()
    }

  }

  setRotation(degrees: number, dropped: boolean=false) {
    degrees %= 360
    if (degrees < 0)
    degrees += 360
    this.rotation = degrees
    if (this.format != ElementFormat.FORMAT_MINUTE) {
      this.model.setHour(Math.round(degrees / this.leastCount))
    }
    else {
      this.model.setMinute(Math.round(degrees / this.leastCount))
    }
    if (dropped) {
      this.rotation = this.finalRotation(this.rotation)
    }
  }

  finalRotation(degrees: number) {
    return Math.round(degrees / this.leastCount) * this.leastCount
  }

  setTime(hour: number, minute: number) {
    this.model.setHour(hour)
    this.model.setMinute(minute)
    this.rotation = this.model.hour * 30 + this.model.minute * 0.5
  }

  setHandLength(length: number) {
    this.handLength = length
  }

  setHandColor(color: string | Color) {
    this.handColor = color
  }

  setJointSize(size: number) {
    this.jointSize = size
  }

  setPointerDiameter(diameter: number) {
    this.pointerDiameter = diameter
  }

  setHeight(height: number) {
    this.height = height
  }

  setWidth(width: number) {
    this.width = width
  }

  initialize() {
    this.elements = this.ElementOptions[this.format]
    this.leastCount = this.LeastCountOptions[this.format]
    this.elementStates = Array(this.numberOfElements).fill(0)
    if ((this.rotation % 360) % (360 / this.numberOfElements) < 0.01) {
      this.selectedState = Number(Math.round((this.rotation % 360) / (360 / this.numberOfElements)))
      this.elementStates[this.selectedState] = 1
    }
    this.elementColors = [this.unselectedElementColor, this.selectedElementColor]
    this.updateElementPositions()
  }

  updateElementPositions() {
    this.elementPositions = Array(this.numberOfElements).fill(1).map((_, idx) => {
      var angle: number = (idx * 360 * Math.PI) / (180 * this.numberOfElements);
      var pos: ElementPosition = new ElementPosition();
      pos.x = this.width / 2 + this.elementPositionRadius * Math.sin(angle) - this.elementRadius / 4
      pos.y = this.height / 2 - this.elementPositionRadius * Math.cos(angle) - this.elementRadius / 4
      return pos
    })
  }
}