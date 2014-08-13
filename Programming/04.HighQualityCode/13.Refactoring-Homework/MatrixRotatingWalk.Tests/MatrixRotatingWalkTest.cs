﻿using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

[TestClass]
public class MatrixRotatingWalkTest
{
    [TestMethod]
    [ExpectedException(typeof(ArgumentOutOfRangeException))]
    public void AboveMaxSizeShouldThrowEx()
    {
        var filledMatrix = MatrixRotatingWalk.FillMatrix(MatrixRotatingWalk.MaxSize + 1);
    }

    [TestMethod]
    [ExpectedException(typeof(ArgumentOutOfRangeException))]
    public void BelowMinSizeShouldThrowEx()
    {
        var filledMatrix = MatrixRotatingWalk.FillMatrix(MatrixRotatingWalk.MinSize - 1);
    }

    [TestMethod]
    public void FillMatrix_6x6()
    {
        int size = 6;
        var filledMatrix = MatrixRotatingWalk.FillMatrix(size);

        var expected = new int[,]
        {
            {1,16,17,18,19,20},
            {15,2,27,28,29,21},
            {14,31,3,26,30,22},
            {13,36,32,4,25,23},
            {12,35,34,33,5,24},
            {11,10,9,8,7,6}
        };

        CollectionAssert.AreEqual(filledMatrix, expected);
    }

    [TestMethod]
    public void FillMatrix_3x3()
    {
        int size = 3;
        var filledMatrix = MatrixRotatingWalk.FillMatrix(size);

        var expected = new int[,] {
            { 1, 7, 8 },
            { 6, 2, 9 },
            { 5, 4, 3 } 
        };

        CollectionAssert.AreEqual(filledMatrix, expected);
    }
}
