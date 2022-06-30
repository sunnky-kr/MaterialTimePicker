//export class ElementPosition implements Position
//{
//  x:number;y:number;
//  ElementPosition(x:number,y:number)
//  {
//    this.x=x!=undefined?x:0;
//    this.y=y!=undefined?y:0;
//
//  }
//}
@Entry
@Component
struct TimePicker {
  build() {
    Flex({ justifyContent: FlexAlign.Center, direction: FlexDirection.Column }) {
      Column() {
        Text("SELECT TIME").fontSize(12).fontColor(Color.Green).alignSelf(ItemAlign.Start)
      }
      .height(28)
      .width(280)
      .padding(24)
      .backgroundColor(Color.Brown)

      Column() {

      }
      .height(396)
      .padding(24)
      .backgroundColor(Color.Blue)

      Column() {

      }
      .height(52)
      .backgroundColor(Color.Black)
    }
    .width(328)
    .padding({ right: 24, left: 24, top: 0, bottom: 0 })
  }
}

@Component
struct TimeDisplay {
  build() {

  }
}