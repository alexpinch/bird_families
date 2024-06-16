# Ave phylogeny game

### To-do
- [x] Guessing game as shell script
- [x] Guessing game as an R script
- [x] Shiny app that hosts the R script
- [x] Add columns names to the R dataset when read, so can refer to answer$GENUS, etc. ((just change header==FALSE to TRUE idiot))
- [x] Autocomplete search bar in shinyapp version? *almost!!  
<br>
<u>ui changes</u>
- [ ] Have a 'submit' button after you select the bird, make that count toward your guesses. Bird phylogeny info should show up after.
- [ ] Have the drop-down appear only when you start typing (so that you cant scroll through entire list)  
<br>
<u>additions, new features, completionist</u>
- [ ] Completely add the Audubon Field Guide dataset
- [ ] Add orders manually
- [ ] Add guess numbers/limited guesses to R script, as well as how many species are in GENUS
- [ ] "Learn the bird families" section of shinyapp (Transcribe Audubon appendix)
- [ ] Disclaimer on shinyapp, species, genus and family are as accurate as (audubon publish date), order as accurate as 2024.
- [ ] Institute check if only species in it's genus and family, if so, return correct
- [ ] Draggable tree elements
