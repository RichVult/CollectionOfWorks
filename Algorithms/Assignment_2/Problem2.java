  /*
   * file: Problem2.java
   * author: Ricahrd Vultaggio 9/25
   * course: CMPT 435
   * assignment: 2
   * 
   * This file contains the skeleton code of  
   * Problem 2.
   */
   
public class Problem2 {

	public static int squareroot(int x)
	{
		// Given a positive integer x, return square root of x
		// If x is not a perfect square, return the floor of its square root
		// Complete the method squareroot() here
		// O(log n) time algorithm expected
		// Algorithms slower than O(logn) will be graded out of 10 points
		// Feel free to change the return type or parameters
		// Complete the method
		
		int l = 0;
        int r = x;
		int location = -1;
        
        while (l <= r) {
            int mid = l + (r - l) / 2; 
            
            if (mid*mid <= x) { //check if mid^2 is less than x, if so it may be the nearest root, then keep looking
                location = mid;
				l = mid + 1; 
            } else 
                r = mid - 1; 
		}	

		return location;
	}
	

	
	public static void main(String[] args) {
		// test your squareroot() method here
		
		int x1 = 9;
		int x2 = 5;
		int x3 = 17;
		int x4 = 0;
		int x5 = 1;
		int x6 = 2;
		System.out.println("The square root of " + x1 + " is " + squareroot(x1));
		// 3 expected
		System.out.println("The square root of " + x2 + " is " + squareroot(x2));
		// 2 expected
		System.out.println("The square root of " + x3 + " is " + squareroot(x3));
		// 4 expected
		System.out.println("The square root of " + x4 + " is " + squareroot(x4));
		// 0 expected
		System.out.println("The square root of " + x5 + " is " + squareroot(x5));
		// 1 expected
		System.out.println("The square root of " + x6 + " is " + squareroot(x5));
		// 1 expected
		
	}

}
