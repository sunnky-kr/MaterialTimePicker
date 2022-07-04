import { TimePickerModel } from './TimePickerModel';
import { ElementFormat } from "./Enums"

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
        .height(this.timePickerModel.height)
        .width(this.timePickerModel.width)
        .strokeOpacity(0.5)

      Circle({ height: this.timePickerModel.jointSize, width: this.timePickerModel.jointSize })
        .fill(this.timePickerModel.handColor)
      Circle({ height: this.timePickerModel.pointerDiameter, width: this.timePickerModel.pointerDiameter })
        .fill(this.timePickerModel.handColor)
        .position(this.timePickerModel.pointerPosition)
        .fillOpacity(0.5)
        .onTouch((event) => {
          this.timePickerModel.setRotation((180 * Math.atan2(event.touches[0].x - this.timePickerModel.width / 2, -event.touches[0].y + this.timePickerModel.height / 2)) / Math.PI)
          this.timePickerModel.update()
          if (event.type == TouchType.Up) {
            setTimeout
            (
            function changeInput(){
              this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
            }.bind(this),
              100
            );
          }
        })
    }
    .height(this.timePickerModel.height)
    .width(this.timePickerModel.width)
    .onTouch((event) => {
      this.timePickerModel.setRotation((180 * Math.atan2(event.touches[0].x - this.timePickerModel.width / 2, -event.touches[0].y + this.timePickerModel.height / 2)) / Math.PI)
      this.timePickerModel.update()
      if (event.type == TouchType.Up) {
        setTimeout
        (
        function changeInput(){
          this.timePickerModel.setFormat(ElementFormat.FORMAT_MINUTE)
        }.bind(this),
          100
        );
      }
    })
  }
}