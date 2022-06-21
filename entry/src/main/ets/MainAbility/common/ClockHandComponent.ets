import {ElementPosition,TimePickerModel} from "./TimePickerModel"
@Entry
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
    this.timePickerModel=new TimePickerModel()
    this.timePickerModel.update()
  }
  build()
  {
    Stack({alignContent:Alignment.Center}) {
//      Shape() {
        //      Path().width(this.width).height(this.height).commands("M"+this.height/2+" "+this.width/2+)
      Line().strokeWidth(4).startPoint(this.timePickerModel.startPoint).endPoint(this.timePickerModel.endPoint).height(this.timePickerModel.height).width(this.timePickerModel.width).fill(this.timePickerModel.handColor)
      Circle({ height: this.timePickerModel.jointSize, width: this.timePickerModel.jointSize }).fill(this.timePickerModel.handColor)
      Circle({height:this.timePickerModel.pointerDiameter,width:this.timePickerModel.pointerDiameter}).fill(this.timePickerModel.handColor).position(this.timePickerModel.pointerPosition).onDragMove((event)=>
      {
        this.timePickerModel.rotation=(180*Math.atan2(event.getY()-this.timePickerModel.width/2,event.getX()-this.timePickerModel.height/2))/Math.PI
        this.timePickerModel.update()
      })

      Text(this.timePickerModel.rotation+"").fontSize(40)
      .onClick(()=>
      {
        this.timePickerModel.rotation+=10
        this.timePickerModel.update()
      })
    }
    .height(this.timePickerModel.height)
    .width(this.timePickerModel.width)
  }


}