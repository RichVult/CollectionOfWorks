  /*
   * file: Problem1.java
   * author: Richard Vultaggio
   * course: CMPT 435
   * assignment: 4
   * 
   * This file contains the skeleton code of  
   * Problem 1.
   */

class Max2ndMax {
	int max;
	int max2nd;
}

public class Problem1
{

public static Max2ndMax dcfindmax2ndmax(int[] A)
	{
		// Complete this method to find max and 2nd max in an array A
		// At most 3n/2-2 comparisons
		// Algorithms that make more comparisons than 3n/2-2 will be scored out of 10 points
		// Complete the code from here
		// Feel free to change method type, parameters

		int big;//current biggest
		int secBig;//current second biggest

		if(A[0] > A[1])//determine biggest and second biggest among first two ints
		{
			big = A[0];
			secBig = A[1];
		}
		else
		{
			big = A[1];
			secBig = A[0];
		}
		
		//parse through array, checking to find newer biggest, searches in pairs to cut down on comparisons
		for(int i = 2; i < A.length - 1; i+=2)//start at 2 because 0 and 1 are already accounted for
		{
			if(A[i+1] > A[i]){  //find bigger in pair
				if(A[i+1] > big){ //if bigger, check for both biggest and second
					secBig = big;
					big = A[i+1];
					if(A[i] > secBig)
					{
						secBig = A[i];
					}
				}
				else{
					if(A[i+1] > secBig){//if not, only check for second biggest, saving comparisons
						secBig = A[i+1];
					}
				}
			}
			else{
				if(A[i] > big){//same concept but checking if the other item in pair is bigger
					secBig = big;
					big = A[i];
					if(A[i+1] > secBig)
					{
						secBig = A[i+1];
					}
				}
				else{
					if(A[i] > secBig){
						secBig = A[i];
					}
				}
			}
		}


		if(A.length % 2 != 0)//check last item if odd numbered array
		{
			if(A[A.length-1] > secBig)
			{
				if(A[A.length-1] > big)
				{
					secBig = big;
					big = A[A.length-1];
				}
				else{
					secBig = A[A.length-1];
				}
			}
		}


		
		Max2ndMax ret = new Max2ndMax();
		ret.max = big;
		ret.max2nd = secBig;
		return ret;
	}
		public static void main(String[] args) {
		int[] givenarray = {100,2,3,4,5,6,7,67,2,32,10,20};	
		
		// Test your method
		Max2ndMax pair = new Max2ndMax();
		// Java does pass-by-value not by-reference
		// Therefore we create a class of Max2ndMax for max and 2ndmax pair
		pair = dcfindmax2ndmax(givenarray);
		int max2nd = pair.max2nd;
		int max = pair.max;
		System.out.println("The max and 2ndmax of the given array are "+ max + " and "+max2nd+".");
		// Your method should return 100 and 67
		int[] test1 = {5, 10};
		Max2ndMax pair1 = dcfindmax2ndmax(test1);
		System.out.println("max=" + pair1.max + ", 2ndmax=" + pair1.max2nd);
		
		int[] test2 = {100, 2, 3, 67, 2, 32, 10, 20};
		Max2ndMax pair2 = dcfindmax2ndmax(test2);
		System.out.println("max=" + pair2.max + ", 2ndmax=" + pair2.max2nd);
		
		int[] test3 = {6, 7, 8, 9, 10, 99};
		Max2ndMax pair3 = dcfindmax2ndmax(test3);
		System.out.println("max=" + pair3.max + ", 2ndmax=" + pair3.max2nd);
		
		int[] test4 = {50, 50, 40, 40, 30, 60, 60, 20};
		Max2ndMax pair4 = dcfindmax2ndmax(test4);
		System.out.println("max=" + pair4.max + ", 2ndmax=" + pair4.max2nd);
		
		int[] test5 = {90, 80, 70, 60, 50, 40, 30, 20, 10};
		Max2ndMax pair5 = dcfindmax2ndmax(test5);
		System.out.println("max=" + pair5.max + ", 2ndmax=" + pair5.max2nd);
		
	}		
}	
	
	