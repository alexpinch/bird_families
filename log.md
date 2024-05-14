# Ave phylogeny game

### Goals
- [ ] Audubon Field Guide dataset (Common name, Latin name, Genus, Family, Order), as a CSV
- [ ] Shell script that randomly choses 1, if readline matches common name
- [ ] "Learn the bird families" HTML (Transcribe Audubon appendix)

### Pseudocode
#!bin/bash  
1. readcsv, count # of lines (each individual is a new line)
2. chose # between 1 and line_count
3. set answer == line_count(COMMON_NAME)
4. set guesses_remaining=5
5. while guesses_remaining>0 and readline!=correct:
5. a) print "Guess a bird" readline
5. b) if readline==answer print "Correct!", done
5. c) if readline!=answer, guesses_remaining--, if readline(GENUS)==answer(GENUS) || FAMILY==answerFAMILY || order==answerORDER, print "Shared ancestry: GENUS||FAMILY||ORDER"
6. if guesses_remaining<=0 print "Failure! You don't know your ave phylogeny."
