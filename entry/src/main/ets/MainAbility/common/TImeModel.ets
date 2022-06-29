//import {TimePickerModel} from "./TimePickerModel"
import {ElementFormat,ClockPeriod,TimeFormat,InputMethod} from "./Enums"

export class TimeModel
{
  hour :number
  minute : number
  //  seconds : number
  period:ClockPeriod
  format:TimeFormat
  //  timePickerModel: TimePickerModel
  constructor(hour:number,minute : number,  format:TimeFormat)//,  timePickerModel: TimePickerModel)
  {
    this.format=format
    this.setHour(hour)
    this.setMinute(minute)
    //    this.seconds=seconds
    this.setHourOfDay(hour)
    //    this.timePickerModel=timePickerModel
  }
  public setHour(hour:number)
  {
    if(this.format==TimeFormat.CLOCK_24H)
    {
      this.hour=hour%24
    }
    else
    {
      this.hour=hour%12+(this.period==ClockPeriod.PM?12:0)
    }
  }
  public setHourOfDay(hour:number)
  {
    hour%=24
    this.period=hour>=12?ClockPeriod.PM:ClockPeriod.AM
    this.hour=hour
  }
  public getHourForDisplay()
  {
    if(this.format==TimeFormat.CLOCK_24H){
      return this.hour%24}
    if((this.hour%12)==0){
      return 12}
    if(this.period==ClockPeriod.PM){
      return this.hour-12}
    return this.hour
  }
  public getMinuteForDisplay()
  {
    return this.minute
  }
  public formattedHour()
  {
    return String(this.getHourForDisplay()).padStart(2,'0')
  }
  public formattedMinute()
  {
    return String(this.getMinuteForDisplay()).padStart(2,'0')
  }

  public setMinute(minute:number)
  {
    this.minute=minute%60
  }
  //  public setSeconds(second:number)
  //  {
  //    this.seconds=second%60
  //  }
  public setPeriod(period:ClockPeriod)
  {
    if(this.period!=period)
    {
      this.period=period
      if(this.hour<12 && period==ClockPeriod.PM)
      this.hour+=12
      else if (this.hour>=12 && period==ClockPeriod.AM) {
        this.hour-=12
      }
    }
  }
}