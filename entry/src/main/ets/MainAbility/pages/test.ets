//import {test2} from "./test2"
@Entry
@Component
struct LineExample {
  @State param:number=232
  build() {
    Column() {
      Line({ width: 50, height: 100 }).startPoint([0, 0]).endPoint([50, 100]).strokeWidth(6).fill(Color.Red)
      Line().width(200).height(200).startPoint([50, 50]).endPoint([150, 150])
      test2({param:$param})
    }.margin({ top: 5 })
  }
}
@Component
export struct test2
{
  @Link param:number
  build()
  {
    Text(this.param+"").fontSize(20)
  }
}