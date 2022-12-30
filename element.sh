#!/bin/bash

PSQL="psql -X --tuples-only --username=freecodecamp --dbname=periodic_table -c"

if [[ -z $1 ]]
then

  echo Please provide an element as an argument.

else
  
  if [[ $1 =~ ^[0-9]+$ ]]
  then

    ATOM_SELECT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1")

  else

    ATOM_SELECT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name = '$1' OR symbol = '$1'")

  fi

  if [[ -z $ATOM_SELECT ]]
  then
  
    echo "I could not find that element in the database."

  else

    echo $ATOM_SELECT | while read ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
    do

    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."

    done

  fi

fi
