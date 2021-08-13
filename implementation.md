# Implementation

## Core

### Authentication

- #### authentication implementation using Firebase

## Period Tracking

### Domain

- #### Entity

  - `User`
  - `Menstrual Cycle`

- #### Usecase

  - Has only one dependency - `MenstrualCycleRepository`
  - Has the following methods :
    - `Future<int> getCycleLength()` - Calculates the average menstrual cycle
    length over the period of 5 months.
    - `Future<DateTime> getCycleEnd()` - Calculates the date on which the
    current cycle is going to end the next is going to begin.
    - `Future<DateTime> getOvulationDate()` - Calculates the ovulation date.
    - `Future<DateTime> getFertilityStart()` - Calculates the start of the
    fertility period.
    - `Future<DateTime> getFertilityEnd()` - Calculates the end of the fertility
    period.
    - `Future<MenstrualCycle> getMenstrualCycle()` - Uses all the above methods
    and creates a `MenstrualCycle` object.
  - Has the following helper methods :
    - `double _nonZeroAverage(List<MenstrualCycle> inputList)`
    - `List<int> _extractCycleLength(List<MenstrualCycle> list)`
    - `int _sum(List<int> list)`
    - `int _nonZeroElements(List<int> list)`

### Data

- #### Model

### Database Outline
```
crimsonApp
  |
  |-- Users
  |     |
  |     |-- UserModel
  |     |-- Current MenstrualCycle
  |     |-- History
  |           |
  |           |-- cycle1
  |           |-- cycle2
  |           |-- cycle3
  |
  |-- HealthTips
        |
        |-- tip#1
        |-- tip#2
        |-- tip#3
```
