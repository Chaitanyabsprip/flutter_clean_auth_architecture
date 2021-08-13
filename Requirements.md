# Requirements

## User Requirements

### Predictions

- Next cyle start. ✔️
- Ovulation Date. ✔️
- Fertility period start date. ✔️
- Fertility period end date. ✔️

### Other Features

- Ability for spouse to check the user's menstrual cycle information.
- Show Health tips in context of page and information.
- Make Health tips searchable.

## Implicit requriements

- Authentication. ✔️
- Write user information to database. ✔️
- Store user menstrual cycle history in database. ✔️
- Store current cycle info seperate in the database. ✔️
- To predict the cycle length, consider the average cycle length of last 5 or
less cycles. ✔️
- For every complete cycle save the cycle info as history and start a new cycle.
- Make Health Tips database.
- Health tips must be seachable using keywords.

### Authentication

- Allows ThirdPartyService authentication: Google, Apple, etc and email &
  password authentication.

---

## Implementation

### System features

- Tracking menstrual cycle.
- Showing contextual health tips.
- authentication and linking two accounts as spouses.

### Other implicit features

- Database for menstrual cycle and health tips.

### Tracking menstrual cycle needs the following functionality

- predict the current cycle length. ✔️
- predict the start and end of fertility period. ✔️
- predict the day of ovulation. ✔️
- predict the start of next cycle. ✔️
- store the user initial cycle info in a database.
- store history of the user in the database. ✔️

### Presentation Logic

- create an API for the user to interact with the system such that the front-end
gets the data from the system and is able to provide data to the system.
- create the data input API before the data o/p API.

## RULES

- Anything that is supposed to happen outside of my system/application/code base
should be at the outside boundaries of the structure.
- Every layer or block of code must be coupled only using an abstract class as
an interface.
- Before implemeting any interface or class, the attributes that point outwards
(can be used by other classes or rest of the code base) must be decided and
thought through.
- Every class and implementation must follow SOLID.
