import {ElementPosition,TimePickerModel} from "./TimePickerModel"
//import {ClockHandComponent} from "./ClockHandComponent"
@Entry
@Component
export struct ClockFaceComponent
{
  @State timePickerModel:TimePickerModel=undefined
  aboutToAppear()
  {
    this.timePickerModel=new TimePickerModel()
  }
  build()
  {
    Stack({alignContent:Alignment.Center})
    {
      Circle({width:this.timePickerModel.clockFaceDiameter , height:this.timePickerModel.clockFaceDiameter}).fill(this.timePickerModel.clockFaceColor)
      RadialContainer({timePickerModel: $timePickerModel})
      ClockHandComponent({timePickerModel: $timePickerModel})
    }.width(this.timePickerModel.width).height(this.timePickerModel.height)
  }
}

@Component
export struct RadialContainer
{
  @Link timePickerModel:TimePickerModel
  aboutToAppear()
  {
    this.timePickerModel.initialize()
    console.log("initialized")
  }

  build()
  {
    Flex()
    {
        ForEach(this.timePickerModel.elements,(element,idx)=> {
          Text(element + "")
            .fontSize(20)
            .position(this.timePickerModel.elementPositions[idx])
            .alignSelf(ItemAlign.Center)
            .fontColor(this.timePickerModel.elementColors[this.timePickerModel.elementStates[idx]])
            .onClick(()=>
          {
            this.timePickerModel.elementStates[this.timePickerModel.selectedState]=0
            this.timePickerModel.elementStates[idx]=1
            this.timePickerModel.selectedState=idx
            this.timePickerModel.rotation=idx*(360/this.timePickerModel.numberOfElements)
          })
        })
    }
    .height(this.timePickerModel.height).width(this.timePickerModel.width)
  }
}



@Component
export struct ClockHandComponent
{
  @Link timePickerModel:TimePickerModel

  aboutToAppear()
  {
//        this.timePickerModel=new TimePickerModel()
    this.timePickerModel.update()
  }
  aboutToDisappear()
  {
    console.log("destroyed")
  }
  build()
  {
    Stack({alignContent:Alignment.Center}) {
      //      Shape() {
      //      Path().width(this.width).height(this.height).commands("M"+this.height/2+" "+this.width/2+)
      Line()
        .strokeWidth(4)
        .startPoint(this.timePickerModel.startPoint)
        .endPoint(this.timePickerModel.endPoint)
        .height(this.timePickerModel.height)
        .width(this.timePickerModel.width)
        .fill(this.timePickerModel.handColor)

      Circle({ height: this.timePickerModel.jointSize, width: this.timePickerModel.jointSize }).fill(this.timePickerModel.handColor)
      Circle({height:this.timePickerModel.pointerDiameter,width:this.timePickerModel.pointerDiameter})
        .fill(this.timePickerModel.handColor)
        .position(this.timePickerModel.pointerPosition)
        .fillOpacity(0.5)

        .onDragStart((event)=>
        {
          //      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
          this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
          this.timePickerModel.update()
        })
        .onDragMove((event)=>
        {
          //      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
          this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
          this.timePickerModel.update()
        })
        .onDrop((event)=>
        {
          //      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
          this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
          this.timePickerModel.update()
        })

//      Text(this.timePickerModel.rotation+"").fontSize(40)
//        .onClick(()=>
//        {
//          this.timePickerModel.rotation+=10
//          this.timePickerModel.update()
//          console.log("updated")
////          if(this.timePickerModel.rotation==100)
////          {
////            this.visible=Visibility.Hidden
////          }
//        })
    }
    .height(this.timePickerModel.height)
    .width(this.timePickerModel.width)
//    .visibility(this.visible)
    .onClick((event)=>
    {
      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
      this.timePickerModel.rotation=(180*Math.atan2(event.x-this.timePickerModel.width/2,-event.y+this.timePickerModel.height/2))/Math.PI
      this.timePickerModel.update()
    })
//    .onDragEnter((event)=>
//    {
//      //      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
//      this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
//      this.timePickerModel.update()
//    })
    .onDragStart((event)=>
    {
      //      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
      this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
      this.timePickerModel.update()
    })
    .onDragMove((event)=>
    {
//      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
      this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
      this.timePickerModel.update()
    })
    .onDrop((event)=>
    {
      //      console.log(event.x+"   "+event.y+"  "+event.screenX+"  "+event.screenY)
      this.timePickerModel.rotation=(180*Math.atan2(event.getX()-this.timePickerModel.width/2,-event.getY()+this.timePickerModel.height/2))/Math.PI
      this.timePickerModel.update()
    })
  }


}