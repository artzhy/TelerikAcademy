﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Security;

class CountWordsInFile
{
    static void Main()
    {
        // Write a program that reads a list of words from a file words.txt
        // and finds how many times each of the words is contained in another file test.txt.
        // The result should be written in the file result.txt
        // and the words should be sorted by the number of their occurrences in descending order.
        // Handle all possible exceptions in your methods.

        string fileWords = @"...\...\words.txt"; // the file that contains the list of words
        string fileTest = @"...\...\test.txt"; // the file where the occurences of those words will be counted
        string fileResult = @"...\...\result.txt"; // the new file with the counted words

        try
        {
            // Get all lines in the file and store them in a list of strings
            List<string> wordsToCount = ReadLines(fileWords);

            // Build a dictionary containing each unique word as a key and its occurence as value
            Dictionary<string, int> dictionary = FindOccurences(wordsToCount, fileTest);

            // Save the result to a file
            WriteResultToFile(dictionary, fileResult);
        }

        catch (FileNotFoundException) { Console.WriteLine("File not found!"); }
        catch (DirectoryNotFoundException) { Console.WriteLine("Directory not found!"); }
        catch (SecurityException) { Console.WriteLine("Security error detected!"); }
        catch (IOException e) { Console.WriteLine(e.Message); }
        catch (UnauthorizedAccessException e) { Console.WriteLine(e.Message); }
    }

    static List<string> ReadLines(string path)
    {
        List<string> fileLines = new List<string>();

        using (StreamReader input = new StreamReader(path))
        {
            string lineString;
            while ((lineString = input.ReadLine()) != null)
            {
                fileLines.Add(lineString);
            }
        }

        return fileLines;
    }

    static Dictionary<string, int> FindOccurences(List<string> wordsToCount, string path)
    {
        using (StreamReader input = new StreamReader(path))
        {
            // Contains a collection of words (the key) and the number of their occurence (the value) 
            Dictionary<string, int> dictionary = new Dictionary<string, int>();

            string lineString;
            while ((lineString = input.ReadLine()) != null)
            {
                // Separate the words on the current line and store them an array
                string[] lineOfWords = lineString.ToLower().Split(' ', '.', ';', ':');

                foreach (string word in lineOfWords) // For each word on the line...
                {
                    if (wordsToCount.Contains(word)) // ... check if it is one of the words to count
                    {
                        if (!dictionary.ContainsKey(word))
                        {
                            dictionary.Add(word, 1);
                        }
                        else ++dictionary[word];
                    }
                }
            }

            return dictionary;
        }
    }

    static void WriteResultToFile(Dictionary<string, int> dictionary, string path)
    {
        using (StreamWriter output = new StreamWriter(path))
        {
            // using LINQ
            var sortedDictionary = (from d in dictionary
                                    orderby d.Value descending
                                    select d);

            foreach (var pair in dictionary)
            {
                string result = "\"" + pair.Key + "\" found " + pair.Value + " times.";
                output.WriteLine(result);
                Console.WriteLine(result);
            }
        }
    }
}