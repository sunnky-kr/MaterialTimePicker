
export class ElementPosition implements Position
{
  x:number;y:number;
  ElementPosition(x:number,y:number)
  {
    this.x=x!=undefined?x:0;
    this.y=y!=undefined?y:0;

  }
}