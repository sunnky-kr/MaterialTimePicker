class ElementPosition implements Position {
  x: number;
  y: number;

  ElementPosition(x: number, y: number) {
    this.x = x != undefined ? x : 0;
    this.y = y != undefined ? y : 0;
  }
}
@Entry
@Component

export struct test2
{
  @State param:number=43
  position:ElementPosition
  aboutToAppear()
  {
    this.position=new ElementPosition()
    this.position.x=-20
    this.position.y=-20
  }
  build()
  {
    Column() {
      Text("")
      TextInput({ text: this.param + "" }).fontSize(20)
      .width(200)
      .height(60)
      .borderRadius(10)
      .borderWidth(2)
      .backgroundColor(Color.White)
      Column(){
        Text("Test Text").fontSize(60).position(this.position)
      }
      .borderWidth(3)
      .width(100)
      .height(100)
      .clip(true)
//      .clip(true)
//      Circle()
//        .width(300)
//        .height(300)
//        .fill(Color.Blue)
//        .invert(44)
//      .radialGradient({center:[250,250],radius:30,colors:[Color.Blue,Color.White]})


    }
  }
}