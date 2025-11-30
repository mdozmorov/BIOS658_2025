# 1. Define the list of students
num_students <- 6
# students <- paste0("Student_", 1:num_students)
# Alphabetical sorting by last name
students <- c("MA", "AG", "OH", "AR", "AS", "RZ")

# Print the initial list
cat("Initial list of students:\n")
print(students)
cat("\n")

# 2. Randomly shuffle the list of students
# Setting a seed (e.g., 101) for a reproducible random chain
set.seed(42)
shuffled_students <- sample(students)

cat("Shuffled order of students:\n")
print(shuffled_students)
cat("\n")

# 3. Create the circular assignment
# The grader list is the shuffled list
grader <- shuffled_students

# The graded list is the shuffled list shifted by one position.
# The last element (shuffled_students[num_students]) wraps around to the first position.
# Example: Student A (grader[1]) grades Student B (graded[1])
#          Student F (grader[6]) grades Student A (graded[6])
graded <- c(shuffled_students[2:num_students], shuffled_students[1])

# 4. Combine into a data frame
grading_assignment_df <- data.frame(
  Grader = grader,
  Graded_Student = graded
)

# 5. Display the results
cat("--- Homework Grading Assignment (Circular Chain) ---\n")
print(grading_assignment_df)

# Check for correctness: Each student should appear exactly once in the 'Grader' column
# and exactly once in the 'Graded_Student' column.
cat("\nVerification: All students used as Grader and Graded Student:\n")
print(sort(unique(grading_assignment_df$Grader)))