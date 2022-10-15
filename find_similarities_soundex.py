from jellyfish import soundex

def fill_similarities(start_word, end_word) -> float:
    similarity_array = [[0 for i in range(0, len(start_word)+1)] for j in range(0, len(end_word)+1)]
    for i in range(0, len(start_word)):
        #Sets the bottom row with icrementing values
        temp = len(start_word)
        similarity_array[len(end_word)][i] = len(start_word) - i

    for i in range(0, len(end_word)):
    #Sets the rightmost column with incrementing values
        temp = len(end_word)
        similarity_array[i][len(start_word)] = len(end_word) - i

    #Itterates from the bottom right to the top left
    for i in range(len(end_word)-1, -1, -1):
        for j in range(len(start_word)-1, -1, -1):
            if end_word[i: i+1] == start_word[j: j+1]:#Used in the case of a substitution
                temp = 0
            else:
                temp = 1

            #Sets the value to minimum of 1+right, 1+ below, and either 1 or 0 + below and to the right
            similarity_array[i][j] = min(similarity_array[i+1][j] + 1, similarity_array[i][j+1] + 1, similarity_array[i+1][j+1] + temp)
    
    ld_coeficient = 1-(similarity_array[0][0]/max(len(start_word), len(end_word)))
    start_soundex = int(soundex(start_word)[1:])
    end_soundex = int(soundex(end_word)[1:])
    soundex_coeficient = 1-(abs(start_soundex-end_soundex))/max(start_soundex, end_soundex)
        
    
    return (ld_coeficient + soundex_coeficient)/2

print(fill_similarities("fortnite", "night"))