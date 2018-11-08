Text Prediction
========================================================
author: Athanasios K. Tsiaras
date: 11/5/2018
autosize: true

1. Text mining
========================================================

- In order to make a prediction function, a corpus of text is needed
to base the function upon.

- The corpus is analysed with various text mining exploratory analysis
techniques, and key elements of the text and of the relationships between the words
are identified.

- Those key principles are taken into account in the making of the
prediction algorithm.

2. The n-grams
========================================================

-On the exploratory analysis of the text, a lot of emphasis was given on the n-gram analysis

-An n-gram is n number of words that appear together. For example, a trigram is three words that appear together

-The next_word function bases its prediction of the next word on the n-gram analysis of the initial corpus
3. How the function works
========================================================

-The function takes one input that can be either a word or a phrase

- If the input is only 1 word, the function returns the 3 most probable second words of the bigrams that have this word as their first word

- If the input is more than 1 word, the function first goes to the bigrams and then to the trigrams and then:

        - It takes the 3 most probable second words of the bigrams that have the same first word
        
        - I takes the 3 most probable third words of the trigrams that have the same first and second word
        
        - From the 6 words the function returns the 3 most probable

4. The application
========================================================

- An interface for the prediction algorithm was created using a Shiny app

- It's a simple straight forward application that requests the user to enter a text phrase

- Then the user should press the 'Predict' button and on the right side of the screen 3 possible next words appear

- You can check the application here: https://athanasiostsiaras.shinyapps.io/Next_word/

5. Thank you
========================================================

- Hope you enjoyed using the app

- You are welcome to try all kinds of crazy words/phrases

- Feedback is welcome!