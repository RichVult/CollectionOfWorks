  /*
   * file: Problem2.java
   * author: Richard Vultaggio 9/4
   * course: CMPT 435
   * assignment: 1
   * 
   * This file contains the skeleton code of  
   * Problem 2.
   */
public class Problem2 {

	
	
	public static int missingnumber(int[] A)
	{
		boolean flag = false; //flag to check if number had been found
		for(int i = 1; i < A.length + 1; i++) //loop starting at 1 to check each number that should be in array
		{
			for(int k = 0; k<A.length;k++)//loop through each item in array to search for number
			{
				if (A[k] == i) //if number is found, Set flag
				{
					flag = true;
				}
			}
			if(flag) // if flag found, reset and move it
			{
				flag = false;
			}
			else // if not, missing number found, return current search
			{
				return i;
			}
		}
		/*
		Input: a list of n-1 integers and these integers are in the range of 1 to n. There are no duplicates in list. One of the integers from 1 to n is missing in the list.
		Output: find the missing integer
		Let the input array be [2, 4, 1, 6, 3, 7, 8]. Elements in this list are in the range of 1 to 8. There are no duplicates, and 5 is missing. Your algorithm needs to return 5.
		Design an algorithm that solves this problem.
		*/
		
		// Complete this method
		
		return A.length + 1;
	}
	
	
	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		// Test your majority method
		
		int[] testarray1 = {2, 4, 1, 6, 3, 7, 8};
		
		int[] testarray2 = {6, 3, 4, 5, 1};

		int[] testarray3 = {2,1,4}; //test a short array

		int[] testarray4 = {1}; //test an array with one element (n= 2)

		int[] testarray5 = {4,2,3,1}; //test an array where n is missing (n = 5)

		int[] testarray6 = {}; //test an empty array (n=1)

		int[] testarray7 = {2}; //test an array with one element, but 2 (n= 2)
		
		
		System.out.println("The missing number in testarray1 "+ missingnumber(testarray1)); // 5 expected
		System.out.println("The missing number in testarray2 "+ missingnumber(testarray2)); // 2 expected 
		System.out.println("The missing number in testarray3 "+ missingnumber(testarray3)); // 3 expected
		System.out.println("The missing number in testarray4 "+ missingnumber(testarray4)); // 2 expected 
		System.out.println("The missing number in testarray5 "+ missingnumber(testarray5)); // 5 expected 
		System.out.println("The missing number in testarray6 "+ missingnumber(testarray6)); // 1 expected 
		System.out.println("The missing number in testarray7 "+ missingnumber(testarray7)); // 1 expected 
		
	}

}
