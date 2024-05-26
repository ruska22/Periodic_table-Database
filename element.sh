#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
echo Please provide an element as an argument.
else

ELEMENT=$1


  if [[ ! $ELEMENT =~ ^[0-9]+$ ]]
  then
    LENGTH=$($PSQL "SELECT LENGTH('$ELEMENT')")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$ELEMENT'")
    if [[ $LENGTH -gt 2 ]]
    then
    EVERYTHING=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name = '$ELEMENT'")
      if [[ -z $EVERYTHING ]]
      then
      echo I could not find that element in the database.
        else
        echo "$EVERYTHING" | while read TYPE_ID BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
        do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    else   
    EVERYTHING=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol = '$ELEMENT'")
    echo "$EVERYTHING" | while read TYPE_ID BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
    do
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
    fi 

  else 
  EVERYTHING=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $ELEMENT")
    if [[ -z $EVERYTHING ]]
      then
      echo I could not find that element in the database.
    else
    echo "$EVERYTHING" | while read TYPE_ID BAR NUMBER BAR SYMBOL BAR NAME BAR MASS BAR MELTING BAR BOILING BAR TYPE
    do
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
    fi
  fi

fi
