/*
 * Copyright (C) 2022 Application Library Engineering Group
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export enum ElementFormat {
  FORMAT_12H = 0, FORMAT_24H = 1, FORMAT_MINUTE = 2
}

export enum InputMethod {
  ClockInputMethod, TextInputMethod
}

export enum ClockPeriod {
  AM, PM
}

export enum TimeFormat {
  CLOCK_12H, CLOCK_24H
}

export interface TimePickerOptions {
  timeFormat?: TimeFormat
  hour?: number
  minute?: number
  cancel?: () => void
  confirm?: (string) => void
  keyboardSymbol?: Resource
  clockSymbol?: Resource
  clockFaceBackgroundColor?: ResourceColor
  clockHandColor?: ResourceColor
  clockNumberTextColor?: ResourceColor
  clockInputTitle?: string
  textInputTitle?: string
  inputMethod?: InputMethod
  titleBackgroundColor?: ResourceColor
  titleFontColor?: ResourceColor
}