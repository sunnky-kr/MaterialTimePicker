import {ElementPosition,TimePickerModel} from "./TimePickerModel"
//import {ClockHandComponent} from "./ClockHandComponent"
@Entry
@Component
export struct ClockFaceComponent
{
  @State timePickerModel:TimePickerModel=undefined
  @State width:number=280
  @State height: number=256
  @State diameter : number=256
  @State color:string | Color="#cccccc"
  @State rotation:number=0
  aboutToAppear()
  {
    this.timePickerModel=new TimePickerModel()
  }
  build()
  {
    Stack({alignContent:Alignment.Center})
    {
      Circle({width:this.timePickerModel.clockFaceDiameter , height:this.timePickerModel.clockFaceDiameter}).fill("#cccccc")
      RadialContainer({timePickerModel: this.timePickerModel})
      ClockHandComponent({timePickerModel: this.timePickerModel})
    }.width(this.timePickerModel.width).height(this.timePickerModel.height)
  }
}

@Component
export struct RadialContainer
{
  @State timePickerModel:TimePickerModel=undefined
  @State elementPositionRadius:number=100
  @State elementRadius:number=50
  @State rotation:number=0
  @State numberOfElements:number=1
  @State diameter:number=250
  @State selectedElementColor:string | Color=Color.White
  @State unselectedElementColor:string | Color=Color.Black
  @State elements:string[] | number[]=[]
  @State elementPositions : ElementPosition[]=[]
  @State height:number=250
  @State width: number=250
  @State elementStates:number[]=[]
  @State selectedState:number=0
  @State stateChanged:boolean=false
  elementColors:(string|Color)[]=[this.unselectedElementColor,this.selectedElementColor]

  initialize()
  {
    if(this.timePickerModel.elements.length!=this.timePickerModel.numberOfElements)
    {
      this.timePickerModel.elements=Array(this.timePickerModel.numberOfElements).fill(1).map((_,idx)=> idx)
      this.timePickerModel.elements[0]=12
    }
    this.timePickerModel.elementStates=Array(this.timePickerModel.numberOfElements).fill(0)
    if((this.timePickerModel.rotation%360)%(360/this.timePickerModel.numberOfElements)<0.01)
    {
      this.timePickerModel.selectedState=Number(Math.round((this.timePickerModel.rotation%360)/(360/this.timePickerModel.numberOfElements)))
      this.timePickerModel.elementStates[this.timePickerModel.selectedState]=1
    }
    this.timePickerModel.updateElementPositions()
  }
  updateElementPositions()
  {
    this.elementPositions=Array(this.numberOfElements).fill(1).map((_,idx)=> {
      var angle: number=(idx*360*Math.PI)/(180*this.numberOfElements);
      var pos: ElementPosition=new ElementPosition();
      pos.x=this.width/2+this.elementPositionRadius*Math.sin(angle)-this.elementRadius/4
      pos.y=this.height/2-this.elementPositionRadius*Math.cos(angle)-this.elementRadius/4
      return pos
    })


  }
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
            this.stateChanged=!this.stateChanged
            console.log("State Changed")
          })
        })
    }
    .height(this.timePickerModel.height).width(this.timePickerModel.width)
  }
}



@Component
export struct ClockHandComponent
{
  @State timePickerModel:TimePickerModel=undefined
  @State rotation: number=0
  @State handLength: number=100
  @State handColor:string | Color=Color.Blue
  @State jointSize:number=10
  @State pointerDiameter:number=50
  @State height:number=250
  @State width:number=250
  @State visible:Visibility=Visibility.Visible
  startPoint:number[]
  endPoint:number[]
  pointerPosition:ElementPosition=new ElementPosition();
  updateStartPoint()
  {
    this.startPoint= [this.width/2,this.height/2]
  }
  updateEndPoint()
  {
    this.endPoint= [this.width/2+this.handLength*Math.sin((this.rotation*Math.PI)/180),this.height/2-this.handLength*Math.cos((this.rotation*Math.PI)/180)]
  }
  updatePointerPosition()
  {
    this.pointerPosition.x=this.endPoint[0]-this.pointerDiameter/2
    this.pointerPosition.y=this.endPoint[1]-this.pointerDiameter/2
  }
  update()
  {
    this.updateEndPoint()
    this.updateStartPoint()
    this.updatePointerPosition()
  }
  setRotation(degrees:number)
  {
    this.rotation=degrees
  }
  setHandLength(length:number)
  {
    this.handLength=length
  }
  setHandColor(color:string | Color)
  {
    this.handColor=color
  }
  setJointSize(size:number)
  {
    this.jointSize=size
  }
  setPointerDiameter(diameter:number)
  {
    this.pointerDiameter=diameter
  }
  setHeight(height:number)
  {
    this.height=height
  }
  setWidth(width:number)
  {
    this.width=width
  }
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
        .onTouch()
        .onDragMove((event)=>
      {
        this.timePickerModel.rotation=(180*Math.atan2(event.getY()-this.timePickerModel.width/2,event.getX()-this.timePickerModel.height/2))/Math.PI
        this.timePickerModel.update()
      })

      Text(this.timePickerModel.rotation+"").fontSize(40)
        .onClick(()=>
        {
          this.timePickerModel.rotation+=10
          this.timePickerModel.update()
          console.log("updated")
//          if(this.timePickerModel.rotation==100)
//          {
//            this.visible=Visibility.Hidden
//          }
        })
    }
    .height(this.timePickerModel.height)
    .width(this.timePickerModel.width)
    .visibility(this.visible)
  }


}