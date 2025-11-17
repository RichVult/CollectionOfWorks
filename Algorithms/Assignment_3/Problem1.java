  /*
   * file: Problem1.java
   * author: Richard Vultaggio 10/4
   * course: CMPT 435
   * assignment: 3
   * 
   * This file contains the skeleton code of  
   * Problem 1.
   */
public class Problem1 {

	public static boolean subsetsum(int[] A,int x)
	{
		// Complete the method from here
		// Input: an array A[] and a value x
		// Output: True if there is a subset of A[] with sum = x
		// False otherwise 
		// Full credits (30 points) will be awarded to a recursive methd without loop. A non-recursive method will be scored out of 10 points.
		// Feel free to change the function return type and the parameters

		return subsetsum(A,x,0,0);
	
	}

	public static boolean subsetsum(int[] A,int x,int currentSum,int index)
	{
		if(currentSum == x){
			return true;
		}

		if(index == A.length){
			return false;
		}
		else{
			return subsetsum(A,x,A[index]+currentSum,index + 1) || subsetsum(A,x,currentSum,index + 1);
		}
	}
	public static void main(String[] args) {
		// Test your largest() method 
		int[] a = {3, 34, 4, 12, 5, 2};
        int x = 9;

		int[] b = {3, 34, 4, 12, 5, 2};
        int x1 = 222;

		int[] c = {3};
        int x3 = 3;

		int[] d = {1,1,1,1,1,1,1,1};
        int x4 = 5;

		
        if (subsetsum(a, x) && !(subsetsum(b, x1)) && subsetsum(c, x3) && subsetsum(d, x4) ) {
		// Feel free to change the function return type and the parameters
            System.out.println("True");
        } 
		else 
		{
            System.out.println("False");
        }
	
	}
	
}
