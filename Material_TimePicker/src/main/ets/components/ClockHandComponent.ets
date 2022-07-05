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
        .strokeOpacity(0.5)

      Circle({ height: this.timePickerModel.jointSize, width: this.timePickerModel.jointSize })
        .fill(this.timePickerModel.handColor)
      Column() {
        Circle({ height: this.timePickerModel.pointerDiameter, width: this.timePickerModel.pointerDiameter })
          .fill(this.timePickerModel.handColor)
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