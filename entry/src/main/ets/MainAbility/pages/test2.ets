@Component
export struct test2
{
  @Link param:number
  build()
  {
    Text(this.param+"").fontSize(20)
  }
}