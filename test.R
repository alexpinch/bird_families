# Alex Pinch, May 14 2024

birds <- read.csv("/Users/alexpinch/GitHub/private/phyl_bird/birds.csv", header = FALSE)
num_rows <- nrow(birds)
random_row <- sample(1:num_rows, 1)
answer <- birds[random_row, 1]

# test print
cat("Randomly selected row number:", random_row, "\n")
cat("First field (answer):", answer, "\n")

cat("Guess a bird: ")
guess <- readLines(con = "stdin", n = 1)

if (guess == answer) {
  cat("Correct!\n")
} 
else {
  guess_found <- which(birds[, 1] == guess)
  if (length(guess_found) > 0) {
    
    # test print
    cat("Guess found in birds.csv at row", guess_found, "\n")
    
    shared_ancestry <- intersect(birds[random_row, 2:4], birds[guess_found, 2:4])
    if (length(shared_ancestry) > 0) {
      cat("Shared ancestry:", paste(shared_ancestry, collapse = ", "), "\n")
    }
  } 
  else {
    cat("Unrecognized bird\n")
  }
}
