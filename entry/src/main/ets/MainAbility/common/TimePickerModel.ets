
export class ElementPosition implements Position
{
  x:number;y:number;
  ElementPosition(x:number,y:number)
  {
    this.x=x!=undefined?x:0;
    this.y=y!=undefined?y:0;

  }
}
export class TimePickerModel
{
  rotation :number=0
  height:number=250
  width:number=250
  handLength:number=100
  handColor: string|Color=Color.Blue
  jointSize: number=10
  pointerDiameter:number=50
  startPoint:number[]
  endPoint:number[]
  pointerPosition:ElementPosition=new ElementPosition()
  //ClockFaceParameters
  clockFaceDiameter: number=256
  clockFaceColor:string|Color="#cccccc"
  elementPositionRadius:number=100
  elementRadius:number=50
  numberOfElements:number=12
//  diameter:number=250
  selectedElementColor:string | Color=Color.White
  unselectedElementColor:string | Color=Color.Black
  elements:string[] | number[]=[]
  elementPositions : ElementPosition[]=[]
  elementStates:number[]=[]
  selectedState:number=0
  elementColors:(string|Color)[]

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
  //Clock Face functions
  initialize()
  {
    if(this.elements.length!=this.numberOfElements)
    {
      this.elements=Array(this.numberOfElements).fill(1).map((_,idx)=> idx)
      this.elements[0]=12
    }
    this.elementStates=Array(this.numberOfElements).fill(0)
    if((this.rotation%360)%(360/this.numberOfElements)<0.01)
    {
      this.selectedState=Number(Math.round((this.rotation%360)/(360/this.numberOfElements)))
      this.elementStates[this.selectedState]=1
    }
    this.elementColors=[this.unselectedElementColor,this.selectedElementColor]
    this.updateElementPositions()
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
}