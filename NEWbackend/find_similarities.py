from math import floor

def scorecalc(start_word, end_word):
    start_word = start_word.lower()
    end_word = end_word.lower()
    if (start_word == end_word):
        return 1

    print("expected = " + start_word + ", actual = " + end_word)
 
    len1 = len(start_word)
    len2 = len(end_word)
    max_dist = floor(max(len1, len2) / 2) - 1
    matches = 0
    start_arr = [0] * len(start_word)
    end_arr = [0] * len(end_word)
 
    for i in range(len1):
        for j in range(max(0, i - max_dist), min(len2, i + max_dist + 1)):
            if (start_word[i] == end_word[j] and end_arr[j] == 0):
                matches += 1
                start_arr[i] = 1
                end_arr[j] = 1
                
                break
 
    if (matches == 0):
        return 0
 
    t = 0
    pointer = 0

    for i in range(len1):
        if (start_arr[i] == 1):
            while (end_arr[pointer] == 0):
                pointer += 1
 
            if (start_word[i] != end_word[pointer]):
                t += 1
            pointer += 1
    t = t//2
 
    # Return the Jaro Similarity
    return ((matches/len1)+(matches/len2)+((matches-t)/matches))/3